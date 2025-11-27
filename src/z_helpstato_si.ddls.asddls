@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Help Stato'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity z_helpstato_si 
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZD_STATO_SI'  ) as dd07t
{
    key dd07t.value_low   as StatusCode,
        dd07t.text       as StatusText
}
where dd07t.language = $session.system_language
