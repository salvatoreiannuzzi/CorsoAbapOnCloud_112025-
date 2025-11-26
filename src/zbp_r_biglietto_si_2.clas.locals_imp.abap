CLASS lhc_zr_biglietto_si_2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Biglietto2
        RESULT result,
      earlynumbering_create FOR NUMBERING
        IMPORTING entities FOR CREATE Biglietto2.
ENDCLASS.

CLASS lhc_zr_biglietto_si_2 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD earlynumbering_create.


    WITH +big AS (
        SELECT MAX( idbiglietto ) AS id_max FROM zr_biglietto_si_2
        UNION
            SELECT MAX( idbiglietto ) AS id_max FROM zbglietto_si_2_D )
    SELECT MAX( id_max ) FROM +big AS big
    INTO @DATA(lv_max).

    LOOP AT entities INTO DATA(ls_entities).

      IF ls_entities-IdBiglietto IS INITIAL.
        lv_max += 1.
      ELSE.
        lv_max = ls_entities-IdBiglietto.
      ENDIF.

      APPEND VALUE #(
                      %cid = ls_entities-%cid
                      %is_draft = ls_entities-%is_draft
                      idbiglietto = lv_max )
                    TO mapped-biglietto2.

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
