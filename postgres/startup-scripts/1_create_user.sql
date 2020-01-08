WITH x AS (
    SELECT
        ''::text AS mountpoint,
           'test-client'::text AS client_id,
           'test-user'::text AS username,
           '123'::text AS password,
           gen_salt('bf')::text AS salt,
           '[{"pattern": "#"}]'::json AS publish_acl,
           '[{"pattern": "#"}]'::json AS subscribe_acl
    ) 
INSERT INTO vmq_auth_acl (mountpoint, client_id, username, password, publish_acl, subscribe_acl)
    SELECT 
        x.mountpoint,
        x.client_id,
        x.username,
        crypt(x.password, x.salt),
        publish_acl,
        subscribe_acl
    FROM x;