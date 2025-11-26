CLASS zcl_estrazione_flight_si DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
  TYPES: BEGIN OF ty_flight,
            carrier_id type /dmo/carrier_id,
            connection_id type /dmo/connection_id,
         end of ty_flight.
    CLASS-DATA: lt_flight TYPE TABLE OF ty_flight..
    METHODS _count   CHANGING out TYPE REF TO if_oo_adt_classrun_out.
    METHODS _EXTRACT CHANGING out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS zcl_estrazione_flight_si IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



    out->write( data = lt_flight ).

  ENDMETHOD.

  METHOD _count.

  ENDMETHOD.

  METHOD _EXTRACT.

        SELECT carrier_id, connection_id FROM /dmo/flight INTO TABLE @lt_flight.

  ENDMETHOD.

ENDCLASS.
