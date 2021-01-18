DROP DATABASE IF EXISTS Hospital;
CREATE DATABASE Hospital;

DROP TABLE IF EXISTS doctor;
CREATE TABLE doctor (
	D_Ssn Varchar(10) not null,
	D_name varchar(40) not null,
	Age  int,
	Phone Varchar(15),
	DAddress Varchar(70),
	Office Varchar(20),
	PRIMARY KEY(D_Ssn)
	);

DROP TABLE IF EXISTS pat;
CREATE TABLE pat(
	P_Ssn Varchar(10) not null,
	P_name Varchar(40) not null,
	BirthDate Date,
	Phone Varchar(15),
	Paddress Varchar(70),
	PRIMARY KEY(P_Ssn)
	);
DROP TABLE IF EXISTS gender;
CREATE TABLE gender(
	Gender_id Varchar(10) not null,
	Gender_name Varchar(10),
	PRIMARY KEY(Gender_id)
	);
DROP TABLE IF EXISTS DoctorGender;
CREATE TABLE DoctorGender(
	Gender_id Varchar(10) not null,
	D_Ssn Varchar(10) not null,
	FOREIGN KEY (Gender_id) REFERENCES gender(Gender_id),
	FOREIGN KEY (D_Ssn) REFERENCES doctor(D_Ssn),
	);



DROP TABLE IF EXISTS City;
CREATE TABLE City(
	ZIP Varchar(10) not null,
	city_name Varchar(30),
	PRIMARY KEY(ZIP)
	);

DROP TABLE IF EXISTS DoctorCity;
CREATE TABLE DoctorCity (
	ZIP Varchar(10) not null,
	D_Ssn Varchar(10) not null,
	FOREIGN KEY (ZIP) REFERENCES City(ZIP),
	FOREIGN KEY (D_Ssn)REFERENCES doctor(D_Ssn),
	);

	DROP TABLE IF EXISTS PatientGender;
CREATE TABLE PatientGender(
	Gender_id varchar(10) not null,
	P_Ssn varchar(10) not null,
	FOREIGN KEY (Gender_id) REFERENCES gender(Gender_id),
	FOREIGN KEY (P_Ssn) REFERENCES pat(P_Ssn),
	);

DROP TABLE IF EXISTS PatientCity;
CREATE TABLE PatientCity(
	ZIP Varchar(10) not null,
	P_Ssn Varchar(10) not null,
	FOREIGN KEY (ZIP) REFERENCES City(ZIP),
	FOREIGN KEY (P_Ssn)REFERENCES pat(P_Ssn),
	);

DROP TABLE IF EXISTS Insurance;
CREATE TABLE Insurance(
	InsCo_Id Varchar(10) not null,
	InsCo_Name Varchar(30),
	Phone Varchar(15),
	IAddress Varchar(30),
	PRIMARY KEY(InsCo_Id)
	);
DROP TABLE IF EXISTS Patient_Insurance;
CREATE TABLE Patient_Insurance(
	P_Ssn Varchar(10) not null,
	InsCo_Id Varchar(10) not null,
	FOREIGN KEY (P_Ssn) REFERENCES Pat(P_Ssn),
	FOREIGN KEY (InsCo_Id) REFERENCES Insurance(InsCo_Id),
	);

DROP TABLE IF EXISTS InsuranceCity;
CREATE TABLE InsuranceCity(
	InsCo_Id Varchar(10) not null,
	ZIP Varchar(10) not null,
	FOREIGN KEY(InsCo_Id) REFERENCES Insurance(InsCo_Id),
	FOREIGN KEY(ZIP) REFERENCES City(ZIP),
	);

DROP TABLE IF EXISTS Bill;
CREATE TABLE Bill(
	Bill_Num Varchar(10) not null,
	Amount int,
	Bill_Date date,
	Due_date date,
	PRIMARY KEY(Bill_Num)
	);
DROP TABLE IF EXISTS Payment;
CREATE TABLE Payment(
	PayTrans_Num Varchar(10) not null,
	Pay_method Varchar(20),
	Pay_status Varchar(20),
	Paid_Date date,
	PRIMARY KEY (PayTrans_Num)
	);

DROP TABLE IF EXISTS Diagnosis;
CREATE TABLE Diagnosis(
	Diagnosis_Id Varchar(10) not null,
	category Varchar(30),
	PRIMARY KEY(Diagnosis_id)
	);

DROP TABLE IF EXISTS Prescription;
CREATE TABLE Prescription(
	Prescription_Id varchar(10),
	medicine_quantity int,
	PRIMARY KEY(Prescription_Id)
	);

DROP TABLE IF EXISTS Record;
CREATE TABLE Record(
	record_id Varchar(10) not null,
	record_type varchar(30),
	PRIMARY KEY(record_id)
	);

DROP TABLE IF EXISTS Manufacturer;
CREATE TABLE Manufacturer(
	Manufacturer_Id Varchar(10) not null,
	Manufacturer_name Varchar(30) ,
	PRIMARY KEY(Manufacturer_Id)
	);

DROP TABLE IF EXISTS Medicine;
CREATE TABLE Medicine(
	MInventory_Id varchar(10) not null,
	Manufacturer_id Varchar(10) not null,
	M_name Varchar(30),
	Price int,
	Quantity int,
	Exp_Date date,
	PRIMARY KEY(MInventory_Id),
	FOREIGN KEY (Manufacturer_id) REFERENCES Manufacturer(Manufacturer_Id),
	);

DROP TABLE IF EXISTS Visit;
CREATE TABLE Visit(
	Visit_id Varchar(10)  not null,
	Vdate date,
	Vtime dateTime ,
	complaint Varchar(200),
	Diagnosis_id Varchar(10) not null,
	D_Ssn Varchar(10) not null,
	Prescription_id varchar(10) not null,
	PRIMARY KEY(Visit_id),
	FOREIGN KEY(Diagnosis_id) REFERENCES Diagnosis(Diagnosis_id),
	FOREIGN KEY (D_Ssn) REFERENCES Doctor(D_Ssn),
	FOREIGN KEY (Prescription_id) REFERENCES Prescription(Prescription_Id),
	);

DROP TABLE IF EXISTS History;
CREATE TABLE History(
	P_Ssn Varchar(10) not null,
	Visit_id varchar(10) not null,
	FOREIGN KEY(P_Ssn) REFERENCES Pat(P_Ssn),
	FOREIGN KEY(Visit_id) REFERENCES Visit(Visit_id),
	);

DROP TABLE IF EXISTS PatientBill;
CREATE TABLE PatientBill(
	Bill_Num Varchar(10) not null,
	
	P_Ssn Varchar(10) not null,
	Diagnosis_id Varchar(10) not null,
	Prescription_id Varchar(10) not null,
	FOREIGN KEY(P_Ssn) REFERENCES Pat(P_Ssn),
	FOREIGN KEY(Diagnosis_id) REFERENCES Diagnosis(Diagnosis_Id),

	FOREIGN KEY(Bill_Num) REFERENCES Bill(Bill_Num),
	FOREIGN KEY(Prescription_id) REFERENCES Prescription(Prescription_id),
	
	);

DROP TABLE IF EXISTS BillPayment;
CREATE TABLE BillPayment(
	Bill_Num Varchar(10) not null,
	PayTrans_Num Varchar(10) not null,
	FOREIGN KEY(Bill_Num) REFERENCES Bill(Bill_Num),
	FOREIGN KEY(PayTrans_Num) REFERENCES Payment(PayTrans_Num),
	);

DROP TABLE IF EXISTS PrescriptionMedicine;
CREATE TABLE PrescriptionMedicine(
	MInventory_Id Varchar(10) not null,
	Prescription_id Varchar(10) not null,
	FOREIGN KEY(MInventory_Id) REFERENCES Medicine(MInventory_Id),
	FOREIGN KEY(Prescription_id) REFERENCES Prescription(Prescription_id),
);

DROP TABLE IF EXISTS PatientRecord;
CREATE TABLE PatientRecord(
	P_Ssn Varchar(10) not null,
	record_id Varchar(10) not null,
	FOREIGN KEY(P_Ssn) REFERENCES Pat(P_Ssn),
	FOREIGN KEY(record_id) REFERENCES Record(record_id),
	);


INSERT INTO gender Values('g1','Male');
INSERT INTO gender Values('g2','Female');

INSERT INTO City Values ('c1','Bangalore');
INSERT INTO City Values('c2','Hyderabad');
INSERT INTO City Values('c3','Vijayawada');
INSERT INTO City Values('c4','Anantapur');
INSERT INTO City Values('c5','Guntur');
INSERT INTO City Values('c6','Bombay');

INSERT INTO Insurance Values('IN001','Star Health','9123456789','Madhapur,Hyderabad');
INSERT INTO Insurance Values('IN002','HDFC ERGO','9124567389','IndiraNagar,Bangalore');
INSERT INTO Insurance Values('IN003','Apollo Munich','8976453210','Apollo Street ,Bombay');


INSERT INTO doctor Values('d001','Smith','40','Bangalore','Bangalore','9490914467');
INSERT INTO doctor Values('d002','Deepika','22','Bombay','18 Cross HSR LAyout ,Bombay','9807654321');
INSERT INTO doctor Values('d003','Bhargavi','24','Anantapur','Ramnagar,Anantapur','8923456790');
INSERT INTO doctor Values('d004','Rahul','26','Vijayawada','MG road ,Vijayawada','7890654321');
INSERT INTO doctor Values('d005','Tinku','35','Banglore','Bhanishankari,Banglore','9012345678');
INSERT INTO doctor Values('d006','Uchitha','30','Guntur','VidhyaNagar,Guntur','8097654321');

INSERT INTO pat Values('pa001','Rama','1995-10-15','940913345','SanjeevNagar,Nandhayal');
INSERT INTO pat Values('pa002','Ritish','2000-12-8','8097654323','Hyderabad');
INSERT INTO pat Values('pa003','Manasa','1997-3-10','7890654321','Bangalore');
INSERT INTO pat Values('pa004','Gananath','1988-7-3','6789012345','Bombay');

INSERT INTO DoctorGender Values('g1','d001');
INSERT INTO DoctorGender Values('g2','d002');
INSERT INTO DoctorGender Values('g2','d003');
INSERT INTO DoctorGender Values('g1','d004');
INSERT INTO DoctorGender Values('g1','d005');
INSERT INTO DoctorGender Values('g2','d006');

INSERT INTO DoctorCity Values('c1','d001');
INSERT INTO DoctorCity Values('c1','d005');

INSERT INTO PatientGender Values('g2','pa001');
INSERT INTO PatientGender Values('g1','pa002');
INSERT INTO PatientGender Values('g2','pa003');
INSERT INTO PatientGender Values('g1','pa004');

INSERT INTO PatientCity Values('c1','pa003');

INSERT INTO Bill Values('B001','5000','2020-5-23','2020-7-23');
INSERT INTO Bill Values('B002','2000','2020-5-18','2020-5-22');
INSERT INTO Bill Values('B003','13000','2020-5-22','2020-5-28');
INSERT INTO Bill Values('B004','1500','2020-5-16','2020-5-18');

INSERT INTO Payment Values('P001','Insurance','Paid','2020-7-23');
INSERT INTO Payment Values('P002','Self','Pending','2020-5-19');

INSERT INTO Diagnosis Values('dg001','HyperTension');
INSERT INTO Diagnosis Values('dg002','HIV');
INSERT INTO Diagnosis Values('dg003','Scanning');
INSERT INTO Diagnosis Values('dg004','Malaria');
INSERT INTO Diagnosis Values('dg005','Covid');

INSERT INTO Record Values('bg001','BloodGroupA');
INSERT INTO Record Values('bg002','BloodGroupB');
INSERT INTO Record Values('bg003','BloodGroupO');
INSERT INTO Record Values('aller001','SeasonalAllergy');
INSERT INTO Record Values('aller002','DrugAllergy');

INSERT INTO Manufacturer Values('Man001','M&B');
INSERT INTO Manufacturer Values('Man002','Emzor');
INSERT INTO Manufacturer Values('Man003','Pfizer');
INSERT INTO Manufacturer Values('Man004','Beecham');
INSERT INTO Manufacturer Values('Man005','Hulet');

INSERT INTO Prescription Values('pr001','2');
INSERT INTO Prescription Values('pr002','1');
INSERT INTO Prescription Values('pr003','3');
INSERT INTO Prescription Values('pr004','4');

INSERT INTO Medicine Values('001','Man004','Paracetamol','50','1','2022-1-12');
INSERT INTO Medicine Values('002','Man003','Amoxil','230','2','2023-1-3');
INSERT INTO Medicine Values('003','Man005','Ampiclox','1000','3','2022-4-5');
INSERT INTO Medicine Values('004','Man003','Novalgin','100','1','2022-3-1');

INSERT INTO Visit Values('V001','2020-5-16','2020-5-16 12:00','ConstantHeadache','dg001','d003','pr002');
INSERT INTO Visit Values('V002','2020-5-17','2020-5-17 15:00','highTemperature','dg004','d006','pr004');
INSERT INTO Visit Values('V004','2020-5-15','13:00','2020-5-15 high fever','dg004','d003','pr004');

INSERT INTO Patient_Insurance Values('pa001','IN001');
INSERT INTO Patient_Insurance Values('pa002','IN001');
INSERT INTO Patient_Insurance Values('pa003','IN003');

INSERT INTO InsuranceCity Values('IN003','c6');
	
	
INSERT INTO History Values('pa001','V001');
INSERT INTO History Values('pa001','V002');

INSERT INTO PatientBill Values('B001','pa001','dg001','pr002');


INSERT INTO BillPayment Values('B001','P001');

INSERT INTO PatientRecord Values('pa001','bg001');
INSERT INTO PatientRecord Values('pa002','bg002');
INSERT INTO PatientRecord Values('pa002','aller002');
INSERT INTO PatientRecord Values('pa001','aller001');
INSERT INTO PatientRecord Values('pa003','bg003');

INSERT INTO PrescriptionMedicine Values('001','pr001');
INSERT INTO PrescriptionMedicine Values('003','pr002');

SELECT Visit.Visit_id,Visit.Vtime,Diagnosis.category,Prescription.medicine_quantity
FROM Visit,Diagnosis,Prescription
WHERE Visit.D_Ssn='d003'
AND Visit.Diagnosis_id=Diagnosis.Diagnosis_Id
AND Visit.Prescription_id=Prescription.Prescription_Id


SELECT PatientBill.Bill_Num,Bill.Amount,pat.P_name,Diagnosis.category,Prescription.medicine_quantity,BillPayment.PayTrans_Num
FROM PatientBill,Bill,pat,Diagnosis,Prescription,BillPayment
where PatientBill.P_Ssn='pa001'
AND PatientBill.Bill_Num=Bill.Bill_Num
AND PatientBill.P_Ssn=pat.P_Ssn
AND PatientBill.Diagnosis_id=Diagnosis.Diagnosis_Id
AND PatientBill.Prescription_id=Prescription.Prescription_Id
AND PatientBill.Bill_Num=BillPayment.Bill_Num

SELECT COUNT(D_Ssn)
FROM DoctorGender
WHERE DoctorGender.Gender_id='g1'

SELECT COUNT(P_Ssn)
FROM History
WHERE P_Ssn='pa001' 

SELECT COUNT(P_Ssn)
FROM History,Visit
WHERE History.P_Ssn='pa001' 
AND History.Visit_id=Visit.Visit_id
AND Visit.D_Ssn='d003'

SELECT doctor.D_name,doctor.Office
FROM doctor,DoctorCity,City
WHERE doctor.D_Ssn=DoctorCity.D_Ssn
AND DoctorCity.ZIP=City.ZIP
AND city.ZIP='c1'


SELECT pat.P_name,Medicine.M_name,Medicine.Price,Medicine.Quantity,Medicine.Exp_Date 
FROM pat,Medicine,Prescription,PatientBill,PrescriptionMedicine
WHERE PatientBill.Prescription_Id='pr002'
AND PatientBill.P_Ssn=pat.P_Ssn
AND PrescriptionMedicine.MInventory_Id=Medicine.MInventory_Id


     

create table payment_miss
(
PayTrans_Num Varchar(10) not null,
    Pay_status Varchar(20),
    primary key(PayTrans_Num)
);


drop trigger if exists payStatus;



CREATE TRIGGER payStatus
instead of insert on payment
for each row
BEGIN
if new.Pay_Status = 'pending' begin
insert into payment_miss values(new.PayTrans_Num,'pending');
end 
END 


    

select * from payment_miss;













DROP TABLE IF EXISTS payment_pending;
CREATE TABLE payment_pending(
    
   PayTrans_Num Varchar(10) PRIMARY KEY,
	
	Pay_status Varchar(20) not null,
);
DROP VIEW IF EXISTS vw_payment;
CREATE VIEW vw_payment
AS
SELECT
	PayTrans_Num,
	'PAid' approval_status
    
FROM
    Payment

WHERE Pay_status='Paid'

UNION

SELECT
    PayTrans_Num,
    'Pending' approval_status
FROM
    payment_pending;


CREATE TRIGGER trg_vw_payment 
ON vw_payment
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO payment_pending( 
        PayTrans_Num,Pay_status
    )
    SELECT
        i.PayTrans_Num
    FROM
        inserted i
    WHERE
        i.PayTrans_Num NOT IN (
            SELECT 
                Pay_status
            FROM
				Payment
        );
END



SELECT PayTrans_Num,approval_status
FROM vw_payment;

SELECT PayTrans_Num,Pay_Status
FROM payment;

SELECT PayTrans_Num,Pay_Status
FROM payment_pending;

INSERT INTO vw_payment(PayTrans_Num)
VALUES('P003');


USE hospital;

SET sql_notes = 0;      -- Temporarily disable the "Table already exists" warning
drop trigger if exists doctor_backup;
drop table if exists dataMissing;
-- create table for bookings audit
create table dataMissing
(
D_Ssn varchar(10) not null,
    message varchar(255) not null,
    primary key(D_Ssn)
   
);


drop trigger if exists after_insert;



CREATE TRIGGER after_insert
instead of insert on doctor
for each row
BEGIN
IF new.Phone IS null 
begin
INSERT INTO dataMissing values(new.D_Ssn,concat('Hey ',new.D_name,' please update your Ph. No'));
end
    ELSE IF new.Age IS NULL begin
INSERT INTO dataMissing values(new.D_Ssn,concat('Hey ',new.D_name,' please update your Age'));
end
ELSE IF new.DAddress IS NULL begin
INSERT INTO dataMissing values(new.D_Ssn,concat('Hey ',new.D_name,' please update your ADDRESS'));
end
ELSE IF new.Office is null begin
INSERT INTO dataMissing values(new.D_Ssn,concat('Hey ',new.D_name,' please update your ADDRESS'));
END 
    
END 


SET sql_notes = 1;      -- And then re-enable the warning again

select * from datamissing;








CREATE VIEW medicine_info AS
    SELECT MInventory_Id,Manufacturer_id,M_name,Price,Quantity,Exp_Date
        FROM   Medicine;



CREATE TRIGGER insert_medicine
on medicine_info
instead of insert
as
--instead of INSERT ON medicine_info              


BEGIN
DECLARE @rowcnt INT;
SELECT COUNT(*) INTO rowcnt
    FROM Medicine
    WHERE (Manufacturer_id = new.Manufacturer_id);
IF rowcnt = 0  begin
       INSERT INTO Medicine(MInventory_Id,Manufacturer_id,M_name,Price,Quantity,Exp_Date) VALUES (new.MInventory_Id, new.Manufacturer_id,new.M_name,new.Price,new.Quantity,new.Exp_Date);
end
ELSE
begin
      UPDATE Medicine SET Medicine.Quantity = new.Quantity
         WHERE Medicine.Manufacturer_id = new.Manufacturer_id;
END 
END
      
CREATE TRIGGER insert_medicine
instead of INSERT ON medicine_info

FOR EACH ROW
DECLARE
   @rowcnt int;
BEGIN
   SELECT COUNT(*) INTO rowcnt 
   FROM Medicine 
   WHERE Manufacturer_id = :NEW.Manufacturer_id;
   IF rowcnt = 0 
   begin
       INSERT INTO Medicine(MInventory_Id,Manufacturer_id,M_name,Price,Quantity,Exp_Date) VALUES (:new.MInventory_Id,:new.Manufacturer_id,:new.M_name,:new.Price,:new.Quantity,:new.Exp_date);
	end
	ELSE
	begin
      UPDATE Medicine SET Medicine.Quantity = :New.Quantity
        WHERE Medicine.Manufacturer_id = :New.Manufacturer_id
   END 
END


CREATE VIEW doctor_info AS
    SELECT MInventory_Id,Manufacturer_id,M_name,Price,Quantity,Exp_Date
        FROM   Medicine;






 



CREATE TRIGGER medicine_update
ON Medicine
FOR INSERT
AS

BEGIN
	if new.Manufacturer_id=old.Manufacturer_id
	begin
		UPDATE Medicine
	SET Quantity=Quantity+1
	end
	
END



INSERT INTO Medicine VALUES('007','Man004','Paracetamol','50','2','2022-1-12');
SELECT * FROM Medicine


create function medicine_update()
returns TRIGGER
language plpgsql
as $functions$
begin
update Medicine set Quantity=Quantity+New.Quantity where New.Manufacturer_Id=Manufacturer_id;
return NULL;
end;
$functions;
CREATE TRIGGER medicine_update
after update on medicine
for each row
execute procedure medicine_update();
	

CREATE TRIGGER medicine_update
AFTER UPDATE
ON Medicine FOR EACH ROW
BEGIN
    IF new.Manufacturer_id!= old.Manufacturer_id
	begin
        insert into medicine values('new.MInventory_Id','new.Manufacturer_id','new.M_name','new.Price','new.Quantity','new.Exp_date');
    END
	else
	begin
		update Medicine
		set Quantity=new.Qunatity,
		Exp_Date=new.Exp_Date,
	end
END 


CREATE TRIGGER update_medicine 
ON Medicine after update as

begin 
	if (new.Manufacturer_id!=old.Manufacturer_id) 
	begin
		insert into medicine values('new.MInventory_Id','new.Manufacturer_id','new.M_name','new.Price','new.Quantity','new.Exp_date');
	end
	else
	begin
		update Medicine
			set old.Quantity=old.Quantity+new.Quantity;
	end
end

		

CREATE TABLE doctor_backup (
	D_Ssn Varchar(10) not null,
	D_name varchar(40) not null,
	Age  int,
	Phone Varchar(15),
	DAddress Varchar(70),
	Office Varchar(20),
	PRIMARY KEY(D_Ssn)
	);


CREATE TRIGGER insert_doctor after Insert ON doctor_backup 
FOR EACH ROW
if new.Age>25 THEN
BEGIN
INSERT INTO doctor_backup
VALUES ('new.D_Ssn','new.D_name','new.Age','new.Phone','new.DAddress','new.Office');
END
END 





DROP TRIGGER IF EXISTS insert_doctor;
DELIMITER //

CREATE TRIGGER insert_doctor
BEFORE INSERT
ON doctor FOR EACH ROW
IF New.Age > 20 THEN
BEGIN
    
    
    
        insert into doctor values ('new.D_Ssn','new.D_name','new.Age','new.Phone','new.DAddress','new.Office');
  END;  
    END IF// 



DELIMITER ;


use hospital;

DROP TRIGGER IF EXISTS hospital.insert_doctor;
USE hospital 
CREATE TRIGGER insert_doctor 
ON doctor AFTER INSERT AS
FOR EACH ROW
BEGIN 
IF NEW.Age > 25 THEN
insert into doctor values ('new.D_Ssn','new.D_name','new.Age','new.Phone','new.DAddress','new.Office');
END IF;
END 







CREATE TRIGGER 
insert_doctor
on doctor for insert as
begin 
	IF NEW.Age > 25 
		insert into doctor values ('new.D_Ssn','new.D_name','new.Age','new.Phone','new.DAddress','new.Office');
	end 
end

INSERT INto doctor values('da007','siva','40','6789012345','bangalore','bangalore');









CREATE TRIGGER 
insert_doctor
   after insert on doctor
for each row
begin
	IF NEW.Age > 25 THEN
insert into doctor values ('new.D_Ssn','new.D_name','new.Age','new.Phone','new.DAddress','new.Office');
END 
end











