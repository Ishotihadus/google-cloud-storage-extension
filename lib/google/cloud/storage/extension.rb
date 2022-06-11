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
          file = self.file(filename)
          raise 'file not found' unless file

          name = file.name
          basename = ::File.basename(name, '.*')
          extname = ::File.extname(name)
          tempfile = ::Tempfile.create([basename, extname], mode:)
          file.download(tempfile.path)
          ret = yield(tempfile.path)
          ::File.delete(tempfile.path)

          ret
        end
      end
    end
  end
end
