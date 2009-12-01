gems = %w(rubygems irb/completion irb/ext/save-history pp wirble hirb ruby-debug)
 
gems.each do |gem_name|
  begin
    require gem_name
  rescue LoadError
    STDOUT << "Cannot load #{gem_name.inspect}\n"
  end
end

if defined?(IRB)
  IRB.conf[:SAVE_HISTORY] = 100
  IRB.conf[:HISTORY_FILE] = "#{ENV["HOME"]}/.irb_history"
  IRB.conf[:PROMPT_MODE]  = :SIMPLE
  IRB.conf[:AUTO_INDENT]  = true
  IRB.conf[:EVAL_HISTORY] = 100
  IRB.conf[:USE_READLINE] = true
end

# try to load rubygems
begin
  require "rubygems"
  puts "Rubygems loaded."
rescue LoadError => e
  puts "Seems you don't have Rubygems installed: #{e}"
end

if defined?(Wirble) 
  Wirble.init
  Wirble.colorize
end

if defined?(Hirb)
  Hirb.enable
  extend Hirb::Console
end
 
# Log to STDOUT if in Rails
if ENV.include?("RAILS_ENV") && !defined?(RAILS_DEFAULT_LOGGER)
 require "logger"
 RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

