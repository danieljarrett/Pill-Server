class Pill
  class Handler
    def on_message_begin
      @body = ''
    end

    def on_body(chunk)
      @body << chunk
    end

    def on_message_complete
      print_message
      send_response(env)
      close
    end

    def env
      @parser.headers.each_pair.reduce({}) do |acc, (name, value)|
        acc.update('HTTP_' + name.upcase.tr('-', '_') => value)
      end .

      update('PATH_INFO' => @parser.request_path).
      update('REQUEST_METHOD' => @parser.http_method).
      update('rack.input' => StringIO.new(@body))
    end

    def print_message
      puts "#{@parser.http_method} \"#{@parser.request_path}\" for #{@connection.remote_address.ip_address}:#{@connection.remote_address.ip_port} at #{Time.now}"
    end
  end
end
