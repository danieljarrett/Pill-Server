Pill-Server
============

A minimal, multi-threaded, Rack-compliant web server.

[![Gem Version](https://badge.fury.io/rb/pill.svg)](http://badge.fury.io/rb/pill)

Start the server:

	$ pill

Optionally, specify the port and number of maximum connections, like so:

	$ pill -c 128 -p 4848

No surprises:

	Pill web server (v0.5.1 codename Pak)
	Maximum connections set to 128
	Listening on 0.0.0.0:4848, CTRL+C to stop

### Handler

Pill uses the Ruby standard `socket`, `stringio`, and `thread` modules.  A single process listens for incoming connections, with each acceptance assigned to a new thread:

	loop do
		connection, _ = @server.accept

		Thread.new do
			handler = Handler.new(connection, @app)
			handler.read_request(1024 * 16)
		end
	end

A handler is instantiated for each connection to send the request for processing and to write back a response to the client socket when the parser callback is triggered:

	def initialize(connection, app)
		@connection = connection
		@app = app
		@parser = HTTP::Parser.new(self)
	end

### Parser

The handler object implements the callback functions to interface with the [http/parser](https://github.com/tmm1/http_parser.rb) module, and defines a rack-compliant environment hash holding the body of the client request.

### Builder

A minimal builder class is specified to operate on the `config.ru` file in a Rack-based application, in order to allow for the inclusion of middleware in applications run on Pill.

### Extensions

Instead of instantiating threads per connection on the fly, the following are models that can be implemented for efficiency:

1. Thread Pool
2. Processes
3. Preforking
4. Evented
5. Hybrids

### Resources

* [RubyGems](https://rubygems.org/)
* [Documentation](http://www.rubydoc.info/gems/pill)

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
