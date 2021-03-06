module Vagrant
  class Action
    module VM
      class Persist
        def initialize(app, env)
          @app = app

          # Error the environment if the dotfile is not valid
          raise Errors::PersistDotfileExists.new(:dotfile_path => env.env.dotfile_path) if File.exist?(env.env.dotfile_path) &&
                                                                                       !File.file?(env.env.dotfile_path)
        end

        def call(env)
          env.ui.info "vagrant.actions.vm.persist.persisting", :uuid => env["vm"].uuid
          env.env.update_dotfile

          @app.call(env)
        end
      end
    end
  end
end
