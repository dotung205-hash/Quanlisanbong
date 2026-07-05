-- =============================================
-- TAO DATABASE QuanLySanBong
-- =============================================
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'QuanLySanBong')
BEGIN
    CREATE DATABASE QuanLySanBong
END
GO
USE QuanLySanBong
GO
-- =============================================
-- XOA BANG NEU TON TAI (Theo thu tu khoa ngoai)
-- =============================================
DROP TABLE IF EXISTS ThueSan;
DROP TABLE IF EXISTS HoaDon;
DROP TABLE IF EXISTS San;
DROP TABLE IF EXISTS LoaiSan;
DROP TABLE IF EXISTS KhachHang;
DROP TABLE IF EXISTS Account;
GO
-- =============================================
-- TAO BANG
-- =============================================
-- Khach hang
CREATE TABLE KhachHang
(
	Ma_KhachHang VARCHAR(100) PRIMARY KEY,
	Ten_KhachHang NVARCHAR(100) NOT NULL DEFAULT N'Chua nhap!',
	DiaChi_KhachHang NVARCHAR(150) NOT NULL DEFAULT N'Chua nhap!',
	Sdt_KhachHang VARCHAR(100) NOT NULL DEFAULT '0123456789'
)
GO
-- Loai San
CREATE TABLE LoaiSan
(
	Loai_San VARCHAR(100) PRIMARY KEY,
	Ten_Loai NVARCHAR(100) NOT NULL,	
	GiaLoai_San FLOAT
)
GO
-- San
CREATE TABLE San
(
	Ma_San VARCHAR(100) PRIMARY KEY,
	Loai_San VARCHAR(100) NOT NULL,
	Ten_San NVARCHAR(100) NOT NULL,
	FOREIGN KEY(Loai_San) REFERENCES dbo.LoaiSan(Loai_San)
)
GO

-- Thue San bong
CREATE TABLE ThueSan
(
	[Ma_ThueSan] INT IDENTITY PRIMARY KEY,
	Ma_San VARCHAR(100),
	Ma_KhachHang VARCHAR(100),
	[ThoiGianBatDau] [datetime] NULL,
	[ThoiGianKetThuc] [datetime] NULL,
	[LoaiThue] [nvarchar](50) NULL,
	[DonGia] [FLOAT] NULL,
	[ThanhTien] [nchar](10) NULL,
	FOREIGN KEY(Ma_San) REFERENCES dbo.San(Ma_San),
	FOREIGN KEY(Ma_KhachHang) REFERENCES dbo.KhachHang(Ma_KhachHang)
)
GO

-- Hoa don
CREATE TABLE HoaDon
(	
	Ma_HD INT IDENTITY PRIMARY KEY,	
	Ma_KhachHang VARCHAR(100),
	Ma_San VARCHAR(100) NOT NULL,	
	NgayLap_HD [date] NOT NULL,
	TongPhut_Da INT NOT NULL,
	DonGia [FLOAT] NULL,
	TongTien_HD FLOAT NULL,
	FOREIGN KEY(Ma_KhachHang) REFERENCES dbo.KhachHang(Ma_KhachHang)
)	
GO

-- Account
CREATE TABLE Account
(	
	UserName VARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL,	 
	PassWord VARCHAR(1000) NOT NULL,
	Quyen NVARCHAR(100) NOT NULL
) 
GO

-- =============================================
-- INSERT DU LIEU MAU
-- =============================================
SET DATEFORMAT DMY
GO

-- Them Account
INSERT Account(UserName, DisplayName, PassWord, Quyen) VALUES
('nguyentrinh', N'Nguyễn Thị Ngọc Trinh', '123', N'Admin'),
('quangphuc', N'Nguyễn Quang Phúc', '123', N'User')
GO

-- Them KhachHang
INSERT KhachHang(Ma_KhachHang, Ten_KhachHang, DiaChi_KhachHang, Sdt_KhachHang) VALUES
('KH1', N'Lê Văn A',        N'Hà Tĩnh',    '0689712942'),
('KH2', N'Nguyễn Văn B',    N'Bình Dương', '0623452314'),
('KH3', N'Nguyễn Văn C',    N'Thanh Hóa',  '0786583521'),
('KH4', N'Nguyễn Văn D',    N'Đồng Nai',   '0987234224'),
('KH5', N'Nguyễn Văn E',    N'Tp.HCM',     '0978943634'),
('KH6', N'Trần Văn A',      N'Đà Nẵng',    '0272352342');
GO

-- Them LoaiSan
INSERT LoaiSan(Loai_San, Ten_Loai, GiaLoai_San) VALUES
('Loai1', N'Sân 6 người',  20000),
('Loai2', N'Sân 10 người', 40000),
('Loai3', N'Sân 14 người', 80000);
GO

-- Them San
INSERT San(Ma_San, Loai_San, Ten_San) VALUES
('SAN1', 'Loai1', N'Sân 1'),
('SAN2', 'Loai2', N'Sân 2'),
('SAN3', 'Loai3', N'Sân 3'),
('SAN4', 'Loai1', N'Sân 4'),
('SAN5', 'Loai2', N'Sân 5'),
('SAN6', 'Loai3', N'Sân 6');
GO

-- Them ThueSan
INSERT ThueSan(Ma_San, Ma_KhachHang, ThoiGianBatDau, ThoiGianKetThuc, LoaiThue, DonGia, ThanhTien) VALUES
('SAN1','KH1','2021-11-23 17:00','2021-11-23 18:00', N'Trực tiếp', 20000, N'120000'),
('SAN2','KH3','2021-11-24 18:00','2021-11-24 19:00', N'Đặt trước', 40000, N'240000'),
('SAN3','KH4','2021-11-25 19:00','2021-11-25 20:00', N'Đặt trước', 80000, N'480000'),
('SAN4','KH2','2021-11-26 18:00','2021-11-26 19:00', N'Trực tiếp', 20000, N'120000'),
('SAN5','KH5','2021-11-27 17:00','2021-11-27 18:00', N'Đặt trước', 40000, N'240000'),
('SAN6','KH6','2021-11-28 19:00','2021-11-28 20:00', N'Trực tiếp', 80000, N'480000');
GO

-- Them HoaDon
INSERT HoaDon(Ma_KhachHang, Ma_San, NgayLap_HD, TongPhut_Da, DonGia, TongTien_HD) VALUES
('KH1','SAN1','2021-11-23', 60, 20000, 120000),
('KH3','SAN2','2021-11-24', 60, 40000, 240000),
('KH4','SAN3','2021-11-25', 60, 80000, 480000),
('KH2','SAN4','2021-11-26', 60, 20000, 120000),
('KH5','SAN5','2021-11-27', 60, 40000, 240000),
('KH6','SAN6','2021-11-28', 60, 80000, 480000),
('KH5','SAN6','2021-11-29', 60,  2000, 120000);
GO

-- =============================================
-- STORED PROCEDURES
-- =============================================

-- Danh sach khach hang theo ma
CREATE OR ALTER PROCEDURE spDSKH
(
	@Ma_KhachHang VARCHAR(100)
)
AS 
BEGIN
	SELECT KhachHang.*, HoaDon.NgayLap_HD, HoaDon.TongTien_HD
	FROM KhachHang 
	INNER JOIN HoaDon ON KhachHang.Ma_KhachHang = HoaDon.Ma_KhachHang
	WHERE KhachHang.Ma_KhachHang = @Ma_KhachHang
END
GO

-- Danh sach hoa don theo ma
CREATE OR ALTER PROCEDURE spDSHD
(
	@Ma_HD INT
)
AS 
BEGIN
	SELECT HoaDon.*
	FROM HoaDon 
	WHERE HoaDon.Ma_HD = @Ma_HD
END
GO

-- =============================================
-- KIEM TRA DU LIEU
-- =============================================

-- Xem tat ca account
SELECT * FROM Account
GO

-- Xem tat ca khach hang
SELECT * FROM KhachHang
GO

-- Xem san voi loai san
SELECT San.Ma_San, San.Loai_San, San.Ten_San, LoaiSan.Ten_Loai, LoaiSan.GiaLoai_San
FROM San, LoaiSan
WHERE San.Loai_San = LoaiSan.Loai_San
GO

-- Lay gia loai san cua SAN1
SELECT GiaLoai_San
FROM San, LoaiSan
WHERE San.Loai_San = LoaiSan.Loai_San AND San.Ma_San = 'SAN1'
GO

-- Tong tien tat ca hoa don
SELECT SUM(TongTien_HD) AS TongDoanhThu
FROM HoaDon
GO

-- Xem hoa don so 1
SELECT * FROM HoaDon WHERE Ma_HD = 1
GO

-- Goi procedure
EXEC spDSKH 'KH1'
GO
EXEC spDSHD 1
GO
