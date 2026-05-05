/*
  # Add has_photo column to receipts

  1. Changes
    - Add `has_photo` boolean column to `receipts` table
    - Defaults to true if captured_face exists, false otherwise
    - This allows the admin list to show photo badges without downloading heavy base64 images
  2. Security
    - No RLS changes needed
*/

ALTER TABLE receipts ADD COLUMN IF NOT EXISTS has_photo boolean DEFAULT false;

-- Set has_photo = true for all existing rows that have a captured_face
UPDATE receipts SET has_photo = true WHERE captured_face IS NOT NULL;
