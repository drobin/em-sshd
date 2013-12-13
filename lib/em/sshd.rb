require "eventmachine"
require "nexop"

require "em/nexop/version"
require "em/nexop/server"

module EventMachine
  module Nexop
    # Your code goes here...
  end
end

module EventMachine
  class Sshd < Connection
    include EventMachine::Nexop
    include EventMachine::Nexop::Server
  end
end
