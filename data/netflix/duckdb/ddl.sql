CREATE TABLE IF NOT EXISTS netflix_shows (
  show_id VARCHAR PRIMARY KEY,
  type VARCHAR,
  title VARCHAR,
  director VARCHAR,
  cast_members VARCHAR,
  country VARCHAR,
  date_added DATE,
  release_year BIGINT,
  rating VARCHAR,
  duration VARCHAR,
  listed_in VARCHAR,
  description VARCHAR
);
