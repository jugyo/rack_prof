require "rack_prof/version"
require 'ruby-prof'
require 'launchy'

class RackProf
  DEFAULT_PRINTER = RubyProf::CallStackPrinter

  PRINTERS = {
    RubyProf::FlatPrinter      => 'flat.txt',
    RubyProf::GraphPrinter     => 'graph.txt',
    RubyProf::GraphHtmlPrinter => 'graph.html',
    RubyProf::CallStackPrinter => 'call_stack.html',
    RubyProf::CallTreePrinter  => 'call_tree.tree'
  }

  def initialize(app, options = {})
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.params.delete('profile')
      profile(env, request)
    else
      @app.call(env)
    end
  end

  private

  def profile(env, request)
    response = nil
    result = RubyProf.profile { response = @app.call(env) }
    printer = parse_printer(request.params.delete('printer'))
    file_name = get_file_name(request, printer)
    print(result, printer, file_name)
    Launchy.open(file_name)
    response
  end

  def print(result, printer, file_name)
    File.open(file_name, 'wb') do |file|
      printer.new(result).print(file, :min_percent => 1)
    end
    file_name
  end

  def get_file_name(request, printer)
    path = request.path.gsub('/', '-')
    path.slice!(0)
    base_name = PRINTERS[printer]
    File.join(Dir.tmpdir, "#{path}-#{base_name}")
  end

  def parse_printer(printer)
    if printer.nil?
      DEFAULT_PRINTER
    elsif printer.is_a?(Class)
      printer
    else
      name = "#{camel_case(printer)}Printer"
      if RubyProf.const_defined?(name)
        RubyProf.const_get(name)
      else
        DEFAULT_PRINTER
      end
    end
  end

  def camel_case(word)
    word.to_s.gsub(/(?:^|_)(.)/) { $1.upcase }
  end
end
