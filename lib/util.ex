defmodule Util do
  def input_for_day(n) do
    File.read!("inputs/day#{n}.txt")
  end
end
