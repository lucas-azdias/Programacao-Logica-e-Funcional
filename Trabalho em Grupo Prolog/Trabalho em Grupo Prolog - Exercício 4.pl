% Lucas Azevedo Dias
% ATIVIDADE AVALIATIVA – PROLOG 1
/*
 * 4. O quebra-cabeça do Sudoku é um jogo de lógica e colocação de números. O objetivo é
 * preencher um tabuleiro de 9x9 células, que está dividido em 9 quadrados de 3x3 células. As
 * regras são simples:
 * 		a. Cada linha do tabuleiro de 9x9 deve conter todos os dígitos de 1 a 9 sem repetições.
 * 		b. Cada coluna do tabuleiro de 9x9 deve também conter todos os dígitos de 1 a 9 sem
 * 		   repetições.
 * 		c. Cada um dos 9 quadrados de 3x3 deve conter todos os dígitos de 1 a 9 sem repetições.
 * 		   Algumas células já vêm preenchidas com números. Esses números são chamados de "dicas".
 * O número de dicas e sua disposição variam em cada quebra-cabeça, e é com base neles que
 * você deve completar o tabuleiro.
 * O desafio aqui é usar Prolog para criar um solver de Sudoku que pode preencher qualquer
 * tabuleiro 9x9 válido. O solver deve ser capaz de receber um tabuleiro parcialmente
 * preenchido e devolver a solução completa. Para resolver, insira os números das "dicas" em
 * uma lista de listas que represente o tabuleiro e execute sudoku(Tabuleiro). O Prolog
 * preencherá os espaços vazios para completar o tabuleiro. No link a seguir você pode
 * encontrar tabuleiros a serem resolvidos: Sudoku - New York Times Number Puzzles - The New
 * York Times (nytimes.com) use o modo hard
 * */

/* EXEMPLO DE TABULEIRO
[
	[4, _, _, _, _, _, _, _, _],
	[_, 7, 5, _, _, _, _, _, _],
	[_, _, _, _, 5, _, 8, 6, _],
	[_, _, _, _, _, 2, 1, _, _],
	[_, _, _, 4, _, _, 6, _, _],
	[2, _, _, _, 7, 1, _, 4, 3],
	[_, 5, _, _, 8, 7, _, _, _],
	[_, 9, 1, _, 6, _, _, 7, _],
	[_, _, 2, _, _, _, _, 5, _]
]
*/

/*
 * NOTA IMPORTANTE!
 * Tentei resolver, porém não consegui.
 * A lógica parece correta para mim, contudo o único resultado que consigo é Time-out.
 * Não consegui otimizar o suficiente para fazer com que o Prolog tente apenas alternativas
 * com números distintos e não de um em um.
 * Pensei em adicionar os que faltam a linha em questão e fazer um random_permutation até
 * bater com a linha que eu quero (reduz o universo de possibilidades consideravelmente).
 * */

all_different([]).
all_different([H|T]) :-
    not(member(H, T)),
    all_different(T).

sudoku_numbers([]).
sudoku_numbers([H|T]) :-
    sudoku_numbers(T),
    maplist(between(1, 9), H).

sudoku(Tabuleiro, Solucao) :-
    Solucao = Tabuleiro,
    
    Tabuleiro = [
    	[S11, S12, S13, S14, S15, S16, S17, S18, S19],
		[S21, S22, S23, S24, S25, S26, S27, S28, S29],
		[S31, S32, S33, S34, S35, S36, S37, S38, S39],
		[S41, S42, S43, S44, S45, S46, S47, S48, S49],
		[S51, S52, S53, S54, S55, S56, S57, S58, S59],
		[S61, S62, S63, S64, S65, S66, S67, S68, S69],
		[S71, S72, S73, S74, S75, S76, S77, S78, S79],
		[S81, S82, S83, S84, S85, S86, S87, S88, S89],
		[S91, S92, S93, S94, S95, S96, S97, S98, S99]
    ],

    sudoku_numbers(Solucao),
    
    write(Solucao),
    
    %LINES
    all_different([S11, S12, S13, S14, S15, S16, S17, S18, S19]),
    all_different([S21, S22, S23, S24, S25, S26, S27, S28, S29]),
    all_different([S31, S32, S33, S34, S35, S36, S37, S38, S39]),
    all_different([S41, S42, S43, S44, S45, S46, S47, S48, S49]),
    all_different([S51, S52, S53, S54, S55, S56, S57, S58, S59]),
    all_different([S61, S62, S63, S64, S65, S66, S67, S68, S69]),
    all_different([S71, S72, S73, S74, S75, S76, S77, S78, S79]),
    all_different([S81, S82, S83, S84, S85, S86, S87, S88, S89]),
    all_different([S91, S92, S93, S94, S95, S96, S97, S98, S99]),

    %COLUMNS
    all_different([S11, S21, S31, S41, S51, S61, S71, S81, S91]),
    all_different([S12, S22, S32, S42, S52, S62, S72, S82, S92]),
    all_different([S13, S23, S33, S43, S53, S63, S73, S83, S93]),
    all_different([S14, S24, S34, S44, S54, S64, S74, S84, S94]),
    all_different([S15, S25, S35, S45, S55, S65, S75, S85, S95]),
    all_different([S16, S26, S36, S46, S56, S66, S76, S86, S96]),
    all_different([S17, S27, S37, S47, S57, S67, S77, S87, S97]),
    all_different([S18, S28, S38, S48, S58, S68, S78, S88, S98]),
    all_different([S19, S29, S39, S49, S59, S69, S79, S89, S99]),

    %SECTORS
    all_different([S11, S12, S13, S21, S22, S23, S31, S32, S33]),
    all_different([S14, S15, S16, S24, S25, S26, S34, S35, S36]),
    all_different([S17, S18, S19, S27, S28, S29, S37, S38, S39]),
    all_different([S41, S42, S43, S51, S52, S53, S61, S62, S63]),
    all_different([S44, S45, S46, S54, S55, S56, S64, S65, S66]),
    all_different([S47, S48, S49, S57, S58, S59, S67, S68, S69]),
    all_different([S71, S72, S73, S81, S82, S83, S91, S92, S93]),
    all_different([S74, S75, S76, S84, S85, S86, S94, S95, S96]),
    all_different([S77, S78, S79, S87, S88, S89, S97, S98, S99]),
    
    write(Solucao).
