class CandleAccess
  include ActiveModel::Model

  attr_accessor :candle_format, :granularity, :instrument
  attr_accessor :count, :start

  validates :candle_format, presence: true
  validates :granularity, presence: true
  validates :instrument, presence: true
  validates :count, numericality: {greater_than: 0, less_than: 5001, only_integer: true}
  validates :start, format: {with: /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}[+-]+\d{2}:\d{2}\z/}

  def client
    @client ||= Mishina::Oanda::ClientFactory.client
  end

  def access
    self.start = transform_start(start)
    client.candles(candle_params).get.instance_variable_get(:@collection)
  end

  def transform_start(start)
    Time.parse(start).utc.strftime('%Y-%m-%dT%H:%M:%S%z')
  end

  def candle_params
    {
      candle_format: candle_format,
      granularity: granularity,
      instrument: instrument,
      count: count,
      start: start
    }
  end
end
