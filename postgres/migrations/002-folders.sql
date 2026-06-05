-- educatool-infra/postgres/migrations/002-folders.sql
CREATE TABLE IF NOT EXISTS folders (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name       TEXT NOT NULL,
  icon       TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS document_folders (
  document_id UUID NOT NULL REFERENCES documents(id) ON DELETE CASCADE,
  folder_id   UUID NOT NULL REFERENCES folders(id) ON DELETE CASCADE,
  PRIMARY KEY (document_id, folder_id)
);

CREATE INDEX IF NOT EXISTS document_folders_folder_id_idx ON document_folders (folder_id);
CREATE INDEX IF NOT EXISTS folders_user_id_idx ON folders (user_id);
