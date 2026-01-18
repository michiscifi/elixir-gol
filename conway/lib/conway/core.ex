defmodule Conway.Core do
  @moduledoc """
  Core functionality for Conway's Game of Life.

  This module provides functions to create and manipulate a Game of Life world.
  The world is represented as a one-dimensional map where keys are integer positions
  and values are cell states (`:alive` or `:dead`).

  While the world is conceptually a two-dimensional grid, it uses a flattened
  one-dimensional representation for efficient neighbor calculations.
  """

  @doc """
  Creates a world.
  The world is a one dimensional map
  which keys are integers.

  A key is a position in the world, and can be used
  to express the relations to its neighbors of the cell.

  The values of a cell - here a map entry - can be `:dead` or `:alive`.

  `xbase` is the length of a two-dimensional quadratic world.
  However, the created Map is one-dimensional

  This representation allows simple and efficient neighbor calculations.

  ## Examples

      iex> Conway.Core.create_world(3)
      %{
        0 => :dead,
        1 => :dead,
        2 => :dead,
        3 => :dead,
        4 => :dead,
        5 => :dead,
        6 => :dead,
        7 => :dead,
        8 => :dead,
      }
  """
  def create_world(xbase) when xbase > 0 do
    first_index = 0
    last_index = xbase * xbase - 1

    first_index..last_index
    |> Enum.to_list()
    |> Map.from_keys(:dead)
  end

  @doc """
  Worlds are quadratic. Computes the base of a world.

  ## Examples
    iex> w = Conway.Core.create_world(3)
    iex> Conway.Core.get_xbase(w)
    3
  """
  def get_xbase(world) do
    world
    |> Enum.count()
    |> :math.sqrt()
    |> trunc
  end

  @doc """
  Marks the cell at `index` as `:alive`.

  Expects that the cell already exists in the world.

  ## Examples

    iex> Conway.Core.set_alive(%{0 => :dead}, 0)
    %{0 => :alive}

  """
  def set_alive(world, index) do
    %{world | index => :alive}
  end

  @doc """
  Marks the cell at `index` as `:dead`.

  Expects that the cell already exists in the world.

  ## Examples

    iex> Conway.Core.set_dead(%{0 => :alive}, 0)
    %{0 => :dead}

  """
  def set_dead(world, index) do
    %{world | index => :dead}
  end

  @doc """
  Determines the neighbors of a cell in a (quadratic) world,
  where the cell is expressed by its index and the world by its xbase.
  Keep im mind that the world is a closed torus.

  Returns neighbors in this order: [NW, N, NE, W, E, SW, S, SE]

  Example world (3x3):

  +-+-+-+
  |0|1|2|
  +-+-+-+
  |3|4|5|
  +-+-+-+
  |6|7|8|
  +-+-+-+

  The neighbors of cell 4 would be: [0, 1, 2, 3, 5, 6, 7, 8]
  The neighbors of cell 0 would be: [8, 6, 7, 2, 1, 5, 3, 4]

  ## Examples

    iex> Conway.Core.neighbors(4, 3)
    [0, 1, 2, 3, 5, 6, 7, 8]

    iex> Conway.Core.neighbors(0, 3)
    [8, 6, 7, 2, 1, 5, 3, 4]

  """
  def neighbors(index, xbase) do
    [
      index |> top(xbase) |> left(xbase),
      index |> top(xbase),
      index |> top(xbase) |> right(xbase),
      index |> left(xbase),
      index |> right(xbase),
      index |> bottom(xbase) |> left(xbase),
      index |> bottom(xbase),
      index |> bottom(xbase) |> right(xbase)
    ]
  end

  def left(index, xbase) do
    unless Integer.mod(index, xbase) === 0 do
      index - 1
    else
      index - 1 + xbase
    end
  end

  def right(index, xbase) do
    unless is_right_edge(index, xbase) do
      index + 1
    else
      index + 1 - xbase
    end
  end

  def top(index, xbase) do
    unless is_top_edge(index, xbase) do
      index - xbase
    else
      index - xbase + xbase * xbase
    end
  end

  def bottom(index, xbase) do
    unless is_bottom_edge(index, xbase) do
      index + xbase
    else
      index + xbase - xbase * xbase
    end
  end

  def is_top_edge(index, xbase) do
    index < xbase
  end

  def is_left_edge(index, xbase) do
    Integer.mod(index, xbase) === 0
  end

  def is_right_edge(index, xbase) do
    Integer.mod(index, xbase) === xbase - 1
  end

  def is_bottom_edge(index, xbase) do
    xbase * xbase - index <= xbase
  end

  def next_generation(world) do
    xbase = get_xbase(world)

    Enum.map(world, fn {index, value} ->
      number_of_living_neighbors =
        neighbors(index, xbase)
        |> Enum.count(fn item -> world[item] == :alive end)

      next_gen_value =
        case number_of_living_neighbors do
          3 ->
            :alive

          2 when value == :alive ->
            :alive

          _ ->
            :dead
        end

      {index, next_gen_value}
    end)
    |> Map.new()
  end

  @doc """
  Creates a string representation of a world.

  ## Examples
    iex> 3 |> Conway.Core.create_world |> Conway.Core.set_alive(4) |> Conway.Core.format_world
    " o  o  o \\n o  x  o \\n o  o  o \\n"
  """
  def format_world(world) do
    xbase = get_xbase(world)

    Enum.map(world, fn {index, value} ->
      symbol =
        case value do
          :alive -> " x "
          :dead -> " o "
        end

      case rem(index + 1, xbase) do
        0 ->
          "#{symbol}\n"

        _ ->
          "#{symbol}"
      end
    end)
    |> Enum.join()
  end
end
