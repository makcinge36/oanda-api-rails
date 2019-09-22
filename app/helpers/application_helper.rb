module ApplicationHelper
  def render_notices
    render partial: 'partials/notices'
  end

  def candle_latest_time(candle)
    candle ? candle.time : '(なし)'
  end

  def check_icon(boolean)
    boolean ? 'glyphicon-check' : 'glyphicon-unchecked'
  end
end
