local words = {"hello", "quiz", "text", "ch" .. "air"}
local guessedLetters = {}

math.randomseed(os.time())
local word = words[math.random(#words)] --> # shorthand for len(words)

local correctGuesses = 0
local incorrectGuesses = 0

local CONST_MAX_INCORRECT = 7

local function printTable()
    io.write("Currently guessed: ")
    for i, item in ipairs(guessedLetters) do
        io.write(item)
    end
    print()
end

local function checkIfLetterAlreadyGuessed(newLetter)
    for i, item in ipairs(guessedLetters) do
        if item == newLetter then
            print("letter already entered!")
            return true
        end
    end
    return false
end

local function checkIfCharInGuessed(character)
    for i, item in ipairs(guessedLetters) do
        if item == character then
            return true
        end
    end
    return false
end

local function checkIfGuessedInRandomWord()
    io.write("Word status: ")
    for char in string.gmatch(word, ".") do
        if checkIfCharInGuessed(char) then
            io.write(char)
        else
            io.write("_")
        end
        io.write(" ")
    end
    print()
end

local function getInput()
    while true do
        printTable()
        io.write("NEW letter to be entered: ")
        local input = io.read()
        print()
        if string.len(input) == 1 and not checkIfLetterAlreadyGuessed(input) then
            return input
        end
    end
end

local function count(base, pattern)
    return select(2, string.gsub(base, pattern, ""))
end

local function checkGuesses()
    correctGuesses = 0
    incorrectGuesses = 0
    for i, item in ipairs(guessedLetters) do
        if string.match(word, item) then
            correctGuesses = correctGuesses + count(word, item)
        else
            incorrectGuesses = incorrectGuesses + 1
        end
    end
end

local function printGuesses()
    print("Correct Guesses: " .. correctGuesses)
    print("Incorrect Guesses: " .. incorrectGuesses)
end

local function checkForWin()
    if correctGuesses == string.len(word) then
        return true
    end
    return false
end

local function checkForLoss()
    if incorrectGuesses == CONST_MAX_INCORRECT then
        return true
    end
    return false
end

local function wonMessage()
    print("You won, nice job!\n" .. "It was: " .. word .. "\n")
end

local function lostMessage()
    print("You lost, sorry!\n" .. "It was: " .. word .. "\n")
end

local function main()
    while true do
        checkGuesses()

        if checkForWin() then
            wonMessage()
            return
        elseif checkForLoss() then
            lostMessage()
            return
        end

        printGuesses()
        checkIfGuessedInRandomWord()

        local inputLetter = getInput()
        guessedLetters[#guessedLetters + 1] = inputLetter
    end
end

main()
