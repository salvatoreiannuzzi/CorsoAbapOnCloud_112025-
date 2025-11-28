@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCOMPONENTI_SI'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZR_COMPONENTI_SI
  as select from zcomponenti_si as componenti  
  association to parent ZR_BIGLIETTO_SI_2 as _biglietto  
  on _biglietto.IdBiglietto = $projection.IdBiglietto
  association to z_help_tipountente_si as _tipoutente on componenti.tipoutente = _tipoutente.id
//  association to z_help_tipountente_si as tipoutente on tipoutente.id = componenti.tipoutente
{
  key id_biglietto as IdBiglietto,
  key progressivo as Progressivo,
  tipoutente as Tipoutente,
  @Semantics.user.createdBy: true
  creato_da as CreatoDa,
  @Semantics.systemDateTime.createdAt: true
  creato_il as CreatoIl,
  @Semantics.user.lastChangedBy: true
  modificato_da as ModificatoDa,
  @Semantics.systemDateTime.lastChangedAt: true
  modificato_il as ModificatoIl,
//Association
  _biglietto,
  _tipoutente
}
