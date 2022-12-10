% sudoku.pl
%
% This program defines a `sudoku/1` predicate that solves a sudoku puzzle. The
% puzzle is represented as a list of lists, with each inner list representing a
% row of the puzzle.
%
%
% Author: Your Name (PouyaHallaj@Gmail.com)
%
% License: This code is in the public domain.
:- use_module(library(clpfd)).
% sudoku(Puzzle)
%
% Solves the sudoku puzzle represented by Puzzle. Puzzle should be a list of
% lists, with each inner list representing a row of the puzzle. The solution
% will be a labeling of the variables in Puzzle.
%

sudoku(Puzzle) :-
    % Flatten the puzzle into a single list of variables
    flatten(Puzzle, Tmp),
    % Restrict the values of the variables to the integers from 1 to 9
    Tmp ins 1..9,
    % Transpose the rows of the puzzle into columns
    Rows = Puzzle,
    transpose(Rows, Columns),
    % Split the puzzle into 3x3 blocks
    blocks(Rows, Blocks),
    % Apply the all_distinct/1 constraint to each row, column, and block
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    maplist(all_distinct, Blocks),
    % Find a labeling of the variables that satisfies all of the constraints
    maplist(label, Rows).

% blocks(Rows, Blocks)
%
% Splits the rows of a sudoku puzzle into 3x3 blocks. Rows should be a list of
% lists, with each inner list representing a row of the puzzle. Blocks will be
% a list of lists, with each inner list representing a 3x3 block of the puzzle.
%
blocks([A,B,C,D,E,F,G,H,I], Blocks) :-
    % Split the rows into 3 blocks
    blocks(A,B,C,Block1), blocks(D,E,F,Block2), blocks(G,H,I,Block3),
    % Combine the blocks into a single list
    append([Block1, Block2, Block3], Blocks).

% blocks(Row1, Row2, Row3, Block)
blocks([], [], [], []).
blocks([A,B,C|Bs1],[D,E,F|Bs2],[G,H,I|Bs3], [Block|Blocks]) :-
    % Combine the rows into a single block
    Block = [A,B,C,D,E,F,G,H,I],
    % Split the remaining rows into blocks
    blocks(Bs1, Bs2, Bs3, Blocks).
    

