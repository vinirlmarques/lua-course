require('./mod5_exercise1/helpers')

local const = require('./mod5_exercise1/const')

function main()
  print('Welcome to Game Platform\n')

  print('Which game do you want to play?')

  local games = const.games
  for i,gameConfig in ipairs(games) do
    print(i .. ' - ' .. gameConfig.name)
  end

  local gameId = readNumber('Choose the game: ', 1, #games, 'Invalid choice. Try again.')
  local gameConfig = games[gameId]

  local difficulties = const.difficulties
  local difficultySelected = false

  while not difficultySelected do
    print('Choose the difficulty:')
    for i,difficulty in ipairs(difficulties) do
      print(i .. ' - ' .. difficulty.name)
    end

    local difficultyId = readNumber('Choose the difficulty: ', 1, #difficulties + 1, 'Invalid choice. Try again.')
    if difficultyId == #difficulties + 1 then
      gameConfig.cheatMode = true
    else
      gameConfig.difficulty = difficulties[difficultyId]
      difficultySelected = true
    end
  end

  local GameClass = require(gameConfig.filename)
  local game = GameClass.create(gameConfig)
  game:run()
end

main()
