*&---------------------------------------------------------------------*
*& Report zcmfirstday_students
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zcmfirstday_student_top                 .    " global Data

* INCLUDE ZCMFIRSTDAY_STUDENT_O01                 .  " PBO-Modules
* INCLUDE ZCMFIRSTDAY_STUDENT_I01                 .  " PAI-Modules
* INCLUDE ZCMFIRSTDAY_STUDENT_F01                 .  " FORM-Routines

SELECTION-SCREEN BEGIN OF BLOCK 1.
PARAMETERS update TYPE boolean.
PARAMETERS count TYPE i.
SELECTION-SCREEN END OF BLOCK 1.

lv_counter = 0.
SELECT * FROM zcm_firstday INTO TABLE lt_firstday.
LOOP AT lt_firstday INTO ls_firstday.
  SELECT peryr, perid, otjid, packnumber, sobid, smstatus, id, zzpriox
      FROM v_piqmodbooked
      WHERE perid = @ls_firstday-crs_sess
      AND packnumber = @ls_firstday-section_objid
      AND peryr = @ls_firstday-crs_year
      AND smstatus = 1                    "booked and not yet completed
      AND zzpriox = '50'                  "remove waitlisted and transfer
      INTO TABLE @lt_booked_stud.
  LOOP AT lt_booked_stud INTO ls_booked_stud.
    lv_counter = lv_counter + 1.
    IF count IS NOT INITIAL AND
      lv_counter > count.
      EXIT.
    ENDIF.
    ls_firstday_st-fd_student = ls_booked_stud-sobid.
    ls_sm_objid = ls_booked_stud-otjid.
    ls_firstday_st-crs_objid = ls_sm_objid-objid.
    ls_firstday_st-fd_sess = ls_booked_stud-perid.
    ls_firstday_st-fd_year = ls_booked_stud-peryr.
    ls_firstday_st-section_objid = ls_booked_stud-packnumber.
    ls_firstday_st-fd_update_dt = sy-datum.
    ls_firstday_st-fd_update_tm = sy-timlo.
    WRITE: /(12) ls_firstday_st-fd_student,
            (30) ' First day table updated'.
    IF update IS NOT INITIAL.
      MODIFY zcmfirstday_st FROM ls_firstday_st.
      lv_st_objid = ls_firstday_st-fd_student.
      CALL METHOD zcl_cm_utilities=>get_studentnumber
        EXPORTING
          im_objectid      = lv_st_objid
        RECEIVING
          re_studentnumber = lv_student_no.
      CONCATENATE '00' lv_student_no INTO lv_partner.
      CALL FUNCTION 'Z_CM_FIRST_DAY_CHRG'
        EXPORTING
          im_partner       = lv_partner
          im_year          = ls_firstday_st-fd_year
          im_session       = ls_firstday_st-fd_sess
          im_firstday_fee  = lc_fd_fee
        IMPORTING
          ex_requestnumber = lv_requestnumber
          et_return        = lt_return
          et_req_doc       = lt_req_doc.
      IF lt_req_doc IS INITIAL.
        WRITE: /(12) lv_partner,
                (15) 'not posted'.
      ELSE.
        WRITE: /(12) lv_partner,
                (20) lv_requestnumber,
                (10) ' posted'.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDLOOP.
