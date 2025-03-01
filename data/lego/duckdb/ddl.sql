CREATE TABLE IF NOT EXISTS lego_colors (
  id BIGINT PRIMARY KEY,
  name VARCHAR NOT NULL,
  rgb VARCHAR NOT NULL,
  is_trans BOOLEAN NOT NULL
);
CREATE TABLE IF NOT EXISTS lego_inventories (
  id BIGINT PRIMARY KEY,
  version BIGINT NOT NULL,
  set_num VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS lego_inventory_parts (
  inventory_id BIGINT PRIMARY KEY,
  part_num VARCHAR NOT NULL,
  color_id BIGINT NOT NULL,
  quantity BIGINT NOT NULL,
  is_spare BOOLEAN NOT NULL
);
CREATE TABLE IF NOT EXISTS lego_inventory_sets (
  inventory_id BIGINT PRIMARY KEY,
  set_num VARCHAR NOT NULL,
  quantity BIGINT NOT NULL
);
CREATE TABLE IF NOT EXISTS lego_part_categories (
  id BIGINT PRIMARY KEY,
  name VARCHAR NOT NULL
);
CREATE TABLE IF NOT EXISTS lego_parts (
  part_num VARCHAR PRIMARY KEY,
  name VARCHAR NOT NULL,
  part_cat_id BIGINT NOT NULL
);
CREATE TABLE IF NOT EXISTS lego_themes (
  id BIGINT PRIMARY KEY,
  name VARCHAR NOT NULL,
  parent_id BIGINT
);
CREATE TABLE IF NOT EXISTS lego_sets (
  set_num VARCHAR PRIMARY KEY,
  name VARCHAR NOT NULL,
  year BIGINT NOT NULL,
  theme_id BIGINT NOT NULL,
  num_parts BIGINT NOT NULL
);
