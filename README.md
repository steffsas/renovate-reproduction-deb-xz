# renovate-reproduction-deb-xz

This repository demonstrates the missing implementation of the **xz compression algorithm** in Renovate (analogous to bzip2). See [Renovate discussion #33086](https://github.com/renovatebot/renovate/discussions/33086) for details.

## Current behavior

Renovate fails with a `404` error while attempting to look up the required Debian package indices (`bookworm-backports`) in the `Packages.gz` file.  
This occurs because the indices are compressed using **xz**, resulting in a `Packages.xz` file instead.

See the output of Renovate in this [GitHub Actions workflow run](https://github.com/steffsas/renovate-reproduction-deb-xz/actions/runs/14531637381/job/40772302391).

Renovate attempts to fetch the indices using the following configuration:

```yaml
"options": 
    {
        ...
        "url": "https://deb.debian.org/debian/dists/bookworm-backports/main/binary-amd64/Packages.gz",
        "hostType": "deb",
        "username": "",
        "password": "",
        "method": "GET",
        "http2": false
    }
```

which results in 

```yaml
    "response": {
        "statusCode": 404,
        "statusMessage": "Not Found",
        ...
    }
```

Because the actual indices are available under `Packages.xz`:

```
https://deb.debian.org/debian/dists/bookworm-backports/main/binary-amd64/Packages.xz
```

## Expected behavior

As stated by the [Debian authors](https://wiki.debian.org/DebianRepository/Format#line-58) "clients **must support xz compression**, and must support gzip and bzip2 if they want to use the files that are listed as usual use cases of these formats".

However, Renovate has the compression algorithm hard-coded, always attempting to retrieve `Packages.gz`. See [renovate source code](https://github.com/renovatebot/renovate/blob/5ae1c39da72306660e12a7ceaf694fbedb3e4dd1/lib/modules/datasource/deb/index.ts#L74):
```typescript
const compression = 'gz';
```

Ideally, Renovate should dynamically detect or try multiple compression formats (i.e., xz, bzip2, and gz) when fetching Debian package indices.
