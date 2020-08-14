#Include "protheus.ch"
#Include 'FWMVCDef.ch'
#INCLUDE 'FWEditPanel.CH'

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} INTEGLOG 
@type				: Funcao de Usuario
@Sample				: U_INTEGLOG()
@description	    : Monta Browse com as opções - CRUD MVC da tabela de Log de integracao 						
@Param				: Nulo
@return				: Nulo
@ ------------------|----------------
@author				: Lucas.Brustolin
@since				: 02/07/2019
@version			: Protheus 12.1.17
/*/
//------------------------------------------------------------------------------------------
User Function INTEGLOG()

Local cTitulo   := "Log de Integração"
Local oBrowse   := Nil

Private aRotina := FwLoadMenuDef("INTEGLOG")

oBrowse := FwMBrowse():New()
oBrowse:SetAlias("ZLG") // 


// oBrowse:SETDETAILS( .T. )
oBrowse:SETFIXEDDETAILS( .T. )
oBrowse:SETSIZEDETAILS(50)
oBrowse:SetOnlyFields( { 'ZLG_CODIGO', 'ZLG_DESCRI', 'ZLG_REQ','ZLG_RESP','ZLG_DATA','ZLG_HORA','ZLG_USER','ZLG_STATUS' } )

oBrowse:AddLegend( "ZLG_STATUS == '1' " , "BLUE"        , "Enviado"  )
oBrowse:AddLegend( "ZLG_STATUS == '2' " , "DISABLE.BMP" , "Falha" )

oBrowse:SetDescription(cTitulo)
oBrowse:Activate()

Return()

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ModelDef 
@type				: Funcao Statica
@Sample				: ModelDef()
@description	    : Define o modelo de dados MVC da tabela de Log de Monitoramento (INTELIPOST)					
@Param				: Nulo
@return				: oModel
@ ------------------|----------------
@author				: Lucas.Brustolin
@since				: 02/07/2019
@version			: Protheus 12.1.17
/*/
//------------------------------------------------------------------------------------------
Static Function ModelDef()

Local oModel		:= Nil
Local oStruZLG	    := FwFormStruct(1,"ZLG")

Local bMPre			:= {|| .T. }
Local bMPost		:= {|| .T. }
Local bMCommit	    := {|| .T. }
Local bMCancel	    := {|| .T. }


oModel := MPFormModel():New('MINTEGLOG', /*bMPre*/,/*bMPost*/,/*bMCommit*/,/*bMCancel*/)

oModel:AddFields('ZLGMASTER',/*cOwner*/,oStruZLG,/*bPreVld*/,/*bPostVld*/,/*bLoad*/)


oModel:SetDescription("Log de Integracao")

Return(oModel)

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ViewDef 
@type				: Funcao Statica
@Sample				: ViewDef()
@description	    : Define o modelo de visualização MVC da tabela de Log de Integracao					
@Param				: Nulo
@return				: oModel
@ ------------------|----------------
@author				: Lucas.Brustolin
@since				: 02/07/2019
@version			: Protheus 12.1.17
/*/
//------------------------------------------------------------------------------------------
Static Function ViewDef()

Local oView			:= FwFormView():New()
Local oModel		:= FWLoadModel('INTEGLOG')
Local oStruZLG 	    := FwFormStruct(2,"ZLG") 

// // AGRUPA OS CAMPOS NA INTERFACE 
oStruZLG:AddGroup( 'GRP_01'	, 'Chave do Log'    , '', 2 )
oStruZLG:AddGroup( 'GRP_02' , 'Json Comunicacao', '', 2 )

oStruZLG:SetProperty("*"            , MVC_VIEW_GROUP_NUMBER, "GRP_02")
//--
oStruZLG:SetProperty("ZLG_CODIGO"   , MVC_VIEW_GROUP_NUMBER, "GRP_01")
oStruZLG:SetProperty("ZLG_IDURI"    , MVC_VIEW_GROUP_NUMBER, "GRP_01")
oStruZLG:SetProperty("ZLG_DESCRI"   , MVC_VIEW_GROUP_NUMBER, "GRP_01")
oStruZLG:SetProperty("ZLG_FILORI"   , MVC_VIEW_GROUP_NUMBER, "GRP_01")
oStruZLG:SetProperty("ZLG_ALIAS"    , MVC_VIEW_GROUP_NUMBER, "GRP_01")
oStruZLG:SetProperty("ZLG_KEY"      , MVC_VIEW_GROUP_NUMBER, "GRP_01")

oView:SetModel(oModel)

oView:AddField('ZLGMASTER',oStruZLG,'ZLGMASTER')

// -- ALTERA LAYOUT DO FORMULARIO
oView:SetViewProperty("ZLGMASTER","SETLAYOUT" ,{ FF_LAYOUT_VERT_DESCR_TOP , -1 } )

oView:CreateHorizontalBox('SUPERIOR',100)
	
oView:SetOwnerView('ZLGMASTER','SUPERIOR')

oView:SetInsertMessage("INTEGLOG","Log Registrado com Sucesso!")

Return(oView)
//------------------------------------------------------------------------------------------
/*/{Protheus.doc} MenuDef 
@type				: Funcao Statica
@Sample				: MenuDef()
@description	    : Define o menu de operacoes do CRUD MVC  						
@Param				: Nulo
@return				: oModel
@ ------------------|----------------
@author				: Lucas.Brustolin
@since				: 02/07/2019
@version			: Protheus 12.1.17
/*/
//------------------------------------------------------------------------------------------
Static Function MenuDef()

Local aRotina := {}

If FWIsInCallStack("U_INTEGLOG")
    ADD OPTION aRotina TITLE '+ Detalhes'   ACTION 'VIEWDEF.INTEGLOG' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 2
Else
    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.INTEGLOG' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 2
    ADD OPTION aRotina TITLE 'Incluir' 		ACTION 'VIEWDEF.INTEGLOG' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
    ADD OPTION aRotina TITLE 'Alterar' 		ACTION 'VIEWDEF.INTEGLOG' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
    ADD OPTION aRotina TITLE 'Excluir' 		ACTION 'VIEWDEF.INTEGLOG' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
    ADD OPTION aRotina TITLE 'Copiar'	    ACTION 'VIEWDEF.INTEGLOG' OPERATION 9                      ACCESS 0 //"Copiar"
EndIf 

Return(aRotina)


