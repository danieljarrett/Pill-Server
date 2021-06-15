class Pill
	class Handler
		STATUS = {
			200 => 'OK',
			302 => 'Redirect',
			404 => 'Not Found'
		}

		def initialize(connection, app)
			@connection = connection
			@app = app
			@parser = HTTP::Parser.new(self)
		end

		def read_request(bytes)
			until @connection.closed? || @connection.eof?
				@parser << @connection.readpartial(bytes)
			end
		end

		def send_response(env)
			status, headers, body = @app.call(env)

			write_status(status)
			write_headers(headers)
			write_body(body)
		end

		def write_status(status)
			@connection.write "HTTP/1.1 #{status} #{STATUS[status]}\r\n"
		end

		def write_headers(headers)
			headers.each do |key, value|
				@connection.write "#{key}: #{value}\r\n"
			end

			@connection.write "\r\n"
		end

		def write_body(body)
			body.each do |chunk|
				@connection.write chunk
			end

			body.close if body.respond_to? :close
		end

		def close
			@connection.close
		end
	end
end
