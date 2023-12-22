defmodule Aoc.Day1 do

  def first_part(input) do
    choose_number = fn str ->
      String.split(str, "", trim: true)
      |> Enum.filter(fn (ch) -> String.match?(ch, ~r/[0-9]/) end)
    end
    to_int = fn str -> Integer.parse(str) |> elem(0) end
    as_num = fn l -> to_int.(List.first(l)) * 10 + to_int.(List.last(l)) end

    input
    |> String.split
    |> List.foldl(0, fn str, acc ->
      (choose_number.(str) |> as_num.()) + acc
    end)
  end

  def second_part(input) do
    ""
  end

end

defmodule Aoc.Day2 do

  def first_part(input) do
    choose_number = fn str ->
      String.split(str, "", trim: true)
      |> Enum.filter(fn (ch) -> String.match?(ch, ~r/[0-9]/) end)
    end
    to_int = fn str -> Integer.parse(str) |> elem(0) end
    as_num = fn l -> to_int.(List.first(l)) * 10 + to_int.(List.last(l)) end

    input
    |> String.split
    |> List.foldl(0, fn str, acc ->
      (choose_number.(str) |> as_num.()) + acc
    end)
  end

  def second_part(input) do
    ""
  end

end
