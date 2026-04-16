local const = {
  games = {
    {
      name = 'Sudoku',
      filename = './mod5_exercise1/sudoku',
    },
    {
      name = 'Minesweeper',
      filename = './mod5_exercise1/minesweeper',
      difficulties = {
        {
          name = 'Easy',
          rows = 9,
          cols = 9,
          bombs = 20
        },
        {
          name = 'Medium',
          rows = 15,
          cols = 15,
          bombs = 70
        },
        {
          name = 'Hard',
          rows = 100,
          cols = 100,
          bombs = 1000
        }
      }
    }
  }
}

return const
