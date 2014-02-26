require 'pstore'

module Bernstein
	class Storage
		def initialize()
			@path = ENV['BERNSTEIN_FILE'] || File.expand_path("~/.bernstein")
			@store = PStore.new(@path)
		end

		def read
			@store
		end

		def store=(s)
			@store = s if s.kind_of?(PStore)
		end

		def write(&block)
			@store.transaction do
				yield(@store)
			end
		end
	end
end
