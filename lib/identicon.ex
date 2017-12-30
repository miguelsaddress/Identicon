defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
  end

  @doc """
  Given a string `input` it returns an `Identicon.Image` struct with the value
  of `hex` filled up with a list og 16 integers between 0 and 255

  ## Examples

      iex> Identicon.hash_input("hash")
      %Identicon.Image{color: nil,
       hex: [8, 0, 252, 87, 114, 148, 195, 78, 11, 40, 173, 40, 57, 67, 89, 69]}

  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  @doc """
  Given an `image` of type `Identicon.Image` with a non empty `hex` property
  It will return a new `Identicon.Image` with the `color` property filled up

  ## Examples

      iex> image = %Identicon.Image{hex: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]}
      iex> Identicon.pick_color(image)
      %Identicon.Image{hex: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], color: {1,2,3}}

  """
  def pick_color(%Identicon.Image{hex: [r,g,b | _tail]} = image) do
    %Identicon.Image{image | color: {r,g,b}}
  end

  @doc """
  Given an `Identicon.Image` struct with the value of `hex` properly filled,
  it will return a list of 25 tuples of {number, index}, every 5 tuples
  representing a row, where each raw has 3 elements from `hex` followed by the
  repetition of the 2nd and 1st numbers respectively.

  ## Examples

    iex> image = %Identicon.Image{hex: [8, 0, 252, 87, 114, 148, 195, 78, 11, 40, 173, 40, 57, 67, 89, 69]}
    iex> %Identicon.Image{grid: grid} = Identicon.build_grid(image)
    iex> grid
    [{8, 0}, {0, 1}, {252, 2}, {0, 3}, {8, 4}, {87, 5}, {114, 6}, {148, 7},
    {114, 8}, {87, 9}, {195, 10}, {78, 11}, {11, 12}, {78, 13}, {195, 14},
    {40, 15}, {173, 16}, {40, 17}, {173, 18}, {40, 19}, {57, 20}, {67, 21},
    {89, 22}, {67, 23}, {57, 24}]

  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Given a row containing 3 elements, returns a list containing those 3 elements
  in the same given order but followed by the second and the first elements

  ## Examples

    iex> Identicon.mirror_row([1,2,3])
    [1,2,3,2,1]

  """
  def mirror_row([a,b,c]) do
    [a,b,c,b,a]
  end

  @doc """
  Given an `Identicon.Image` struct filters out the pairs of the grid which
  value is odd

  ## Examples

  iex> image = %Identicon.Image{hex: [8, 0, 252, 87, 114, 148, 195, 78, 11, 40, 173, 40, 57, 67, 89, 69]}
  iex> image = Identicon.build_grid(image)
  iex> %Identicon.Image{grid: grid} = Identicon.filter_odd_squares(image)
  iex> grid
  [{8, 0}, {0, 1}, {252, 2}, {0, 3}, {8, 4}, {114, 6}, {148, 7}, {114, 8},
  {78, 11}, {78, 13}, {40, 15}, {40, 17}, {40, 19}]

  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    even_nums = Enum.filter grid, fn({num, _index}) ->
      rem(num, 2) == 0
    end

    %Identicon.Image{image | grid: even_nums}
  end
end
