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
    |> Enum.map(&( &1 |> String.split |> List.to_tuple ))
    |> Enum.map(&{ elem(&1, 1), elem(&1, 0) |> Integer.parse |> elem(0) })
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
          elem(entry, 1) |> String.split(";") |> Enum.map(&entries_extract/1)
        }
        end)
      |> game_to_val()
    end)
    |> Enum.sum
  end

  def max_of_color(list_of_maps, color) do
    list_of_maps
    |> Enum.map(&(Map.get(&1, color, 0)))
    |> Enum.max
  end

  def second_part(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn i ->
      i
      |> String.split(":") |> List.to_tuple
      |> elem(1) |> String.split(";") |> Enum.map(&entries_extract/1)
    end)
    |> Enum.map(&(
      max_of_color(&1, "red") * max_of_color(&1, "green") * max_of_color(&1, "blue")
    ))
    |> Enum.sum

  end

end

defmodule Aoc.Day4 do
  def str_to_int_list(str) do
    str |> String.split |> Enum.map(&Integer.parse/1) |> Enum.map(&(elem(&1, 0)))
  end

  def first_part(input) do
    input |> String.split("\n")
    |> Enum.map(&(&1 |> String.replace(~r/Card\s+[0-9]+:/, "")))
    |> Enum.map(&(&1 |> String.split("|") |> List.to_tuple))
    |> Enum.map(fn {fst, snd} -> {str_to_int_list(fst) |> MapSet.new, str_to_int_list(snd) |> MapSet.new} end)
    |> Enum.map(fn {fst, snd} -> MapSet.intersection(fst, snd) |> MapSet.size end)
    |> Enum.map(&(if &1==0 do 0 else 2**(&1-1) end))
    |> Enum.sum
  end

  def scratch([head | tail], acc) do
    # current index
    i = head |> elem(0)

    # splits every cards after into
    tail_split = tail |> Enum.group_by(fn {j, _} -> j==i end)
    # those with the same index (thus same score, and wins the same cards)
    same_ind = Map.get(tail_split, true, [])
    # those without (thus win different cards and need to be evaluated)
    leftover = Map.get(tail_split, false, [])

    won_cards = if elem(head, 1) == 0 do []
    else
      tail
      # all cards from index+1 to index+score
      # example:
      # {0, 4} wins cards of indices 1 to 0+4 i.e. 1, 2, 3, 4
      |> Enum.filter(fn {j, _} ->
          Enum.member?((i+1)..(i+elem(head, 1)), j)
        end)
      # since the tail may have multiple copies of the same card
      # we check the index, and keep only 1 of each index
      |> Enum.group_by(&(elem(&1, 0)), &(&1))
      |> Map.values
      # the values are wrapped in list because they are technically groups?
      |> Enum.map(&hd/1)
      # duplicate the all the cards this card won by the amount of cards with the winning
      |> List.duplicate(length(same_ind)+1)
      |> List.flatten
    end

    # dbg(i)
    # dbg(won_cards)
    # dbg(Enum.frequencies_by(acc++won_cards, &(elem(&1, 0))))

    scratch(won_cards ++ leftover, acc++won_cards)
  end

  def scratch([], acc) do acc end

  def second_part(input) do
    score_list = input |> String.split("\n")
    |> Enum.map(&(&1 |> String.replace(~r/Card\s+[0-9]+:/, "")))
    |> Enum.map(&(&1 |> String.split("|") |> List.to_tuple))
    |> Enum.map(fn {fst, snd} -> {str_to_int_list(fst) |> MapSet.new, str_to_int_list(snd) |> MapSet.new} end)
    |> Enum.map(fn {fst, snd} -> MapSet.intersection(fst, snd) |> MapSet.size end)

    # list of {index, score}
    indexed = Enum.zip(0..(length(score_list)-1), score_list)

    # count total cards won + initial cards
    (scratch(indexed, []) ++ indexed)
    |> Enum.count
  end
end

defmodule Aoc.Day26 do
  def first_part(input) do
  end

  def second_part(input) do
  end
end
