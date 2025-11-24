CLASS zcl_hello_rap_si DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
  METHODS: TEST_SI
  IMPORTING IV_INPUT TYPE STRING
  RETURNING VALUE(RV_VALUE) TYPE STRING.
ENDCLASS.



CLASS zcl_hello_rap_si IMPLEMENTATION.

METHOD TEST_SI.
    DATA lv_test TYPE string.
    DATA lv_concat TYPE string VALUE 'CHIST'.
    rv_value = | { IV_INPUT } { lv_concat } |.

ENDMETHOD.

  METHOD if_oo_adt_classrun~main.




   out->write(
      EXPORTING
        data   = TEST_SI( 'ciao' )
        name   = 'Salvatore'     ).


  ENDMETHOD.
ENDCLASS.
