-- Tao va su dung database
CREATE DATABASE QUANLYGIAOVU
USE QUANLYGIAOVU

-- PHAN I: NGON NGU DINH NGHIA DU LIEU
-- Cau 1: Tao quan he va khai bao rang buoc. Them 3 thuoc tinh cho quan he HOCVIEN
-- Tao quan he
CREATE TABLE KHOA
(
	MAKHOA varchar(4) NOT NULL,
	TENKHOA varchar(40) ,
	NGTLAP smalldatetime ,
	TRGKHOA char(4) 
)
CREATE TABLE MONHOC
(
	MAMH varchar(10) NOT NULL,
	TENMH varchar(40) ,
	TCLT tinyint ,
	TCTH tinyint ,
	MAKHOA varchar(4) 
)
CREATE TABLE DIEUKIEN
(
	MAMH varchar(10) NOT NULL,
	MAMH_TRUOC varchar(10) NOT NULL
)
CREATE TABLE GIAOVIEN
(
	MAGV char(4) NOT NULL,
	HOTEN varchar(40) ,
	HOCVI varchar(10) ,
	HOCHAM varchar(10) ,
	GIOITINH varchar(3) ,
	NGSINH smalldatetime ,
	NGVL smalldatetime ,
	HESO numeric(4,2) ,
	MUCLUONG money ,
	MAKHOA varchar(4) 
)
CREATE TABLE LOP
(
	MALOP char(3) NOT NULL,
	TENLOP varchar(40) ,
	TRGLOP char(5) ,
	SISO tinyint ,
	MAGVCN char(4) 
)
CREATE TABLE HOCVIEN
(
	MAHV char(5) NOT NULL,
	HO varchar(40) ,
	TEN varchar(10) ,
	NGSINH smalldatetime ,
	GIOITINH varchar(3) ,
	NOISINH varchar(40) ,
	MALOP char(3) 
)
CREATE TABLE GIANGDAY
(
	MALOP char(3) NOT NULL,
	MAMH varchar(10) NOT NULL,
	MAGV char(4) ,
	HOCKY tinyint ,
	NAM smallint ,
	TUNGAY smalldatetime ,
	DENNGAY smalldatetime 
)
CREATE TABLE KETQUATHI 
(
	MAHV char(5) NOT NULL,
	MAMH varchar(10) NOT NULL,
	LANTHI tinyint NOT NULL,
	NGTHI smalldatetime ,
	DIEM numeric(4,2) ,
	KQUA varchar(10)
)
-- Them cac rang buoc PK, FK
ALTER TABLE HOCVIEN ADD CONSTRAINT PK_HOCVIEN PRIMARY KEY (MAHV)
ALTER TABLE LOP ADD CONSTRAINT PK_LOP PRIMARY KEY (MALOP)
ALTER TABLE KHOA ADD CONSTRAINT PK_KHOA PRIMARY KEY (MAKHOA)
ALTER TABLE MONHOC ADD CONSTRAINT PK_MONHOC PRIMARY KEY (MAMH)
ALTER TABLE DIEUKIEN ADD CONSTRAINT PK_DIEUKIEN PRIMARY KEY (MAMH, MAMH_TRUOC)
ALTER TABLE GIAOVIEN ADD CONSTRAINT PK_GIAOVIEN PRIMARY KEY (MAGV)
ALTER TABLE GIANGDAY ADD CONSTRAINT PK_GIANGDAY PRIMARY KEY(MALOP, MAMH)
ALTER TABLE KETQUATHI ADD CONSTRAINT PK_KQTHI PRIMARY KEY (MAHV, MAMH, LANTHI)
ALTER TABLE HOCVIEN ADD CONSTRAINT FK_HOCVIEN FOREIGN KEY (MALOP) REFERENCES LOP (MALOP)
ALTER TABLE LOP ADD CONSTRAINT FK_LOP FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN (MAGV)
ALTER TABLE LOP ADD CONSTRAINT FK_TRGLOP FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN (MAHV)
ALTER TABLE KHOA ADD CONSTRAINT FK_KHOA FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN (MAGV)
ALTER TABLE MONHOC ADD CONSTRAINT FK_MONHOC FOREIGN KEY (MAKHOA) REFERENCES KHOA (MAKHOA)
ALTER TABLE DIEUKIEN ADD CONSTRAINT FK_DIEUKIEN1 FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH)
ALTER TABLE DIEUKIEN ADD CONSTRAINT FK_DIEUKIEN2 FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC (MAMH)
ALTER TABLE GIAOVIEN ADD CONSTRAINT FK_GIAOVIEN FOREIGN KEY (MAKHOA) REFERENCES KHOA (MAKHOA)
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_GIANGDAY1 FOREIGN KEY (MALOP) REFERENCES LOP (MALOP)
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_GIANGDAY2 FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH)
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_GIANGDAY3 FOREIGN KEY (MAGV) REFERENCES GIAOVIEN (MAGV)
ALTER TABLE KETQUATHI ADD CONSTRAINT FK_KQTHI1 FOREIGN KEY (MAHV) REFERENCES HOCVIEN (MAHV)
ALTER TABLE KETQUATHI ADD CONSTRAINT FK_KQTHI2 FOREIGN KEY (MAMH) REFERENCES MONHOC (MAMH)
-- Them vao 3 thuoc tinh GHICHU, DIEMTB, XEPLOAI cho quan he HOCVIEN
ALTER TABLE HOCVIEN ADD GHICHU varchar(1000)
ALTER TABLE HOCVIEN ADD DIEMTB numeric (4,2)
ALTER TABLE HOCVIEN ADD XEPLOAI varchar(20)
-- Cau 2: Ma hoc vien la mot chuoi 5 ky tu, 3 ky tu dau la ma lop, 2 ky tu cuoi la stt hoc vien trong lop
ALTER TABLE HOCVIEN ADD CONSTRAINT CK_MAHV CHECK (MAHV LIKE '[A-Z][0-9][0-9][0-9][0-9]')
-- Cau 3: Thuoc tinh GIOITINH chi co gia tri la "Nam" hoac "Nu"
ALTER TABLE HOCVIEN ADD CONSTRAINT CK_GIOITINH CHECK (GIOITINH IN ('Nam','Nu'))
-- Cau 4: Diem so cua mot lan thi co gia tri tu 0 den 10 va can lu den 2 so le
ALTER TABLE KETQUATHI ADD CONSTRAINT CK_DIEM CHECK (0<= DIEM AND DIEM<=10)
-- Cau 5: Ket qua thi la "Dat" neu diem tu 5 den 10 va khong dat neu diem nho hon 5
ALTER TABLE KETQUATHI ADD CONSTRAINT CK_KQUA CHECK ((DIEM < 5 AND KQUA = 'Khong Dat') OR (5 <= DIEM AND DIEM <= 10 AND KQUA = 'Dat'))
-- Cau 6: Hoc vien thi moi mon toi da 3 lan
ALTER TABLE KETQUATHI ADD CONSTRAINT CK_LANTHI CHECK (LANTHI <= 3)
-- Cau 7: Hoc ky chi co gia tri tu 1 den 3
ALTER TABLE GIANGDAY ADD CONSTRAINT CK_HOCKY CHECK (1 <= HOCKY AND HOCKY <= 3)
-- Cau 8: Hoc vi cua giao vien chi co the la CN, KS, Ths, TS, PTS
ALTER TABLE GIAOVIEN ADD CONSTRAINT CK_HOCVI CHECK (HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS'))

-- Nhap du lieu cho CSDL
SET DATEFORMAT dmy
-- Quan he KHOA
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP)
	VALUES
		('KHMT', 'Khoa hoc may tinh', '7/6/2005'),
		('HTTT', 'He thong thong tin', '7/6/2005'),
		('CNPM', 'Cong nghe phan mem', '7/6/2005'),
		('MTT', 'Mang va truyen thong', '20/10/2005'),
		('KTMT', 'Ky thuat may tinh', '20/12/2005')
-- Quan he GIAOVIEN
INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA)
	VALUES
		('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '2/5/1950', '11/1/2004', 5.00, 2250000, 'KHMT'),
		('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '17/12/1965', '20/4/2004', 4.50, 2025000, 'HTTT'),
		('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1/8/1950', '23/9/2004', 4.00, 1800000, 'CNPM'),
		('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '22/2/1961', '12/1/2005', 4.50, 2025000, 'KTMT'),
		('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '12/3/1958', '12/1/2005', 3.00, 1350000, 'HTTT'),
		('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '11/3/1953', '12/1/2005', 4.50, 2025000, 'KHMT'),
		('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '23/11/1971', '1/3/2005', 4.00, 1800000, 'KHMT'),
		('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '26/3/1974', '1/3/2005', 1.69, 760500, 'KHMT'),
		('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '31/12/1966', '1/3/2005', 4.00, 1800000, 'HTTT'),
		('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '17/7/1972', '1/3/2005', 1.86, 837000, 'CNPM'),
		('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '12/1/1980', '15/5/2005', 2.67, 1201500, 'MTT'),
		('GV12', 'Tran Van Anh', 'CN', NULL, 'Nu', '29/3/1981', '15/5/2005', 1.69, 760500, 'CNPM'),
		('GV13', 'Nguyen Linh Dan', 'CN', NULL, 'Nu', '23/5/1980', '15/5/2005', 1.69, 760500, 'KTMT'),
		('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '30/11/1976', '15/5/2005', 3.00, 1350000, 'MTT'),
		('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '4/5/1978', '15/5/2005', 3.00, 1350000, 'KHMT')
-- Them truong khoa cho KHOA
UPDATE KHOA SET TRGKHOA = 'GV01' WHERE (MAKHOA = 'KHMT')
UPDATE KHOA SET TRGKHOA = 'GV02' WHERE (MAKHOA = 'HTTT')
UPDATE KHOA SET TRGKHOA = 'GV04' WHERE (MAKHOA = 'CNPM')
UPDATE KHOA SET TRGKHOA = 'GV03' WHERE (MAKHOA = 'MTT')
UPDATE KHOA SET TRGKHOA = NULL WHERE (MAKHOA = 'KTMT')
-- Quan he LOP
INSERT INTO LOP (MALOP, TENLOP, SISO, MAGVCN)
	VALUES
		('K11', 'Lop 1 khoa 1', 11, 'GV07'),
		('K12', 'Lop 2 khoa 1', 12, 'GV09'),
		('K13', 'Lop 3 khoa 1', 12, 'GV14')
-- Quan he HOCVIEN
INSERT INTO HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP)
	VALUES
		('K1101', 'Nguyen Van', 'A', '27/1/1986', 'Nam', 'TpHCM', 'K11'),
		('K1102', 'Tran Ngoc', 'Han', '14/3/1986', 'Nu', 'Kien Giang', 'K11'),
		('K1103', 'Ha Duy', 'Lap', '18/4/1986', 'Nam', 'Nghe An', 'K11'),
		('K1104', 'Tran Ngoc', 'Linh', '30/3/1986', 'Nu', 'Tay Ninh', 'K11'),
		('K1105', 'Tran Minh', 'Long', '27/2/1986', 'Nam', 'TpHCM', 'K11'),
		('K1106', 'Le Nhat', 'Minh', '24/1/1986', 'Nam', 'TpHCM', 'K11'),
		('K1107', 'Nguyen Nhu', 'Nhut', '27/1/1986', 'Nam', 'Ha Noi', 'K11'),
		('K1108', 'Nguyen Manh', 'Tam', '27/2/1986', 'Nam', 'Kien Giang', 'K11'),
		('K1109', 'Phan Thi Thanh', 'Tam', '27/1/1986', 'Nu', 'Vinh Long', 'K11'),
		('K1110', 'Le Hoai', 'Thuong', '5/2/1986', 'Nu', 'Can Tho', 'K11'),
		('K1111', 'Le Ha', 'Vinh', '25/12/1986', 'Nam', 'Vinh Long', 'K11'),
		('K1201', 'Nguyen Van', 'B', '11/2/1986', 'Nam', 'TpHCM', 'K12'),
		('K1202', 'Nguyen Thi Kim', 'Duyen', '18/1/1986', 'Nu', 'TpHCM', 'K12'),
		('K1203', 'Tran Thi Kim', 'Duyen', '17/9/1986', 'Nu', 'TpHCM', 'K12'),
		('K1204', 'Truong My', 'Hanh', '19/5/1986', 'Nu', 'Dong Nai', 'K12'),
		('K1205', 'Nguyen Thanh', 'Nam', '17/4/1986', 'Nam', 'TpHCM', 'K12'),
		('K1206', 'Nguyen Thi Truc', 'Thanh', '4/3/1986', 'Nu', 'Kien Giang', 'K12'),
		('K1207', 'Tran Thi Bich', 'Thuy', '8/2/1986', 'Nu', 'Nghe An', 'K12'),
		('K1208', 'Huynh Thi Kim', 'Trieu', '8/4/1986', 'Nu', 'Tay Ninh', 'K12'),
		('K1209', 'Pham Thanh', 'Trieu', '23/2/1986', 'Nam', 'TpHCM', 'K12'),
		('K1210', 'Ngo Thanh', 'Tuan', '14/2/1986', 'Nam', 'TpHCM', 'K12'),
		('K1211', 'Do Thi', 'Xuan', '9/3/1986', 'Nu', 'Ha Noi', 'K12'),
		('K1212', 'Le Thi Phi', 'Yen', '12/3/1986', 'Nu', 'TpHCM', 'K12'),
		('K1301', 'Nguyen Thi Kim', 'Cuc', '9/6/1986', 'Nu', 'Kien Giang', 'K13'),
		('K1302', 'Truong Thi My', 'Hien', '18/3/1986', 'Nu', 'Nghe An', 'K13'),
		('K1303', 'Le Duc', 'Hien', '21/3/1986', 'Nam', 'Tay Ninh', 'K13'),
		('K1304', 'Le Quang', 'Hien', '18/4/1986', 'Nam', 'TpHCM', 'K13'),
		('K1305', 'Le Thi', 'Huong', '27/3/1986', 'Nu', 'TpHCM', 'K13'),
		('K1306', 'Nguyen Thai', 'Huu', '30/3/1986', 'Nam', 'Ha Noi', 'K13'),
		('K1307', 'Tran Minh', 'Man', '28/5/1986', 'Nam', 'TpHCM', 'K13'),
		('K1308', 'Nguyen Hieu', 'Nghia', '8/4/1986', 'Nam', 'Kien Giang', 'K13'),
		('K1309', 'Nguyen Trung', 'Nghia', '18/1/1987', 'Nam', 'Nghe An', 'K13'),
		('K1310', 'Tran Thi Hong', 'Tham', '22/4/1986', 'Nu', 'Tay Ninh', 'K13'),
		('K1311', 'Tran Minh', 'Thuc', '4/4/1986', 'Nam', 'TpHCM', 'K13'),
		('K1312', 'Nguyen Thi Kim', 'Yen', '7/9/1986', 'Nu', 'TpHCM', 'K13')
-- Them lop truong cho LOP
UPDATE LOP SET TRGLOP = 'K1108' WHERE MALOP = 'K11'
UPDATE LOP SET TRGLOP = 'K1205' WHERE MALOP = 'K12'
UPDATE LOP SET TRGLOP = 'K1305' WHERE MALOP = 'K13'
-- Quan he MONHOC
INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA)
	VALUES
		('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
		('CTRR', 'Cau truc roi rac', 5, 0, 'KHMT'),
		('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
		('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
		('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
		('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
		('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
		('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
		('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
		('HDH', 'He dieu hanh', 4, 0, 'KTMT'),
		('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
		('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
		('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM')
-- Quan he GIANGDAY
INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY)
	VALUES
		('K11', 'THDC', 'GV07', 1, 2006, '2/1/2006', '12/5/2006'),
		('K12', 'THDC', 'GV06', 1, 2006, '2/1/2006', '12/5/2006'),
		('K13', 'THDC', 'GV15', 1, 2006, '2/1/2006', '12/5/2006'),
		('K11', 'CTRR', 'GV02', 1, 2006, '9/1/2006', '17/5/2006'),
		('K12', 'CTRR', 'GV02', 1, 2006, '9/1/2006', '17/5/2006'),
		('K13', 'CTRR', 'GV08', 1, 2006, '9/1/2006', '17/5/2006'),
		('K11', 'CSDL', 'GV05', 2, 2006, '1/6/2006', '15/7/2006'),
		('K12', 'CSDL', 'GV09', 2, 2006, '1/6/2006', '15/7/2006'),
		('K13', 'CTDLGT', 'GV15', 2, 2006, '1/6/2006', '15/7/2006'),
		('K13', 'CSDL', 'GV05', 3, 2006, '1/8/2006', '15/12/2006'),
		('K13', 'DHMT', 'GV07', 3, 2006, '1/8/2006', '15/12/2006'),
		('K11', 'CTDLGT', 'GV15', 3, 2006, '1/8/2006', '15/12/2006'),
		('K12', 'CTDLGT', 'GV15', 3, 2006, '1/8/2006', '15/12/2006'),
		('K11', 'HDH', 'GV04', 1, 2007, '2/1/2007', '18/2/2007'),
		('K12', 'HDH', 'GV04', 1, 2007, '2/1/2007', '20/3/2007'),
		('K11', 'DHMT', 'GV07', 1, 2007, '18/2/2007', '20/3/2007')
-- Quan he DIEUKIEN
INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC)
	VALUES
		('CSDL', 'CTRR'),
		('CSDL', 'CTDLGT'),
		('CTDLGT', 'THDC'),
		('PTTKTT', 'THDC'),
		('PTTKTT', 'CTDLGT'),
		('DHMT', 'THDC'),
		('LTHDT', 'THDC'),
		('PTTKHTTT', 'CSDL')
-- Quan he KETQUATHI
INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA)
	VALUES
		('K1101', 'CSDL', 1, '20/7/2006', 10.00, 'Dat'),
		('K1101', 'CTDLGT', 1, '28/12/2006', 9.00, 'Dat'),
		('K1101', 'THDC', 1, '20/5/2006', 9.00, 'Dat'),
		('K1101', 'CTRR', 1, '13/5/2006', 9.50, 'Dat'),
		('K1102', 'CSDL', 1, '20/7/2006', 4.00, 'Khong Dat'),
		('K1102', 'CSDL', 2, '27/7/2006', 4.25, 'Khong Dat'),
		('K1102', 'CSDL', 3, '10/8/2006', 4.50, 'Khong Dat'),
		('K1102', 'CTDLGT', 1, '28/12/2006', 4.50, 'Khong Dat'),
		('K1102', 'CTDLGT', 2, '5/1/2007', 4.00, 'Khong Dat'),
		('K1102', 'CTDLGT', 3, '15/1/2007', 6.00, 'Dat'),
		('K1102', 'THDC', 1, '20/5/2006', 5.00, 'Dat'),
		('K1102', 'CTRR', 1, '13/5/2006', 7.00, 'Dat'),
		('K1103', 'CSDL', 1, '20/7/2006', 3.50, 'Khong Dat'),
		('K1103', 'CSDL', 2, '27/7/2006', 8.25, 'Dat'),
		('K1103', 'CTDLGT', 1, '28/12/2006', 7.00, 'Dat'),
		('K1103', 'THDC', 1, '20/5/2006', 8.00, 'Dat'),
		('K1103', 'CTRR', 1, '13/5/2006', 6.50, 'Dat'),
		('K1104', 'CSDL', 1, '20/7/2006', 3.75, 'Khong Dat'),
		('K1104', 'CTDLGT', 1, '28/12/2006', 4.00, 'Khong Dat'),
		('K1104', 'THDC', 1, '20/5/2006', 4.00, 'Khong Dat'),
		('K1104', 'CTRR', 1, '13/5/2006', 4.00, 'Khong Dat'),
		('K1104', 'CTRR', 2, '20/5/2006', 3.50, 'Khong Dat'),
		('K1104', 'CTRR', 3, '30/6/2006', 4.00, 'Khong Dat'),
		('K1201', 'CSDL', 1, '20/7/2006', 6.00, 'Dat'),
		('K1201', 'CTDLGT', 1, '28/12/2006', 5.00, 'Dat'),
		('K1201', 'THDC', 1, '20/5/2006', 8.50, 'Dat'),
		('K1201', 'CTRR', 1, '13/5/2006', 9.00, 'Dat'),
		('K1202', 'CSDL', 1, '20/7/2006', 8.00, 'Dat'),
		('K1202', 'CTDLGT', 1, '28/12/2006', 4.00, 'Khong Dat'),
		('K1202', 'CTDLGT', 2, '5/1/2007', 5.00, 'Dat'),
		('K1202', 'THDC', 1, '20/5/2006', 4.00, 'Khong Dat'),
		('K1202', 'THDC', 2, '27/5/2006', 4.00, 'Khong Dat'),
		('K1202', 'CTRR', 1, '13/5/2006', 3.00, 'Khong Dat'),
		('K1202', 'CTRR', 2, '20/5/2006', 4.00, 'Khong Dat'),
		('K1202', 'CTRR', 3, '30/6/2006', 6.25, 'Dat'),
		('K1203', 'CSDL', 1, '20/7/2006', 9.25, 'Dat'),
		('K1203', 'CTDLGT', 1, '28/12/2006', 9.50, 'Dat'),
		('K1203', 'THDC', 1, '20/5/2006', 10.00, 'Dat'),
		('K1203', 'CTRR', 1, '13/5/2006', 10.00, 'Dat'),
		('K1204', 'CSDL', 1, '20/7/2006', 8.50, 'Dat'),
		('K1204', 'CTDLGT', 1, '28/12/2006', 6.75, 'Dat'),
		('K1204', 'THDC', 1, '20/5/2006', 4.00, 'Khong Dat'),
		('K1204', 'CTRR', 1, '13/5/2006', 6.00, 'Dat'),
		('K1301', 'CSDL', 1, '20/12/2006', 4.25, 'Khong Dat'),
		('K1301', 'CTDLGT', 1, '25/7/2006', 8.00, 'Dat'),
		('K1301', 'THDC', 1, '20/5/2006', 7.75, 'Dat'),
		('K1301', 'CTRR', 1, '13/5/2006', 8.00, 'Dat'),
		('K1302', 'CSDL', 1, '20/12/2006', 6.75, 'Dat'),
		('K1302', 'CTDLGT', 1, '25/7/2006', 5.00, 'Dat'),
		('K1302', 'THDC', 1, '20/5/2006', 8.00, 'Dat'),
		('K1302', 'CTRR', 1, '13/5/2006', 8.50, 'Dat'),
		('K1303', 'CSDL', 1, '20/12/2006', 4.00, 'Khong Dat'),
		('K1303', 'CTDLGT', 1, '25/7/2006', 4.50, 'Khong Dat'),
		('K1303', 'CTDLGT', 2, '7/8/2006', 4.00, 'Khong Dat'),
		('K1303', 'CTDLGT', 3, '15/8/2006', 4.25, 'Khong Dat'),
		('K1303', 'THDC', 1, '20/5/2006', 4.50, 'Khong Dat'),
		('K1303', 'CTRR', 1, '13/5/2006', 3.25, 'Khong Dat'),
		('K1303', 'CTRR', 2, '20/5/2006', 5.00, 'Dat'),
		('K1304', 'CSDL', 1, '20/12/2006', 7.75, 'Dat'),
		('K1304', 'CTDLGT', 1, '25/7/2006', 9.75, 'Dat'),
		('K1304', 'THDC', 1, '20/5/2006', 5.50, 'Dat'),
		('K1304', 'CTRR', 1, '13/5/2006', 5.00, 'Dat'),
		('K1305', 'CSDL', 1, '20/12/2006', 9.25, 'Dat'),
		('K1305', 'CTDLGT', 1, '25/7/2006', 10.00, 'Dat'),
		('K1305', 'THDC', 1, '20/5/2006', 8.00, 'Dat'),
		('K1305', 'CTRR', 1, '13/5/2006', 10.00, 'Dat')

-- PHAN I: NGON NGU DINH NGHIA DU LIEU
-- Cau 11: Hoc vien it nhat la 18 tuoi
ALTER TABLE HOCVIEN ADD CONSTRAINT CK_TUOI CHECK (DATEDIFF(year, NGSINH, GETDATE()) >= 18)
-- Cau 12: Giang day mot mon hoc ngay bat dau phai nho hon ngay ket thuc
ALTER TABLE GIANGDAY ADD CONSTRAINT CK_NGAYBD_KT CHECK (TUNGAY < DENNGAY)
-- Cau 13: Giao vien khi vao lam it nhat la 22 tuoi
ALTER TABLE GIAOVIEN ADD CONSTRAINT CK_NGVL CHECK (DATEDIFF(year, NGSINH, NGVL) >= 22)
-- Cau 14: Tat ca cac mon hoc deu co so tin chi ly thuyet va tin chi thuc hanh chenh ech nhau khong qua 5
ALTER TABLE MONHOC ADD CONSTRAINT CK_SLTC CHECK (ABS(TCLT - TCTH) <= 5)

-- PHAN III: NGON NGU TRUY VAN DU LIEU
-- Cau 1: in ra danh sach (MAHV, HO, TEN, NGSINH, MALOP) lop truong cua cac lop
SELECT MAHV, HO, TEN, NGSINH, HOCVIEN.MALOP 
	FROM HOCVIEN JOIN LOP ON HOCVIEN.MALOP = LOP.MALOP
	WHERE (MAHV = TRGLOP)
-- Cau 2: in ra bang diem thi (MAHV, HO, TEN , LANTHI, DIEM) mon CTRR cua lop K12 sap xep theo ten, ho hoc vien
SELECT HOCVIEN.MAHV, HO, TEN, LANTHI, DIEM
	FROM HOCVIEN JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
	WHERE (MAMH = 'CTRR' and MALOP = 'K12')
	ORDER BY TEN ASC, HO ASC
-- Cau 3: in danh sach hoc vien (MAHV, HO, TEN) va nhung mon hoc ma hoc vien do thi lan thu nhat da dat
SELECT HOCVIEN.MAHV, HO, TEN, MAMH 
	FROM HOCVIEN JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
	WHERE (LANTHI = 1 AND KQUA = 'Dat')
-- Cau 4: in danh sach hoc vien (MAHV, HO, TEN) cua lop K11 thi mon CTRR khong dat o lan thi 1
SELECT HOCVIEN.MAHV, HO, TEN
	FROM HOCVIEN JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
	WHERE(MALOP = 'K11' AND LANTHI = 1 AND MAMH = 'CTRR' AND KQUA = 'Khong Dat')
-- Cau 5: in danh sach hoc vien (MAHV, HO, TEN) cua lop K thi mon CTRR khong dat o tat ca cac lan thi
SELECT HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
	FROM HOCVIEN JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
	WHERE(MAMH = 'CTRR')
	GROUP BY HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
	HAVING (COUNT(DISTINCT KQUA) = 1 AND MAX(KQUA) = 'Khong Dat')

-- PHAN II: NGON NGU THAO TAC DU LIEU
-- Cau 1: Tang he so luong them 0.2 cho nhung giao vien la truong khoa
UPDATE GIAOVIEN SET HESO = HESO + 0.2 
	WHERE MAGV IN (SELECT TRGKHOA FROM KHOA)
-- Cau 2: Cap nhat gia tri DIEMTB cua moi hoc vien (cac mon co he so 1 va lay ket qua lan thi cuoi cung)
UPDATE HOCVIEN SET DIEMTB = HV_DTB.TB
FROM HOCVIEN HV JOIN (SELECT KQ.MAHV, AVG(DIEM) AS TB
						FROM KETQUATHI KQ 
						JOIN (
							SELECT MAHV, MAMH, MAX(LANTHI) AS LANCUOI
							FROM KETQUATHI
							GROUP BY MAHV, MAMH
							) LC
						ON (KQ.MAHV = LC.MAHV AND KQ.MAMH = LC.MAMH AND KQ.LANTHI = LC.LANCUOI)
						GROUP BY KQ.MAHV
					 ) AS HV_DTB 
				ON HV.MAHV = HV_DTB.MAHV
-- Cau 3: Cap nhat gia tri cho cot GHICHU la "Cam thi" voi hoc vien co mot mon bat ki thi lan thu 3 duoi 5 diem
UPDATE HOCVIEN SET GHICHU = 'Cam thi'
	WHERE HOCVIEN.MAHV IN (SELECT DISTINCT KETQUATHI.MAHV FROM KETQUATHI WHERE LANTHI=3 AND DIEM <5)
SELECT * FROM HOCVIEN
-- Cau 4: Cap nhat gia tri cho cot XEPLOAI trong quan he HOCVIEN 
UPDATE HOCVIEN SET XEPLOAI = 'XS' WHERE DIEMTB >= 9
UPDATE HOCVIEN SET XEPLOAI = 'G' WHERE DIEMTB >= 8 AND DIEMTB < 9
UPDATE HOCVIEN SET XEPLOAI = 'K' WHERE DIEMTB >= 6.5 AND DIEMTB < 8
UPDATE HOCVIEN SET XEPLOAI = 'TB' WHERE DIEMTB >= 5 AND DIEMTB < 6.5
UPDATE HOCVIEN SET XEPLOAI = 'Y' WHERE DIEMTB < 5

-- PHAN III: NGON NGU TRUY VAN DU LIEU
-- Cau 6: Tim ten nhung mon hoc ma giao vien co ten "Tran Tam Thanh" day trong hk1 nam 2006
SELECT DISTINCT TENMH
	FROM MONHOC MH
		JOIN GIANGDAY GD ON MH.MAMH = GD.MAMH
		JOIN GIAOVIEN GV ON GV.MAGV = GD.MAGV
	WHERE GV.HOTEN = 'Tran Tam Thanh' and HOCKY = 1 AND NAM = 2006
-- Cau 7: Tim nhung mon hoc (MAMH, TENMH) ma giao vien chu nhiem lop K11 day trong HK1 nam 2006
SELECT MH.MAMH, MH.TENMH
	FROM GIANGDAY GD JOIN (SELECT MAGVCN FROM LOP WHERE LOP.MALOP = 'K11') GVCN ON GD.MAGV = GVCN.MAGVCN
					 JOIN MONHOC MH ON GD.MAMH = MH.MAMH
	WHERE NAM = 2006 AND HOCKY = 1
-- Cau 8: Tim ho ten lop truong cua lop ma gvcn co ten la "Nguyen To Lan" day mon CSDL
SELECT HO, TEN 
	FROM GIAOVIEN GV JOIN LOP ON GV.MAGV = LOP.MAGVCN
					JOIN HOCVIEN HV ON HV.MAHV = LOP.TRGLOP
					JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
					JOIN MONHOC MH ON MH.MAMH = GD.MAMH
	WHERE HOTEN = 'Nguyen To Lan' AND TENMH = 'Co so du lieu'
-- Cau 9: In danh sach mon hoc (MAMH, TENMH) phai hoc lien truoc mon 'Co so du lieu'
SELECT MH.MAMH, MH.TENMH
FROM (SELECT DISTINCT MH.MAMH as MHSAU
			FROM DIEUKIEN DK JOIN MONHOC MH ON MH.MAMH = DK.MAMH
			WHERE TENMH = 'Co so du lieu') SAU JOIN DIEUKIEN DK ON DK.MAMH = SAU.MHSAU 
												JOIN MONHOC MH ON MH.MAMH = DK.MAMH_TRUOC
-- Cau 10: Mon 'Cau truc roi rac' la mon bat buoc phai hoc lien truoc nhung mon hoc nao (MAMH, TENMH)
SELECT MH.MAMH, MH.TENMH
FROM (SELECT DISTINCT MH.MAMH AS MHTRUOC
			FROM DIEUKIEN DK JOIN MONHOC MH ON MH.MAMH = DK.MAMH_TRUOC
			WHERE TENMH = 'Cau truc roi rac') TRUOC JOIN DIEUKIEN DK ON DK.MAMH_TRUOC = TRUOC.MHTRUOC
													JOIN MONHOC MH ON MH.MAMH = DK.MAMH
-- Cau 11: Tim ho ten giao vien day mon CTRR cho ca 2 lop K11 va K12 trong HK1 nam 2006
SELECT HOTEN
	FROM GIAOVIEN GV JOIN GIANGDAY GD ON GV.MAGV = GD.MAGV
	WHERE GD.MAMH = 'CTRR' AND HOCKY = 1 AND NAM = 2006 AND MALOP = 'K11' AND GV.MAGV IN 
		(SELECT GV.MAGV FROM GIAOVIEN GV JOIN GIANGDAY GD ON GV.MAGV = GD.MAGV 
			WHERE GD.MAMH = 'CTRR' AND HOCKY = 1 AND NAM = 2006 AND MALOP = 'K12')
-- Cau 12: Tim nhung hoc vien (mahv, hoten) thi khong dat mon CSDL o lan thi thu 1 nhung chua thi lai mon nay
SELECT distinct HV.MAHV, HV.HO, HV.TEN
	FROM HOCVIEN HV JOIN(
		SELECT MAHV, MAMH
			FROM KETQUATHI KQ 
			WHERE MAMH = 'CSDL'
			GROUP BY KQ.MAHV, KQ.MAMH
			HAVING MAX(LANTHI) = 1) as A
		ON HV.MAHV = A.MAHV
		JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
		WHERE KQUA = 'Khong Dat' AND LANTHI = 1 AND KQ.MAMH = 'CSDL'
-- Cau 13: Tim giao vien (magv, hoten) khong duoc phan cong giang day bat ki mon hoc nao
SELECT GV.MAGV, HOTEN FROM GIAOVIEN GV WHERE NOT EXISTS (SELECT * FROM GIANGDAY GD WHERE GD.MAGV = GV.MAGV)
-- Cau 14: Tim giao vien (magv, hoten) khong duoc phan cong giang day bat ki mon hoc nao thuoc khoa gv do phu trach
SELECT GV.MAGV, HOTEN FROM GIAOVIEN GV
	WHERE NOT EXISTS 
	(SELECT * FROM GIANGDAY GD 
		JOIN MONHOC MH ON GD.MAMH = MH.MAMH
		WHERE GD.MAGV = GV.MAGV AND GV.MAKHOA = MH.MAKHOA)
-- Cau 15: Tim ho ten cac hoc vien thuoc lop 'K11' thi 1 mon bat ky 3 lan ma van khong dat hoac thi CTRR lan thu 2 duoc 5 diem
SELECT HV.HO + ' ' + HV.TEN AS HOTEN
	FROM HOCVIEN HV 
	WHERE HV.MAHV IN ( SELECT MAHV FROM KETQUATHI KQ
			WHERE LEFT(MAHV,3) = 'K11' 
				AND (EXISTS (SELECT * FROM KETQUATHI KQ WHERE HV.MAHV = KQ.MAHV AND LANTHI = 3 AND KQUA = 'Khong Dat')
						OR (LANTHI = 2 AND MAMH = 'CTRR' AND DIEM = 5)))
-- Cau 16: Tim ho ten giao vien day mon CTRR cho it nhat 2 lop trong cung 1 hoc ky cua 1 nam hoc
SELECT HOTEN
	FROM GIAOVIEN GV JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
	WHERE MAMH = 'CTRR'
	GROUP BY GD.MAGV, GV.HOTEN, HOCKY, NAM
	HAVING COUNT(*) >= 2
-- Cau 17: Danh sach hoc vien va diem thi mon CSDL (lan thi sau cung)
SELECT HV.MAHV, HO + ' ' + TEN AS HOTEN, DIEM
	FROM HOCVIEN HV 
		JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
		JOIN (SELECT MAHV, MAX(LANTHI) AS LANCUOI FROM KETQUATHI 
				WHERE MAMH = 'CSDL'
				GROUP BY MAHV, MAMH) A ON A.MAHV = HV.MAHV
	WHERE MAMH = 'CSDL' AND LANTHI = LANCUOI
-- Cau 18: Danh sach hoc vien va diem thi mon 'Co so du lieu' (diem cao nhat cua cac lan thi)
SELECT HV.MAHV, HO + ' ' + TEN AS HOTEN, MAX(DIEM) AS DIEMMAX
	FROM HOCVIEN HV
		JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
		JOIN MONHOC MH ON MH.MAMH = KQ.MAMH
	WHERE TENMH = 'Co so du lieu'
	GROUP BY HV.MAHV, HO + ' ' + TEN, KQ.MAMH
-- Cau 19: Khoa nao (MAKHOA, TENKHOA) duoc thanh lap som nhat
SELECT TOP 1 WITH TIES MAKHOA, TENKHOA FROM KHOA ORDER BY NGTLAP ASC
-- Cau 20: Co bao nhieu giao vien co hoc ham la 'GS' hoac 'PGS'
SELECT COUNT(MAGV) AS SOLUONG FROM GIAOVIEN WHERE HOCHAM = 'GS' OR HOCHAM = 'PGS'
-- Cau 21: Thong ke co bao nhieu giao vien co hoc vi la CN, KS, Ths, TS, PTS trong moi khoa
SELECT MAKHOA, HOCVI, COUNT(*) AS SOLUONG FROM GIAOVIEN GROUP BY MAKHOA, HOCVI
-- Cau 22: Moi mon hoc thong ke so luong hoc vien theo ket qua (dat, khong dat)
SELECT MAMH, KQUA, COUNT(DISTINCT MAHV) AS SOLUONG
	FROM KETQUATHI KQ1
	WHERE LANTHI >= ALL (SELECT LANTHI 
							FROM KETQUATHI KQ2
							WHERE KQ1.MAHV = KQ2.MAHV AND KQ1.MAMH = KQ2.MAMH)
	GROUP BY MAMH, KQUA
-- Cau 23: Tim giao vien (MAGV, HOTEN) la giao vien chu nhiem cua 1 lop, dong thoi day cho lop do it nhat 1 mon hoc
SELECT GV.MAGV, GV.HOTEN
	FROM GIAOVIEN GV JOIN LOP ON LOP.MAGVCN = GV.MAGV
	WHERE EXISTS (SELECT * FROM GIANGDAY GD
							WHERE GD.MAGV = GV.MAGV AND GD.MALOP = LOP.MALOP)
-- Cau 24: Tim ho ten lop truong cua lop co si so cao nhat
SELECT L1.MALOP, HO + ' ' + TEN AS HOTEN
	FROM LOP L1 JOIN HOCVIEN HV ON HV.MAHV = L1.TRGLOP
	WHERE L1.SISO >= ALL (SELECT L2.SISO FROM LOP L2)
-- Cau 25: Tim ho ten nhung LOPTRG thi khong dat qua 3 mon (moi mon deu khong dat o cac lan thi)
SELECT HO + ' ' + TEN AS HOTEN
	FROM LOP L1 JOIN HOCVIEN HV ON HV.MAHV = L1.TRGLOP
	WHERE TRGLOP IN (SELECT MAHV FROM KETQUATHI KQ1
								WHERE LANTHI >= ALL (SELECT LANTHI
															FROM KETQUATHI KQ2
															WHERE KQ1.MAHV = KQ2.MAHV AND KQ1.MAMH = KQ2.MAMH)
										AND KQUA = 'Khong dat'
								GROUP BY KQ1.MAHV
								HAVING COUNT(KQ1.MAMH)>=3)
-- Cau 26: Tim hoc vien (ma hoc vien, ho ten) co so mon dat diem 9,10 nhieu nhat.
SELECT TOP 1 WITH TIES HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
	FROM HOCVIEN HV JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
	WHERE DIEM = 9 OR DIEM = 10
	GROUP BY HV.MAHV, HV.HO + ' ' + HV.TEN
	ORDER BY COUNT(*) DESC
-- Cau 27: Trong tung lop, tim hoc vien (ma hoc vien, ho ten) co so mon dat diem 9,10 nhieu nhat.
SELECT HV.MALOP, HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
	FROM HOCVIEN HV JOIN KETQUATHI KQ1 ON KQ1.MAHV = HV.MAHV
	WHERE DIEM = 9 OR DIEM = 10
	GROUP BY HV.MALOP, HV.MAHV, HV.HO + ' ' + HV.TEN
	HAVING COUNT(MAMH) >= ALL (SELECT COUNT(MAMH)
									FROM KETQUATHI KQ2 JOIN HOCVIEN HV2 ON KQ2.MAHV = HV2.MAHV
									WHERE HV2.MALOP = HV.MALOP AND (DIEM = 9 OR DIEM = 10)
									GROUP BY HV2.MAHV)
-- Cau 28: Trong tung hoc ky cua tung nam, moi giao vien phan cong day bao nhieu mon hoc, bao nhieu lop.
SELECT HOCKY, NAM, GV.MAGV, GV.HOTEN, COUNT(DISTINCT MAMH) AS SOMONHOC, COUNT(MALOP) AS SOLOP
	FROM GIAOVIEN GV JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
	GROUP BY HOCKY, NAM, GV.MAGV, GV.HOTEN
	ORDER BY NAM ASC, HOCKY ASC
-- Cau 29: Trong tung hoc ky cua tung nam, tim giao vien (ma giao vien, ho ten) giang day nhieu nhat.
SELECT HOCKY, NAM, GV.MAGV, GV.HOTEN
	FROM GIAOVIEN GV JOIN GIANGDAY GD ON GD.MAGV = GV.MAGV
	GROUP BY HOCKY, NAM, GV.MAGV, GV.HOTEN
	HAVING COUNT(MALOP) >= ALL (SELECT COUNT(GD2.MALOP)
										FROM GIANGDAY GD2 
										WHERE GD2.HOCKY = GD.HOCKY AND GD2.NAM = GD.NAM
										GROUP BY GD2.MAGV)
	ORDER BY NAM ASC, HOCKY ASC
-- Cau 30: Tim mon hoc (ma mon hoc, ten mon hoc) co nhieu hoc vien thi khong dat (o lan thi thu 1) nhat.
SELECT TOP 1 WITH TIES MH.MAMH, MH.TENMH
	FROM MONHOC MH JOIN KETQUATHI KQ ON KQ.MAMH = MH.MAMH
	WHERE LANTHI = 1 AND KQUA = 'Khong dat'
	GROUP BY MH.MAMH, MH.TENMH
	ORDER BY COUNT(*) DESC
-- Cau 31: Tim hoc vien (ma hoc vien, ho ten) thi mon nao cung dat (chi xet lan thi thu 1).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
	FROM HOCVIEN HV JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
	GROUP BY HV.MAHV, HV.HO + ' ' + HV.TEN
	HAVING MAX(LANTHI) = 1 AND MAX(KQUA) = 'Dat'
-- Cau 32: * Tim hoc vien (ma hoc vien, ho ten) thi mon nao cung dat (chi xet lan thi sau cung).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
	FROM KETQUATHI KQ JOIN HOCVIEN HV ON HV.MAHV = KQ.MAHV
	WHERE LANTHI = (SELECT MAX(LANTHI)
							FROM KETQUATHI KQ2
							WHERE KQ2.MAHV = KQ.MAHV AND KQ2.MAMH = KQ.MAMH
							GROUP BY KQ2.MAHV, KQ2.MAMH)
	GROUP BY HV.MAHV, HV.HO + ' ' + HV.TEN
	HAVING MAX(KQUA) = 'Dat'
-- Cau 33: * Tim hoc vien (ma hoc vien, ho ten) da thi tat ca cac mon deu dat (chi xet lan thi thu 1).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
	FROM HOCVIEN HV JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
	WHERE LANTHI = 1 AND KQUA = 'Dat'
	GROUP BY HV.MAHV, HV.HO + ' ' + HV.TEN
	HAVING COUNT(*) = (SELECT COUNT(*) FROM MONHOC)
-- Cau 34: * Tim hoc vien (ma hoc vien, ho ten) da thi tat ca cac mon deu dat (chi xet lan thi sau cung).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
	FROM KETQUATHI KQ JOIN HOCVIEN HV ON HV.MAHV = KQ.MAHV
	WHERE LANTHI = (SELECT MAX(LANTHI)
							FROM KETQUATHI KQ2
							WHERE KQ2.MAHV = KQ.MAHV AND KQ2.MAMH = KQ.MAMH
							GROUP BY KQ2.MAHV, KQ2.MAMH)
					AND KQUA = 'Dat'
	GROUP BY HV.MAHV, HV.HO + ' ' + HV.TEN
	HAVING COUNT(*) = (SELECT COUNT(*) FROM MONHOC)
-- Cau 35: ** Tim hoc vien (ma hoc vien, ho ten) co diem thi cao nhat trong tung mon (lay diem o lan thi sau cung).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN, MAMH, DIEM
	FROM HOCVIEN HV JOIN KETQUATHI KQ ON KQ.MAHV = HV.MAHV
	WHERE LANTHI = (SELECT MAX(LANTHI)
							FROM KETQUATHI KQ2
							WHERE KQ2.MAHV = KQ.MAHV AND KQ2.MAMH = KQ.MAMH
							GROUP BY KQ2.MAHV, KQ2.MAMH)
		AND KQ.DIEM >= ALL (SELECT DIEM
								FROM KETQUATHI KQ3
								WHERE KQ.MAMH = KQ3.MAMH)
	ORDER BY MAMH ASC

-- PHAN I: NGON NGU DINH NGHIA DU LIEU
-- Cau 9: Lop truong cua 1 lop phai la hoc vien cua lop do
-- 9.1 trigger update LOP
CREATE TRIGGER lop_update
ON LOP
AFTER UPDATE
AS
IF (UPDATE(TRGLOP))
BEGIN
	DECLARE @MALOP varchar(4), @TRGLOP varchar(4)
	SELECT @MALOP = MALOP, @TRGLOP = TRGLOP FROM INSERTED
	IF (NOT EXISTS (SELECT * FROM HOCVIEN HV
							WHERE HV.MAHV = @TRGLOP AND HV.MALOP = @MALOP))
		BEGIN
			PRINT 'LOI: LOP TRUONG PHAI LA HOC VIEN CUA LOP DO'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- 9.2 trigger update HOCVIEN
CREATE TRIGGER hocvien_update
ON HOCVIEN
AFTER UPDATE
AS
IF (UPDATE(MALOP))
BEGIN
	IF(EXISTS (SELECT * FROM LOP, INSERTED I WHERE LOP.TRGLOP =I.MAHV))
		BEGIN
			PRINT 'HOC VIEN LA TRUONG LOP, KHONG THE CHUYEN LOP'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 10: Truong khoa phai la giao vien thuoc khoa va co hoc vi la 'TS' hoac 'PTS'
-- 10.1 trigger update KHOA
CREATE TRIGGER khoa_update_trgkhoa
ON KHOA
AFTER UPDATE
AS
BEGIN
	IF(NOT EXISTS (SELECT * FROM INSERTED I, GIAOVIEN GV 
							WHERE I.TRGKHOA = GV.MAGV AND I.MAKHOA = GV.MAKHOA AND GV.HOCVI IN ('TS', 'PTS')))
		BEGIN
			PRINT 'LOI: TRUONG KHOA PHAI LA GIAO VIEN THUOC KHOA VA CO HOC VI LA TS HOAC PTS'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- 10.2 trigger update hoc vi cua GIAOVIEN
CREATE TRIGGER giaovien_update_hocvi
ON GIAOVIEN
AFTER UPDATE
AS
IF (UPDATE (HOCVI))
BEGIN
	IF (EXISTS (SELECT * FROM KHOA, INSERTED I WHERE I.MAGV = KHOA.TRGKHOA AND I.HOCVI NOT IN ('TS', 'PTS')))
		BEGIN
			PRINT 'LOI: GIAO VIEN DANG LA TRUONG KHOA VA HOC VI PHAI LA TS HOAC PTS'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- 10.3 trigger update khoa GIAOVIEN
CREATE TRIGGER giaovien_update_khoa
ON GIAOVIEN
AFTER UPDATE
AS
IF (UPDATE (MAKHOA))
BEGIN
	IF (EXISTS (SELECT * FROM KHOA, INSERTED I WHERE I.MAGV = KHOA.TRGKHOA))
		BEGIN
			PRINT 'LOI: GIAO VIEN DANG LA TRUONG KHOA'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 15: Hoc vien chi duoc thi 1 mon nao do khi lop cua hoc vien da hoc xong mon nay
-- 15.1 trigger insert, update ngay thi KETQUATHI
CREATE TRIGGER trg15_ketquathi_insert_update
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @NGTHI smalldatetime, @NGKT smalldatetime, @MAHV varchar(4), @MALOP varchar(4)
	SELECT @NGTHI = I.NGTHI, @NGKT = GD.DENNGAY, @MAHV = I.MAHV, @MALOP = GD.MALOP 
		FROM INSERTED I, GIANGDAY GD, HOCVIEN HV 
			WHERE HV.MAHV = I.MAHV AND HV.MALOP = GD.MALOP AND I.MAMH = GD.MAMH
	IF(@NGTHI < @NGKT)
		BEGIN
			PRINT 'LOI: NGAY THI PHAI LON HON HOAC BANG NGAY KET THUC MON'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- 15.2 trigger update ngay ket thuc GIANGDAY
CREATE TRIGGER trg15_giangday_update
ON GIANGDAY
AFTER UPDATE
AS
IF (UPDATE(DENNGAY))
BEGIN
	DECLARE @NGTHI smalldatetime, @NGKT smalldatetime, @MAHV varchar(4), @MALOP varchar(4)
	SELECT @NGTHI = KQ.NGTHI, @NGKT = I.DENNGAY, @MAHV = KQ.MAHV, @MALOP = I.MALOP
		FROM INSERTED I, KETQUATHI KQ, HOCVIEN HV
			WHERE HV.MAHV = KQ.MAHV AND HV.MALOP = I.MALOP AND KQ.MAMH = I.MAMH
	IF(@NGTHI < @NGKT)
		BEGIN
			PRINT 'LOI: NGAY THI PHAI LON HON HOAC BANG NGAY KET THUC MON'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 16: Moi hoc ky cua 1 nam hoc moi lop chi duoc hoc toi da 3 mon
CREATE TRIGGER trg16_giangday_insert_update
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
	IF ((SELECT COUNT(DISTINCT GD.MAMH) FROM INSERTED I, GIANGDAY GD
				WHERE I.MALOP = GD.MALOP AND I.HOCKY = GD.HOCKY AND I.NAM = GD.NAM) > 3)
		BEGIN
			PRINT 'LOI: TRONG 1 HOC KY CUA 1 NAM MOI LOP CHI DUOC HOC TOI DA 3 MON'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 17: Si so cua 1 lop bang so luong hoc vien cua lop do
-- 17.1: trigger insert, update HOCVIEN
CREATE TRIGGER trg17_hocvien_insert_update
ON HOCVIEN
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @SISO tinyint, @MALOP varchar(4)
	SELECT @MALOP = MALOP FROM INSERTED
	SELECT @SISO = COUNT(*) FROM HOCVIEN HV, INSERTED I
			WHERE HV.MALOP = I.MALOP
	UPDATE LOP SET SISO = @SISO WHERE LOP.MALOP = @MALOP
END
-- 17.2: trigger delete HOCVIEN
CREATE TRIGGER trg17_hocvien_delete
ON HOCVIEN
AFTER DELETE
AS
BEGIN
	DECLARE @SISO tinyint, @MALOP varchar(4)
	SELECT @MALOP = MALOP FROM DELETED
	SELECT @SISO = COUNT(*) FROM HOCVIEN HV, DELETED D
		WHERE HV.MALOP = D.MALOP
	UPDATE LOP SET SISO = @SISO WHERE LOP.MALOP = @MALOP
END
-- 17.3: trigger update LOP
CREATE TRIGGER trg_17_lop_update
ON LOP
AFTER UPDATE
AS
BEGIN
	DECLARE @SISO tinyint, @MALOP varchar(4)
	SELECT @MALOP = MALOP FROM INSERTED
	SELECT @SISO = COUNT(*) FROM HOCVIEN HV, INSERTED I
		WHERE HV.MALOP = I.MALOP
	UPDATE LOP SET SISO = @SISO WHERE LOP.MALOP = @MALOP
END
-- Cau 18: Trong quan he DIEUKIEN gia tri cua thuoc tinh MAMH va MAMH_TRUOC trong cung mot bo khong duoc giong nhau 
--				("A","A") va cung khong ton tai hai bo ("A","B") va ("B","A").
CREATE TRIGGER trg18_dieukien_insert
ON DIEUKIEN
AFTER INSERT
AS
BEGIN
	DECLARE @I_MAMH varchar(10), @I_MAMH_TRUOC varchar (10)
	SELECT @I_MAMH = MAMH, @I_MAMH_TRUOC = MAMH_TRUOC FROM INSERTED
	IF((@I_MAMH = @I_MAMH_TRUOC) 
		OR EXISTS (SELECT * FROM DIEUKIEN DK, INSERTED I
							WHERE (I.MAMH = DK.MAMH_TRUOC AND I.MAMH_TRUOC = DK.MAMH)
								OR (DK.MAMH = I.MAMH_TRUOC AND DK.MAMH_TRUOC = I.MAMH)))
		BEGIN
			PRINT 'LOI! VUI LONG NHAP LAI'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 19: Cac giao vien co cung hoc vi, hoc ham, he so luong thi co muc luong bang nhau
CREATE TRIGGER trg19_giaovien_insert_update
ON GIAOVIEN
AFTER INSERT, UPDATE
AS
BEGIN
	IF (EXISTS (SELECT * FROM GIAOVIEN GV, INSERTED I
						WHERE GV.MAGV <> I.MAGV AND I.HOCVI = GV.HOCVI AND I.HOCHAM = GV.HOCHAM
							AND I.HESO = GV.HESO AND I.MUCLUONG <> GV.MUCLUONG))
		BEGIN 
			PRINT 'LOI: CAC GIAO VIEN CO CUNG HOC VI, HOC HAM, HE SO LUONG THI CO MUC LUONG BANG NHAU!'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 20: Hoc vien chi duoc thi lai khi diem cua lan thi truoc do duoi 5
CREATE TRIGGER trg20_ketquathi_insert_update
ON KETQUATHI
AFTER INSERT
AS
BEGIN
	IF (EXISTS (SELECT * FROM KETQUATHI KQ, INSERTED I
						WHERE KQ.MAHV = I.MAHV AND KQ.MAMH = I.MAMH
								AND KQ.LANTHI < I.LANTHI AND KQ.DIEM >= 5))
		BEGIN 
			PRINT 'LOI: HOC VIEN CHI DUOC THI LAI KHI DIEM CUA LAN THI TRUOC DO DUOI 5'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 21: Ngay thi cua lan thi sau phai lon hon ngay thi cua lan thi truoc voi cung hoc vien cung mon hoc
CREATE TRIGGER trg21_ketquathi_insert_update
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
	IF (EXISTS (SELECT * FROM KETQUATHI KQ, INSERTED I
						WHERE KQ.MAHV = I.MAHV AND KQ.MAMH = I.MAMH
								AND I.LANTHI > KQ.LANTHI AND I.NGTHI < KQ.NGTHI))
		BEGIN
			PRINT 'LOI: NGAY THI CUA LAN THI SAU PHAI LON HON NGAY THI CUA LAN THI TRUOC!'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 22: Hoc vien chi duoc thi nhung mon ma lop do da hoc xong
-- 22.1 trigger insert, update ngay thi KETQUATHI
CREATE TRIGGER trg22_ketquathi_insert_update
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @NGTHI smalldatetime, @NGKT smalldatetime, @MAHV varchar(4), @MALOP varchar(4)
	SELECT @NGTHI = I.NGTHI, @NGKT = GD.DENNGAY, @MAHV = I.MAHV, @MALOP = GD.MALOP 
		FROM INSERTED I, GIANGDAY GD, HOCVIEN HV 
			WHERE HV.MAHV = I.MAHV AND HV.MALOP = GD.MALOP AND I.MAMH = GD.MAMH
	IF(@NGTHI < @NGKT)
		BEGIN
			PRINT 'LOI: NGAY THI PHAI LON HON HOAC BANG NGAY KET THUC MON'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- 22.2 trigger update ngay ket thuc GIANGDAY
CREATE TRIGGER trg22_giangday_update
ON GIANGDAY
AFTER UPDATE
AS
IF (UPDATE(DENNGAY))
BEGIN
	DECLARE @NGTHI smalldatetime, @NGKT smalldatetime, @MAHV varchar(4), @MALOP varchar(4)
	SELECT @NGTHI = KQ.NGTHI, @NGKT = I.DENNGAY, @MAHV = KQ.MAHV, @MALOP = I.MALOP
		FROM INSERTED I, KETQUATHI KQ, HOCVIEN HV
			WHERE HV.MAHV = KQ.MAHV AND HV.MALOP = I.MALOP AND KQ.MAMH = I.MAMH
	IF(@NGTHI < @NGKT)
		BEGIN
			PRINT 'LOI: NGAY THI PHAI LON HON HOAC BANG NGAY KET THUC MON'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 23: Khi phan cong giang day phai luu y thu tu truoc sau giua cac mon hoc.
CREATE TRIGGER trg23_giangday_insert_update
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @MAMH_TRUOC varchar(10)
	SELECT @MAMH_TRUOC = DK.MAMH_TRUOC FROM DIEUKIEN DK, INSERTED I
			WHERE DK.MAMH = I.MAMH
	IF (NOT EXISTS (SELECT * FROM GIANGDAY GD, INSERTED I
							WHERE GD.MALOP = I.MALOP AND GD.MAMH = @MAMH_TRUOC))
		BEGIN
			PRINT 'LOI: PHAN CONG GIANG DAY SAI THU TU TRUOC SAU CUA DIEU KIEN MON HOC'
			ROLLBACK TRANSACTION
		END
	ELSE 
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- Cau 24: Giao vien chi duoc phan cong day nhung mon thuoc khoa giao vien do phu trach
-- 24.1: trigger insert, update GIANGDAY
CREATE TRIGGER trg24_giangday_insert_update
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
	IF (EXISTS (SELECT * FROM MONHOC MH, GIAOVIEN GV, INSERTED I
						WHERE I.MAGV = GV.MAGV AND I.MAMH = MH.MAMH
								AND MH.MAKHOA <> GV.MAKHOA))
		BEGIN
			PRINT 'LOI: GIAO VIEN CHI DUOC PHAN CONG DAY NHUNG MON THUOC KHOA GIAO VIEN DO PHU TRACH'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- 24.2: trigger update MONHOC
CREATE TRIGGER trg24_monhoc_update
ON MONHOC
AFTER UPDATE
AS
BEGIN
	IF (EXISTS (SELECT * FROM GIANGDAY GD, GIAOVIEN GV, INSERTED I
						WHERE I.MAMH = GD.MAMH AND GD.MAGV = GV.MAGV AND GV.MAKHOA <> I.MAKHOA))
		BEGIN
			PRINT 'LOI: GIAO VIEN CHI DUOC PHAN CONG DAY NHUNG MON THUOC KHOA GIAO VIEN DO PHU TRACH'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
-- 24.3: trigger update GIAOVIEN
CREATE TRIGGER trg24_giaovien_update
ON GIAOVIEN
AFTER UPDATE
AS
BEGIN
	IF (EXISTS (SELECT * FROM GIANGDAY GD, MONHOC MH, INSERTED I
						WHERE I.MAGV = GD.MAGV AND GD.MAMH = MH.MAMH AND I.MAKHOA <> MH.MAKHOA))
		BEGIN
			PRINT 'LOI: GIAO VIEN CHI DUOC PHAN CONG DAY NHUNG MON THUOC KHOA GIAO VIEN DO PHU TRACH'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THAO TAC THANH CONG'
		END
END
