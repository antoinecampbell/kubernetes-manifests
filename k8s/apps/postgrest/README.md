# postgrest

## Database setup
```postgresql
CREATE DATABASE postgrest;
CREATE USER postgrest WITH PASSWORD 'postgrest';
GRANT ALL ON DATABASE postgrest to postgrest;
ALTER DATABASE postgrest OWNER TO postgrest;

create role web_anon nologin;
grant web_anon to postgrest;
\connect postgrest
grant usage on schema public to web_anon;

```
Trigger schema cache reload:
```postgresql
NOTIFY pgrst, 'reload schema';
```
Automated schema cache reloading: https://postgrest.org/en/v12/references/schema_cache.html#automatic-schema-cache-reloading


