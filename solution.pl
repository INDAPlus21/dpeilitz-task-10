% Taken and modified from https://gist.github.com/MuffinTheMan/7806903
% Get an element from a 2-dimensional list at (Row,Column)
% using 1-based indexing.
nth1_2d(Row, Column, List, Element) :-
    nth1(Row, List, SubList),
    nth1(Column, SubList, Element).


is_visited(Coordinate, [H|T]):-
    Coordinate = H ; is_visited(Coordinate, T).

% Checks whether the group of stones connected to
% the stone located at (Row, Column) is alive or dead.
is_occupied(Row, Column, Board):-
    nth1_2d(Row, Column, Board, Stone),
    (Stone = b; Stone = w).

% Top-level predicate
alive(Row, Column, BoardFileName):-
    see(BoardFileName),     % Loads the input-file
    read(Board),            % Reads the first Prolog-term from the file
    seen,                   % Closes the io-stream
    is_occupied(Row, Column, Board),
    check_alive(Row, Column, Board, Stone, []).

%Alive tar in en specifik punkt på brädet,
% Vi vill hitta en punkt, kolla ifall den är vid liv, sedan rekursivt testa punkterna upp, ned, höger och vänster
check_alive(Row, Column, Board, Colour, Visited):-

    %check_occupied(Row, Column, Board),

    %get the colour of the stone in the given position.
    nth1_2d(Row, Column, Board, Stone),

    %if the given tile is empty, return true
    (Stone = e;

        %Check if correct colour
        (Stone = Colour,

            \+ is_visited((Row, Column), Visited),
            Left is Column - 1,
            Right is Column + 1,
            Up is Row - 1,
            Down is Row + 1,
    (
        %Check every direction from the piece in question.
        check_alive(Row, Left, Board, Colour, [(Row, Column) | Visited]);
        check_alive(Row, Right, Board, Colour, [(Row, Column) | Visited]);
        check_alive(Up, Column, Board, Colour, [(Row, Column) | Visited]);
        check_alive(Down, Column, Board, Colour, [(Row, Column) | Visited])
    )
)).
