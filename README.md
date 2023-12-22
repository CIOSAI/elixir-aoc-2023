# Docker Image for Advent of Code in Elixir

[Advent of Code](https://adventofcode.com/)

[Elixir Language](https://elixir-lang.org/)

## How to use

1. run(local) `compose up -d` here
2. go to Docker Desktop or wherever you can interact with the container's terminal
3. paste the test input for day N in `test/inputs/N-1.txt`, second part in `test/inputs/N-2`
4. write your code at `lib/aoc.ex` under module `Aoc.DayN`
5. write the test for it at `test/aoc_test.exs`
6. run(container) `mix test` to see if your code is correct
7. paste the puzzle input for day N in `inputs/dayN.txt`
8. run(container) `iex -S mix` to open a interactive terminal with your code
9. run(container, in iex REPL) one of these :

`Util.input_for_day(1) |> Aoc.Day1.first_part`
`Util.input_for_day(1) |> Aoc.Day1.second_part`

10. find your output
11. answer that on AOC
12. get that star ⭐ !
