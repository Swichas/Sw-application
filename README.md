# Sw-application
This a upgraded version of mycroft-jobforms
# installation 
Make sure to have Qb-core and Ox_lib installed
# SQL

CREATE TABLE `aplikacijos` (
  `vardas` text NOT NULL,
  `pavarde` text NOT NULL,
  `metai` varchar(225) NOT NULL,
  `telefonas` varchar(255) NOT NULL,
  `arpasiruoses` text NOT NULL,
  `patirtis` text DEFAULT NULL,
  `job` text DEFAULT NULL
) 

insert this into database

# CREDITS https://github.com/Mycroft-Studios/mycroft-jobforms
# to open type /bossmenu
