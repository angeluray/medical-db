CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE medical_histories (
    id INTEGER GENERATED AlWAYS AS IDENTITY,
    admitted_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    patient_id INTEGER NOT NULL,
    status VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE treatments (
    id INTEGER GENERATED AlWAYS AS IDENTITY,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE invoice_items (
    id INTEGER GENERATED AlWAYS AS IDENTITY,
    unit_price DECIMAL(8, 2) NOT NULL,
    quantity INTEGER NOT NULL,
    total_price DECIMAL(8, 2) NOT NULL,
    invoice_id INTEGER NOT NULL,
    treatment_id INTEGER NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT invoice_items_treatment_id_foreign FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

CREATE TABLE invoices (
    id INTEGER GENERATED AlWAYS AS IDENTITY,
    total_amount DECIMAL(8, 2) NOT NULL,
    generated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    payed_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    medical_history_id INTEGER NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT invoices_medical_history_id_foreign FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE histories_treatments(
    id INTEGER GENERATED AlWAYS AS IDENTITY,
    history_id INTEGER NOT NULL,
    treatment_id INTEGER NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE histories_treatments ADD CONSTRAINT histories_treatments_history_id_foreign FOREIGN KEY(history_id) REFERENCES medical_histories(id);
ALTER TABLE medical_histories ADD CONSTRAINT medical_histories_patient_id_foreign FOREIGN KEY(patient_id) REFERENCES patients(id);
ALTER TABLE histories_treatments ADD CONSTRAINT histories_treatments_treatment_id_foreign FOREIGN KEY(treatment_id) REFERENCES treatments(id);
ALTER TABLE invoice_items ADD CONSTRAINT invoice_items_invoice_id_foreign FOREIGN KEY(invoice_id) REFERENCES invoices(id);