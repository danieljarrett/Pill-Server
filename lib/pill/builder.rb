class Pill
	class Builder
		def initialize
			@use = []
			@run = nil
		end

    def use(middleware, *args, &block)
      @use << proc { |app| middleware.new(app, *args, &block) }
    end

		def run(app)
			@run = app
		end

		def app
			@use.reverse.reduce(@run) { |app, proc| proc === app }
		end

		def self.parse_file(file)
			b = self.new
			b.instance_eval(File.read(file))
			b.app
		end
	end
end