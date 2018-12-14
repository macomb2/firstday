FUNCTION Z_CM_FD_UPDATE_ST.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_ACTIVITY) TYPE  CHAR1
*"     VALUE(IV_FD_STUDENT) TYPE  GPA1R_PAY
*"     VALUE(IV_FD_YEAR) TYPE  PIQPERYR
*"     VALUE(IV_FD_SESS) TYPE  PIQPERID
*"     VALUE(IV_CRS_OBJID) TYPE  OBJEKTID
*"     VALUE(IV_SECTION_OBJID) TYPE  OBJEKTID
*"  EXPORTING
*"     VALUE(RETURN) TYPE  BAPIRET2
*"----------------------------------------------------------------------
DATA: ls_firstday_st      type zcmfirstday_st,
      ls_return           TYPE bapiret2.

IF iv_activity = 'A'.
  move iv_fd_student to ls_firstday_st-fd_student.
  MOVE iv_fd_year TO ls_firstday_st-fd_year.
  move iv_fd_sess to ls_firstday_st-fd_sess.
  move iv_crs_objid TO ls_firstday_st-crs_objid.
  move iv_section_objid TO ls_firstday_st-section_objid.
  MODIFY zcmfirstday_st FROM ls_firstday_st.
  IF sy-subrc <> 0.
    CALL FUNCTION 'BALW_BAPIRETURN_GET2'
      EXPORTING
        type   = 'E'
        cl     = 'ZCMFIRSTDAY'
        number = 000
        par1   = iv_fd_student
        par2   = iv_crs_objid
        par3   = iv_section_objid
      IMPORTING
        return = ls_return.
  ENDIF.

ENDIF.




ENDFUNCTION.
