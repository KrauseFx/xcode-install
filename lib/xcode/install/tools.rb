require 'claide'

module XcodeInstall
  class Command
    class Tools < Command
      self.command = 'tools'
      self.summary = 'List or install Xcode CLI tools.'

      def self.options
        [['--install=name', 'Install CLI tools with the name specified'],
         ['--force', 'Install even if the same version is already installed.'],
         ['--no-install', 'Only download DMG, but do not install it.'],
         ['--no-progress', 'Don’t show download progress.']].concat(super)
      end

      def initialize(argv)
        @install = argv.option('install')
        @force = argv.flag?('force', false)
        @should_install = argv.flag?('install', true)
        @progress = argv.flag?('progress', true)
        @installer = XcodeInstall::Installer.new
        super
      end

      def run
        @install ? install : list
      end

      :private

      def install
        @installer.install_tools(@install)
      end

      def list
        puts @installer.toolslist
      end
    end
  end
end
