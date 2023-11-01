%Lucas Azevedo Dias

% ATIVIDADE AVALIATIVA – PROLOG RA1

% -------------------------------------------------------------------------
% 
% Exercício 1: Crie uma regra em Prolog que verifica se um número é par.
par(Number) :-
    integer(Number),
    mod(Number, 2) =:= 0.
% ?- par(2).
% 	 return: true
% ?- par(5).
% 	 return: false

% -------------------------------------------------------------------------

% Exercício 2: Escreva uma regra que calcula o fatorial de um número.
factorial(0, 1).
factorial(Number, Result) :-
	% Obs.: Caso a consulta seja inválida (números negativos ou não-inteiros) retorna "false".
    integer(Number),
    Number >= 0,
    NextNumber is (Number - 1),
    factorial(NextNumber, NextResult),
    Result is (Number * NextResult).
% ?- factorial(3, X).
% 	 return: X = 6
% ?- factorial(5, X).
% 	 return: X = 120

% -------------------------------------------------------------------------

% Exercício 3: Crie uma regra que verifica se uma lista é vazia.
isEmpty([]).
% ?- isEmpty([1]).
% 	 return: false
% ?- isEmpty([]).
% 	 return: true

% -------------------------------------------------------------------------

% Exercício 4: Escreva uma regra que inverte uma lista.
invert([], []).
invert([H|T], Result) :-
    invert(T, TailInverted),
    append(TailInverted, [H], Result).
% ?- invert([1, 2, 3], X).
% 	 return: X = [3, 2, 1]
% ?- invert([1, 2, 3, 4, 5], X).
% 	 return: X = [5, 4, 3, 2, 1]

% -------------------------------------------------------------------------

% Exercício 5: Implemente uma regra para encontrar o maior elemento em uma lista.
max([], []).
max([X], X).
max([H|T], Result) :-
    max(T, NextResult),
    (
    	H >= NextResult ->
    		Result is H;
    	Result is NextResult
    ).
% ?- max([1, 2, 3, 4, 5], X).
% 	 return: X = 5
% ?- max([4, 5, 1, 9, 0, 2], X).
% 	 return: X = 9

% -------------------------------------------------------------------------

% Exercício 6: Crie uma regra que verifica se uma lista é uma palíndrome.
isListPalindrome(List) :-
    is_list(List),
    invert(List, Inverted),
	List == Inverted.
% ?- isListPalindrome([1, 2, 3, 2, 1]).
% 	 return: true
% ?- isListPalindrome([1, 5, 3, 2, 1]).
% 	 return: false

% -------------------------------------------------------------------------

% Exercício 7: Escreva uma regra que calcule o n-ésimo termo da sequência de Fibonacci.
fibonacci(0, 0). % Só os verdadeiros sabem que a sequência de Fibonacci começa com zero (igual o conjunto dos naturais) :p
fibonacci(1, 1).
fibonacci(Number, Result) :-
    integer(Number),
    Number >= 0,
    LastLastNumber is Number - 2,
    fibonacci(LastLastNumber, LastLastResult),
    LastNumber is Number - 1,
    fibonacci(LastNumber, LastResult),
    Result is LastLastResult + LastResult.
% ?- fibonacci(3, X).
% 	 return: X = 2
% ?- fibonacci(6, X).
% 	 return: X = 8

% -------------------------------------------------------------------------

% Exercício 8: Implemente uma regra que encontre o maior divisor comum (MDC) de dois
% números inteiros.
mdc(Number1, Number2, Result) :-
    divisors(Number1, Divisors1),
    divisors(Number2, Divisors2),
    intersection(Divisors1, Divisors2, CommonDivisors),
    max(CommonDivisors, Result).
% ?- mdc(10, 9, X).
% 	 return: X = 1
% ?- mdc(9, 6, X).
% 	 return: X = 3

divisors(0, []).
divisors(Number, Result) :-
    integer(Number),
    (Number >= 0 -> N is Number; N is -Number),
    divisors_try(N, N, Result).

divisors_try(_, 0, []).
divisors_try(Number, Try, Result) :-
    integer(Number),
    integer(Try),
    NextTry is (Try - 1),
    divisors_try(Number, NextTry, LastResult),
    Quotient is (Number / Try),
    (integer(Quotient) -> append([Try], LastResult, Result); Result = LastResult).

% -------------------------------------------------------------------------

% Exercício 9: Crie uma regra que verifica se um número é primo.
isPrime(Number) :-
    integer(Number),
    Number > 1, % 1 é um caso especial, não sendo primo pela convenção geral (ou seja, sempre "false")
	divisors(Number, Result) -> Result == [Number, 1].
% ?- isPrime(19).
% 	 return: true
% ?- isPrime(8).
% 	 return: false

% -------------------------------------------------------------------------

% Exercício 10: Escreva uma regra que verifica se uma palavra é um palíndromo.
isWordPalindrome(Word) :-
    is_stream(Word),
    atom_chars(Word, WordChars),
    invert(WordChars, InvertedChars),
	WordChars == InvertedChars.
% ?- isWordPalindrome("civic").
% 	 return: true
% ?- isWordPalindrome("civil").
% 	 return: false

% -------------------------------------------------------------------------
