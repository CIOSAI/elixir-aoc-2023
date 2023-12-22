defmodule AocTest do
  def rd(d, p) do
    File.read!("test/inputs/#{d}-#{p}.txt")
  end

  use ExUnit.Case


  doctest Aoc.Day1

  test "day1 : 1" do
    assert rd(1, 1) |> Aoc.Day1.first_part == 142
  end
  test "day1 : 2" do
    assert rd(1, 2) |> Aoc.Day1.second_part == 281
  end


  doctest Aoc.Day2

  test "day2 : 1" do
    assert rd(2, 1) |> Aoc.Day2.first_part == 142
  end
  test "day2 : 2" do
    assert rd(2, 2) |> Aoc.Day2.second_part == 281
  end
end
