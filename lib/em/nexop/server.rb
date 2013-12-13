module EventMachine
  module Nexop
    module Server
      include ::Nexop::Log

      attr_accessor :hostkey

      def session
        @session ||= ::Nexop::Session.new
      end

      def post_init
        unless hostkey
          raise ArgumentError, "no hostkey available"
        end

        session.hostkey = hostkey

        session.on_obuf do |buf|
          nwritten = send_data(buf)
          buf[0, nwritten] = ""
          log.debug("#{nwritten} bytes written")
        end

        session.tick

        log.info("session is open")
      end

      def unbind
        log.info("session is closed")
      end

      def receive_data(data)
        log.debug("#{data.size} bytes read")
        session.ibuf += data
        session.tick
      end
    end
  end
end
