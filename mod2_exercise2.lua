local craftRecipes = {
  {
    name = 'chair', 
    ingredients = {
      { name = 'wood', count = 4 },
      { name = 'paint', count = 1 },
      { name = 'nail', count = 4 },
    },
  },
  {
    name = 'table', 
    ingredients = {
      { name = 'wood', count = 8 },
      { name = 'paint', count = 1 },
      { name = 'nail', count = 4 },
    },
  },
  {
    name = 'halloween costume', 
    ingredients = {
      { name = 'pumpkin', count = 1 },
      { name = 'cloth', count = 8 },
    },
  },
  {
    name = 'stone axe',
    ingredients = {
      { name = 'wood', count = 2 },
      { name = 'stone', count = 2 },
    },
  },
}

local craftsByIngredient = {}

local function setupCraftsByIngredient()
    for _, recipe in ipairs(craftRecipes) do
      for _, ingredient in ipairs(recipe.ingredients) do
        local ingredientName = ingredient.name

        if not craftsByIngredient[ingredientName] then
          craftsByIngredient[ingredientName] = {}
        end

        table.insert(craftsByIngredient[ingredientName], recipe)
      end
    end
end

local function getRecipes()
  return craftRecipes
end

local function getRecipesByIngredientName(name)
  return craftsByIngredient[name] or {}
end

local function getAvailableRecipes(playerIngredients)

  local playerInventory = {}
  for _, ingredient in ipairs(playerIngredients) do
    playerInventory[ingredient.name] = ingredient.count
  end

  local availableRecipes = {}

  for _, recipe in ipairs(craftRecipes) do
    local hasAllIngredients = true

    for _, ingredient in ipairs(recipe.ingredients) do
      if (playerInventory[ingredient.name] or 0) < ingredient.count then
        hasAllIngredients = false
        break
      end
    end

    if hasAllIngredients then
      availableRecipes[#availableRecipes + 1] = recipe
    end
  end

  return availableRecipes
end

local function main()
  setupCraftsByIngredient()

  local recipesWithWood = getRecipesByIngredientName("wood")


  local available = getAvailableRecipes({
    { name = 'wood', count = 8 },
    { name = 'nail', count = 4 },
    { name = 'paint', count = 30 },
  })

  local recipeNames = {}
  for _, recipe in ipairs(available) do
    table.insert(recipeNames, "- " .. recipe.name)
  end
  print("Available recipes:\n" .. table.concat(recipeNames, "\n"))

end

main()
