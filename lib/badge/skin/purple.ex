defmodule Badge.Skin.Purple do
  @moduledoc """
  Lavender on deep violet, with a thin rule under the title bar.
  """

  @behaviour Badge.Skin

  alias Badge.Icons
  alias Badge.Theme

  @status_y 3
  @status_margin 6
  @status_gap 6
  @status_w elem(Icons.size(:battery_100), 0)
  @battery_x Theme.width() - @status_margin - @status_w
  @wifi_x @battery_x - @status_gap - @status_w
  @char_w 8

  @impl true
  def name, do: "Purple"

  @impl true
  def bg, do: 0x140A24
  @impl true
  def fg, do: 0xEFE6FF
  @impl true
  def muted, do: 0xB39DDB
  @impl true
  def dim, do: 0x5E4480
  @impl true
  def accent, do: 0xC77DFF
  @impl true
  def ok, do: 0x7EE0A0
  @impl true
  def warn, do: 0xFFD166
  @impl true
  def alert, do: 0xFF6B9D
  @impl true
  def select, do: 0xE9B8FF
  @impl true
  def glyph, do: 0xFFFFFF

  @impl true
  def chrome(title, status) do
    [
      Icons.item(status.battery, @battery_x, @status_y, glyph(), bg()),
      Icons.item(status.wifi, @wifi_x, @status_y, glyph(), bg()),
      clock_item(status.clock),
      {:text, @status_margin, @status_y, :pixel_operator, accent(), bg(), title}
    ] ++
      rule(0, Theme.bar_h(), Theme.width()) ++
      [{:rect, 0, 0, Theme.width(), Theme.height(), bg()}]
  end

  @impl true
  def rule(x, y, w), do: [{:rect, x, y, w, 1, dim()}]

  # default16px is 8px per character, so this is the one thing in the bar that can be centred.
  defp clock_item(clock) do
    x = div(Theme.width() - @char_w * byte_size(clock), 2)

    {:text, x, @status_y, :default16px, dim(), bg(), clock}
  end
end
