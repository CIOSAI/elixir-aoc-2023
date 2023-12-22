defmodule Aoc.Day1 do
  def choose_number(str) do
    String.split(str, "", trim: true)
    |> Enum.filter(fn (ch) -> String.match?(ch, ~r/[0-9]/) end)
  end

  def to_int(str) do Integer.parse(str) |> elem(0) end

  def as_num(l) do
    to_int(List.first(l)) * 10 + to_int(List.last(l))
  end

  def first_part(input) do
    input
    |> String.split
    |> List.foldl(0, fn str, acc ->
      (choose_number(str) |> as_num()) + acc
    end)
  end

  @eng_numbers ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

  def eng_to_int(str) do
    Enum.find_index(@eng_numbers, fn eng -> str == eng end) + 1
  end

  def replace_to_int(str) do
    String.replace(str, @eng_numbers, fn match ->
      (eng_to_int(match) |> Integer.to_string) <> String.last(match)
    end)
  end

  def second_part(input) do
    input
    |> String.split
    |> Enum.map(fn str -> str |> replace_to_int() |> replace_to_int() end)
    |> List.foldl(0, fn str, acc ->
      (choose_number(str) |> as_num()) + acc
    end)
  end

end

defmodule Aoc.Day2 do
  def entries_extract(str) do
    str
    |> String.split(",")
    |> Enum.map(fn column ->
      column |> String.split |> List.to_tuple
    end)
    |> Enum.map(fn column ->
      { elem(column, 1), elem(column, 0) |> Integer.parse |> elem(0) }
    end)
    |> Map.new
  end

  @subject_to %{"red" => 12, "green" => 13, "blue" => 14}

  def get_game_index(str) do
    str |> String.replace("Game ", "") |> Integer.parse |> elem(0)
  end

  def fit_constraints(reveal_list) do
    Enum.all?(reveal_list, fn m ->
      Enum.all?(@subject_to, fn {k, v} -> Map.get(m, k, 0) <= v end)
    end)
  end

  def game_to_val(tup) do
    if fit_constraints(elem(tup, 1)) do elem(tup, 0)
    else 0
    end
  end

  def first_part(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn i ->
      i
      |> String.split(":") |> List.to_tuple
      |> then(fn entry ->
        {
          elem(entry, 0) |> get_game_index(),
          elem(entry, 1) |> String.split(";") |> Enum.map(fn reveal ->
            entries_extract(reveal)
          end)
        }
        end)
      |> game_to_val()
    end)
    |> Enum.sum
  end

  def max_of_color(list_of_maps, color) do
    list_of_maps
    |> Enum.map(fn j -> Map.get(j, color, 0) end)
    |> Enum.max
  end

  def second_part(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn i ->
      i
      |> String.split(":") |> List.to_tuple
      |> elem(1) |> String.split(";") |> Enum.map(fn reveal ->
        entries_extract(reveal)
      end)
    end)
    |> Enum.map(fn i ->
      max_of_color(i, "red") * max_of_color(i, "green") * max_of_color(i, "blue")
    end)
    |> Enum.sum

  end

end
