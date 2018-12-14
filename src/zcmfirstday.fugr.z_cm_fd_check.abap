FUNCTION Z_CM_FD_CHECK.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IM_PERID) TYPE  ZCM_FIRSTDAY-CRS_SESS
*"     VALUE(IM_PERYR) TYPE  ZCM_FIRSTDAY-CRS_YEAR
*"     VALUE(IM_PACKNUMBER) TYPE  ZCM_FIRSTDAY-SECTION_OBJID
*"     VALUE(IM_SMSTATUS) TYPE  PIQSMSTATUS
*"     VALUE(IM_PRIOX) TYPE  PRIOX
*"  EXPORTING
*"     REFERENCE(EX_RETURN) TYPE REF TO  BAPIRET2
*"----------------------------------------------------------------------
DATA:
        lt_firstday                 TYPE TABLE OF zcm_firstday.

* load courses in local table
SELECT * FROM zcm_firstday INTO TABLE lt_firstday.

* If booked course
if im_smstatus = 1 AND
   im_priox = '50'.

endif.






  endfunction.
