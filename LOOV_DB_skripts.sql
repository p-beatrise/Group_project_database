
CREATE TABLE Moderatori (
Moderatora_ID INT NOT NULL PRIMARY KEY,
Moderatora_lietotajvards NVARCHAR(12) NOT NULL,
Mod_PK NVARCHAR(12) NOT NULL,	---Moderatora personas kods
Moder_vards NVARCHAR(100) NOT NULL,
Moder_uzvards NVARCHAR(100) NOT NULL,
Mod_parole NVARCHAR(24) NOT NULL,
Darba_uzs_dat DATE NOT NULL,	---Datums, kurā uzsāka strādāt
Darba_beig_dat DATE NULL		---Datums, kurā beidz strādāt
)

CREATE TABLE Treso_pusu_lietotnes(
Savienojumu_ID INT NOT NULL PRIMARY KEY,
Lietotaja_Netflix_API nvarchar(255) NULL,	--Lietotāja Netflix API atslēga
Lietotaja_Facebook_API nvarchar(255) NULL,	--Lietotāja Netflix API atslēga
Lietotaja_Instagram_API nvarchar(255) NULL,	--Lietotāja Netflix API atslēga
Lietotaja_Goodreads_API nvarchar(255) NULL,	--Lietotāja Netflix API atslēga
Lietotaja_Spotify_API nvarchar(255) NULL,	--Lietotāja Netflix API atslēga
Lietotaja_Steam_API nvarchar(255) NULL,		--Lietotāja Netflix API atslēga
)

CREATE TABLE Registretie_lietotaji(
Lietotaja_ID INT NOT NULL PRIMARY KEY,
Vards NVARCHAR(100) NOT NULL,
Uzvards NVARCHAR(100) NOT NULL,
Dzimsanas_dat DATE NOT NULL,
Ofic_vards NVARCHAR(100) NOT NULL,	--No bankas iegūtie dati
Ofic_uzvards NVARCHAR(100) NOT NULL,--No bankas iegūtie dati
Ofic_dzimsanas_datums DATE NOT NULL,--No bankas iegūtie dati
Epasts NVARCHAR(255) NOT NULL,
Liet_parole NVARCHAR(24) NOT NULL,	--Lietotāja parole
Tel_nr NVARCHAR(8) NOT NULL,		--Telefona numurs
Atrasanas_vieta NVARCHAR(32) NOT NULL,	
MBTI_tips NVARCHAR(4) NULL,
Horoskops NVARCHAR(10) NULL,
Apraksts NVARCHAR(1016) NULL,		--Profila apraksts
Att_sanemsanas_iesp BIT NULL,		--Funkcija, kas nosaka, vai citi lietotāji var sūtīt bildes
Liet_ar_bildem_radisana BIT NULL,	--Funkcija, kas nosaka, ka lietotājs redz tikai profilus ar bildēm tajos
Verific_lietotaju_radisana BIT NULL,--Funkcija, kas nosaka, ka lietotājs redz tikai verificētu lietotāju profilus
Dziv_testa_versijas_ID INT UNIQUE NOT NULL,	---Lietotāja dzīvesstila testa versijas ID
Liet_dealbr_saraksta_ID INT UNIQUE NOT NULL,		--Lietotāja dealbreakers saraksta ID
Treso_pusu_savien_ID INT UNIQUE NOT NULL		--Lietotāja trešo pušu lietotņu savienojuma ID
)

ALTER TABLE Registretie_lietotaji	--Ārējā atslēga
ADD CONSTRAINT FK_Lietotaji_Lietotnes FOREIGN KEY (Treso_pusu_savien_ID)
REFERENCES Treso_pusu_lietotnes (Savienojumu_ID)


CREATE TABLE Netflix_parraides(
Parraides_ID INT NOT NULL PRIMARY KEY,
Parraides_nosaukums NVARCHAR(100)
) 


CREATE TABLE Lietotaja_parraides(	--Tabula, kas glabā, kādas Netflix pārraides skatās un kuras patīk lietotājiem
Skatitas_parraides_ID INT NOT NULL REFERENCES Netflix_parraides,
Atzimetas_parraudes_ID INT NOT NULL REFERENCES Netflix_parraides,
Savien_ID INT NOT NULL REFERENCES Treso_pusu_lietotnes
PRIMARY KEY(Skatitas_parraides_ID,Atzimetas_parraudes_ID,Savien_ID)
)

CREATE TABLE Facebook_lapas(
Lapas_ID INT NOT NULL PRIMARY KEY,
Lapas_nosaukums NVARCHAR(100) NOT NULL
)

CREATE TABLE Facebook_grupas(
Grupas_ID INT NOT NULL PRIMARY KEY,
Grupas_nosaukums NVARCHAR(100) NOT NULL
)


CREATE TABLE Facebook_info(		--Tabula, kas glabā, kādām Facebook lapām un grupām seko lietotāji
Lapu_ID INT NOT NULL REFERENCES Facebook_lapas,
Grupu_ID INT NOT NULL REFERENCES Facebook_grupas,
Savien_ID INT NOT NULL REFERENCES Treso_pusu_lietotnes

)


CREATE TABLE Instagram_profili(
Profila_ID INT NOT NULL PRIMARY KEY,
Profila_lietotajvards INT NOT NULL 
)

CREATE TABLE Lietotaja_profili(		--Tabula, kas glabā, kādiem Instagram profiliem seko lietotāji
Profilu_ID INT NOT NULL REFERENCES Instagram_profili,
Savien_ID INT NOT NULL REFERENCES Treso_pusu_lietotnes
)


CREATE TABLE Goodreads_gramatas(
Gramatas_ID INT NOT NULL PRIMARY KEY,
Gramatas_nosaukums NVARCHAR(100) NOT NULL
)


CREATE TABLE Lietotaja_gramatas(	--Tabula, kas glabā, kādas grāmatas Goodreads lietotāji ir lasījuši
Gramatu_ID INT NOT NULL REFERENCES Goodreads_gramatas,
Savien_ID INT NOT NULL REFERENCES Treso_pusu_lietotnes
)


CREATE TABLE Spotify_izpilditaji(
Izpilditaja_ID INT NOT NULL PRIMARY KEY,
Izpilditaja_vards NVARCHAR(100) NOT NULL
)

CREATE TABLE Lietotaja_izpilditaji(	--Tabula, kas glabā, kādi mākslinieki Spotify patīk lietotājiem
Izpilditaju_ID INT NOT NULL REFERENCES Spotify_izpilditaji,
Savien_ID INT NOT NULL REFERENCES Treso_pusu_lietotnes
)


CREATE TABLE Steam_speles(
Speles_ID INT NOT NULL PRIMARY KEY,
Speles_nosaukums NVARCHAR(100) NOT NULL
)

CREATE TABLE Lietotajs_speles(	--Tabula, kas glabā, kādas Steam spēles spēlē lietotāji
Speles_ID INT NOT NULL REFERENCES Steam_speles,
Savien_ID INT NOT NULL REFERENCES Treso_pusu_lietotnes
)


CREATE TABLE Jautajumi(		--Jautājumi testam, ko cilvēki lietotnē varētu izpildīt
Jautajuma_ID INT NOT NULL PRIMARY KEY,
Jautajums NVARCHAR(300) NOT NULL
)

CREATE TABLE Atbildes(		--Atbildes testam, ko cilvēki lietotnē varētu izpildīt
Atbildes_ID INT NOT NULL PRIMARY KEY,
Atbilde BIT NULL		
)

CREATE TABLE Dzivesstila_tests(	
Pilditaja_testa_ID INT NOT NULL PRIMARY KEY,	--Lietotājam piešķirtais ID pēc testa izpildes
Liet_jaut_ID INT NOT NULL REFERENCES Jautajumi,
Liet_atb_ID INT NOT NULL REFERENCES Atbildes
)

ALTER TABLE Registretie_lietotaji	--Ārējā atslēga
ADD CONSTRAINT FK_Lietotaji_dzivesstila_tests FOREIGN KEY (Dziv_testa_versijas_ID)
REFERENCES Dzivesstila_tests (Pilditaja_testa_ID)

CREATE TABLE Dealbreakeri(		--Tabula, kas glabā 'dealbreakers'(lietas, ar ko cilvēks nav gatavs samierināties attiecībās)
Dealbreakera_ID INT NOT NULL PRIMARY KEY,
Nosaukums NVARCHAR(300) NOT NULL
)


CREATE TABLE Dealbreakers_esamiba(	--Tabula, kas glabā iespējamās 'Jā' un 'Nē' atbildes uz jautājumiem par dealbreakers esamību
Dealbr_atb_ID INT NOT NULL PRIMARY KEY,
Dealbr_atbilde BIT NULL

)

CREATE TABLE Lietotaja_dealbreakeri(	--Tabula, kas glabā informāciju par to, kuram lietotājam ir kādi dealbreakers
Dealbr_saraksta_ID INT NOT NULL PRIMARY KEY,	--ID, kas tiek piešķirts lietotājam pēc dealbreakers atzīmēšanas
Dealbr_ID INT NOT NULL REFERENCES Dealbreakeri,
Liet_dealbr_atb_ID INT NOT NULL REFERENCES Dealbreakers_esamiba
)

ALTER TABLE Registretie_lietotaji	--Ārējā atslēga
ADD CONSTRAINT FK_Lietotaji_dealbreakeri FOREIGN KEY (Liet_dealbr_saraksta_ID)
REFERENCES Lietotaja_dealbreakeri (Dealbr_saraksta_ID)


CREATE TABLE Atzimetie_lietotaji(		--Tabula, kas glabā, kuri lietotāji ir citus lietotājus atzīmējuši ar 'Patīk'
Atzimetajs INT NOT NULL FOREIGN KEY REFERENCES Registretie_lietotaji,
Atzimejamais INT NOT NULL FOREIGN KEY REFERENCES Registretie_lietotaji,
Laiks DATETIME NOT NULL,
Stavoklis BIT NOT NULL		--Stāvoklis apzīmē, vai divi lietotāji ir viens otru atzīmējuši ar 'Patīk'
PRIMARY KEY (Atzimetajs,Atzimejamais)
)

CREATE TABLE Lietotaju_skatisana(	--Tabula, kas glabā informāciju par moderatoru skatītajiem lietotāju profiliem
Liet_ID INT NOT NULL REFERENCES Registretie_lietotaji,
Skatitaja_mod_ID INT NOT NULL REFERENCES Moderatori
)

CREATE TABLE Lietotaju_dzesana(		--Tabula, kas glabā informāciju par moderatoru dzēstajiem lietotāju profiliem
Liet_ID INT NOT NULL UNIQUE,
Skatitaja_mod_ID INT NOT NULL REFERENCES Moderatori
)

ALTER TABLE Lietotaju_dzesana	--Ārējā atslēga
ADD CONSTRAINT FK_Lietotaji_dzestie FOREIGN KEY (Liet_ID)
REFERENCES Registretie_lietotaji (Lietotaja_ID)

CREATE TABLE Sarakstes(		--Tabula, kas glabā informāciju par sarakstes esamību starp diviem lietotājiem
Sarakstes_ID INT NOT NULL PRIMARY KEY,
Izveides_laiks DATETIME NOT NULL
)


CREATE TABLE Sarakstes_zinas(	--Tabula, kas glabā datus par ziņām, kas ir nosūtītas sarakstēs
Zinas_ID INT NOT NULL PRIMARY KEY,
Laiks DATETIME NOT NULL,
Teksts NVARCHAR(1016) NULL,
Balss_ieraksts VARBINARY(MAX) NULL,
Attels VARBINARY(MAX) NULL,
Sar_ID INT NOT NULL REFERENCES Sarakstes 
)


CREATE TABLE Zinu_sutitaji(	--Tabula, kas glabā datus par ziņu sūtītāja nosūtītajām ziņām
Sutitaja_ID INT NOT NULL REFERENCES Registretie_lietotaji,
Sut_zinas_ID INT NOT NULL
PRIMARY KEY(Sutitaja_ID,Sut_zinas_ID)
)

ALTER TABLE Zinu_sutitaji	--Ārējā atslēga
ADD CONSTRAINT FK_Lietotaji_nosut_zinas FOREIGN KEY (Sut_zinas_ID)
REFERENCES Sarakstes_zinas (Zinas_ID)


CREATE TABLE Zinu_sanemeji(	--Tabula, kas glabā datus par ziņu saņēmēja saņemtajām ziņām
Sanemeja_ID INT NOT NULL,
San_zinas_ID INT NOT NULL REFERENCES Sarakstes_zinas,
PRIMARY KEY(Sanemeja_ID,San_zinas_ID)
)

ALTER TABLE Zinu_sanemeji	--Ārējā atslēga
ADD CONSTRAINT FK_Lietotaji_sanem_zinas FOREIGN KEY (Sanemeja_ID)
REFERENCES Registretie_lietotaji (Lietotaja_ID)


CREATE TABLE Verifikacijas(	--Tabula, kas glabā datus par lietotāju profila verifikāciju
Verif_notikuma_ID INT NOT NULL PRIMARY KEY,
Laiks DATETIME NOT NULL,
Stavokla_nos NVARCHAR(10) NOT NULL,
Verif_liet_ID INT NOT NULL REFERENCES Registretie_lietotaji,
Mainitaja_mod_ID INT NOT NULL REFERENCES Moderatori
)

CREATE TABLE Blokejamie_tel_nr(	--Tabula, kas glabā bloķētos telefona numurus
Blokejama_nr_ID INT NOT NULL PRIMARY KEY,
Blokejamais_nr NVARCHAR(8) NOT NULL
)

CREATE TABLE Lietotaju_bloketie_tel_nr(	--Tabula, kas glabā datus par to, kurš lietotājs ir bloķējis kādu numuru
Bloketaja_ID INT NOT NULL FOREIGN KEY REFERENCES Registretie_lietotaji,
Blok_nr_ID INT NOT NULL FOREIGN KEY REFERENCES Blokejamie_tel_nr,
Laiks DATETIME NOT NULL,
PRIMARY KEY (Bloketaja_ID,Blok_nr_ID)
)


CREATE TABLE Sudzibas(	--Tabula, kas glabā datus par lietotāju nosūtītajām sūdzībām
Sudzibas_ID INT NOT NULL PRIMARY KEY,
Iemesls NVARCHAR(100) NOT NULL,
Stavoklis NVARCHAR(11) NOT NULL,
Laiks DATETIME NOT NULL,
Sudz_iesniedz_ID INT NOT NULL FOREIGN KEY REFERENCES Registretie_lietotaji,
Apsudzama_ID INT NOT NULL FOREIGN KEY REFERENCES Registretie_lietotaji,
Sar_ID INT NOT NULL FOREIGN KEY REFERENCES Sarakstes
)


CREATE TABLE Sudzibas_apstrade(	--Tabula, kas glabā datus par to, kuru sūdzību izskata kurš moderators
Apstradajamas_sudz_ID INT NOT NULL UNIQUE,
Apstrades_mod_ID INT NOT NULL UNIQUE
)

ALTER TABLE Sudzibas_apstrade	--Ārējā atslēga
ADD CONSTRAINT FK_Apstradajama_sudz FOREIGN KEY (Apstradajamas_sudz_ID)
REFERENCES Sudzibas (Sudzibas_ID)

ALTER TABLE Sudzibas_apstrade	--Ārējā atslēga
ADD CONSTRAINT FK_Sudz_apstradatajs_mod FOREIGN KEY (Apstrades_mod_ID)
REFERENCES Moderatori (Moderatora_ID)



CREATE TABLE Lietotaja_verifikacijas_bildes(	--Tabula, kas glabā lietotāju verifikācijas bildes
Liet_verif_bildes_ID INT NOT NULL PRIMARY KEY,
Liet_verif_bilde VARBINARY(MAX) NOT NULL,
Verif_bildes_liceja_ID INT NOT NULL UNIQUE
)

ALTER TABLE Lietotaja_verifikacijas_bildes	--Ārējā atslēga
ADD CONSTRAINT FK_Lietotajs_verif_bilde FOREIGN KEY (Verif_bildes_liceja_ID)
REFERENCES Registretie_lietotaji (Lietotaja_ID)


CREATE TABLE Moderatori_verif_bildes(	--Tabula, kas glabā datus par to, kuru lietotāja bilžu verifikāciju veic kurš moderators
Verif_bildes_ID INT NOT NULL UNIQUE,
V_bildes_redz_mod_ID INT NOT NULL UNIQUE
)

ALTER TABLE Moderatori_verif_bildes	--Ārējā atslēga
ADD CONSTRAINT FK_Verif_bilde FOREIGN KEY (Verif_bildes_ID)
REFERENCES Lietotaja_verifikacijas_bildes (Liet_verif_bildes_ID)

ALTER TABLE Moderatori_verif_bildes	--Ārējā atslēga
ADD CONSTRAINT FK_Moderators_verif_bilde FOREIGN KEY (V_bildes_redz_mod_ID)
REFERENCES Moderatori (Moderatora_ID)


CREATE TABLE Lietotaja_profila_bildes(	--Tabula, kas glabā datus par lietotāju profila bildēm
Liet_prof_bildes_ID INT NOT NULL PRIMARY KEY,
Liet_prof_bilde VARBINARY(MAX) NULL,
Bildes_liceja_ID INT NOT NULL REFERENCES Registretie_lietotaji
)


CREATE TABLE Moderatori_prof_bildes(	--Ārējā atslēga
Profila_bildes_ID INT NOT NULL REFERENCES Lietotaja_profila_bildes,
Bildes_redz_mod_ID INT NOT NULL REFERENCES Moderatori
)

