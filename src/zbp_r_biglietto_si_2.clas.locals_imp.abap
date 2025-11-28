CLASS lhc_zr_biglietto_si_2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Biglietto2
        RESULT result,
      earlynumbering_create FOR NUMBERING
        IMPORTING entities FOR CREATE Biglietto2,
      GetDefaultsForCreate FOR READ
        IMPORTING keys FOR FUNCTION Biglietto2~GetDefaultsForCreate RESULT result,
      checkstatus FOR VALIDATE ON SAVE
        IMPORTING keys FOR Biglietto2~checkstatus,
      get_instance_features FOR INSTANCE FEATURES
        IMPORTING keys REQUEST requested_features FOR Biglietto2 RESULT result,
      changestatus FOR DETERMINE ON SAVE
        IMPORTING keys FOR Biglietto2~changestatus,
      customdelete FOR MODIFY
        IMPORTING keys FOR ACTION Biglietto2~customdelete RESULT result,
      earlynumbering_cba_Componenti FOR NUMBERING
        IMPORTING entities FOR CREATE Biglietto2\_Componenti.
ENDCLASS.

CLASS lhc_zr_biglietto_si_2 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD earlynumbering_create.


*    WITH +big AS (
*        SELECT MAX( idbiglietto ) AS id_max FROM zr_biglietto_si_2
*        UNION
*            SELECT MAX( idbiglietto ) AS id_max FROM zbglietto_si_2_D )
*    SELECT MAX( id_max ) FROM +big AS big
*    INTO @DATA(lv_max).
*
*    LOOP AT entities INTO DATA(ls_entities).


    LOOP AT entities INTO DATA(ls_entities).

      IF ls_entities-IdBiglietto IS INITIAL.
        TRY.
            cl_numberrange_runtime=>number_get(
              EXPORTING
                nr_range_nr = '01'
                object      = 'Z_IDBIG_SI'
                quantity = '1'
              IMPORTING
                number      = DATA(lv_max)
                returncode = DATA(code)
                returned_quantity = DATA(return_qty) ).

          CATCH cx_nr_object_not_found INTO DATA(lx_obj_not_found).
          CATCH cx_number_ranges INTO DATA(lx_ranges_error).
        ENDTRY.
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

  METHOD GetDefaultsForCreate.

    result = VALUE #( FOR key IN keys (
             %cid = key-%cid
             %param-stato = 'BOZZA'
              ) ).

  ENDMETHOD.

  METHOD checkstatus.

    DATA: lt_biglietto TYPE TABLE FOR READ RESULT  zr_biglietto_si_2.

    READ ENTITIES OF zr_biglietto_si_2 IN LOCAL MODE ENTITY Biglietto2
      FIELDS ( stato ) WITH CORRESPONDING #( keys )
      RESULT lt_biglietto.

    LOOP AT lt_biglietto INTO DATA(ls_biglietto)
    WHERE stato <> 'BOZZA'
      AND stato <> 'FINALE'
      AND stato <> 'CANC'.

      APPEND VALUE #( %tky = ls_biglietto-%tky
                        ) TO failed-biglietto2.

      APPEND VALUE #( %tky = ls_biglietto-%tky
                     %msg = NEW zcx_error_bigl_si( textid = zcx_error_bigl_si=>gc_invalid_status
                                                   iv_stato    = ls_biglietto-stato
                                                   iv_severity = if_abap_behv_message=>severity-error )
                    %element-stato = if_abap_behv=>mk-on
                    ) TO reported-biglietto2.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.

    DATA: lt_biglietto TYPE TABLE FOR READ RESULT  zr_biglietto_si_2.

    DATA: ls_result LIKE LINE OF result.

    READ ENTITIES OF zr_biglietto_si_2 IN LOCAL MODE ENTITY Biglietto2
      FIELDS ( stato ) WITH CORRESPONDING #( keys )
      RESULT lt_biglietto.

    LOOP AT lt_biglietto INTO DATA(ls_biglietto).
*      APPEND VALUE #( %tky = ls_biglietto-%tky
*                      %field-stato = if_abap_behv=>fc-f-read_only
*
*                      ) TO result.
      ls_result-%tky = ls_biglietto-%tky.
      ls_result-%field-stato = if_abap_behv=>fc-f-read_only.
      CASE ls_biglietto-stato.
        WHEN 'BOZZA' OR 'CANC'.
          ls_result-%action-customdelete = if_abap_behv=>fc-o-disabled.
        WHEN 'FINALE'.
          ls_result-%action-customdelete = if_abap_behv=>fc-o-enabled.


      ENDCASE.
      APPEND ls_result TO result.
    ENDLOOP.



  ENDMETHOD.

  METHOD changestatus.

    DATA lt_update TYPE TABLE FOR UPDATE zr_biglietto_si_2.

    DATA: lt_biglietto TYPE TABLE FOR READ RESULT  zr_biglietto_si_2.

    READ ENTITIES OF zr_biglietto_si_2 IN LOCAL MODE ENTITY Biglietto2
      FIELDS ( stato ) WITH CORRESPONDING #( keys )
      RESULT lt_biglietto.

    LOOP AT lt_biglietto INTO DATA(ls_biglietto).

      IF ls_biglietto-stato = 'BOZZA'.
        APPEND INITIAL LINE TO lt_update
        ASSIGNING FIELD-SYMBOL(<lfs_update>).
        <lfs_update>-%tky = ls_biglietto-%tky.
        <lfs_update>-stato = 'FINALE'.
* per dire quale campo è stato modficato.
        <lfs_update>-%control-stato = if_abap_behv=>mk-on.
      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zr_biglietto_si_2
    IN LOCAL MODE
    ENTITY Biglietto2
    UPDATE FROM lt_update.

*        MODIFY ENTITIES OF zr_biglietto_si_2
*        IN LOCAL MODE
*        ENTITY Biglietto2
*        UPDATE FROM VALUE #( ( %tky = ls_biglietto-%tky
*                               stato = 'FINALE'
*                              %control-stato = if_abap_behv=>mk-on ) ).
  ENDMETHOD.



  METHOD customdelete.

    DATA lt_update TYPE TABLE FOR UPDATE zr_biglietto_si_2.

    DATA: lt_biglietto TYPE TABLE FOR READ RESULT  zr_biglietto_si_2.

    READ ENTITIES OF zr_biglietto_si_2 IN LOCAL MODE ENTITY Biglietto2
      ALL FIELDS  WITH CORRESPONDING #( keys )
      RESULT lt_biglietto.

    LOOP AT lt_biglietto INTO DATA(ls_biglietto).

      ls_biglietto-stato = 'CANC'.
      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lfs_result>).
      <lfs_result>-%tky = ls_biglietto-%tky.
      <lfs_result>-%param = ls_biglietto.

      APPEND INITIAL LINE TO lt_update ASSIGNING FIELD-SYMBOL(<lfs_biglietto>).
      <lfs_biglietto>-%tky = ls_biglietto-%tky.
      <lfs_biglietto>-stato = 'CANC'.
      <lfs_biglietto>-%control-stato = if_abap_behv=>mk-on.

    ENDLOOP.

    MODIFY ENTITIES OF zr_biglietto_si_2
    IN LOCAL MODE
    ENTITY Biglietto2
    UPDATE FROM lt_update.



*    DATA:
*      lt_biglietto TYPE TABLE FOR READ RESULT zr_biglietto_mb2.
*
*    READ ENTITIES OF zr_biglietto_mb2 IN LOCAL MODE
*    ENTITY Biglietto
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT lt_biglietto.
*    LOOP AT lt_biglietto INTO DATA(ls_biglietto).
*      MODIFY ENTITIES OF zr_biglietto_mb2 IN LOCAL MODE
*             ENTITY Biglietto
*             UPDATE FROM VALUE #( ( %tky               = ls_biglietto-%tky
*                                    Stato             = 'CANC'
*                                    %control-Stato = if_abap_behv=>mk-on ) ).
*      ls_biglietto-stato = 'CANC'.
*      INSERT VALUE #( %tky = ls_biglietto-%tky
*                     %param = ls_biglietto ) INTO TABLE result.
*    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_cba_Componenti.


    READ ENTITIES OF zr_biglietto_si_2
        IN LOCAL MODE
        ENTITY Biglietto2 BY \_Componenti
        FIELDS ( Progressivo )
        WITH
        VALUE #( FOR line
            IN entities
            (
                IdBiglietto = line-IdBiglietto
                %is_draft   = line-%is_draft
            )
             ) RESULT DATA(lt_progressivo).

    SELECT MAX( progressivo ) FROM :@lt_progressivo AS lt_progressivo
    INTO @DATA(lv_max_progr).

    DATA ls_componenti LIKE LINE OF mapped-componenti.


    LOOP AT entities INTO DATA(ls_entities).
      LOOP AT ls_entities-%target INTO DATA(ls_target).
        lv_max_progr += 1.
        ls_componenti-%cid = ls_target-%cid.
        ls_componenti-%is_draft = ls_target-%is_draft.
        ls_componenti-Progressivo = lv_max_progr.
        ls_componenti-IdBiglietto = ls_target-IdBiglietto.
        APPEND ls_componenti TO mapped-componenti.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
