************************************************************************
* Name                : ZABAPGIT_REPORT
* Transaction         : <transaction code>
************************************************************************
REPORT zabapgit_report.
SELECT *
  FROM sbook
  INTO TABLE @DATA(lt_bookings)
  UP TO 50 ROWS. "Updated code
TRY.
    "Create ALV table object for the output data table
    cl_salv_table=>factory( IMPORTING r_salv_table = DATA(lo_tab)
                            CHANGING  t_table      = lt_bookings ).
    lo_tab->get_functions( )->set_all( ).
    lo_tab->get_columns( )->set_optimize( ).
    lo_tab->get_display_settings( )->set_striped_pattern( abap_true ).
    lo_tab->display( ).
  CATCH cx_root.
    MESSAGE 'Error in ALV creation' TYPE 'E'.
ENDTRY.
