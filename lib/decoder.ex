defmodule Decoder do
use Bitwise


  def go do
    list = take_code()
    charlist =
      list
      |> List.delete_at(0)
      |> List.delete_at(0)

    key = String.to_integer(Enum.at(list,0) <> Enum.at(list,1), 16)

    list_of_bit = create_bits(charlist, [])

    email = list_of_bit |> decode(key) |> List.to_string

    IO.puts("Great! Your encoded email: #{email}")
  end
def create_bits([], acc) do
  acc
end

def create_bits([a, b | tail], acc) do
  bit = List.wrap(a <> b)
  create_bits(tail, acc ++ bit )
end

def decode(list_of_bit, key) do
  for n <- list_of_bit do
    charcode = String.to_integer(n, 16)
    <<Bitwise.bxor(key, charcode)::utf8>>
  end
end

def take_code do
  IO.gets("put string to decode: ")
    |> String.trim
    |> String.codepoints
end
end
