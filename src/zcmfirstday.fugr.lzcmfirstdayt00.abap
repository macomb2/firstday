*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 07/23/2018 at 09:43:31
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZCM_FIRSTDAY....................................*
DATA:  BEGIN OF STATUS_ZCM_FIRSTDAY                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZCM_FIRSTDAY                  .
CONTROLS: TCTRL_ZCM_FIRSTDAY
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *ZCM_FIRSTDAY                  .
TABLES: ZCM_FIRSTDAY                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
