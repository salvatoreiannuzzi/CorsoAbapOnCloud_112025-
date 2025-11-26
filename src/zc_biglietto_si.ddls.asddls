@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Proiezione CDS Biglietto'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_biglietto_si
  provider contract transactional_query
  as projection on zibiglietto_si
{
  key id_biglietto  as idbiglietto,
      creato_da     as creatoda,
      creato_il     as creatoil,
      modificato_da as modificatoda,
      modificato_il as modificatoil,
      modificato    as modificato
}
