class GaijinPotWorker
  include Sidekiq::Worker

  def perform(*args)
    GaijinPotRetrievalService.new.call
  end
end
