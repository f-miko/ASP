# ASP
ASP: Answer set programming. A declarative programming paradigm for NP-hard search problems.Collection of examples, programs, small projects from my ASP class and beyond.
## Main resource
All kinds of resources about ASP, i.e. lecture material, source code, tutorial can be found at [Potassco](https://potassco.org/).

## Solved problems so far
### Sudoku
[Sudoku](https://en.wikipedia.org/wiki/Sudoku) is probably familiar to most. Instances were transcribed from [here](https://sudoku.tagesspiegel.de/).
The sudoku problem was given as a class assignment.
### Yosenabe
[Yosenabe](https://www.janko.at/Raetsel/Yosenabe/index.htm) is another logic riddle. The board is made of up numbers and areas. 
The numbers have to be moved across the board in only one direction into the areas. No empty areas are allowed. No numbers must cross.
For some areas, a sum is given. That sum has to be reached with the numbers moved into the given area. See link at the beginning for 
a more detailed explananation and a interface to try some puzzles. Problem instances were taken from the link as well.
The Yosenabe problem was given as a class assignment.
### Minotaurus
[Minotaurus](https://www.janko.at/Spiele/Minotaurus/index.htm) is another logic riddle. Given a board, where some cells are separated by walls,
the goal is to move Theseus towards the goal without begin eaten by the Minotaur. Based on Greek [myth](https://en.wikipedia.org/wiki/Minotaur).
Theseus can move once per step, the Minotaur twice but only deterministically. Walls can't be crossed. For detailed rules see link at beginning. 
This problem was given as a class assignment. The solution is far from optimal, though it wasn't the worst performing either :).
Instances with a lot of walls can take incredibly long, e.g. level02.lp currently takes up to 1 minute. Instances were taken from the link 
at the beginning. 

### Rullo
I found the game app Rullo in the Google App store. Or rather, it was proposed to me by the App store. The game can also be played on 
[Kongregate](https://www.kongregate.com/games/crescentyr/rullo). Given a number of matrix and predefined column and row sums, the numbers
within the matrix have to be selected/deselected such that all row and column sums match the predefined values.
