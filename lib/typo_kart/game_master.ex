defmodule TypoKart.GameMaster do
  use GenServer

  alias TypoKart.{
    Game,
    Course,
    Path,
    PathCharIndex
  }

  def start_link(_init \\ nil) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_init \\ nil) do
    {:ok, %{
      games: %{}
    }}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:new_game, game}, _from, state) do
    id = UUID.uuid1()
    {:reply, id, put_in(state, [:games, id], game)}
  end

  def state do
    GenServer.call(__MODULE__, :state)
  end

  def new_game(%Game{} = game \\ %Game{}) do
    GenServer.call(__MODULE__, {:new_game, game})
  end

  @spec char_from_course(Course.t(), PathCharIndex.t()) :: char() | nil
  def char_from_course(%Course{paths: paths}, %PathCharIndex{path_index: path_index, char_index: char_index}) do
    with %Path{} = path <- Enum.at(paths, path_index),
      chars when is_list(chars) <- Map.get(path, :chars) do
        Enum.at(chars, char_index)
    else
      _ ->
        nil
    end
  end
end
