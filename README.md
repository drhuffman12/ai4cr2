# ai4cr2

The CURRENT 

```sh
shards version
```

.. SHOULD MATCH ..

```output
# to be automated...
0.2.1i
```

[![Crystal CI](https://github.com/drhuffman12/ai4cr2/actions/workflows/crystal.yml/badge.svg)](https://github.com/drhuffman12/ai4cr2/actions/workflows/crystal.yml)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     ai4cr2:
       github: drhuffman12/ai4cr2
   ```

2. Run `shards install`

## Usage

```crystal
require "ai4cr2"
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. FORK it (<https://github.com/drhuffman12/ai4cr2/fork>)
2. Make sure you are on the main/master BRANCH (`git branch`  `git reset --hard; git checkout master; git pull origin master`)
3. Create your FEATURE branch (`git checkout -b my-new-feature`)
4. TEST existing changes!!! (`crystal spec --error-trace`)
5. VERIFY your "Changes to be committed" (`git status`)
6. *** (Please) correctly update the VERSION!!! (Edit/Syncup `src/ai4cr2/about.cr` and `shard.yml` and in the notes above, under "SHOULD MATCH")
7. ADD your CHANGES (`git add my-new-files`)
7. Update and VERSION your changes (`git add README.md; git add shard.yml; git add src/ai4cr2/about.cr`)
9. TEST your changes!!! (`crystal spec --error-trace`)
10. COMMIT your changes to your new branch (`git commit -am 'my-new-feature description'`)
11. PUSH to the branch (`git push origin my-new-feature`)
12. Create a new Pull Request, get it Approved, and Merge it!

## Contributors

- [Daniel Huffman](https://github.com/drhuffman12) - creator and maintainer
