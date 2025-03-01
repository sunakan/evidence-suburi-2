CREATE TABLE IF NOT EXISTS "2019" (
  overall_rank BIGINT NOT NULL,
  country_or_region VARCHAR PRIMARY KEY,
  score DOUBLE NOT NULL,
  gdp_per_capita DOUBLE NOT NULL,
  social_support DOUBLE NOT NULL,
  healthy_life_expectancy DOUBLE NOT NULL,
  freedom_to_make_life_choices DOUBLE NOT NULL,
  generosity DOUBLE NOT NULL,
  perceptions_of_corruption DOUBLE NOT NULL
);
COMMENT ON TABLE "2019" IS '2019年度の国別幸福度ランキング';
COMMENT ON COLUMN "2019".overall_rank IS 'ランキング(順位)';
COMMENT ON COLUMN "2019".country_or_region IS '国名や州';
COMMENT ON COLUMN "2019".score IS '総合スコア(幸福度の評価点)';
COMMENT ON COLUMN "2019".gdp_per_capita IS '1人あたりのGDP(経済的豊かさ)';
COMMENT ON COLUMN "2019".social_support IS '社会支援(家族や友人からのサポート度合い)';
COMMENT ON COLUMN "2019".healthy_life_expectancy IS '健康寿命(健康で過ごせる期間の予測)';
COMMENT ON COLUMN "2019".freedom_to_make_life_choices IS '人生の選択の自由度合い';
COMMENT ON COLUMN "2019".generosity IS '寛容さ(他者への思いやりや寄付の度合い)';
COMMENT ON COLUMN "2019".perceptions_of_corruption IS '汚職に対する認識(政府や企業の信頼度)';
