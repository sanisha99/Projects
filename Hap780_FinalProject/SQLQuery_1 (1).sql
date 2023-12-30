select * from [dbo].[ADMISSIONS]
[ADMISSION_TYPE]

select ad.[SUBJECT_ID] as subject_id, ad.[HADM_ID] as adm_id,
    case
    when ad.[ADMISSION_LOCATION] = 'HMO REFERRAL/SICK' then 0
    when ad.[ADMISSION_LOCATION] = 'CLINIC REFERAL/PREMATURE' then 1
    when ad.[ADMISSION_LOCATION] = 'EMERGENCY ROOM ADMIT' then 2
    when ad.[ADMISSION_LOCATION] = 'TRANSFER FROM HOSP/EXTRAM' then 3
    when ad.[ADMISSION_LOCATION] = 'TRSF WITHIN THIS FACILITY' then 4
    when ad.[ADMISSION_LOCATION] = 'TRANSFER FROM OTHER HEALT' then 5
    when ad.[ADMISSION_LOCATION] = '** INFO NOT AVAILABLE **' then 6
    when ad.[ADMISSION_LOCATION] = 'PHYS REFERRAL/NORMAL DELI' then 7
    when ad.[ADMISSION_LOCATION] = 'TRANSFER FROM SKILLED NUR' then 8
    end [ADMISSION_LOCATION]
    ,
    case
    when ad.[ADMISSION_TYPE] = 'ELECTIVE' then 1
    when ad.[ADMISSION_TYPE] = 'EMERGENCY' then 2
    when ad.[ADMISSION_TYPE] = 'EMERGENCY' then 3
    when ad.[ADMISSION_TYPE] = 'EMERGENCY' then 4
    end [ADMISSION_TYPE]
    ,
    case
    when ad.[MARITAL_STATUS] = 'SINGLE' then 1
    when ad.[MARITAL_STATUS] = 'WIDOWED' then 2
    when ad.[MARITAL_STATUS] = 'SEPARATED' then 3
    when ad.[MARITAL_STATUS] = 'LIFE PARTNER' then 4
    when ad.[MARITAL_STATUS] = 'MARRIED' then 5
    when ad.[MARITAL_STATUS] = 'UNKNOWN (DEFAULT)' then 6
    when ad.[MARITAL_STATUS] = 'DIVORCED' then 7
    else 6
    end [MARITAL_STATUS]
    ,
    case
    when ad.[INSURANCE] = 'Private' then 1
    when ad.[INSURANCE] = 'Medicaid' then 2
    when ad.[INSURANCE] = 'Self Pay' then 3
    when ad.[INSURANCE] =  'Government' then 4
    when ad.[INSURANCE] = 'Medicare' then 5
    end [INSURANCE]
    ,
    case
    when ad.[RELIGION] = 'JEWISH' then 1
    when ad.[RELIGION] = 'JEHOVAH''S WITNESS' then 2
    when ad.[RELIGION] = 'GREEK ORTHODOX' then 3
    when ad.[RELIGION] = 'NOT SPECIFIED' then 4
    when ad.[RELIGION] = 'ROMANIAN EAST. ORTH' then 5
    when ad.[RELIGION] = 'CATHOLIC' then 6
    when ad.[RELIGION] = 'EPISCOPALIAN' then 7
    when ad.[RELIGION] = 'METHODIST' then 8
    when ad.[RELIGION] = 'UNOBTAINABLE' then 9
    when ad.[RELIGION] = '7TH DAY ADVENTIST' then 10
    when ad.[RELIGION] = 'PROTESTANT QUAKER' then 11
    when ad.[RELIGION] = 'HINDU' then 12
    when ad.[RELIGION] = 'CHRISTIAN SCIENTIST' then 13
    when ad.[RELIGION] = 'OTHER' then 14
    when ad.[RELIGION] = 'HEBREW' then 15
    when ad.[RELIGION] = 'BAPTIST' then 16
    when ad.[RELIGION] = 'LUTHERAN' then 17
    when ad.[RELIGION] = 'MUSLIM' then 18
    when ad.[RELIGION] = 'UNITARIAN-UNIVERSALIST' then 19
    when ad.[RELIGION] = 'BUDDHIST' then 20
    else 4
    end [RELIGION]
    ,
    case
    when ad.[ETHNICITY] = 'HISPANIC/LATINO - PUERTO RICAN' then 1
    when ad.[ETHNICITY] = 'SOUTH AMERICAN' then 2
    when ad.[ETHNICITY] = 'BLACK/HAITIAN' then 3
    when ad.[ETHNICITY] = 'UNKNOWN/NOT SPECIFIED' then 4
    when ad.[ETHNICITY] = 'AMERICAN INDIAN/ALASKA NATIVE FEDERALLY RECOGNIZED TRIBE' then 5
    when ad.[ETHNICITY] = 'ASIAN - THAI' then 6
    when ad.[ETHNICITY] = 'ASIAN - VIETNAMESE' then 7
    when ad.[ETHNICITY] = 'ASIAN - FILIPINO' then 8
    when ad.[ETHNICITY] = 'MULTI RACE ETHNICITY' then 9
    when ad.[ETHNICITY] = 'HISPANIC/LATINO - COLOMBIAN' then 10
    when ad.[ETHNICITY] = 'ASIAN - CAMBODIAN' then 11
    when ad.[ETHNICITY] = 'HISPANIC/LATINO - HONDURAN' then 12
    when ad.[ETHNICITY] = 'AMERICAN INDIAN/ALASKA NATIVE' then 13
    when ad.[ETHNICITY] = 'ASIAN - ASIAN INDIAN' then 14
    when ad.[ETHNICITY] = 'ASIAN - KOREAN' then 15
    when ad.[ETHNICITY] = ' ASIAN - OTHER' then 16
    when ad.[ETHNICITY] = 'HISPANIC/LATINO - DOMINICAN' then 19
    when ad.[ETHNICITY] = 'HISPANIC/LATINO - GUATEMALAN' then 20
    when ad.[ETHNICITY] = 'CARIBBEAN ISLAND' then 21
    when ad.[ETHNICITY] = 'ASIAN' then 22
    when ad.[ETHNICITY] = 'HISPANIC/LATINO - SALVADORAN' then 23
    when ad.[ETHNICITY] = 'WHITE - EASTERN EUROPEAN' then 24
    when ad.[ETHNICITY] = 'WHITE - BRAZILIAN' then 25
    when ad.[ETHNICITY] = 'NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER' then 26
    when ad.[ETHNICITY] = 'ASIAN - JAPANESE' then 27
    when ad.[ETHNICITY] = 'BLACK/AFRICAN' then 28
    when ad.[ETHNICITY] = 'WHITE - OTHER EUROPEAN' then 29
    when ad.[ETHNICITY] = 'MIDDLE EASTERN' then 30
    when ad.[ETHNICITY] = 'ASIAN - CHINESE' then 31
    when ad.[ETHNICITY] = 'HISPANIC/LATINO - CUBAN' then 32
    when ad.[ETHNICITY] = 'WHITE' then 33
    when ad.[ETHNICITY] = 'HISPANIC/LATINO - MEXICAN' then 34
    when ad.[ETHNICITY] = 'OTHER' then 35
    when ad.[ETHNICITY] = 'HISPANIC OR LATINO' then 36
    when ad.[ETHNICITY] = 'PATIENT DECLINED TO ANSWER' then 37
    when ad.[ETHNICITY] = 'BLACK/AFRICAN AMERICAN' then 38
    when ad.[ETHNICITY] = 'WHITE - RUSSIAN' then 39
    when ad.[ETHNICITY] = 'BLACK/CAPE VERDEAN' then 40
    when ad.[ETHNICITY] = 'PORTUGUESE' then 41
    else 35
    end [ETHNICITY]
    ,DATEDIFF(d, '2002-01-01 00:00:00', ad.[ADMITTIME]) admit_time
     , DATEDIFF(d, '2002-01-01 00:00:00', ad.[DISCHTIME]) discharge_time
    into #ADMISSIONS_TABLE_1
from [dbo].[ADMISSIONS] ad;

select *from #ADMISSIONS_TABLE_1

DROP TABLE #ADMISSIONS_TABLE_1

select p.[SUBJECT_ID] as subject_id,
case
        when p.[GENDER] = 'F' then 1 else 2
        end [GENDER]
    ,DATEDIFF(d, '2002-01-01 00:00:00', p.[DOB]) dob 
INTO #PT1
from [dbo].[PATIENTS] p;

select * from #PT1; 

drop table #PT1




-- filtering   out the total number of diagnosis recorded for a patient
select d.[SUBJECT_ID] subject_id, d.[HADM_ID] adm_id, max(d.[SEQ_NUM]) seq_num 
into #td
from [dbo].[DIAGNOSES_ICD] d 
group by d.[SUBJECT_ID], d.[HADM_ID]

select * into #Null_ICD
from [dbo].[DIAGNOSES_ICD] d where d.[ICD9_CODE] is NULL

select * into #Not_Null
from [dbo].[DIAGNOSES_ICD] where [ICD9_CODE] is not null 

--- filtering out the ICD9 code starting with A and R ; cleaning icd9
select d.[SUBJECT_ID] subject_id, d.[HADM_ID] adm_id, SUBSTRING(d.[ICD9_CODE], 2, 3) icd9_code
into #icd9_table
from #Not_Null d where d.[SEQ_NUM] = 1 and d.[ICD9_CODE] not like '"A%' and d.[ICD9_CODE] not like '"R%';

select * from #icd9_table

select t.subject_id, t.adm_id, icd.icd9_code, t.seq_num
into #dt1
from #td t 
inner join #icd9_table icd on t.subject_id = icd.subject_id and t.adm_id = icd.adm_id 

select * from #dt1

drop table #dt1


-----------------------------

select p.[SUBJECT_ID] subject_id, p.[HADM_ID] adm_id, max(p.[SEQ_NUM]) proc_num
    into #proceduretab1
    from [dbo].[PROCEDURES_ICD] p 
    group by p.[SUBJECT_ID], p.[HADM_ID];

select * from #proceduretab1

drop table #proceduretab1

-------------------------------

select * from [dbo].[CPTEVENTS]
select cast (cpt.[CPT_NUMBER] as int) CPT_NUMBER
from [dbo].[CPTEVENTS] cpt;

------- costcenter only has two values ICU or RESP
------ taking average for cpt_number
select cpt.[SUBJECT_ID] subject_id, cpt.[HADM_ID] adm_id , AVG(CAST (cpt.[CPT_NUMBER] AS int)) cpt_num,
    case when cpt.[COSTCENTER] = 'ICU' then 1
            else 2
    end cost_center
into #cpt_table
from [dbo].[CPTEVENTS] cpt 
group by cpt.[SUBJECT_ID], cpt.[HADM_ID], cpt.[COSTCENTER];

select * from #cpt_table

drop table #cpt_table

-------------------------------------

select i.[SUBJECT_ID] subject_id, i.[HADM_ID] adm_id, i.[FIRST_WARDID] first_wardid, i.[LAST_WARDID] last_wardid, i.[LOS] los,
    case 
    when i.[FIRST_CAREUNIT] = 'CCU' then 1
    when i.[FIRST_CAREUNIT] = 'CSRU' then 2
    when i.[FIRST_CAREUNIT] = 'NICU' then 3
    when i.[FIRST_CAREUNIT] = 'MICU' then 4
    when i.[FIRST_CAREUNIT] = 'TSICU' then 5
    when i.[FIRST_CAREUNIT] = 'SICU' then 6
    end first_care
    ,case 
    when i.LAST_CAREUNIT = 'CCU' then 1
	 when i.LAST_CAREUNIT = 'CSRU' then 2
	  when i.LAST_CAREUNIT = 'NICU' then 3
	  when i.LAST_CAREUNIT = 'MICU' then 4
	  when i.LAST_CAREUNIT = 'TSICU' then 5
	  when i.LAST_CAREUNIT = 'SICU' then 6
	 end last_care
	into #icu_table
   FROM [dbo].[ICUSTAYS] i

select * from #icu_table

drop table #icu_table

-----------------------------------


select s.SUBJECT_ID subject_id, s.HADM_ID adm_id, 
  case 
  when s.PREV_SERVICE = 'TRAUM' then 1
  when s.PREV_SERVICE = 'NSURG' then 2
  when s.PREV_SERVICE = 'NBB' then 3
  when s.PREV_SERVICE = 'MED' then 4
  when s.PREV_SERVICE = 'PSYCH' then 5
  when s.PREV_SERVICE = 'NB' then 6
  when s.PREV_SERVICE = 'GU' then 7
  when s.PREV_SERVICE = 'OBS' then 8
  when s.PREV_SERVICE = 'ORTHO' then 9
  when s.PREV_SERVICE = 'GYN' then 10
  when s.PREV_SERVICE = 'VSURG' then 11
  when s.PREV_SERVICE = 'DENT' then 12
  when s.PREV_SERVICE = 'OMED' then 13
  when s.PREV_SERVICE = 'PSURG' then 14
  when s.PREV_SERVICE = 'NMED' then 15
  when s.PREV_SERVICE = 'TSURG' then 16
  when s.PREV_SERVICE = 'ENT' then 17
  when s.PREV_SERVICE = 'CMED' then 18
  when s.PREV_SERVICE = 'CSURG' then 19
  when s.PREV_SERVICE = 'SURG' then 20
  else 21
  end prev_service
  , case 
  when s.CURR_SERVICE = 'TRAUM' then 1
  when s.CURR_SERVICE = 'NSURG' then 2
  when s.CURR_SERVICE = 'NBB' then 3
  when s.CURR_SERVICE = 'MED' then 4
  when s.CURR_SERVICE = 'PSYCH' then 5
  when s.CURR_SERVICE = 'NB' then 6
  when s.CURR_SERVICE = 'GU' then 7
  when s.CURR_SERVICE = 'OBS' then 8
  when s.CURR_SERVICE = 'ORTHO' then 9
  when s.CURR_SERVICE = 'GYN' then 10
  when s.CURR_SERVICE = 'VSURG' then 11
  when s.CURR_SERVICE = 'DENT' then 12
  when s.CURR_SERVICE = 'OMED' then 13
  when s.CURR_SERVICE = 'PSURG' then 14
  when s.CURR_SERVICE = 'NMED' then 15
  when s.CURR_SERVICE = 'TSURG' then 16
  when s.CURR_SERVICE = 'ENT' then 17
  when s.CURR_SERVICE = 'CMED' then 18
  when s.CURR_SERVICE = 'CSURG' then 19
  when s.CURR_SERVICE = 'SURG' then 20
  else 21
  end curr_service
  into #service_table
  from [dbo].[SERVICES] s;


select * from #service_table
 
drop table #service_table

------ Joining All Temporary Tables

select a.*, d.seq_num, d.icd9_code
 into #temp_table_1
 from  #ADMISSIONS_TABLE_1 a
 inner join #dt1 d on a.subject_id = d.subject_id and a.adm_id = d.adm_id;

select * from #temp_table_1

drop table #temp_table_1

select distinct t1.*, s.prev_service, s.curr_service
 into #temp_table_2
 from  #service_table s
 inner join #temp_table_1 t1  on t1.subject_id = s.subject_id and t1.adm_id = s.adm_id;

select * from #temp_table_2

drop table #temp_table_2

select * from #cpt_table;

 select t2.*, c.cost_center, c.cpt_num
 into #temp_table_3
 from #temp_table_2 t2
  inner join #cpt_table c on t2.subject_id = c.subject_id and t2.adm_id = c.adm_id;
 select * from #temp_table_3;

 drop table #temp_table_3

select * from #icu_table;
 select t3.*,i.first_wardid, i.last_wardid, i.first_care, i.last_care, i.los
 into #temp_table_4
 from #temp_table_3 t3
 inner join #icu_table i on t3.subject_id = i.subject_id and t3.adm_id = i.adm_id;

 select * from #temp_table_4

 drop table #temp_table_4

select * from #proceduretab1

 select t4.* , p.proc_num
 into #temp_table_5
 from #temp_table_4 t4
 inner join #proceduretab1 p on  t4.subject_id = p.subject_id and t4.adm_id = p.adm_id;

select * from #temp_table_5

drop table #temp_table_5

select pt.*, p.gender, p.dob
 into #final_table_1
 from #temp_table_5 pt
 inner join #PT1 p on pt.subject_id = p.subject_id;

 select * from #final_table_1

 drop table final_1_table_1

select f.*, (f.admit_time - f.dob) age, (f.discharge_time - f.admit_time) as full_LOS
 into #final_table
 from #final_table_1 f where (f.discharge_time - f.admit_time) < 90;
 drop table #final_table

select count(*) as full_LOS from #final_table

select f.*, case when f.full_LOS > 10 then 1 else 0 end LOS_B 
 into final_LOS
 from #final_table f;

select * from  final_LOS

drop table final_LOS

DELETE FROM final_LOS
WHERE ADMISSION_LOCATION IS NULL;

DELETE FROM final_LOS
WHERE ADMISSION_TYPE IS NULL;

select * from  final_LOS