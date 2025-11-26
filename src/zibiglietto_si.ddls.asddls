@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View per Biglietto'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zibiglietto_si as select from zbiglietto_si
{
    key id_biglietto,
      @Semantics.user.createdBy: true
        creato_da,
      @Semantics: { systemDateTime.createdAt: true }  
        creato_il,
        
     @Semantics: { user: { lastChangedBy: true } }
        modificato_da,
     @Semantics: { systemDateTime.lastChangedAt: true }    
        modificato_il,
    case when creato_da = modificato_da
    then 'X'
    else ' ' end as modificato        
}
