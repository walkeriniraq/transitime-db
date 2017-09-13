#!/usr/bin/env bash

# This is to substitute into config file the env values
sed -i s#"POSTGRES_PORT_5432_TCP_ADDR"#"$POSTGRES_PORT_5432_TCP_ADDR"#g /usr/local/transitime/config/*
sed -i s#"POSTGRES_PORT_5432_TCP_PORT"#"$POSTGRES_PORT_5432_TCP_PORT"#g /usr/local/transitime/config/*
sed -i s#"PGPASSWORD"#"$PGPASSWORD"#g /usr/local/transitime/config/*
sed -i s#"AGENCYNAME"#"$AGENCYNAME"#g /usr/local/transitime/config/*
sed -i s#"GTFSRTVEHICLEPOSITIONS"#"$GTFSRTVEHICLEPOSITIONS"#g /usr/local/transitime/config/*

cp /usr/local/transitime/config/transitime.properties /usr/local/transitimeTomcatConfig/transitime.properties

java -jar /usr/local/transitime/CreateAPIKey.jar -c "/usr/local/transitime/config/transiTimeConfig.xml" -d "foo" -e "og.crudden@gmail.com" -n "Sean Og Crudden" -p "123456" -u "http://www.transitime.org"