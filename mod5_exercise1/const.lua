local const = {
  games = {
    {
      name = 'Sudoku',
      filename = './mod5_exercise1/sudoku',
    }
    ,
    {
      name = 'Minesweeper',
      filename = './mod5_exercise1/minesweeper',
    }
  },
  difficulties = {
    {
      name = 'Easy',
      rows = 9,
      cols = 9,
      bombs = 10
    },
    {
      name = 'Medium',
      rows = 30,
      cols = 30,
      bombs = 50
    },
    {
      name = 'Hard',
      rows = 100,
      cols = 100,
      bombs = 99
    }
  }
}

return const
