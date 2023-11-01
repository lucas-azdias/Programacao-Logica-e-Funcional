% Lucas Azevedo Dias
% ATIVIDADE AVALIATIVA – PROLOG 1
/*
 * 3. Em uma rua tranquila localizada em uma galáxia muito, muito distante, existem cinco casas,
 * cada uma de uma cor diferente. Em cada casa mora uma pessoa de uma nacionalidade
 * diferente. Cada uma das cinco pessoas bebe uma bebida diferente, tem um tipo diferente de
 * peixe em seu aquário e possui um animal de estimação diferente. Considere as seguintes
 * condições:
 * 		a. O norueguês vive na primeira casa.
 * 		b. O inglês vive na casa vermelha.
 * 		c. A casa verde está imediatamente à esquerda da casa branca.
 * 		d. O dinamarquês bebe chá.
 * 		e. A pessoa que bebe café vive na casa verde.
 * 		f. A pessoa que bebe leite vive na terceira casa.
 * 		g. O sueco tem um cachorro como animal de estimação.
 * 		h. O norueguês vive ao lado da casa azul.
 * 		i. O alemão bebe cerveja.
 * 		j. O brasileiro vive na casa amarela.
 * 		k. O gato vive na casa ao lado da casa onde bebem água.
 * 		l. Os peixes betta vivem na casa ao lado da casa onde bebem chá.
 * 		m. A casa amarela está ao lado da casa onde vivem os peixes beta.
 * Sua tarefa será, usando Prolog, determinar quem possui um tubarão no aquário?
 * */

all_different([]).
all_different([H|T]) :- 
    not(member(H, T)),
    all_different(T).

both_nextto(X, Y, List) :-
    nextto(X, Y, List);
    nextto(Y, X, List).

/*
 * NOTA IMPORTANTE!
 * Do que averiguei, as restrições são incongruentes com o próprio exercício,
 * pois há seis nacionalidades especificadas ao invés de cinco, sendo elas:
 * 		noruegues, ingles, dinamarques, sueco, alemao e brasileiro
 * Além disso, nas restrições, não indicação apontando para "tubarão", o que basicamente
 * torna criar um caminho entre ele e uma nacionalidade impossível.
 * Dessa forma, acredito que o exercício é irresolvível pelas suas próprias premissas.
 * */

solve(PossuiTubarao) :-
    Casas = [_, _, _, _, _],
    
    Casas = [casa(_, noruegues, _, _, _), _, _, _, _],
    member(casa(vermelha, ingles, _, _, _), Casas),
    nextto(casa(verde, _, _, _, _), casa(branca, _, _, _, _), Casas),
    member(casa(_, dinamarques, cha, _, _), Casas),
    member(casa(verde, _, cafe, _, _), Casas),
    Casas = [_, _, casa(_, _, leite, _, _), _, _],
    member(casa(_, sueco, _, _, cachorro), Casas),
    both_nextto(casa(_, noruegues, _, _, _), casa(azul, _, _, _, _), Casas),
    member(casa(_, alemao, cerveja, _, _), Casas),
    member(casa(amarela, brasileiro, _, _, _), Casas),
    both_nextto(casa(_, _, _, _, gato), casa(_, _, agua, _, _), Casas),
    both_nextto(casa(_, _, _, betta, _), casa(_, _, cha, _, _), Casas),
    both_nextto(casa(amarela, _, _, _, _), casa(_, _, _, betta, _), Casas),

    member(casa(_, PossuiTubarao, _, tubarao, _), Casas),
    
    all_different(Casas).
