CREATE TABLE "objects" (
  "object_id" varchar(32) PRIMARY KEY,
  "object_number" varchar(10) UNIQUE,
  "location" point,
  "description" varchar(500)
);

CREATE TABLE "boreholes" (
  "borehole_id" varchar(32) PRIMARY KEY,
  "borehole_name" varchar(50),
  "object_id" varchar(10),
  "description" varchar(500)
);

CREATE TABLE "samples" (
  "sample_id" varchar(32) PRIMARY KEY,
  "borehole_id" bigint,
  "laboratory_number" varchar(50),
  "soil_type" varchar(500),
  "description" varchar(500)
);

CREATE TABLE "tests" (
  "test_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
  "sample_id" bigint,
  "test_type_id" int,
  "timestamp" timestamp,
  "test_params" jsonb,
  "test_results" jsonb,
  "description" varchar(500)
);

CREATE TABLE "test_types" (
  "test_type_id" int PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
  "test_type" varchar(50),
  "description" varchar(500)
);

CREATE TABLE "parameters_titles" (
  "param_id" bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
  "param_name" varchar(50),
  "param_title" varchar(500),
  "description" varchar(500)
);

COMMENT ON COLUMN "objects"."object_id" IS 'from EngGeo';
COMMENT ON COLUMN "boreholes"."borehole_id" IS 'from EngGeo';
COMMENT ON COLUMN "samples"."sample_id" IS 'from EngGeo';

ALTER TABLE "boreholes" ADD FOREIGN KEY ("object_id") REFERENCES "objects" ("object_id");
ALTER TABLE "samples" ADD FOREIGN KEY ("borehole_id") REFERENCES "boreholes" ("borehole_id");
ALTER TABLE "tests" ADD FOREIGN KEY ("sample_id") REFERENCES "samples" ("sample_id");
ALTER TABLE "tests" ADD FOREIGN KEY ("test_type_id") REFERENCES "test_types" ("test_type_id");

ALTER TABLE "samples" ADD CONSTRAINT CONSTRAINT_borehole_lab_unique UNIQUE ("borehole_id", "laboratory_number");
ALTER TABLE "boreholes" ADD CONSTRAINT CONSTRAINT_borehole_object_unique UNIQUE ("borehole_name", "object_id");
