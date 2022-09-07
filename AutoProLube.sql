CREATE TABLE [dbo].[User] (
    [UserID] NVARCHAR (30) NOT NULL,
    [Sifre]  NVARCHAR (10) NOT NULL,
    [tip]    NVARCHAR (50) NOT NULL,
    UNIQUE NONCLUSTERED ([UserID] ASC),
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([UserID] ASC)
);


CREATE TABLE [dbo].[Ulke] (
    [UlkeAdi] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK_Ulke] PRIMARY KEY CLUSTERED ([UlkeAdi] ASC)
);


CREATE TABLE [dbo].[SirketYonetici] (
    [YoneticiID] INT           IDENTITY (1, 1) NOT NULL,
    [Ad]         NVARCHAR (20) NOT NULL,
    [Soyad]      NVARCHAR (10) NOT NULL,
    [TCKimlikNo] INT           NULL,
    [Unvan]      NVARCHAR (30) NULL,
    [Eposta]     NVARCHAR (30) NULL,
    [Adres]      NVARCHAR (60) NULL,
    [TelNo]      NVARCHAR (24) NULL,
    [UserID]     NVARCHAR (30) NOT NULL,
    CONSTRAINT [PK_SirketYonetici] PRIMARY KEY CLUSTERED ([YoneticiID] ASC),
    UNIQUE NONCLUSTERED ([Eposta] ASC),
    CONSTRAINT [FK_SirketYonetici_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID])
);


CREATE TABLE [dbo].[Kategori] (
    [KategoriKodu] INT           NOT NULL,
    [Ad]           NVARCHAR (40) NULL,
    CONSTRAINT [PK_Kategori] PRIMARY KEY CLUSTERED ([KategoriKodu] ASC)
);


CREATE TABLE [dbo].[Urun] (
    [UrunKodu]     NVARCHAR (30)  NOT NULL,
    [Fiyat]        INT            NULL,
    [StokMiktari]  INT            NULL,
    [KategoriKodu] INT            NOT NULL,
    [Detaylar]     NVARCHAR (500) NULL,
    [Özellikler]   NVARCHAR (200) NULL,
    CONSTRAINT [PK_Urun] PRIMARY KEY CLUSTERED ([UrunKodu] ASC),
    CONSTRAINT [FK_Urun_Kategori] FOREIGN KEY ([KategoriKodu]) REFERENCES [dbo].[Kategori] ([KategoriKodu])
);


CREATE TABLE [dbo].[KargoFirma] (
    [FirmaKodu] NVARCHAR (20)  NOT NULL,
    [Ad]        NVARCHAR (40)  NULL,
    [Adres]     NVARCHAR (100) NULL,
    CONSTRAINT [PK_KargoFirma] PRIMARY KEY CLUSTERED ([FirmaKodu] ASC)
);


CREATE TABLE [dbo].[Siparis] (
    [SiparisNo]      INT           IDENTITY (100, 1) NOT NULL,
    [Tarih]          DATETIME      NULL,
    [KargoFirmaKodu] NVARCHAR (20) NOT NULL,
    [SepetKodu]      INT           NOT NULL,
    CONSTRAINT [SiparisNo] PRIMARY KEY CLUSTERED ([SiparisNo] ASC),
    CONSTRAINT [FK_Siparis_KargoFirma] FOREIGN KEY ([KargoFirmaKodu]) REFERENCES [dbo].[KargoFirma] ([FirmaKodu])
);

CREATE TABLE [dbo].[Il] (
    [IlAdi]   NVARCHAR (20) NOT NULL,
    [UlkeAdi] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK_Il] PRIMARY KEY CLUSTERED ([IlAdi] ASC),
    CONSTRAINT [FK_Il_Ulke] FOREIGN KEY ([UlkeAdi]) REFERENCES [dbo].[Ulke] ([UlkeAdi])
);


CREATE TABLE [dbo].[SatisElemani] (
    [ElemanID]   INT           IDENTITY (1, 1) NOT NULL,
    [Ad]         NVARCHAR (20) NOT NULL,
    [Soyad]      NVARCHAR (10) NOT NULL,
    [TCKimlikNo] NVARCHAR (11) NULL,
    [Eposta]     NVARCHAR (30) NULL,
    [Adres]      NVARCHAR (60) NULL,
    [TelNo]      NVARCHAR (24) NULL,
    [UserID]     NVARCHAR (30) NOT NULL,
    UNIQUE NONCLUSTERED ([Eposta] ASC),
    CONSTRAINT [PK_SatisElemani] PRIMARY KEY CLUSTERED ([ElemanID] ASC),
    CONSTRAINT [FK_SatisElemani_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID])
);


CREATE TABLE [dbo].[SepeteEkle] (
    [SepetKodu] INT           NOT NULL,
    [UrunKodu]  NVARCHAR (30) NOT NULL,
    CONSTRAINT [FK_SepeteEkle_Sepet] FOREIGN KEY ([SepetKodu]) REFERENCES [dbo].[Sepet] ([SepetKodu]),
    CONSTRAINT [FK_SepeteEkle_Urun] FOREIGN KEY ([UrunKodu]) REFERENCES [dbo].[Urun] ([UrunKodu])
);


CREATE TABLE [dbo].[Musteri] (
    [MusteriID] INT           IDENTITY (1, 1) NOT NULL,
    [Ad]        NVARCHAR (20) NOT NULL,
    [Soyad]     NVARCHAR (10) NOT NULL,
    [Eposta]    NVARCHAR (30) NULL,
    [Adres]     NVARCHAR (60) NULL,
    [TelNo]     NVARCHAR (24) NULL,
    [SirketAdi] NVARCHAR (60) NULL,
    [Unvan]     NVARCHAR (30) NULL,
    [ElemanID]  INT           NOT NULL,
    [UserID]    NVARCHAR (30) NOT NULL,
    [UlkeAdi]   NVARCHAR (20) NOT NULL,
    [SepetKodu] INT           NOT NULL,
    CONSTRAINT [PK_Musteri] PRIMARY KEY CLUSTERED ([MusteriID] ASC),
    UNIQUE NONCLUSTERED ([Eposta] ASC),
    CONSTRAINT [FK_Musteri_Ulke] FOREIGN KEY ([UlkeAdi]) REFERENCES [dbo].[Ulke] ([UlkeAdi]),
    CONSTRAINT [FK_Musteri_SatisElemani] FOREIGN KEY ([ElemanID]) REFERENCES [dbo].[SatisElemani] ([ElemanID]),
    CONSTRAINT [FK_Musteri_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID]),
    CONSTRAINT [FK_Musteri_Sepet] FOREIGN KEY ([SepetKodu]) REFERENCES [dbo].[Sepet] ([SepetKodu])
);


CREATE TABLE [dbo].[Fatura] (
    [FaturaNo]  INT        NOT NULL,
    [Tarih]     DATETIME   NULL,
    [Fiyat]     FLOAT (53) NULL,
    [SiparisNo] INT        NOT NULL,
    CONSTRAINT [FaturaNo] PRIMARY KEY CLUSTERED ([FaturaNo] ASC),
    CONSTRAINT [FK_Fatura_Siparis] FOREIGN KEY ([SiparisNo]) REFERENCES [dbo].[Siparis] ([SiparisNo])
);


GO
INSERT INTO [dbo].[User] ([UserID], [Sifre], [tip]) VALUES (N'Ansu', N'1234', N'C')
INSERT INTO [dbo].[User] ([UserID], [Sifre], [tip]) VALUES (N'Baris', N'1234', N'P')
INSERT INTO [dbo].[User] ([UserID], [Sifre], [tip]) VALUES (N'Feride', N'1234', N'ACP')
INSERT INTO [dbo].[User] ([UserID], [Sifre], [tip]) VALUES (N'mahmoud', N'1234', N'C')
INSERT INTO [dbo].[User] ([UserID], [Sifre], [tip]) VALUES (N'Omer', N'1234', N'A')
INSERT INTO [dbo].[User] ([UserID], [Sifre], [tip]) VALUES (N'Salih', N'1234', N'P')
INSERT INTO [dbo].[User] ([UserID], [Sifre], [tip]) VALUES (N'Yasemin', N'1234', N'A')
INSERT INTO [dbo].[User] ([UserID], [Sifre], [tip]) VALUES (N'Zeynep', N'1234', N'P')

GO
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Afghanistan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Albania')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Algeria')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Andorra')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Angola')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Antigua')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Argentina')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Armenia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Australia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Austria')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Azerbaijan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Bahamas')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Bahrain')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Bangladesh')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Barbados')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Belarus')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Belgium')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Belize')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Benin')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Bhutan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Bolivia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Bosnia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Botswana')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Brazil')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Brunei')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Bulgaria')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Burkina Faso')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Burundi')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Cabo Verde')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Cambodia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Cameroon')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Canada')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'CAR')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Chad')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Chile')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'China')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Colombia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Comoros')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Congo')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Costa Rica')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Cote d Ivoire')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Croatia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Cuba')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Cyprus')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Czechia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Denmark')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Djibouti')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Dominica')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Dominican Republic')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Ecuador')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Egypt')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'El Salvador')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Equatorial Guinea')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Eritrea')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Estonia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Eswatini')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Ethiopia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Fiji')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Finland')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'France')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Gabon')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Gambia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Georgia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Germany')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Ghana')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Greece')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Grenada')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Guatemala')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Guinea')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Guinea-Bissau')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Guyana')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Haiti')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Honduras')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Hungary')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Iceland')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'India')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Indonesia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Iran')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Iraq')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Ireland')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Italy')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Jamaica')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Japan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Jordan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Kazakhstan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Kenya')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Kiribati')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Kosovo')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Kuwait')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Kyrgyzstan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Laos')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Latvia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Lebanon')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Lesotho')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Liberia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Libya')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Liechtenstein')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Lithuania')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Luxembourg')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Madagascar')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Malawi')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Malaysia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Maldives')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Mali')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Malta')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Marshall Islands')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Mauritania')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Mauritius')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Mexico')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Micronesia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Moldova')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Monaco')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Mongolia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Montenegro')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Morocco')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Mozambique')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Myanmar')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Namibia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Nauru')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Nepal')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Netherlands')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'New Zealand')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Nicaragua')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Niger')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Nigeria')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'North Korea')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'North Macedonia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Norway')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Oman')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Pakistan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Palau')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Palestine')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Panama')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Papua New Guinea')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Paraguay')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Peru')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Philippines')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Poland')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Portugal')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Qatar')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Romania')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Russia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Rwanda')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Saint Lucia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Saint Vincent')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Samoa')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'San Marino')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Saudi Arabia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Senegal')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Serbia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Seychelles')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Sierra Leone')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Singapore')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Slovakia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Slovenia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Solomon Islands')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Somalia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'South Africa')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'South Korea')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'South Sudan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Spain')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Sri Lanka')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Sudan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Suriname')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Sweden')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Switzerland')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Syria')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Taiwan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Tajikistan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Tanzania')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Thailand')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Timor-Leste')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Togo')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Tonga')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Trinidad and Tobago')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Tunisia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Turkey')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Turkmenistan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Tuvalu')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Uganda')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Ukraine')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'United Arab Emirates')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'United Kingdom (UK)')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'United States(USA)')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Uruguay')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Uzbekistan')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Vanuatu')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Vatican City')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Venezuela')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Vietnam')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Yemen')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Zambia')
INSERT INTO [dbo].[Ulke] ([UlkeAdi]) VALUES (N'Zimbabwe')


GO
SET IDENTITY_INSERT [dbo].[SatisElemani] ON
INSERT INTO [dbo].[SatisElemani] ([ElemanID], [Ad], [Soyad], [TCKimlikNo], [Eposta], [Adres], [TelNo], [UserID]) VALUES (9, N'Zeynep', N'Özdemir', N'73111111111', N'zeynepozdemir', NULL, N'0090 537 111 11 11', N'Zeynep')
INSERT INTO [dbo].[SatisElemani] ([ElemanID], [Ad], [Soyad], [TCKimlikNo], [Eposta], [Adres], [TelNo], [UserID]) VALUES (11, N'Baris', N'Gündoğdu', N'72222222222', N'barisgundogdu@gmail.com', NULL, N'0090 533 222 22 22', N'Baris')
INSERT INTO [dbo].[SatisElemani] ([ElemanID], [Ad], [Soyad], [TCKimlikNo], [Eposta], [Adres], [TelNo], [UserID]) VALUES (12, N'Salih', N'Kaya', N'74444444444', N'salihkaya@gmail.com', NULL, N'0090 522 444 44 44', N'salih')
SET IDENTITY_INSERT [dbo].[SatisElemani] OFF

GO
INSERT INTO [dbo].[Il] ([IlAdi], [UlkeAdi]) VALUES (N'Alexandria', N'Egypt')

GO
INSERT INTO [dbo].[Kategori] ([KategoriKodu], [Ad]) VALUES (1, N'Vehicle Engine Oils')
INSERT INTO [dbo].[Kategori] ([KategoriKodu], [Ad]) VALUES (2, N'Heavy Duty Diesel Motor Oils')
INSERT INTO [dbo].[Kategori] ([KategoriKodu], [Ad]) VALUES (3, N'Four & Two-Stroke Motor Oils')
INSERT INTO [dbo].[Kategori] ([KategoriKodu], [Ad]) VALUES (4, N'Multi-Purpose Tractor Fluid')
INSERT INTO [dbo].[Kategori] ([KategoriKodu], [Ad]) VALUES (5, N'Gear & Transmission Fluid')
INSERT INTO [dbo].[Kategori] ([KategoriKodu], [Ad]) VALUES (6, N'Automatic Transmission Fluid')
INSERT INTO [dbo].[Kategori] ([KategoriKodu], [Ad]) VALUES (7, N'Hydraulic System Oils')
INSERT INTO [dbo].[Kategori] ([KategoriKodu], [Ad]) VALUES (8, N'Antifreeze & Coolant')
INSERT INTO [dbo].[Kategori] ([KategoriKodu], [Ad]) VALUES (9, N'Automatic Transmission Fluid')

GO
SET IDENTITY_INSERT [dbo].[Sepet] ON
INSERT INTO [dbo].[Sepet] ([SepetKodu]) VALUES (3)
INSERT INTO [dbo].[Sepet] ([SepetKodu]) VALUES (1003)
SET IDENTITY_INSERT [dbo].[Sepet] OFF

GO
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'0W16 SN-CF', 20, 1500, 1, N'is specially formulated to meet the speci_c needs of hybrid electric vehicles,suchasHEV, PHEV and BEV with Range Extender, where multiples unexpected stopsand starts of the Gasoline engine are involved during the different operatingphases of the hybrid vehicle. Thisparticular mode of operation of the internalcombustion engine on a hybrid vehicle generates very speci_cconstraintsfor the lubricant', NULL)
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'0W20 SN HYBRID', 5, 2500, 1, N'is full synthetic engine oil provide fuel economy, formulated especially for
hybrid electric vehicles (HEV-Hybrid Electric Vehicle) and hybrids rechargeable
(PHEV-Plug-in Hybrid Electric Vehicle) equipped with gasoline engines, turbo
or atmospheric, direct or indirect injection. Recommended for electric vehicles
of type BEV (Battery Electric Vehicle) equipped with a petrol thermal engine,
extending the range.', N'API SN, ILSAC GF-5, Dexos 1')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'0W20 SN-CF', 3, 1700, 1, N'the blend of effective synthetic oils ultimate additive technology meets the
demand for the absolute best performance in engine oil with low viscosity and
highs stability. Its reliably inhibits deposit formation,reduces frictionlossesand
protects against wear. It creates better engine performance for modern and old
engines. It is the most advanced new generation motor oil providing superior and
long-lastingengine protection, especially for stop and go city trafc use.', N'API SN/CF , ILSAC GF-5')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'0W40 CI-4SL A3', 8, 1000, 1, N'0W40 CI-4/SL A3
It is fully synthetic motor oil and enhanced with good additives formulationfor
passenger cars and light diesel vehicles. Meets all the requirements for diesel
engines that are produced with modern methods. Unique performance in the four
seasons. In all weather and road conditions, provides unparalleled protection in
motor with high viscosity index.', N'API CI-4/SL, MB 228.3/229.1, ACEA 07-E7/B4/A3, ACEA 04-E7/B4/B3/A3')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'10W40 CI-4', 20, 2000, 2, N'is a ultra high performance diesel engine oil for modern heavy commercial
vehicles. It offers long oil change interval. The combination of state of the art
additive technology with high quality base oils provides excellent oil circulation at
cold start, high viscosity index, volatility control and fuel economy.', N'API CI-4/CH-4/CG-4, ACEA E4/E7, CAT ECF-1-a, CUMMINS CES 20078/77,
MACKEO-MPLUS, MAN M 3377/M3277, MB-APPROVAL 228.5')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'10W40 SL-CF', 9, 3000, 1, N'is a synthetic based engine oil developed to meet high performance requirements
of passenger cars and light commercial vehicles. It has been formulated with
unique combination of high quality base oils and advanced additive technology to
provide superior protection in engine.', N'API SL/CF, ACEA A3/B3,A3/B4, MB-APPROVAL 229.1, VW 505 00/50101/500 00')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'15W40 CF-4', 18, 2500, 2, N'is a diesel engine oil that is developed with combination of modern technology
additives and high quality base oils. It completely fulllthe lubrication requirements
of naturally aspirated or turbocharged diesel engines of heavy duty
vehicles. Its special formula keeps engine parts clean and provides effective
protection especially in frequently used and high mileage diesel engines.', N'API CI-4/CH-4/CG-4, ACEA E4/E7, CAT ECF-1-a, CUMMINS CES 20078/77,
MACKEO-MPLUS, MAN M 3377/M3277, MB-APPROVAL 228.5')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'15W40 CI-4', 13, 1500, 2, N'is a diesel engine oil that is developed with combination of modern technology
additives and high quality base oils. It completely fulllthe lubrication requirements
of naturally aspirated or turbocharged diesel engines of heavy duty
vehicles. Its special formula keeps engine parts clean and provides effective
protection especially in frequently used and high mileage diesel engines.', N'API CI-4/CH-4/CG-4,ACEA E4/E7, CAT ECF-1-a, CUMMINS CES 20078/77,
MACKEO-MPLUS, MAN M 3377/M3277, MB-APPROVAL 228.5')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'20W50 CF-4', 31, 4000, 2, N'is a diesel engine oil that is developed with combination of modern technology
additives and high quality base oils. It can be used safely in heavy duty vehicles
operating in construction,transportation and agricultural sectors.Its special
formula keeps engine parts clean and provides effective protection especially in
frequently used and high mileage diesel engines.', N'API CF-4, ACEA E7, CATECF-1-a, CUMMINS 20076 /77, MACK EO-M PLUS,
EO-N, MAN 3275, MB-APPROVAL 228.3')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'20W50 CI-4', 27, 0, 2, N'is a ultra high performance diesel engine oil for modern heavy commercial
vehicles. It offers long oil change interval. The combination of state of the art
additive technology with high quality base oils provides excellent oil circulation at
cold start, high viscosity index, volatility control and fuel economy.', N'API CI-4/CH-4/CG-4, ACEA E4/E7, CAT ECF-1-a, CUMMINS CES 20078/77,
MACKEO-MPLUS, MAN M 3377/M3277, MB-APPROVAL 228.5')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'20W50 SL-CF', 12, 0, 1, N'is an engine oil which meets the lubrication needs of gasoline or diesel engines of
passenger vehicles and light commercial vehicles. It provides effective performance
in vehicles especially driven in urban trafc. ', N'API SL/CF, ACEA A3/B3, A3/B4')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'2T MOTO', 4, 0, 3, N'is a high performance motorcycle oil which is developed for 2-stroke gasoline
engines. Fuel/oil mixin gratio should be decided according to the original equipment
recommendations. It provides excellent wear, rust and corrosion protection
and long engine life.', N'API CD/SF, CF/SF, CC/SC')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'422 FLUID', 21, 2000, 4, N'A multipurpose transmission lubricant in all seasons used condently in brake
and clutch systems,except engine, transmissions,differentials and hydraulic
systems and last drive units, combine-harvesters and disinfection machines.
Ensures silent operation of braking system due to friction inhibiting property. It is suitable to use in manual transmissions,hydraulic, axle, wet brake systems,
nal drives and PTO of tractor and agricultural machines.', N'ALLISON C-4,API GL-4, CASE MS 1210, CNH MAT3525, FORD ESN-M2C86-
B/C/ESN-M2C134-D, JOHN DEERE JDM J20D/C, KUBOTA UDT FLUID, MASSEY
FERGUSON CMS M, 1145/1143/1141/1135, ZFTE-ML 17E/06K/05F/03E')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'4T 10W40', 22, 4000, 3, N'is a synthetic based motorcycle oil which is formulated with special base oils to
meet the lubrication requirements of air or water cooled 4-stroke engines of
scooters. It provides a high degree of anti-wear protection for stressed components
and excellent cleanliness for pistons, rings, combustion chambers and
spark plugs, thereby promoting long engine life and performance retention.', N'API SJ / SL / SH / SG, JASO MA2/MA')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W20 SN-CF', 10, 0, 1, N'is a synthetic engine oil that fullllsthe performance requirements of new technology
engines. Also it can be used in other diesel or gasoline engines of passenger
vehicles and light duty vehicles. Its special formula improves efciency of exhaust
gas a er treatment systems such as Diesel Particulate Filter (DPF) and Three Way
Catalyst (TWC) and extends their service life', N'API SN/CF, ACEA C2, GM DEXOS 2, ACEA A1/B1, RENAULT RN 700E
FIAT 9.55535-S1, PSA B712290')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W30 CI-4-SL C3', 8, 1700, 1, N'High-performance, low friction fully synthetic motor oil designed for long-term
use in modern motors.The combination of ultimate synthetic oil technology with
latest additive generation (mid SAPS technology), guarantees a low viscosity,
highlyshear resistant engine oil that is sure to prevent deposit build-up, lower
friction loss in the engine and provide optimal wear protection.', N'API CI-4/SL, ACEA C3-10, VW 504 00/507 00, BMW LC -04, PORSCHE C30
MB 229.51')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W30 SL-CF', 6, 2000, 1, N'is a synthetic fuel economy engine oil which is developed for gasoline or diesel
engines of passenger vehicles and light commercial vehicles. It provides effective
wear protection due to its specially developed additives and high quality base oils.
It is suitable to use in gasoline or diesel engines of passenger vehicles and light
commercial vehicles.', N'API SL/CF, ACEA A5/B5, A1/B1, FORD WSS-M2C913-D, RENAULT RN 0700')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W30 SM-CF C-2', 19, 0, 1, N'Synthetic Low Saps Diesel and Gasoline Engine Oil, designed to help prolong the
life and maintain the efciency of Car Emission Reduction Systems (Diesel
Engines: Diesel Particule Filter DPFs, Gasoline Engines: Three WAY Catalysts -
TWCs) Recommended for new generation low saps gasoline/dieselautomobiles
and light-dutydiesel powered engines, specially for TWCs).', N'API SM/CF, ACEA C2-12,Fiat 9.55535-S1,RN 0700, ACEA A1/B1,A5/B5')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W30 SM-CF C-3', 16, 0, 1, N'is a synthetic engine oil which is developed to meet safe driving and long usage
requirements of new and modern technology gasoline or diesel engines under
extreme operating conditions. High viscosity index base oils and new technology
additives in its formula provides superior protection and fuel economy.', N'VW 504.00/507.00, MB Approval 229.51,MB Approval 229.31,
API SM/CF, ACEA C3-12, BMW LL-04, Porsche C30')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W30 SM-CF C-4', 16, 0, 1, N'Synthetic Low Saps Diesel and Gasoline Engine Oil, designed to help prolong the
life and maintain the efciency of Car Emission Reduction Systems (Diesel
Engines: Diesel Particule Filter DPFs, Gasoline Engines: Three WAY
Catalysts-TWCs) Recommended for new generation low saps gasoline / diesel
automobiles and light -duty diesel powered engines, specially for TWCs).', N'VW 504.00/507.00, MB Approval 229.51, MB Approval 229.31, API SM/CF,
RN 0720, ACEA C4-12')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W30 SN-CF', 13, 0, 1, N'is a synthetic engine oil that fullllsthe performance requirements of new technology
engines. Also it can be used in other diesel or gasoline engines of passenger
vehicles and light duty vehicles. Its special formula improves efciency of exhaust
gas a er treatment systems such as Diesel Particulate Filter (DPF) and Three Way
Catalyst (TWC) and extends their service life', N'API SN/CF, ACEA C2, GM DEXOS 2, ACEA A1/B1, RENAULT RN 700E
FIAT 9.55535-S1, PSA B712290')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W30 SN-CF A5-B5-A1-B1', 26, 5000, 1, N'Synthetic Low Saps Diesel and Gasoline Engine Oil, designed to help prolong the
life and maintain the efciency of Car Emission Reduction Systems (Diesel
Engines: Diesel Particule Filter DPFs, Gasoline Engines: Three WAY Catalysts -
TWCs) Recommended for new generation low saps gasoline/dieselautomobiles
and light-dutydiesel powered engines, specially.', N'FORD WSS-M2C913-D, FORD, ACEA A5/B5-12, A1/B1-12, API SN/CF,
WSS-M2C913-C, FORD WSS-M2C913-B, RENAULT RN 0700')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W40 CI-4-SL', 16, 0, 1, N'A modern fully synthetic high-performance, low friction engine oil designed for
longterm use in modern engines. The combination of ultimate synthetic oil
technology with latest additive generation (mid SAPS technology), guarantees a
low viscosity, highly shearresitant engine oilthat is sure to prevent deposit
build-up, lowerfriction lossin the engine and provide optimal wear protection.', N'API CI-4 /CH-4')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'5W40 SM-CF', 18, 0, 1, N'is a synthetic engine oil which is developed to meet safe driving and long usage
requirements of new and modern technology gasoline or diesel engines under
extreme operating conditions. High viscosity index base oils and new technology
additives in its formula provides superior protection and fuel economy.', N'API SM/CF, ACEA A3/B4,A3/B3, MB-APPROVAL 229.3,226.5, PORSCHE A40,
RENAULT RN 0710/0700, VW 505 01/50200')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'75W90 GL-5', 29, 4000, 5, N'is a synthetic automotive gear oil based on quality synthetic base oils and modern
additive technology. It has been specially developed for hypoid gears, planetary
axle hubs and transfer gearboxes. It should be avoided mixingwith conventional
branded gear oils.', N'API GL-5/GL-4 ZF TE-ML 21A/19C/17B/16F/12N/12L/05A')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'80W90GL-5', 20, 0, 5, N'is a ultra high performance automotive gear oil which is developed for hypoid gear
axles under extreme operating conditions. Its special formula provides protection
against wear under extreme operating conditions', N'API GL-5/MT-1, ARVIN MERITOR 0-76-D, MAN 342 TYPE M3,
MB APPROVAL 235.2, MACKGO-J, SAE J2360,
SCANIA STO 1:0, ZF TE-ML 05A, 07A, 12E, 16B, 16C')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'85W140 GL-5', 13, 1000, 5, N'is a high performance automotive gear oil for hypoid gear systems, differentials
and axles under extreme operating conditions. Its special formulation provides
superior protection against wear occurring under extreme operating conditions.', N'API GL-5/API GL-4 (SAE 85W-140), API GL–5, MIL-L-2105D')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'ANTIFREEZE', 11, 0, 8, N'is a superior quality ethylene glycol based coolant formulated with special
additives for cooling systems of allgasoline and diesel engines. It prevents radiator
water from freezing in cold climates and prevents radiator water from boiling
due to its special formulation.', N'BS 6580:1992, TS 3582')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'ANTIFREEZE & COOLANT', 7, 0, 8, N'is a long life concentrate coolant based on ethylene glycol. It is free from amines,
nitrites, phosphates and silicates and is formulated using Organic Acid Technology(
OAT). Extended Life Antifreeze provides effective protection against corrosion
in modern technology engines especially aluminum and alloyed iron engines.', N'ASTM D 3306, CUMMINS (ISBe motorlar), DEUTZ TR-0199-99-1115,
GM6277M, JOHN DEERE, MB-APPROVAL 325.3, MWM 0199-99-2091')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'ATF II-III', 9, 3000, 6, N'is an ultra high performance automatic transmission uid based on special
technology additives. It is developed to meet Dexron IIIG and Ford Mercon speci-
cations of the leading engine manufacturers. ATF DX III fullls the requirements
of automatically controlled transmission systems even under most extreme
conditions.', N'ALLISON C-4, FORD MERCON, GM DEXRON IIIG, GM TYPE A SUFFIX A,
MAN 339 TYPE V1/Z1, MB-APPROVAL 236.5/236.1, VOITH, H55.6335.xx,
VOLVO 97341')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'BRAKE FLUID DOT 3', 31, 1700, 9, N'is a high quality synthetic brake uid that performs excellently in the hydraulic
brake systems and clutches of motor vehicles. With its high boiling point, it
provides excellent power transmission, safe operation and maximum protection
thanks to its special additives. It provides effective protection against rust, corrosion
and wear in the system.', N'FMVSS 116-DOT3, ISO 4925, JASO JIS K2233, SAE J1703')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'BRAKE FLUID DOT 4', 34, 2500, 9, N'It is a glycol ether-based uid formulated to meet the internationally accepted
hydraulic uid standards. It contains all the properties needed to ensure brake
systems to operate in a safe and reliable way. It reduces the steam locking risk
under extreme conditions thanks to its high boiling point.', N'FMVSS')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'CVT FLUID', 27, 0, 6, N'is an automatic transmission uid that is developed according to the leading
equipment manufacturer’ s specications. It meets requirements of GM Dexron II.
It provides continuous and perfect power transmissionin torque convertor. Its
high viscosity-temperature behaviour enables fast oil circulation at low temperatures
and lm strength at high temperatures.', N'ALLISON C-4, FORD MERCON, GM DEXRON IIG, GM TYPE A SUFFIX A,
MAN 339 TYPE V1/Z1, MB-APPROVAL 236.5/236.1, VOITH, H55.6335.xx,
VOLVO 97341')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'HD 50 CD-SF', 20, 0, 2, N'is a super high performance diesel engine oil which meets the latest performances
of the leading engine manufacturers and offers maximumprotection in modern
technology engines. It protects engine parts against oxidation even at high
temperatures. Its special formula improves performance of both low and high
mileage diesel engines.', N'API CD/SF, CF/SF, CC/SC')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'HYDRA 46', 18, 2700, 7, N'is a high performance hydraulic system oil which is suitable to use inwide
temperature range. It can be used in all types of construction equipment and
hydraulic system even under high pressure due to its special additive package in
its content. It provides superior protection in hydraulic systems under extreme
operating conditions.', N'BOSCH REXROTH, DENIOSN HF-2/HF-1/HF-0,DIN51524 Part 3 (HVLP),
EATONLUB. SPEC. E-FDGN-TB002-E, FIVES CINCINNATI P-68,-69,
P-70 ISO 11158 HL,HM,HV')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'HYDRA 68', 27, 0, 7, N'is a high performance hydraulic system oil which is suitable to use in wide
temperature range. It can be used in all types of construction equipment and
hydraulic system even under high pressure due to its special additive package in
its content. It provides superior protection in hydraulic systems under extreme
operating conditions.', N'API GL-1/GL-4/GL-5 ZF TE-ML 21A/19C/17B/16F/12N/12L/05A')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'SAE 90-140', 14, 0, 5, N'is a mineral automotive gear oilthat has been developed for alltypes of gear
operating under normal conditions. It does not contain extreme pressure (EP)
additives, so it is suitable to use in gear systems, synchronized transmissionsand
differentials not operating under high load.', N'API GL-1/GL-4/GL-5 ZF TE-ML 21A/19C/17B/16F/12N/12L/05A')
INSERT INTO [dbo].[Urun] ([UrunKodu], [Fiyat], [StokMiktari], [KategoriKodu], [Detaylar], [Özellikler]) VALUES (N'test', 11, 1000, 8, N'test', NULL)


GO
INSERT INTO [dbo].[SepeteEkle] ([SepetKodu], [UrunKodu]) VALUES (3, N'0W16 SN-CF')
INSERT INTO [dbo].[SepeteEkle] ([SepetKodu], [UrunKodu]) VALUES (3, N'0W20 SN HYBRID')
INSERT INTO [dbo].[SepeteEkle] ([SepetKodu], [UrunKodu]) VALUES (3, N'0W20 SN-CF')

GO
SET IDENTITY_INSERT [dbo].[SirketYonetici] ON
INSERT INTO [dbo].[SirketYonetici] ([YoneticiID], [Ad], [Soyad], [TCKimlikNo], [Unvan], [Eposta], [Adres], [TelNo], [UserID]) VALUES (2, N'Feride', N'Elhennawy', NULL, N'CEO', N'ferideelhennawy@gmail.com', N'Istanbul', N'0090 522 222 2222', N'Feride')
INSERT INTO [dbo].[SirketYonetici] ([YoneticiID], [Ad], [Soyad], [TCKimlikNo], [Unvan], [Eposta], [Adres], [TelNo], [UserID]) VALUES (3, N'Yasemin', N'Koçak', NULL, NULL, N'yaseminkocak@gmail.com', N'Istanbul', N'0090 533 333 3333', N'Yasemin')
INSERT INTO [dbo].[SirketYonetici] ([YoneticiID], [Ad], [Soyad], [TCKimlikNo], [Unvan], [Eposta], [Adres], [TelNo], [UserID]) VALUES (4, N'Ömer', N'Kılıç', NULL, NULL, N'omerkilic', N'Adana', N'0090 544 444 4444', N'Omer')
SET IDENTITY_INSERT [dbo].[SirketYonetici] OFF

GO
SET IDENTITY_INSERT [dbo].[Musteri] ON
INSERT INTO [dbo].[Musteri] ([MusteriID], [Ad], [Soyad], [Eposta], [Adres], [TelNo], [SirketAdi], [Unvan], [ElemanID], [UserID], [UlkeAdi], [SepetKodu]) VALUES (4005, N'Ansu', N'Gati', N'ansugati@gmail.com', NULL, N'213 222 222 22 22', N'Max Company', N'CEO', 9, N'Ansu', N'Liberia', 3)
INSERT INTO [dbo].[Musteri] ([MusteriID], [Ad], [Soyad], [Eposta], [Adres], [TelNo], [SirketAdi], [Unvan], [ElemanID], [UserID], [UlkeAdi], [SepetKodu]) VALUES (5006, N'Mahmoud', N'Soliman', N'mahmoudsoliman@gmail.com', NULL, N'0020 111 111 1111', N'Oils Company', N'Employee', 11, N'mahmoud', N'Egypt', 1003)
SET IDENTITY_INSERT [dbo].[Musteri] OFF
