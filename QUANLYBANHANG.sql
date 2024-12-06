-- Tao database va su dung database
CREATE DATABASE QUANLYBANHANG
USE QUANLYBANHANG

-- PHAN I: NGON NGU DINH NGHIA DU LIEU

-- Cau 1: Tao cac quan he va khai bao cac khoa chinh, khoa ngoai
-- Tao cac Table tuong ung
CREATE TABLE KHACHHANG
(
	MAKH char(4) NOT NULL,
	HOTEN varchar(40) ,
	DCHI varchar(50) ,
	SODT varchar(20) ,
	NGSINH smalldatetime ,
	NGDK smalldatetime ,
	DOANHSO money 
)
CREATE TABLE NHANVIEN
(
	MANV char(4) NOT NULL,
	HOTEN varchar(40) ,
	SODT varchar(20) ,
	NGVL smalldatetime 
)
CREATE TABLE SANPHAM
(
	MASP char(4) NOT NULL,
	TENSP varchar(40) ,
	DVT varchar(20) ,
	NUOCSX varchar(40) ,
	GIA money 
)
CREATE TABLE HOADON
(
	SOHD int NOT NULL,
	NGHD smalldatetime ,
	MAKH char(4) ,
	MANV char(4) ,
	TRIGIA money 
)
CREATE TABLE CTHD
(
	SOHD int NOT NULL,
	MASP char(4) NOT NULL,
	SL int 
)

-- Them cac rang buoc toan ven PK, FK
ALTER TABLE KHACHHANG ADD CONSTRAINT PK_KHACHHANG PRIMARY KEY (MAKH)
ALTER TABLE NHANVIEN ADD CONSTRAINT PK_NHANVIEN PRIMARY KEY (MANV)
ALTER TABLE SANPHAM ADD CONSTRAINT PK_SANPHAM PRIMARY KEY (MASP)
ALTER TABLE HOADON ADD CONSTRAINT PK_HOADON PRIMARY KEY (SOHD)
ALTER TABLE HOADON ADD CONSTRAINT FK_HOADON1 FOREIGN KEY (MAKH) REFERENCES KHACHHANG (MAKH)
ALTER TABLE HOADON ADD CONSTRAINT FK_HOADON2 FOREIGN KEY (MANV) REFERENCES NHANVIEN (MANV)
ALTER TABLE CTHD ADD CONSTRAINT	PK_CTHD PRIMARY KEY (SOHD, MASP)
ALTER TABLE CTHD ADD CONSTRAINT FK_CTHD1 FOREIGN KEY (SOHD) REFERENCES HOADON (SOHD)
ALTER TABLE CTHD ADD CONSTRAINT FK_CTHD2 FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP)

-- Cau 2: Them thuoc tinh GHICHU co kieu du lieu varchar(20) cho quan he SANPHAM
ALTER TABLE SANPHAM ADD GHICHU varchar(20)
-- Cau 3: Them thuoc tinh LOAIKH kieu tinyint cho quan he KHACHHANG
ALTER TABLE KHACHHANG ADD LOAIKH tinyint
-- Cau 4: Sua kieu du lieu cua thuoc tinh GHICHU trong quan he SANPHAM thanh varchar(100)
ALTER TABLE SANPHAM ALTER COLUMN GHICHU varchar(100)
-- Cau 5: Xoa thuoc tinh GHICHU trong quan he SANPHAM
ALTER TABLE SANPHAM DROP COLUMN GHICHU
-- Cau 6: De thuoc tinh LOAIKH trong quan he KHACHHANG co the luu cac gia tri: "Vang lai", "Thuong xuyen", "Vip"
ALTER TABLE KHACHHANG ALTER COLUMN LOAIKH varchar(20)
-- Cau 7: Don vi tinh cua san pham chi co the la ("cay", "hop", "cai", "quyen", "chuc")
ALTER TABLE SANPHAM ADD CONSTRAINT CK_DVT CHECK (DVT IN ('cay', 'hop', 'cai', 'quyen', 'chuc'))
-- Cau 8: Gia ban cua san pham tu 500 dong tro len
ALTER TABLE SANPHAM ADD CONSTRAINT CK_GIA CHECK (GIA >= 500)
-- Cau 9: Moi lan mua hang, khach hang phai mua it nhat 1 san pham
ALTER TABLE CTHD ADD CONSTRAINT CK_SLSP CHECK (SL >= 1)
-- Cau 10: Ngay khach hang dang ky la khach hang thanh vien phai lon hon ngay sinh cua nguoi do
ALTER TABLE KHACHHANG ADD CONSTRAINT CK_NGDK CHECK (NGDK > NGSINH)

-- Phan II: NGON NGU THAO TAC DU LIEU

-- Cau 1: Nhap du lieu cho cac quan he
SET DATEFORMAT dmy
-- Quan he NHANVIEN
INSERT INTO NHANVIEN VALUES('NV01', 'Nguyen Nhu Nhut', '0927345678', '13-04-2006')
INSERT INTO NHANVIEN VALUES('NV02', 'Le Thi Phi Yen', '0987567390', '21-04-2006')
INSERT INTO NHANVIEN VALUES('NV03', 'Nguyen Van B', '0997047382', '27-04-2006')
INSERT INTO NHANVIEN VALUES('NV04', 'Ngo Thanh Tuan', '0913758498', '24-06-2006')
INSERT INTO NHANVIEN VALUES('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '20-07-2006')
-- Quan he KHACHHANG
INSERT INTO KHACHHANG (MAKH, HOTEN, DCHI, SODT, NGSINH, NGDK, DOANHSO)
	VALUES
		('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '22-10-1960', '22-07-2006', 13060000),
		('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '3-4-1974', '30-07-2006', 280000),
		('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '12-6-1980', '05-08-2006', 3860000),
		('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '9-3-1965', '02-10-2006', 250000),
		('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '08246108', '10-3-1950', '28-10-2006', 21000),
		('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '08631738', '31-12-1981', '24-11-2006', 915000),
		('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '6-4-1971', '01-12-2006', 12500),
		('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '10-1-1971', '13-12-2006', 365000),
		('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '08654763', '3-9-1979', '14-01-2007', 70000),
		('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '08768904', '2-5-1983', '16-01-2007', 67500)
-- Quan he SANPHAM
INSERT INTO SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA)
	VALUES
		('BC01', 'But chi', 'cay', 'Singapore', 3000),
		('BC02', 'But chi', 'cay', 'Singapore', 5000),
		('BC03', 'But chi', 'cay', 'Viet Nam', 3500),
		('BC04', 'But chi', 'hop', 'Viet Nam', 30000),
		('BB01', 'But bi', 'cay', 'Viet Nam', 5000),
		('BB02', 'But bi', 'cay', 'Trung Quoc', 7000),
		('BB03', 'But bi', 'hop', 'Thai Lan', 100000),
		('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', 2500),
		('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', 4500),
		('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000),
		('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5500),
		('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000),
		('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', 53000),
		('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', 34000),
		('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', 40000),
		('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', 55000),
		('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 51000),
		('ST04', 'So tay', 'quyen', 'Thai Lan', 55000),
		('ST05', 'So tay mong', 'quyen', 'Thai Lan', 20000),
		('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000),
		('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000),
		('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000),
		('ST09', 'But long', 'cay', 'Viet Nam', 5000),
		('ST10', 'But long', 'cay', 'Trung Quoc', 7000)
-- Quan he HOADON
INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
	VALUES
		(1001, '23/07/2006', 'KH01', 'NV01', 320000),
		(1002, '12/08/2006', 'KH01', 'NV02', 840000),
		(1003, '23/08/2006', 'KH02', 'NV01', 100000),
		(1004, '01/09/2006', 'KH02', 'NV01', 180000),
		(1005, '20/10/2006', 'KH01', 'NV02', 3800000),
		(1006, '16/10/2006', 'KH01', 'NV03', 2430000),
		(1007, '28/10/2006', 'KH03', 'NV03', 510000),
		(1008, '28/10/2006', 'KH01', 'NV03', 440000),
		(1009, '28/10/2006', 'KH03', 'NV04', 200000),
		(1010, '01/11/2006', 'KH01', 'NV01', 5200000),
		(1011, '04/11/2006', 'KH04', 'NV03', 250000),
		(1012, '30/11/2006', 'KH05', 'NV03', 21000),
		(1013, '12/12/2006', 'KH06', 'NV01', 5000),
		(1014, '31/12/2006', 'KH03', 'NV02', 3150000),
		(1015, '01/01/2007', 'KH06', 'NV01', 910000),
		(1016, '01/01/2007', 'KH07', 'NV02', 12500),
		(1017, '02/01/2007', 'KH08', 'NV03', 35000),
		(1018, '13/01/2007', 'KH08', 'NV03', 330000),
		(1019, '13/01/2007', 'KH01', 'NV03', 30000),
		(1020, '14/01/2007', 'KH09', 'NV04', 70000),
		(1021, '16/01/2007', 'KH10', 'NV03', 67500),
		(1022, '16/01/2007', NULL, 'NV03', 7000),
		(1023, '17/01/2007', NULL, 'NV01', 330000)
--Quan he CTHD
INSERT INTO CTHD (SOHD, MASP, SL)
	VALUES
		(1001, 'TV02', 10),
		(1001, 'ST01', 5),
		(1001, 'BC01', 5),
		(1001, 'BC02', 10),
		(1001, 'ST08', 10),
		(1002, 'BC04', 20),
		(1002, 'BB01', 20),
		(1002, 'BB02', 20),
		(1003, 'BB03', 10),
		(1004, 'TV01', 20),
		(1004, 'TV02', 10),
		(1004, 'TV03', 10),
		(1004, 'TV04', 10),
		(1005, 'TV05', 50),
		(1005, 'TV06', 50),
		(1006, 'TV07', 20),
		(1006, 'ST01', 30),
		(1006, 'ST02', 10),
		(1007, 'ST03', 10),
		(1008, 'ST04', 8),
		(1009, 'ST05', 10),
		(1010, 'TV07', 50),
		(1010, 'ST07', 50),
		(1010, 'ST08', 100),
		(1010, 'ST04', 50),
		(1010, 'TV03', 100),
		(1011, 'ST06', 50),
		(1012, 'ST07', 3),
		(1013, 'ST08', 5),
		(1014, 'BC02', 80),
		(1014, 'BB02', 100),
		(1014, 'BC04', 60),
		(1014, 'BB01', 50),
		(1015, 'BB02', 30),
		(1015, 'BB03', 7),
		(1016, 'TV01', 5),
		(1017, 'TV02', 1),
		(1017, 'TV03', 1),
		(1017, 'TV04', 5),
		(1018, 'ST04', 6),
		(1019, 'ST05', 1),
		(1019, 'ST06', 2),
		(1020, 'ST07', 10),
		(1021, 'ST08', 5),
		(1021, 'TV01', 7),
		(1021, 'TV02', 10),
		(1022, 'ST07', 1),
		(1023, 'ST04', 6)

-- Cau 2: 
-- Tao quan he SANPHAM1 chua toan bo du lieu cua quan he SANPHAM
SELECT * INTO SANPHAM1 FROM SANPHAM
-- Tao quan he KHACHHANG1 chua toan bo du lieu cua quan he KHACHHANG
SELECT * INTO KHACHHANG1 FROM KHACHHANG
-- Cau 3: cap nhat gia tang 5% doi voi san pham do Thai Lan san xuat cho quan he SANPHAM1
UPDATE SANPHAM1 SET GIA = GIA * 1.05 WHERE (NUOCSX = 'Thai Lan')
-- Cau 4: cap nhat gia giam 5% doi voi san pham do Trung Quoc san xuat co gia tu 10000 tro xuong cho quan he SANPHAM1
UPDATE SANPHAM1 SET GIA = GIA * 0.95 WHERE (NUOCSX = 'Trung Quoc' and GIA <= 10000)
-- Cau 5: cap nhat gia tri LOAIKH la 'Vip' voi ...
UPDATE KHACHHANG1 SET LOAIKH = 'Vip' WHERE ((NGDK<'1/1/2007' AND DOANHSO>=10000000) OR (NGDK>='1/1/2007' AND DOANHSO >=2000000))

--Phan III: NGON NGU TRUY VAN DU LIEU CO CAU TRUC
-- Cau 1: in danh sach cac san pham (masp, tensp) do Trung Quoc san xua
SELECT MASP, TENSP FROM SANPHAM WHERE NUOCSX = 'Trung Quoc'
-- Cau 2: in danh sach cac san pham (masp, tensp) co don vi tinh la cay, quyen
SELECT MASP, TENSP FROM SANPHAM WHERE DVT IN ('cay', 'quyen')
-- Cau 3: in danh sach cac san pham (masp, tensp) co ma san pham bat dau bang 'B' va ket thuc bang '01'
SELECT MASP, TENSP FROM SANPHAM WHERE MASP LIKE ('B%01')
-- Cau 4: in danh sach san pham (masp, tensp) do Trung Quoc san xuat va co gia tu 30000-40000
SELECT MASP, TENSP FROM SANPHAM WHERE (NUOCSX ='Trung Quoc' and 30000 <= GIA and GIA <= 40000)
-- Cau 5: in danh sach san pham (masp, tensp) do Trung Quoc hoac Thai Lan san xuat va co gia tu 30000-40000
SELECT MASP, TENSP FROM SANPHAM WHERE ((NUOCSX IN ('Trung Quoc', 'Thai Lan')) and GIA >= 30000 and GIA <= 40000)
-- Cau 6: in cac so hoa don, tri gia hoa don ban ra trong ngay 1/1/2007 va ngay 2/1/2007
SELECT SOHD, TRIGIA FROM HOADON WHERE (NGHD IN ('1/1/2007', '2/1/2007'))
-- Cau 7: in cac so hoa don, tri gia hoa don trong thang 1/2007 sap xep theo ngay thang tang dan va tri gia hoa don giam dan
SELECT SOHD, TRIGIA FROM HOADON WHERE (MONTH(NGHD) = 1 AND YEAR(NGHD) = 2007) ORDER BY NGHD ASC, TRIGIA DESC
-- Cau 8: in ra danh sach khach hang (MAKH, HOTEN) da mua hang trong ngay 1/1/2007
SELECT KHACHHANG.MAKH, HOTEN FROM KHACHHANG JOIN HOADON ON KHACHHANG.MAKH=HOADON.MAKH WHERE NGHD = '1/1/2007'
-- Cau 9: in ra so hoa don, tri gia cac hoa don do nhan vien co ten Nguyen Van B lap trong ngay 28/10/2006
SELECT SOHD, TRIGIA 
	FROM HOADON JOIN NHANVIEN 
		ON HOADON.MANV = NHANVIEN.MANV 
	WHERE (NHANVIEN.HOTEN = 'Nguyen Van B' AND HOADON.NGHD = '28/10/2006')
-- Cau 10: in ra danh sach cac san pham (MASP, TENSP) duoc khach hang co ten Nguyen Van A mua trong thang 10/2006
SELECT SANPHAM.MASP, TENSP 
	FROM SANPHAM 
		JOIN CTHD ON SANPHAM.MASP = CTHD.MASP
		JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
		JOIN KHACHHANG ON KHACHHANG.MAKH = HOADON.MAKH
	WHERE (HOTEN = 'Nguyen Van A' and MONTH(NGHD) = 10 and YEAR(NGHD) = 2006)
-- Cau 11: tim cac so hoa don da mua san pham co ma so 'BB01' hoac 'BB02'
SELECT DISTINCT HOADON.SOHD 
	FROM HOADON JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
	WHERE (MASP IN ('BB01','BB02'))
-- Cau 12: tim cac so hoa don da mua san pham co masp BB01 hoac BB02, moi san pham mua voi so luong tu 10-20
SELECT DISTINCT SOHD FROM CTHD
	WHERE (MASP IN ('BB01', 'BB02') AND SL >= 10 AND SL <= 20)
-- Cau 13: tim cac so hoa don da mua cung luc 2 san pham co masp la BB01 va BB02, moi san pham mua voi so luong tu 10-20
SELECT DISTINCT SOHD FROM CTHD
	WHERE (MASP = 'BB01' AND SL>=10 AND SL<=20 AND SOHD IN (SELECT SOHD FROM CTHD WHERE (MASP = 'BB02' AND SL>=10 AND SL<=20)))
-- Cau 14: in danh sach san pham (MASP, TENSP) do Trung Quoc san xuat hoac cac san pham duoc ban ra trong ngay 1/1/2007
SELECT SP.MASP, SP.TENSP
	FROM SANPHAM SP 
		JOIN CTHD ON CTHD.MASP = SP.MASP
		JOIN HOADON HD ON CTHD.SOHD = HD.SOHD
	WHERE NUOCSX = 'Trung Quoc' or NGHD = '1/1/2007'
-- Cau 15: in danh sach san pham (MASP, TENSP) khong ban duoc
SELECT DISTINCT SP.MASP, SP.TENSP FROM SANPHAM SP
	EXCEPT (SELECT DISTINCT SP.MASP, SP.TENSP FROM SANPHAM SP JOIN CTHD ON CTHD.MASP = SP.MASP)
-- Cau 16: in danh sach san pham (MASP, TENSP) khong ban duoc trong nam 2006
SELECT DISTINCT SP.MASP, SP.TENSP FROM SANPHAM SP
	EXCEPT (SELECT DISTINCT SP.MASP, SP.TENSP FROM SANPHAM SP 
					JOIN CTHD ON CTHD.MASP = SP.MASP
					JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
					WHERE year(NGHD) = 2006)
-- Cau 17: in danh sach san pham (MASP, TENSP) do Trung Quoc san xuat va khong ban duoc trong nam 2006
SELECT DISTINCT SP.MASP, SP.TENSP FROM SANPHAM SP
	WHERE NUOCSX = 'Trung Quoc'
	EXCEPT (SELECT DISTINCT SP.MASP, SP.TENSP FROM SANPHAM SP 
					JOIN CTHD ON CTHD.MASP = SP.MASP
					JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
					WHERE year(NGHD) = 2006)
-- Cau 18: tim so hoa don da mua tat ca san pham do Singapore san xuat
SELECT SOHD FROM HOADON 
WHERE NOT EXISTS (SELECT * FROM SANPHAM WHERE NUOCSX = 'Singapore' and NOT EXISTS (select * from CTHD
	WHERE HOADON.SOHD = CTHD.SOHD AND CTHD.MASP = SANPHAM.MASP))
-- Cau 19: tim so hoa don trong nam 2006 da mua it nhat tat cac cac san pham do Singapore san xuat
SELECT SOHD FROM HOADON 
WHERE year(NGHD) =2006 AND NOT EXISTS (SELECT * FROM SANPHAM WHERE NUOCSX = 'Singapore' and NOT EXISTS (select * from CTHD
	WHERE HOADON.SOHD = CTHD.SOHD AND CTHD.MASP = SANPHAM.MASP))
-- Cau 20: co bao nhieu hoa don khong phai cua khach hang dang ky thanh vien mua
SELECT count(*) FROM HOADON WHERE MAKH is null
-- Cau 21: co bao nhieu san pham khac nhau duoc ban ra trong nam 2006
SELECT count(DISTINCT MASP) FROM CTHD JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
	WHERE year(NGHD) = 2006
-- Cau 22: cho biet tri gia hoa don cao nhat, thap nhat
SELECT MAX(TRIGIA) AS LONNHAT, MIN(TRIGIA) AS NHONHAT FROM HOADON
-- Cau 23: tri gia trung binh cua tat ca cac hoa don duoc ban ra trong nam 2006
SELECT AVG(TRIGIA) AS TRUNGBINH FROM HOADON WHERE year(NGHD) = 2006
-- Cau 24: tinh doanh thu ban hang trong nam 2006
SELECT SUM(TRIGIA) AS DOANHTHU FROM HOADON WHERE year(NGHD) = 2006
-- Cau 25: tim so hoa don co tri gia cao nhat trong nam 2006
SELECT TOP 1 WITH TIES SOHD, TRIGIA FROM HOADON WHERE year(NGHD) = 2006 ORDER BY TRIGIA DESC
-- Cau 27: in ra danh sach 3 khach hang(MAKH, HOTEN) co doanh so cao nhat
SELECT TOP 3 MAKH, HOTEN FROM KHACHHANG ORDER BY DOANHSO DESC
-- Cau 28: in ra danh sach cac san pham (MASP, TENSP) co gia ban bang 1 trong 3 muc gia cao nhat
SELECT TOP 3 WITH TIES MASP, TENSP FROM SANPHAM ORDER BY GIA DESC
-- Cau 29: in ra danh sach cac san pham (MASP, TENSP) do Thai Lan san xuat co gia bang 1 trong 3 muc gia cao nhat cua tat ca san pham
SELECT MASP, TENSP FROM SANPHAM WHERE NUOCSX = 'Thai Lan' and GIA IN (SELECT DISTINCT TOP 3 GIA FROM SANPHAM ORDER BY GIA DESC)
-- Cau 30: in ra danh sach cac san pham (MASP, TENSP) do Trung Quoc san xuat co gia bang 1 trong 3 muc gia cao nhat cua cac san pham do Trung Quoc san xuat
SELECT TOP 3 WITH TIES MASP, TENSP FROM SANPHAM WHERE NUOCSX = 'Trung Quoc' ORDER BY GIA DESC
-- Cau 31: In ra danh sach 3 khach hang co doanh so cao nhat (sap xep theo kieu xep hang). 
SELECT TOP 3 MAKH, HOTEN FROM KHACHHANG ORDER BY DOANHSO DESC
-- Cau 32: Tinh tong so san pham do “Trung Quoc” san xuat.
SELECT COUNT(*) AS SLSP FROM SANPHAM WHERE NUOCSX = 'Trung Quoc'
-- Cau 33: Tinh tong so san pham cua tung nuoc san xuat.
SELECT NUOCSX, COUNT(*) AS SLSP FROM SANPHAM GROUP BY NUOCSX
-- Cau 34: Voi tung nuoc san xuat, tim gia ban cao nhat, thap nhat, trung binh cua cac san pham.
SELECT NUOCSX, MAX(GIA) AS CAONHAT, MIN(GIA) AS THAPNHAT, AVG(GIA) AS TRUNGBINH
	FROM SANPHAM GROUP BY NUOCSX
-- Cau 35: Tinh doanh thu ban hang moi ngay. 
SELECT NGHD, SUM(TRIGIA) AS DOANHTHU FROM HOADON GROUP BY NGHD
-- Cau 36: Tinh tong so luong cua tung san pham ban ra trong thang 10/2006.
SELECT MASP, SUM(SL) AS TONGSL
	FROM HOADON HD JOIN CTHD ON CTHD.SOHD = HD.SOHD
	WHERE month(NGHD) = 10 AND year(NGHD) = 2006
	GROUP BY MASP
-- Cau 37: Tinh doanh thu ban hang cua tung thang trong nam 2006.
SELECT month(NGHD) AS THANG, SUM(TRIGIA) AS DOANHTHU 
	FROM HOADON 
	WHERE year(NGHD) = 2006 
	GROUP BY month(NGHD)
-- Cau 38: Tim hoa don co mua it nhat 4 san pham khac nhau.
SELECT SOHD FROM CTHD GROUP BY SOHD HAVING COUNT(MASP) >= 4
-- Cau 39: Tim hoa don co mua 3 san pham do “Viet Nam” san xuat (3 san pham khac nhau).
SELECT SOHD
	FROM CTHD JOIN SANPHAM SP ON SP.MASP = CTHD.MASP
	WHERE NUOCSX = 'Viet Nam'
	GROUP BY SOHD HAVING COUNT(CTHD.MASP) >= 3
-- Cau 40: Tim khach hang (MAKH, HOTEN) co so lan mua hang nhieu nhat. 
SELECT TOP 1 WITH TIES KH.MAKH, KH.HOTEN 
	FROM KHACHHANG KH JOIN HOADON HD ON HD.MAKH = KH.MAKH
	GROUP BY KH.MAKH, KH.HOTEN 
	ORDER BY COUNT(*) DESC
-- Cau 41: Thang may trong nam 2006, doanh so ban hang cao nhat?
SELECT TOP 1 WITH TIES month(NGHD) AS THANG
	FROM HOADON
	WHERE year(NGHD) = 2006
	GROUP BY month(NGHD)
	ORDER BY COUNT(*) DESC
-- Cau 42: Tim san pham (MASP, TENSP) co tong so luong ban ra thap nhat trong nam 2006.
SELECT TOP 1 WITH TIES SP.MASP, SP.TENSP
	FROM SANPHAM SP 
		JOIN CTHD ON CTHD.MASP = SP.MASP
		JOIN HOADON HD ON HD.SOHD = CTHD.SOHD
	WHERE year(NGHD) = 2006
	GROUP BY SP.MASP, SP.TENSP 
	ORDER BY SUM(SL) ASC
-- Cau 43: Moi nuoc san xuat, tim san pham (MASP, TENSP) co gia ban cao nhat.
SELECT SP1.NUOCSX, SP1.MASP, SP1.TENSP
	FROM SANPHAM SP1
	WHERE GIA >= ALL (SELECT GIA 
							FROM SANPHAM SP2
							WHERE SP1.NUOCSX = SP2.NUOCSX)
-- Cau 44: Tim nuoc san xuat san xuat it nhat 3 san pham co gia ban khac nhau.
SELECT NUOCSX
	FROM SANPHAM
	GROUP BY NUOCSX
	HAVING COUNT(DISTINCT GIA) >= 3
-- Cau 45: Trong 10 khach hang co doanh so cao nhat, tim khach hang co so lan mua hang nhieu nhat.
SELECT TOP 1 A.MAKH
	FROM (SELECT TOP 10 MAKH
				FROM KHACHHANG
				ORDER BY DOANHSO DESC) A JOIN HOADON HD ON A.MAKH = HD.MAKH
	GROUP BY A.MAKH
	ORDER BY COUNT(*) DESC

-- PHAN I: NGON NGU DINH NGHIA DU LIEU
-- Cau 11: Ngay mua hang (NGHD) cua mot khach hang thanh vien se lon hon hoac bang ngay khach hang do dang ky thanh vien (NGDK)
-- 11.1 trigger insert HOADON
CREATE TRIGGER nghd_ngdk_insert 
ON HOADON
AFTER INSERT
AS
BEGIN
	DECLARE @NGHD smalldatetime, @MAKH char(4), @NGDK smalldatetime
	SELECT @NGHD = NGHD, @MAKH = MAKH
	FROM INSERTED
	SELECT @NGDK = NGDK
	FROM KHACHHANG
	WHERE @MAKH = KHACHHANG.MAKH
	IF (@NGHD < @NGDK)
	BEGIN
		PRINT 'Loi: ngay mua hang khong hop le!'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT 'THEM 1 HOA DON THANH CONG'
	END
END
-- 11.2 trigger update HOADON
CREATE TRIGGER nghd_ngdk_hoadon_update
ON HOADON
AFTER UPDATE
AS
IF (UPDATE(MAKH) OR UPDATE(NGHD))
BEGIN
	DECLARE @NGHD smalldatetime, @MAKH char(4), @NGDK smalldatetime
	SELECT @NGHD = NGHD, @MAKH = MAKH
	FROM INSERTED
	SELECT @NGDK = NGDK
	FROM KHACHHANG
	WHERE @MAKH = KHACHHANG.MAKH
	IF (@NGHD < @NGDK)
	BEGIN
		PRINT 'Loi: ngay mua hang khong hop le!'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT 'SUA 1 HOA DON THANH CONG'
	END
END
-- 11.3 trigger update KHACHHANG
CREATE TRIGGER nghd_ngdk_khachhang_update
ON KHACHHANG
AFTER UPDATE
AS
IF (UPDATE(NGDK))
BEGIN
	DECLARE @MAKH char(4), @NGDK smalldatetime
	SELECT @MAKH = MAKH, @NGDK = NGDK
	FROM INSERTED
	IF(EXISTS (SELECT * FROM HOADON HD
				WHERE HD.MAKH = @MAKH AND @NGDK > HD.NGHD))
		BEGIN
			PRINT 'LOI: NGAY DANG KY PHAI NHO HON HOAC BANG NGAY HOA DON'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'SUA NGAY DANG KY THANH CONG'
		END
END
-- Cau 12: Ngay ban hang (NGHD) cua mot nhan vien phai lon hon hoac bang ngay nhan vien do vao lam.
-- 12.1 trigger insert HOADON
CREATE TRIGGER nghd_ngvl_hoadon_insert
ON HOADON
AFTER INSERT
AS
BEGIN
	DECLARE @NGHD smalldatetime, @NGVL smalldatetime
	SELECT @NGHD = NGHD, @NGVL = NGVL
	FROM INSERTED, NHANVIEN
	WHERE NHANVIEN.MANV = INSERTED.MANV
	IF (@NGHD < @NGVL)
		BEGIN
			PRINT 'LOI: NGAY HOA DON PHAI LON HON HOAC BANG NGAY NHAN VIEN VAO LAM'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'THEM 1 HOA DON THANH CONG'
		END
END
-- 12.2 trigger update HOADON
CREATE TRIGGER nghd_ngvl_hoadon_update
ON HOADON
AFTER UPDATE
AS
IF (UPDATE(NGHD) OR UPDATE(MANV))
BEGIN
	DECLARE @NGHD smalldatetime, @NGVL smalldatetime
	SELECT @NGHD = NGHD, @NGVL = NGVL
	FROM INSERTED, NHANVIEN
	WHERE NHANVIEN.MANV = INSERTED.MANV
	IF (@NGHD < @NGVL)
		BEGIN
			PRINT 'LOI: NGAY HOA DON PHAI LON HON HOAC BANG NGAY NHAN VIEN VAO LAM'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
			PRINT 'SUA 1 HOA DON THANH CONG'
		END
END
-- 12.3 trigger update NHANVIEN
CREATE TRIGGER nghd_ngvl_nhanvien_update
ON NHANVIEN
AFTER UPDATE
AS
IF UPDATE(NGVL)
BEGIN
	DECLARE @MANV char(4), @NGVL smalldatetime
	SELECT @MANV = MANV, @NGVL = NGVL
	FROM INSERTED
	IF (EXISTS (SELECT * FROM HOADON HD
						WHERE HD.MANV = @MANV AND @NGVL > HD.NGHD))
		BEGIN
			PRINT 'LOI: NGAY HOA DON PHAI LON HON HOAC BANG NGAY VAO LAM'
			ROLLBACK TRANSACTION
		END
	ELSE
	BEGIN
		PRINT 'SUA NGAY VAO LAM THANH CONG'
	END
END
-- Cau 13: Moi mot hoa don phai co it nhat mot chi tiet hoa don.
CREATE TRIGGER cthd_hoadon_delete
ON CTHD
AFTER DELETE
AS
BEGIN
	DECLARE @SOLUONG int, @SOHD int
	SELECT @SOHD = SOHD FROM DELETED
	SELECT @SOLUONG = COUNT(*) FROM CTHD WHERE SOHD=@SOHD
	IF (@SOLUONG < 1)
	BEGIN 
		PRINT 'LOI: MOI HOA DON PHAI CO IT NHAT MOT CHI TIET HOA DON'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT 'XOA 1 CTHD THANH CONG'
	END
END
-- Cau 14: Tri gia cua mot hoa don la tong thanh tien (so luong*don gia) cua cac chi tiet thuoc hoa don do.
-- 14.1 trigger update HOADON
CREATE TRIGGER hoadon_trigia_update
ON HOADON
AFTER UPDATE
AS
IF (UPDATE(TRIGIA))
BEGIN
	DECLARE @TRIGIA MONEY, @TONGTRIGIA MONEY, @SOHD INT
	SELECT @TRIGIA = TRIGIA, @SOHD = SOHD FROM INSERTED
	SELECT @TONGTRIGIA = SUM(SL*GIA)
		FROM CTHD, SANPHAM
		WHERE CTHD.SOHD = @SOHD AND CTHD.MASP = SANPHAM.MASP
	IF (@TRIGIA <> @TONGTRIGIA)
	BEGIN
		PRINT 'LOI: TRI GIA PHAI BANG TONG THANH TIEN CUA CAC CTHD'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT 'SUA TRI GIA THANH CONG'
	END
END
-- 14.2 trigger insert CTHD
CREATE TRIGGER hoadon_trigia_insert
ON CTHD
AFTER INSERT
AS
BEGIN
	DECLARE @TRIGIA MONEY, @TONGTRIGIA MONEY, @SOHD INT
	SELECT @SOHD = SOHD FROM INSERTED
	SELECT @TONGTRIGIA = SUM(SL*GIA)
		FROM CTHD, SANPHAM
		WHERE CTHD.SOHD = @SOHD AND CTHD.MASP = SANPHAM.MASP
	UPDATE HOADON SET TRIGIA = @TONGTRIGIA WHERE HOADON.SOHD = @SOHD
END
-- 14.3 trigger delete CTHD
CREATE TRIGGER hoadon_cthd_trigia_delete
ON CTHD
AFTER DELETE
AS
BEGIN
	DECLARE @TRIGIA MONEY, @TONGTRIGIA MONEY, @SOHD INT
	SELECT @SOHD = SOHD FROM DELETED
	SELECT @TONGTRIGIA = SUM(SL*GIA)
		FROM CTHD, SANPHAM
		WHERE CTHD.SOHD = @SOHD AND CTHD.MASP = SANPHAM.MASP
	UPDATE HOADON SET TRIGIA = @TONGTRIGIA WHERE HOADON.SOHD = @SOHD
END
-- 14.4 trigger update CTHD
CREATE TRIGGER hoadon_cthd_trigia_update
ON CTHD
AFTER UPDATE
AS
IF (UPDATE(SL))
BEGIN
	DECLARE @TRIGIA MONEY, @TONGTRIGIA MONEY, @SOHD INT
	SELECT @SOHD = SOHD FROM DELETED
	SELECT @TONGTRIGIA = SUM(SL*GIA)
		FROM CTHD, SANPHAM
		WHERE CTHD.SOHD = @SOHD AND CTHD.MASP = SANPHAM.MASP
	UPDATE HOADON SET TRIGIA = @TONGTRIGIA WHERE HOADON.SOHD = @SOHD
END