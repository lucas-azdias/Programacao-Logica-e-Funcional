% Lucas Azevedo Dias
% ATIVIDADE AVALIATIVA – PROLOG 1
/*
 * 2. Em um universo onde todos, menos você, mentem, você precisa chegar ao centro de um
 * labirinto para impedir a destruição de uma galáxia muito, muito distante. Finalmente,
 * depois de horas de caminhada você chegou a um ponto onde existem três possíveis
 * estradas. A estrada à sua esquerda está pavimentada com ouro, a estada à sua frente
 * está pavimentada com o mais fino Mármore de Carrara e a estrada à sua direita é
 * pavimentada com pequenas pedras preciosas. Cada estrada é protegida por um guardião e,
 * antes que você perguntasse qualquer coisa, eles começam a falar:
 * 		a. O Guardião da Estrada Dourada diz: “Esta estrada irá levá-lo diretamente
 * 		   ao centro do labirinto. Contudo, se pedras preciosas o levarem ao centro
 * 		   então o mármore também levará”.
 * 		b. O Guardião da Estrada de Mármore de Carrara diz: “Nem ouro, nem pedras
 * 		   preciosas o levarão ao centro do labirinto”.
 * 		c. O Guardião da Estrada de Pedras preciosas diz: “Siga o ouro e você chegará
 * 		   ao centro do labirinto, siga o mármore e estará perdido”.
 * Escolha a estrada que o levará ao centro do labirinto antes que seja tarde.
 * */

estrada(estradaDourada).
estrada(estradaMarmore).
estrada(estradaPedras).

/*
 * a) 	not(Dourada)
 * 	  	not(then(Pedras, Mármore))
 * b) 	not(Dourada)
 * 		not(Pedras)
 * c)	not(Dourada)
 * 		Marmore
 * */

% A
fala(estradaDourada, estradaDourada, true).
fala(estradaDourada, estradaMarmore, true) :- fala(_, estradaPedras, true).

% B
fala(estradaMarmore, estradaDourada, false).
fala(estradaMarmore, estradaPedras, false).

% C
fala(estradaPedras, estradaDourada, true).
fala(estradaPedras, estradaMarmore, false).

fala_de_facto(EstradaGuardiao, EstradaReferenciada, Afirmacao) :-
    (
    	Afirmacao = true,
        fala(EstradaGuardiao, EstradaReferenciada, false)
    );
    (
    	Afirmacao = false,
        fala(EstradaGuardiao, EstradaReferenciada, true)
    ).

leva_centro(Estrada) :-
    fala_de_facto(_, Estrada, true).
