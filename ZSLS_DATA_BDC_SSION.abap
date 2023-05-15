report zsls_data_bdc_ssion.

* Author - Harsh Sharma ( HXS0615 ) *

"Structure for insertion.
types: begin of ty_var,
         var_low type tvarvc-low,
       end of ty_var.

"data declaration for inputs
data: wa_var type ty_var,
      it_var type standard table of ty_var.

"data declareations for bdc
data: wa_bdc type bdcdata,
      it_bdc type standard table of bdcdata.

"selection screen for providing path
selection-screen begin of block blk2 with frame title text-001.
parameters: p_file type string default '/SAPMFG/data/BDCI_Items.dat'.
selection-screen end of block blk2.

data(file_name) = p_file.

"Main working code

start-of-selection.
  perform get_data.
  perform session_open.
  perform insert_data.
  perform session_close.

end-of-selection.

  "get_data subroutine
form get_data.
  call function 'GUI_UPLOAD'
    exporting
      filename            = file_name
*     FILETYPE            = 'ASC'
      has_field_separator = 'X'
*     HEADER_LENGTH       = 0
*     READ_BY_LINE        = 'X'
*     DAT_MODE            = ' '
*     CODEPAGE            = ' '
*     IGNORE_CERR         = ABAP_TRUE
*     REPLACEMENT         = '#'
*     CHECK_BOM           = ' '
*     VIRUS_SCAN_PROFILE  =
*     NO_AUTH_CHECK       = ' '
*   IMPORTING
*     FILELENGTH          =
*     HEADER              =
    tables
      data_tab            = it_var
*   CHANGING
*     ISSCANPERFORMED     = ' '
*   EXCEPTIONS
*     FILE_OPEN_ERROR     = 1
*     FILE_READ_ERROR     = 2
*     NO_BATCH            = 3
*     GUI_REFUSE_FILETRANSFER       = 4
*     INVALID_TYPE        = 5
*     NO_AUTHORITY        = 6
*     UNKNOWN_ERROR       = 7
*     BAD_DATA_FORMAT     = 8
*     HEADER_NOT_ALLOWED  = 9
*     SEPARATOR_NOT_ALLOWED         = 10
*     HEADER_TOO_LONG     = 11
*     UNKNOWN_DP_ERROR    = 12
*     ACCESS_DENIED       = 13
*     DP_OUT_OF_MEMORY    = 14
*     DISK_FULL           = 15
*     DP_TIMEOUT          = 16
*     OTHERS              = 17
    .
  if sy-subrc <> 0.
* Implement suitable error handling here
  endif.
endform.

form insert_data.
  loop at it_var into wa_var.

    perform bdc_dynpro      using 'SAPMS38V' '1100'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=SELOP'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'I_TVARVC_PARAMS-NAME(01)'.
    perform bdc_dynpro      using 'SAPMS38V' '1100'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=SEARCH'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'I_TVARVC_SELOPS-NAME(01)'.
    perform bdc_dynpro      using 'SAPMS38V' '1200'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'SEARCH_NAME'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=ENTER'.
    perform bdc_field       using 'SEARCH_NAME'
                                  'ZSLS_ORG_BDC'.
    perform bdc_dynpro      using 'SAPMS38V' '1100'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=TOGGLE'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'I_TVARVC_SELOPS-NAME(01)'.
    perform bdc_field       using 'I_TVARVC_SELOPS-MARK(01)'
                                  'X'.
    perform bdc_dynpro      using 'SAPMS38V' '1100'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=CHNG'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'I_TVARVC_SELOPS-NAME(01)'.
    perform bdc_dynpro      using 'SAPMS38V' '1100'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=MORE'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'I_TVARVC_SELOPS-MULT(01)'.
    perform bdc_dynpro      using 'SAPLALDB' '3000'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=ACPT'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'RSCSEL_255-SLOW_I(02)'.
    perform bdc_field       using 'RSCSEL_255-SLOW_I(01)'
                                  wa_var-var_low.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=SAVE'.

    call function 'BDC_INSERT'
      exporting
        tcode     = 'STVARV'
*       POST_LOCAL             = NOVBLOCAL
*       PRINTING  = NOPRINT
*       SIMUBATCH = ' '
*       CTUPARAMS = ' '
      tables
        dynprotab = it_bdc
*     EXCEPTIONS
*       INTERNAL_ERROR         = 1
*       NOT_OPEN  = 2
*       QUEUE_ERROR            = 3
*       TCODE_INVALID          = 4
*       PRINTING_INVALID       = 5
*       POSTING_INVALID        = 6
*       OTHERS    = 7
      .
    if sy-subrc <> 0.
* Implement suitable error handling here
    endif.

  endloop.
endform.

" SUBROUTINES that are necessarry

form bdc_dynpro using pg_name sc_no.
  clear wa_bdc.
  wa_bdc-program = pg_name.
  wa_bdc-dynpro = sc_no.
  wa_bdc-dynbegin = 'X'.
  append wa_bdc to it_bdc.
endform.

form bdc_field using fd_nam fd_val.
  clear wa_bdc.
  wa_bdc-fnam = fd_nam.
  wa_bdc-fval = fd_val.
  append wa_bdc to it_bdc.
endform.

form session_open.
  call function 'BDC_OPEN_GROUP'
    exporting
*     CLIENT                    = SY-MANDT
*     DEST  = FILLER8
      group = 'Z_VAR2'
*     HOLDDATE                  = FILLER8
      keep  = 'X'
      user  = sy-uname
*     RECORD                    = FILLER1
*     PROG  = SY-CPROG
*     DCPFM = '%'
*     DATFM = '%'
*   IMPORTING
*     QID   =
*   EXCEPTIONS
*     CLIENT_INVALID            = 1
*     DESTINATION_INVALID       = 2
*     GROUP_INVALID             = 3
*     GROUP_IS_LOCKED           = 4
*     HOLDDATE_INVALID          = 5
*     INTERNAL_ERROR            = 6
*     QUEUE_ERROR               = 7
*     RUNNING                   = 8
*     SYSTEM_LOCK_ERROR         = 9
*     USER_INVALID              = 10
*     OTHERS                    = 11
    .
  if sy-subrc <> 0.
* Implement suitable error handling here
  endif.

endform.

form session_close.
  call function 'BDC_CLOSE_GROUP'
*   EXCEPTIONS
*     NOT_OPEN          = 1
*     QUEUE_ERROR       = 2
*     OTHERS            = 3
            .
  if sy-subrc <> 0.
* Implement suitable error handling here
  endif.


  endform.
