require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'
require 'wirble'
 
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
 
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:EVAL_HISTORY] = 100
IRB.conf[:USE_READLINE] = true

Wirble.init
Wirble.colorize