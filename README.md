# RackProf

Rack middleware for profiling.

## Installation

    gem 'rack_prof'

or

    $ gem install rack_prof

## Usage

Modify `config.ru` like:

    use RackProf

    require ::File.expand_path('../config/environment',  __FILE__)
    run YourApp::Application

You might need below to avoid 'stack level too deep' error:

    RubyVM::InstructionSequence.compile_option = {
      :tailcall_optimization => true,
      :trace_instruction => false
    }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
