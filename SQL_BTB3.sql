use master
go
create database QLDEAN2
on primary
( filename='D:\cosodulieu_ca2\qlda2.mdf', name = 'a')
log on 
( filename='D:\cosodulieu_ca2\qlda2.ldf', name = 'b')
go
USE [QLDEAN2]
GO
CREATE TABLE [PHONGBAN](
	[MAPHG] [int] NOT NULL,
	[TENPHONG] [nvarchar] (30),
	[TRPHG] [char] (9),
	[NG_NHANCHUC] [date],
	constraint p_PB PRIMARY KEY ([MAPHG])
	)
GO
CREATE TABLE [NHANVIEN] (
	[MANV] [char] (9) NOT NULL,
	[HONV] [nvarchar] (30),
	[TENLOT] [nvarchar] (30),
	TENNV nvarchar (30) NOT NULL,
	NGSINH date ,
	DIACHI nvarchar (50),
	PHAI nchar (6),
	LUONG float,
	MA_NQL char (9),
	PHG int ,
	constraint c_Phai_NV check (Phai in ('Nam', N'Nữ')),
	constraint c_Luong check (Luong>=0),
	constraint p_NV PRIMARY KEY ([MANV]),
	CONSTRAINT FK_NV_PB FOREIGN KEY (PHG) REFERENCES PHONGBAN(MAPHG)
)
CREATE TABLE [THANNHAN](
	MA_NVIEN char (9) NOT NULL,
	TENTN nvarchar (30) NOT NULL,
	PHAI nchar (6),
	constraint c_Phai_TN check (Phai in ('Nam', N'Nữ')),
	NGSINH date,
	QUANHE nvarchar (16),
	constraint p_TN PRIMARY KEY ([MA_NVIEN],[TENTN]),
	CONSTRAINT FK_TN_NV FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)
    )
Go
CREATE TABLE [DEAN](
	MADA int NOT NULL,
	TENDA nvarchar (30),
	DDIEM_DA nvarchar (30),
	PHONG int,
	constraint p_DA PRIMARY KEY ([MADA]),
	CONSTRAINT FK_DA_PB FOREIGN KEY (PHONG) REFERENCES PHONGBAN(MAPHG)
	)
Go
CREATE TABLE [DIADIEM_PHG](
	MAPHG int NOT NULL,
	DIADIEM nvarchar (30) NOT NULL,
	constraint p_DD_P PRIMARY KEY ([MAPHG],[DIADIEM]),
	CONSTRAINT FK_DD_PHG_PB FOREIGN KEY (MAPHG) REFERENCES PHONGBAN(MAPHG)
	)
Go
CREATE TABLE [CONGVIEC](
	MADA INT NOT NULL,
	STT int NOT NULL,
	TEN_CONG_VIEC nvarchar(50),
	constraint STT check (STT>0),
	constraint p_CV PRIMARY KEY ([MADA],[STT]),
	CONSTRAINT FK_CV FOREIGN KEY (MADA) REFERENCES DEAN(MADA)
	)
Go
CREATE TABLE [PHANCONG](
	MA_NVIEN char(9) NOT NULL,
	MADA int NOT NULL,
	STT int NOT NULL,
	THOIGIAN decimal(5, 1),
	constraint C_TG check (THOIGIAN >=0),
	constraint p_PC PRIMARY KEY ([MA_NVIEN],[MADA],[STT]),
	constraint fk_PC foreign key ([MADA],[STT]) references CONGVIEC([MADA],[STT]), 
	CONSTRAINT FK_PC_NV FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV) 
	)
Go

