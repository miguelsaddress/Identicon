defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "no element of the hex list is lower than 0 nor greater than 255" do
    %Identicon.Image{hex: hex_list} = Identicon.hash_input("hash")
    for e <- hex_list do
      assert e >= 0
      assert e <= 255
    end
  end
  
end
