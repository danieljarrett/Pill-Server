require 'pill/modules'
require 'pill/handler'
require 'pill/parsing'
require 'pill/builder'

class Pill
	def initialize(port, conn, app)
		@server = TCPServer.new(port)
		@server.listen(conn)

		@app = app
	end

	def start
		loop do
			connection, _ = @server.accept

			Thread.new do
				handler = Handler.new(connection, @app)
				handler.read_request(1024 * 16)
			end
		end
	end
end