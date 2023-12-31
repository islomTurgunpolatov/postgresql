CREATE TABLE bank.klienci
    (   
		klient_id NUMBER PRIMARY KEY
	,	imie VARCHAR2(30) NOT NULL
	,	nazwisko VARCHAR(50) NOT NULL
	,	plec VARCHAR2(1 CHAR)
	, 	login VARCHAR2(15 CHAR) GENERATED ALWAYS AS
		(LOWER(SUBSTR(bank_pckg_utilities.f_parser(imie), 0, 3) || '.' || SUBSTR(bank_pckg_utilities.f_parser(nazwisko),0, 3)))
	,	email VARCHAR2(75) NOT NULL UNIQUE
	,	pesel varchar2(11 CHAR) UNIQUE
	,	f_czy_aktywny VARCHAR2(1 CHAR) DEFAULT 'T'
    );
    
--comments
COMMENT ON TABLE bank.klienci IS 'Tabela przechowująca informacje o klientach.';
COMMENT ON COLUMN bank.klienci.klient_id IS 'Klucz główny identyfikujący klienta.';
COMMENT ON COLUMN bank.klienci.imie IS 'Imię klienta.';
COMMENT ON COLUMN bank.klienci.nazwisko IS 'Nazwisko klienta.';
COMMENT ON COLUMN bank.klienci.plec IS 'Zadeklarowana płeć klienta M - mężczyzna, K - kobieta, N - nie chce podawać.';
COMMENT ON COLUMN bank.klienci.login IS 'Login do aplikacji mobilnej danego użytkownika (klienta).';
COMMENT ON COLUMN bank.klienci.email IS 'Adres e-mail klienta.';
COMMENT ON COLUMN bank.klienci.pesel IS 'Numer PESEL klienta.';
COMMENT ON COLUMN bank.klienci.f_czy_aktywny IS 'Flaga czy klient aktywny.';

--synonym
CREATE PUBLIC SYNONYM klienci
FOR bank.klienci;
	
--comments
    COMMENT ON COLUMN bank.klienci.kl_adres_id IS 'Referencja do tabeli Adresy.';

-- additional CONSTRAINTS for allowed values
ALTER TABLE klienci ADD CONSTRAINT kl_gnd_chk CHECK (plec in ('M', 'K', 'N'));
ALTER TABLE klienci ADD CONSTRAINT kl_atv_chk CHECK (f_czy_aktywny in ('T', 'N'));

-- for pesel validator functionality
alter table klienci add (pesel_valid varchar2(4000 CHAR) generated always as (bank_pckg_utilities.f_validate_pesel(klient_id)) virtual);
alter table klienci add constraint kl_psl_vld_chk check(pesel_valid in ('T'));