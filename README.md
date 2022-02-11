# About

This is [complete, minimal, verifiable sample](https://stackoverflow.com/help/minimal-reproducible-example)
that reproduces [spring-cloud/spring-cloud-consul#768](https://github.com/spring-cloud/spring-cloud-consul/issues/768). 

Before running application you should bring consul up and setup ACL. This is done in `bootstrap-consul-acl.sh`.
Run this script once, and you receive two ACL tokens:

* Root token - this is global management token. Useful for obtaining superuser access in consul web UI.
* App token - this token must be placed into `application.yml` under `spring.cloud.consul.token`.

Run test with `./mvnw test`. It should fail.

There's also `bootstrap-consul-no-acl.sh` which setup consul with exactly same KV values as in
`bootstrap-consul-acl.sh` but with disabled ACL. Test completes successfully when testing with
no-acl consul setup.
