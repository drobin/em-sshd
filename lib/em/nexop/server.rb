module EventMachine
  module Nexop
    module Server
      include ::Nexop::Log

      def session
        @session ||= ::Nexop::Session.new
      end

      def post_init
        session.on_obuf do |buf|
          nwritten = send_data(buf)
          buf[0, nwritten] = ""
          log.debug("#{nwritten} bytes written")
        end

        session.tick
      end

      def receive_data(data)
        log.debug("#{data.size} bytes read")
        session.ibuf += data
        session.tick
      end
    end
  end
end
