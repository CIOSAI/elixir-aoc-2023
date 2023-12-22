FROM elixir:latest as base

LABEL author="CIOSAI (JunYou Guo)"

WORKDIR /usr/src/app

COPY ./inputs ./inputs
COPY ./lib ./lib
COPY ./test ./test
COPY mix.exs mix.exs

CMD ["iex"]