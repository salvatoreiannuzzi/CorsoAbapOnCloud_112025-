@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Generatore Biglietti'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZBIGLIETTO_SI_2'
}

@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BIGLIETTO_SI_2
  provider contract transactional_query
  as projection on ZR_BIGLIETTO_SI_2
  association [1..1] to ZR_BIGLIETTO_SI_2 as _BaseEntity on $projection.IdBiglietto = _BaseEntity.IdBiglietto
{
  key IdBiglietto,
  
 @Consumption: { valueHelpDefinition: [{
     entity: {
         name: 'Z_HELPSTATO_SI',
         element: 'StatusCode'
     },
     
     label: 'Stato'
 }] }
  stato as stato,     
  @Semantics: {
    user.createdBy: true
  }  
  CreatoDa, 
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatoIl,
  @Semantics: {
    user.lastChangedBy: true
  }
  ModificatoDa,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  ModificatoIl,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Locallastchanged,
  _BaseEntity
}
