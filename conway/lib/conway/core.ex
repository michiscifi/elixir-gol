defmodule Conway.Core do
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
      8 => :dead
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

  """
  def set_dead(world, index) do
    %{world | index => :dead}
  end
end
