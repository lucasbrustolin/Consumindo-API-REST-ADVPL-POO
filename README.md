# Consumindo API REST - ADVPL POO

##### Progresso desenvolvimento:

? Interface de Log.
? Classe base.
? Classe de Integra��o ERP Protheus x Intelipost.
? Functions para execu��o das integra��es.


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


#####Parte 01: Cria��o da interface de Log. ?


Partiremos na constru��o de uma interface de log com o prop�sito de oferecer a consulta de todos os registros que foram disparados no processo de integra��o, toda troca de dados ter� seu status indicando se a mensagem foi entregue com sucesso ou n�o, isso na eventualidade de falhas de conex�o com a API ou erros de regra de neg�cio. O uso do Framework MVC tamb�m ser� aplicado neste contexto pois o mesmo nos beneficiar� em v�rios aspectos, seja na velocidade na constru��o de tela, c�digo organizado, consistente e tamb�m pelo reuso, onde faremos o instanciamento do objeto (Modelo de dados) que ser� o respons�vel pela grava��o dos dados.


![LogIntegration.gif](./resource/LogIntegration.gif)