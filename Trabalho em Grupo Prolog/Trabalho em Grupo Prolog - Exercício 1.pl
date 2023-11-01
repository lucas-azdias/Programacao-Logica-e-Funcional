% Lucas Azevedo Dias
% ATIVIDADE AVALIATIVA – PROLOG 1
/*
 * 1. Em um universo paralelo, Marcelo, Paulo e Augusto estão presos em uma masmorra escura
 * e fria. Em desespero por uma saída os três rapazes encontram três portas de cores diferentes,
 * vermelha, azul e verde. Atrás de uma destas portas está o caminho da liberdade. Atrás das
 * outras duas portas está Drogon sedento de sangue. Abrir uma destas portas significa morte
 * certa. Não bastasse isso, mesmo no escuro é possível ver uma inscrição em cada porta:
 * 		a. Porta Vermelha: A liberdade está atrás desta porta;
 * 		b. Porta Azul: A liberdade não está atrás desta porta;
 * 		c. Porta Verde: A liberdade não está atrás da porta Azul.
 * Sabendo que, pelo menos uma as três declarações é verdadeira e que pelo menos
 * uma das declarações é falsa, que porta leva a liberdade?
 * */

porta(portaVermelha).
porta(portaAzul).
porta(portaVerde).

inscricao(portaVermelha, portaVermelha, true).
inscricao(portaAzul, portaAzul, false).
inscricao(portaVerde, portaAzul, false).

afirmacao(PortaInscrita, PortaReferenciada, Afirmado) :-
    inscricao(PortaInscrita, PortaReferenciada, Afirmado),
    porta(PortaInscrita),
    porta(PortaReferenciada).

leva_liberdade(Verdadeira, Falsa, Restante) :-
    afirmacao(PIns1, PRef1, Af1),
    afirmacao(PIns2, PRef2, Af2),
    afirmacao(PIns3, _, _),
    
    Verdadeira = PIns1,
    Falsa = PIns2,
    Restante = PIns3,
    
    PIns1 \== PIns2,
    PIns2 \== PIns3,
    PIns3 \== PIns1,
    
    \+(
    	(
        	Af1 == true,
     		Af2 == false
        );
      	(
        	Af1 == false,
      		(Af2 == false, PRef2 == PRef1)
        );
      	(
        	Af1 == false,
      		PRef1 == PIns1
        )
    ).
