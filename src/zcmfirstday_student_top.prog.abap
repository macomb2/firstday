*&---------------------------------------------------------------------*
*&  Include  zcmfirstday_student_top
*&---------------------------------------------------------------------*
REPORT zcmfirstday_students.
TYPES:
  BEGIN OF stru_booked_stud,
    peryr      TYPE piqperyr,
    perid      TYPE piqperid,
    otjid      TYPE otjid, "SM
    packnumber TYPE piqslnum, "SE
    sobid      TYPE sobid, "ST
    smstatus   TYPE piqsmstatus, "status: 1=booked, 2=success, 3=fail
    id         TYPE piqmodreg_id, "module booking id
    zzpriox    TYPE priox, "priority: 50=booked, 99=waitlisted
  END OF stru_booked_stud.

TYPES:
  BEGIN OF sm_objid,
    type  TYPE otype,
    objid TYPE hrobjid,
  END OF sm_objid.

TYPES: table_booked_stud TYPE STANDARD TABLE OF stru_booked_stud.


DATA:
  lt_booked_stud   TYPE table_booked_stud,
  ls_firstday      TYPE zcm_firstday,
  lt_firstday      TYPE TABLE OF zcm_firstday,
  ls_booked_stud   TYPE stru_booked_stud,
  ls_firstday_st   TYPE zcmfirstday_st,
  ls_sm_objid      TYPE sm_objid,
  lv_student_no    TYPE piqstudent12,
  lv_st_objid      TYPE piqst_objid,
  lv_requestnumber TYPE bapirequest_key-requestnumber,
  lt_return        TYPE bapiret2_t,
  lt_req_doc       TYPE zcm_bapirequest_document_t,
  lv_counter       TYPE i,
  lv_partner       TYPE bu_partner.
CONSTANTS:
  lc_fd_fee             TYPE betrw_kk VALUE '90.55'.
