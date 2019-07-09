## LangSearch

Search programming languages by input values. Application presents a list of popular programming languages

> JSON file used as database
> Ruby version 2.5.5
> Rails version 5.2.3

### How to start?
  `git clone or download`

  `cd langSearch`

  `rails s`

 Type your text into input field and press `GO` to get the result of searched languages

### Simple examples:

  * input value `Thomas` return `BASIC` and `HASKELL`

  * input value `Thomas Eugen` return `BASIC`

  * input value `Thomas Eugen -basic` return `Not found :(`

  * input value `Thomas -basic` return `HASKELL`
