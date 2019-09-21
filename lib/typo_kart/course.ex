defmodule TypoKart.Course do
  alias TypoKart.{
    Path,
    PathCharIndex
  }

  defstruct initial_rotation: 0,
    base_translate_x: 0,
    base_translate_y: 0,
    marker_center_offset_x: 0,
    marker_center_offset_y: 0,
    view_box: "",
    paths: [],
    path_branches: []

  @type t :: %__MODULE__ {
    initial_rotation: integer(),
    base_translate_x: integer(),
    base_translate_y: integer(),
    view_box: binary(),
    marker_center_offset_x: integer(),
    marker_center_offset_y: integer(),
    paths: list(Path.t()),
    path_branches: list(PathCharIndex.t())
  }
end
