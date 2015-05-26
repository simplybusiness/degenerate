# Degenerate

Degenerate is an almost feature-free Slack client intended as a demonstration application for the deployment/Puppet Level Up session

It expects a configuration file in `/etc/degenerate.yml`


```
slack:
  token: cmdsq-387569325-12089341-209895-badcafe
  channel: cumulus-levelup
  username: Washington Irving
```

which you (if you are attending said Level Up) will be expected to
create with Puppet using secrets stored in [Blackops](https://github.com/simplybusiness/blackops)