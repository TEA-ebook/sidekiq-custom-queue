module Sidekiq
  module CustomQueue
    class ClientMiddleware
      def call(worker_class, msg, queue, _redis_pool)
        worker = worker_class.is_a?(String) ? worker_class.constantize : worker_class
        msg['queue'] = worker.custom_queue(msg).to_s if worker.respond_to?(:custom_queue)
        yield
      end
    end
  end
end
