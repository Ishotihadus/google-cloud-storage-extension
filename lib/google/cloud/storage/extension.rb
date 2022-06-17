# frozen_string_literal: true

require 'google/cloud/storage'
require 'tempfile'
require_relative 'extension/version'

module Google
  module Cloud
    module Storage
      class Bucket
        # downloads the specified file and passes the path of the temporary file to the block argument
        # @param [String] filename
        # @yield [path]
        # @yieldparam path [String] path of tempfile
        def f(filename, mode: 0)
          tries = 0
          begin
            file = self.file(filename)
          rescue StandardError
            tries += 1
            if tries <= 10
              sleep 0.1
              retry
            end

            raise
          end
          raise 'file not found' unless file

          name = file.name
          basename = ::File.basename(name, '.*')
          extname = ::File.extname(name)
          tempfile = ::Tempfile.create([basename, extname], mode:)

          tries = 0
          begin
            file.download(tempfile.path)
          rescue StandardError
            tries += 1
            if tries <= 10
              sleep 0.1
              retry
            end

            ::File.delete(tempfile.path)
            raise
          end

          ret = yield(tempfile.path)
          ::File.delete(tempfile.path)

          ret
        end
      end
    end
  end
end
