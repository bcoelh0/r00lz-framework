require "r00lz/version"

module R00lz
  class App
    def call(env)
      kl, act = cont_and_act(env)
      text = kl.new(env).send(act)
      [
        200,
        { 'Content-Type' => 'text/html' },
        [text]
      ]
    end

    private

    def cont_and_act(env)
      _, con, act, after = env["PATH_INFO"].split('/')
      con = con.capitalize + "Controller"
      # Object.const_get(con) --> get class with the name passed.
      # So it'll get the controller class.
      [Object.const_get(con), act]
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end

  class Error < StandardError; end
end
