cyan = love.graphics.newImage("cyan.png")
yellow = love.graphics.newImage("yellow.png")
purple = love.graphics.newImage("purple.png")
orange = love.graphics.newImage("orange.png")
pink = love.graphics.newImage("pink.png")
green = love.graphics.newImage("green.png")
red = love.graphics.newImage("red.png")

pieceStructures = {
    {
        {
            {' ', ' ', ' ', ' '},
            {cyan, cyan, cyan, cyan},
            {' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', cyan, ' ', ' '},
            {' ', cyan, ' ', ' '},
            {' ', cyan, ' ', ' '},
            {' ', cyan, ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {' ', yellow, yellow, ' '},
            {' ', yellow, yellow, ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {purple, purple, purple, ' '},
            {' ', ' ', purple, ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', purple, ' ', ' '},
            {' ', purple, ' ', ' '},
            {purple, purple, ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {purple, ' ', ' ', ' '},
            {purple, purple, purple, ' '},
            {' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', purple, purple, ' '},
            {' ', purple, ' ', ' '},
            {' ', purple, ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {orange, orange, orange, ' '},
            {orange, ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', orange, ' ', ' '},
            {' ', orange, ' ', ' '},
            {' ', orange, orange, ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', ' ', orange, ' '},
            {orange, orange, orange, ' '},
            {' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {orange, orange, ' ', ' '},
            {' ', orange, ' ', ' '},
            {' ', orange, ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {pink, pink, pink, ' '},
            {' ', pink, ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', pink, ' ', ' '},
            {' ', pink, pink, ' '},
            {' ', pink, ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', pink, ' ', ' '},
            {pink, pink, pink, ' '},
            {' ', ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', pink, ' ', ' '},
            {pink, pink, ' ', ' '},
            {' ', pink, ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {' ', green, green, ' '},
            {green, green, ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {green, ' ', ' ', ' '},
            {green, green, ' ', ' '},
            {' ', green, ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
    {
        {
            {' ', ' ', ' ', ' '},
            {red, red, ' ', ' '},
            {' ', red, red, ' '},
            {' ', ' ', ' ', ' '},
        },
        {
            {' ', red, ' ', ' '},
            {red, red, ' ', ' '},
            {red, ' ', ' ', ' '},
            {' ', ' ', ' ', ' '},
        },
    },
}


