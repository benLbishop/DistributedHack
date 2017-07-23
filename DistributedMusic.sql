PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE user(
  id            integer     PRIMARY KEY  AUTOINCREMENT,
  first_name    text    NOT NULL,
  last_name     text    NOT NULL,
  email         text    UNIQUE  NOT NULL,
  password      text    NOT NULL,
  user_name     text    UNIQUE  NOT NULL,
  biography     text,
  profile_pic   text,
  join_date     datetime DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "user" VALUES(1,'Tyler','Pedelose','test_email@gmail.com','password','DJ_McDjface',NULL,NULL,'2017-07-23 08:08:28');
INSERT INTO "user" VALUES(2,'Norman','Cook','nc_test@gmail.com','p@ssword','Fatboy Slim',NULL,NULL,'2017-07-23 08:08:28');
CREATE TABLE wallet(
  user_id       integer       NOT NULL,
  address       char(42)    UNIQUE  NOT NULL,
  FOREIGN KEY(user_id) REFERENCES user(id)
);
CREATE TABLE album(
  id            integer     PRIMARY KEY  AUTOINCREMENT,
  name          text        NOT NULL,
  artist_id     integer     NOT NULL,
  genre         text        NOT NULL,
  release_date  datetime    NOT NULL,
  cover_art     text,
  FOREIGN KEY(artist_id) REFERENCES user(id)
  CONSTRAINT unique_album_by_artist UNIQUE (name, artist_id)
);
INSERT INTO "album" VALUES(1,'You''ve Come A Long Way, Baby',2,'Big Beat',1969,'./resources/images/youve_come_a_long_way.jpg');
CREATE TABLE track(
  id            integer     PRIMARY KEY  AUTOINCREMENT,
  track_number  integer     NOT NULL,
  name          text        NOT NULL,
  length        text        NOT NULL,
  album_id      integer     NOT NULL,
  track_path    text        NOT NULL,
  upload_date   datetime    DEFAULT CURRENT_TIMESTAMP,
  play_price    integer     NOT NULL,
  plays         integer     DEFAULT 0,
  FOREIGN KEY(album_id) REFERENCES album(id)
);
INSERT INTO "track" VALUES(1,1,'Right Here, Right Now','6:27',1,'./resources/music/Fatboy Slim - Right Here, Right Now.mp3','2017-07-23 08:11:04',1,0);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('user',2);
INSERT INTO "sqlite_sequence" VALUES('album',1);
INSERT INTO "sqlite_sequence" VALUES('track',1);
COMMIT;
