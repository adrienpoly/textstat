# Texstat 
Ruby gem to calculate statistics from text to determine readability, complexity and grade level of a particular corpus.

Translation based on Python textstat library by @shivam5992 and other contributors. Thanks for making this world more open sourced :heart:

## Usage

```ruby
require 'textstat'

test_data = %(
         Playing games has always been thought to be important to 
        the development of well-balanced and creative children 
        however, what part, if any, they should play in the lives 
        of adults has never been researched that deeply. I believe 
        that playing games is every bit as important for adults 
        as for children. Not only is taking time out to play games 
        with our children and other adults valuable to building 
        interpersonal relationships but is also a wonderful way 
        to release built up tension.
)


TextStat.flesch_reading_ease(test_data)
TextStat.smog_index(test_data)
TextStat.flesch_kincaid_grade(test_data)
TextStat.coleman_liau_index(test_data)
TextStat.automated_readability_index(test_data)
TextStat.dale_chall_readability_score(test_data)
TextStat.difficult_words(test_data)
TextStat.linsear_write_formula(test_data)
TextStat.gunning_fog(test_data)
TextStat.text_standard(test_data)
```

The argument (text) for all the defined functions remains the same -
i.e the text for which statistics need to be calculated.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'textstat'
```

And then execute:

     bundle

Or install it yourself as:

     gem install textstat
## List of Functions

### Syllable Count

```ruby
TextStat.syllable_count(text, lang='en_us')
```

Returns the number of syllables present in the given text.

Uses the Ruby gem [text-hyphen](https://github.com/halostatue/text-hyphen)
for syllable calculation. Optional `language` specifies to
text-hyphen which language dictionary to use.

Default is `'en_us'`, other languages should have their own dictionaries for easy words (TODO).


### Lexicon Count

```ruby
TextStat.lexicon_count(text, remove_punctuation = true)
```

Calculates the number of words present in the text.
Optional `removepunct` specifies whether we need to take
punctuation symbols into account while counting lexicons.
Default value is `True`, which removes the punctuation
before counting lexicon items.

### Sentence Count

```ruby
TextStat.sentence_count(text)
```

Returns the number of sentences present in the given text.


### The Flesch Reading Ease formula

```ruby
TextStat.flesch_reading_ease(text)
```

Returns the Flesch Reading Ease Score.

The following table can be helpful to assess the ease of
readability in a document.

The table is an _example_ of values. While the
maximum score is 121.22, there is no limit on how low
the score can be. A negative score is valid.

| Score |    Difficulty     |
|-------|-------------------|
|90-100 | Very Easy         |
| 80-89 | Easy              |
| 70-79 | Fairly Easy       |
| 60-69 | Standard          |
| 50-59 | Fairly Difficult  |
| 30-49 | Difficult         |
| 0-29  | Very Confusing    |

> Further reading on
[Wikipedia](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests#Flesch_reading_ease)

### The Flesch-Kincaid Grade Level

```ruby
TextStat.flesch_kincaid_grade(text)
```

Returns the Flesch-Kincaid Grade of the given text. This is a grade
formula in that a score of 9.3 means that a ninth grader would be able to
read the document.

> Further reading on
[Wikipedia](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests#Flesch%E2%80%93Kincaid_grade_level)

### The Fog Scale (Gunning FOG Formula)

```ruby
TextStat.gunning_fog(text)
```

Returns the FOG index of the given text. This is a grade formula in that
a score of 9.3 means that a ninth grader would be able to read the document.

> Further reading on
[Wikipedia](https://en.wikipedia.org/wiki/Gunning_fog_index)

### The SMOG Index

```ruby
TextStat.smog_index(text)
```

Returns the SMOG index of the given text. This is a grade formula in that
a score of 9.3 means that a ninth grader would be able to read the document.

Texts of fewer than 30 sentences are statistically invalid, because
the SMOG formula was normed on 30-sentence samples. textstat requires atleast
3 sentences for a result.

> Further reading on
[Wikipedia](https://en.wikipedia.org/wiki/SMOG)

### Automated Readability Index

```ruby
TextStat.automated_readability_index(text)
```

Returns the ARI (Automated Readability Index) which outputs
a number that approximates the grade level needed to
comprehend the text.

For example if the ARI is 6.5, then the grade level to comprehend
the text is 6th to 7th grade.

> Further reading on
[Wikipedia](https://en.wikipedia.org/wiki/Automated_readability_index)

### The Coleman-Liau Index

```ruby
TextStat.coleman_liau_index(text)
```

Returns the grade level of the text using the Coleman-Liau Formula. This is
a grade formula in that a score of 9.3 means that a ninth grader would be
able to read the document.

> Further reading on
[Wikipedia](https://en.wikipedia.org/wiki/Coleman%E2%80%93Liau_index)

### Linsear Write Formula

```ruby
TextStat.linsear_write_formula(text)
```

Returns the grade level using the Linsear Write Formula. This is
a grade formula in that a score of 9.3 means that a ninth grader would be
able to read the document.

> Further reading on
[Wikipedia](https://en.wikipedia.org/wiki/Linsear_Write)

### Dale-Chall Readability Score

```ruby
TextStat.dale_chall_readability_score(text)
```

Different from other tests, since it uses a lookup table
of the most commonly used 3000 English words. Thus it returns
the grade level using the New Dale-Chall Formula.

| Score       |  Understood by                                |
|-------------|-----------------------------------------------|
|4.9 or lower | average 4th-grade student or lower            |
|  5.0–5.9    | average 5th or 6th-grade student              |
|  6.0–6.9    | average 7th or 8th-grade student              |
|  7.0–7.9    | average 9th or 10th-grade student             |
|  8.0–8.9    | average 11th or 12th-grade student            |
|  9.0–9.9    | average 13th to 15th-grade (college) student  |

> Further reading on
[Wikipedia](https://en.wikipedia.org/wiki/Dale%E2%80%93Chall_readability_formula)

### Readability Consensus based upon all the above tests

```ruby
TextStat.text_standard(text, float_output=False)
```

Based upon all the above tests, returns the estimated school
grade level required to understand the text.

Optional `float_output` allows the score to be returned as a
`float`. Defaults to `False`.


## TODO

- [ ] LRU Cache support

Easy words (~2000):
- [x] Catalan
- [x] Czech
- [x] Danish
- [ ] US English and UK English independently
- [x] Spanish
- [x] Estonian
- [x] Finnish
- [x] French
- [ ] Irish Gaelic
- [ ] Croatian
- [ ] Upper Sorbian
- [x] Hungarian
- [ ] Interlingua
- [x] Indonesian
- [x] Icelandic
- [x] Italian
- [x] Latin
- [ ] Mongolian
- [x] Dutch (Nederlande)
- [ ] Nynorsk (Norwegian)
- [x] Bokmål (Norwegian)
- [x] Polish
- [x] Portuguese
- [x] Russian
- [x] Swedish

## Contributing

If you find any problems, you should open an
[issue](https://github.com/kupolak/textstat/issues).

If you can fix an issue you've found, or another issue, you should open
a [pull request](https://github.com/kupolak/textstat/pulls).

1. Fork this repository on GitHub to start making your changes to the master
branch (or branch off of it).
2. Write a test which shows that the bug was fixed or that the feature works as expected.
3. Send a pull request!

### Development setup

```bash
git clone https://github.com/kupolak/textstat.git  # Clone the repo from your fork
cd textstat
bundle  # Install all dependencies

# Make changes
rspec spec  # Run tests
```
