# frozen_string_literal: true

require_relative 'lib/google/cloud/storage/extension/version'

Gem::Specification.new do |spec|
  spec.name = 'google-cloud-storage-extension'
  spec.version = Google::Cloud::Storage::Extension::VERSION
  spec.authors = ['Ishotihadus']
  spec.email = ['hanachan.pao@gmail.com']

  spec.summary = 'Gem to extend google-cloud-storage gem'
  spec.description = 'Gem to extend google-cloud-storage gem'
  spec.homepage = 'https://github.com/ishotihadus/google-cloud-storage-extension'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ishotihadus/google-cloud-storage-extension'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) {|f| File.basename(f)}
  spec.require_paths = ['lib']

  spec.add_dependency 'google-cloud-storage'
end
