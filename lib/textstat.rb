require 'text-hyphen'

class TextStat
  def self.char_count(text, ignore_spaces = true)
    text = text.delete(' ') if ignore_spaces
    text.length
  end

  def self.lexicon_count(text, remove_punctuation = true)
    text  = text.gsub(/[^a-zA-Z\s]/, '').squeeze(' ') if remove_punctuation
    count = text.split(' ').count
    count
  end

  def self.syllable_count(text, language = 'en_us')
    return 0 if text.empty?

    text = text.downcase
    text.gsub(/[^a-zA-Z\s]/, '').squeeze(' ')
    dictionary = Text::Hyphen.new(language: language, left: 0, right: 0)
    count = 0
    text.split(' ').each do |word|
      word_hyphenated = dictionary.visualise(word)
      count += [1, word_hyphenated.count('-') + 1].max
    end
    count
  end

  def self.sentence_count(text)
    text.scan(/[\.\?!][\'\\)\]]*[ |\n][A-Z]/).map(&:strip).count + 1
  end

  def self.avg_sentence_length(text)
    asl = lexicon_count(text).to_f / sentence_count(text).to_f
    asl.round(1)
  rescue ZeroDivisionError
    0.0
  end

  def self.avg_syllables_per_word(text)
    syllable = syllable_count(text)
    words    = lexicon_count(text)
    begin
      syllables_per_word = syllable.to_f / words.to_f
      return syllables_per_word.round(1)
    rescue ZeroDivisionError
      return 0.0
    end
  end

  def self.avg_letter_per_word(text)
    letters_per_word = char_count(text).to_f / lexicon_count(text).to_f
    letters_per_word.round(2)
  rescue ZeroDivisionError
    0.0
  end

  def self.avg_sentence_per_word(text)
    sentence_per_word = sentence_count(text).to_f / lexicon_count(text).to_f
    sentence_per_word.round(2)
  rescue ZeroDivisionError
    0.0
  end

  def self.flesch_reading_ease(text)
    sentence_length    = avg_sentence_length(text)
    syllables_per_word = avg_syllables_per_word(text)
    flesch = (
    206.835 - (1.015 * sentence_length).to_f - (84.6 * syllables_per_word).to_f
    )
    flesch.round(2)
  end

  def self.flesch_kincaid_grade(text)
    sentence_length = avg_sentence_length(text)
    syllables_per_word = avg_syllables_per_word(text)
    flesch = (0.39 * sentence_length.to_f) + (11.8 * syllables_per_word.to_f) - 15.59
    flesch.round(1)
  end

  def self.polysyllab_count(text)
    count = 0
    text.split(' ').each do |word|
      w = syllable_count(word)
      count += 1 if w >= 3
    end
    count
  end

  def self.smog_index(text)
    sentences = sentence_count(text)

    if sentences >= 3
      begin
        polysyllab = polysyllab_count(text)
        smog = (
        (1.043 * (30 * (polysyllab / sentences))**0.5) + 3.1291)
        return smog.round(1)
      rescue ZeroDivisionError
        return 0.0
      end
    else
      return 0.0
    end
  end

  def self.coleman_liau_index(text)
    letters   = (avg_letter_per_word(text) * 100).round(2)
    sentences = (avg_sentence_per_word(text) * 100).round(2)
    coleman   = ((0.058 * letters) - (0.296 * sentences) - 15.8).to_f
    coleman.round(2)
  end
end