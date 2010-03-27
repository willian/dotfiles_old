unless defined?(RUBY_ENGINE) && RUBY_ENGINE == "macruby"
  gems = %w(rubygems irb/completion irb/ext/save-history pp hirb wirble)

  gems.each do |gem_name|
    begin
      require gem_name
    rescue LoadError
    end
  end

  if RUBY_VERSION < "1.9"
    require "ruby-debug"
  else
    require "ruby-debug19"
  end

  # Load some libraries
  require "date"
  require "time"

  if defined?(IRB)
    IRB.conf[:SAVE_HISTORY] = 1000
    IRB.conf[:HISTORY_FILE] = "#{ENV["HOME"]}/.irb_history"
    IRB.conf[:AUTO_INDENT]  = true
    IRB.conf[:EVAL_HISTORY] = 1000
    IRB.conf[:USE_READLINE] = true

    version = "\033[1;30m#{RUBY_VERSION}\033[0m"

    IRB.conf[:PROMPT][:CUSTOM] = {
      :PROMPT_C => "#{version} \033[0;33m?>\033[0m ",
      :RETURN   => "=> %s\n",
      :PROMPT_I => "#{version} \033[0;33m>>\033[0m ",
      :PROMPT_N => "#{version} \033[0;33m>>\033[0m ",
      :PROMPT_S => nil
    }
    IRB.conf[:PROMPT_MODE] = :CUSTOM
  end

  if defined?(Wirble)
    Wirble.init
    Wirble.colorize
  end

  if defined?(Hirb)
    Hirb.enable
    extend Hirb::Console
  end

  if rails_env = ENV["RAILS_ENV"]
    IRB.conf[:IRB_RC] = Proc.new do
      # Replace ActiveRecord logger
      ActiveRecord::Base.logger = Logger.new(STDOUT)

      # Set up ActiveRecord shortcut
      ActiveRecord::Base.instance_eval { alias :[] :find }
    end

    # Set short environment name for prompt
    envs = { "development" => "dev", "production" => "prod" }
    env = envs[rails_env] || rails_env
    env = "\033[1;30m#{env.upcase}\033[0m"

    IRB.conf[:PROMPT] ||= {}
    IRB.conf[:PROMPT][:RAILS] = {
      :PROMPT_C => "#{env} \033[0;33m?>\033[0m ",
      :RETURN   => "=> %s\n",
      :PROMPT_I => "#{env} \033[0;33m>>\033[0m ",
      :PROMPT_N => "#{env} \033[0;33m>>\033[0m ",
      :PROMPT_S => nil
    }
    IRB.conf[:PROMPT_MODE] = :RAILS

    # Empty every single log
    Dir["log/**/*.log"].each do |file|
      system "> #{file}"
    end
  end
end