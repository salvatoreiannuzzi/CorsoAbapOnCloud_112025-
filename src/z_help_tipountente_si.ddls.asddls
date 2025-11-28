@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Help Tipo Utente'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity z_help_tipountente_si as select from ztipo_utente_si
{
    key id,
    descrizione,
    limitazioni,
@Semantics.amount.currencyCode: 'valuta'
    prezzo,
    valuta
    
}
