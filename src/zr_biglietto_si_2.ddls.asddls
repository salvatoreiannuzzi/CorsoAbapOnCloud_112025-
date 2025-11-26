@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZBIGLIETTO_SI_2'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_BIGLIETTO_SI_2
  as select from ZBIGLIETTO_SI_2 as Biglietto2
{
  key id_biglietto as IdBiglietto,
  @Semantics.user.createdBy: true
  creato_da as CreatoDa,
  @Semantics.systemDateTime.createdAt: true
  creato_il as CreatoIl,
  @Semantics.user.lastChangedBy: true
  modificato_da as ModificatoDa,
  @Semantics.systemDateTime.lastChangedAt: true
  modificato_il as ModificatoIl,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchanged as Locallastchanged
}
