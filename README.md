# Redis Pool

Provides a pool of Redis connections.

Example usage

```
pool := redispool.New("localhost:6379", "password")
conn := pool.Get()
defer conn.Close()

// use the connection
// ...
```

## Licence

The MIT License (MIT)

Copyright (c) 2019 Scott Barr

See [LICENSE.md](LICENSE.md)
