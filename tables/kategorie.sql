CREATE TABLE bank.kategorie
    (
        kat_id NUMBER PRIMARY KEY,
        nazwa  VARCHAR2(30 CHAR) UNIQUE NOT NULL,
        opis   VARCHAR(100)
    );
	
	COMMENT ON TABLE bank.kategorie IS 'Tabela przechowująca informacje o kategoriach transakcji.';
	COMMENT ON COLUMN bank.kategorie.kat_id IS 'Klucz główny identyfikujący kategorie.';
	COMMENT ON COLUMN bank.kategorie.nazwa IS 'Nazwa kategorii.';
	COMMENT ON COLUMN bank.kategorie.opis IS 'Opis szczegółowy kategorii.';