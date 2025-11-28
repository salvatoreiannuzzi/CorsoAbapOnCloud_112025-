@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCOMPONENTI_SI'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_COMPONENTI_SI
  as projection on ZR_COMPONENTI_SI
  association [1..1] to ZR_COMPONENTI_SI as _BaseEntity 
  on $projection.IdBiglietto = _BaseEntity.IdBiglietto 
  and $projection.Progressivo = _BaseEntity.Progressivo
{
  key IdBiglietto,
  key Progressivo,
 @Consumption: { valueHelpDefinition: [{
     entity: {
         name: 'z_help_tipountente_si',
         element: 'id' }
//          additionalBinding: [{ element: 'descrizione',
//                                    localElement: 'descrizione',
//                                    usage: #RESULT}] 
          
//     label: 'Stato'
 }] }  
  Tipoutente,
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
  _BaseEntity,
  _biglietto : redirected to parent ZC_BIGLIETTO_SI_2
}
