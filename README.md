# Consumindo API REST - ADVPL POO

##### Progresso desenvolvimento: :eyes:


:white_check_mark: Interface de Log.

:o: Classe base para novas integra��es.

:o: Classe de Integra��o ERP Protheus x Intelipost.

:o: Functions para execu��o das integra��es.


```jsx
 [EXEMPLO DE COMO SERA A CHAMADA DA NOSSA INTEGRACAO]

//-- Busca os pedidos a serem integrados na pltaforma
aPedido  := GetPedidos()[1]
aVolumes := GetPedidos()[2]

//-- Inicializa objeto de integracao
oITLPost := INTELIPOST():New()
		
//-- Dispara integra��o para inclus�o de pedido na plataforma Intelipost
lRet := oITLPost:IncPedido(aPedido,aVolumes)

```


##### Parte 01: Cria��o da interface de Log. :white_check_mark:


Partiremos na constru��o de uma interface de log com o prop�sito de oferecer a consulta de todos os registros que foram disparados no processo de integra��o, toda troca de dados ter� seu status indicando se a mensagem foi entregue com sucesso ou n�o, isso na eventualidade de falhas de conex�o com a API ou erros de regra de neg�cio. O par�o de arquitetura <b>MVC </b> tamb�m ser� aplicado neste contexto, pois o mesmo nos beneficiar� em v�rios aspectos, seja na velocidade na constru��o de tela, melhor manuten��o e pelo reuso, onde faremos o instanciamento do objeto (Modelo de dados) para grava��o dos dados.


![LogIntegration.gif](./resource/LogIntegration.gif)