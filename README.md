# RackProf

Rack middleware for profiling.

![screencast](https://raw.github.com/jugyo/rack_prof/master/screencast.gif)

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

Access to your application with a parameter 'profile=true' like:

[http://localhost:3000/books?profile=true](http://localhost:3000/books?profile=true)

You can specify printer like:

[http://localhost:3000/books?profile=true&printer=flat](http://localhost:3000/books?profile=true&printer=flat)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
