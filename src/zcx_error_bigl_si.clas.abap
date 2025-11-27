CLASS zcx_error_bigl_si DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    DATA: gv_stato TYPE zr_biglietto_si_2-stato.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
         iv_stato TYPE  zr_biglietto_si_2-stato OPTIONAL
         iv_severity type   if_abap_behv_message=>t_severity.

    CONSTANTS: gc_MSGID TYPE sy-msgid VALUE 'Z_IDBLIG_MESS_SI',
               BEGIN OF gc_invalid_status,
                 msgid TYPE symsgid VALUE gc_msgid,
                 msgno TYPE symsgno VALUE '001',
                 attr1 TYPE scx_attrname VALUE 'GV_STATO',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF gc_invalid_status.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_error_bigl_si IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    if_abap_behv_message~m_severity = iv_severity.

    gv_stato = iv_stato.

  ENDMETHOD.


ENDCLASS.
