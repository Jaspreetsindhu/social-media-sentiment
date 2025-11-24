PROJECT: Social Media Sentiment Analysis (Prolog Lexicon-Based) 











OVERVIEW

This project implements a foundational Sentiment Analysis system using Prolog, leveraging its strengths in symbolic programming and rule-based inference. Instead of traditional machine learning, this system classifies text sentiment (Positive, Negative, or Neutral) based on a predefined sentiment lexicon and logical rules, including basic negation handling.

This implementation is ideal for demonstrating logical AI concepts and simple, transparent sentiment classification.


FEATURES

. Lexicon-Based Scoring: Uses a predefined set of positive and negative words (facts) to score text.
. Rule-Based Classification: Employs logical rules to categorize the total score as Positive, Negative, or Neutral.
. Negation Handling: Includes rules to invert the sentiment score when negation words (e.g., not, never) precede a sentiment word.
. Tokenization Utility: Provides an optional utility predicate (analyze_text/2) to easily process raw text strings (requires compatible Prolog environment like SWI-Prolog).



TECHNOLOGY STACK


. Language: Prolog
. Prolog Implementation: Any standard Prolog interpreter (e.g., SWI-Prolog is recommended, especially for the string utilities in analyze_text/2).



INSTALLATION AND SETUP


. Install Prolog: Ensure a Prolog interpreter (e.g., SWI-Prolog) is installed on your system.
. Save the Code: Save the provided Prolog code into a file named sentiment_analysis.pl.
. Load the File: Open your Prolog interpreter and consult the file:

Prolog
?- consult('sentiment_analysis.pl').



USAGE (Querying the System)


Once the file is loaded, you can query the system using the main predicates:

1. Basic List Analysis (classify_sentiment/2)
This predicate takes a list of pre-tokenized, lowercased words (atoms) and returns the sentiment.

Example Query,Description,Expected Output
"?- classify_sentiment([this, product, is, great], S).",Direct positive word count.,S = positive
"?- classify_sentiment([i, hate, that, slow, service], S).",Direct negative word count.,S = negative
"?- classify_sentiment([it, was, good, but, disappointing], S).","Balanced sentiment (1 Positive, 1 Negative).",S = neutral
"?- classify_sentiment([the, phone, is, not, good], S).",Test of the negation rule (not good -> Negative).,S = negative



2. String Analysis (analyze_text/2)
(Requires SWI-Prolog or similar string handling features.) This predicate takes a standard quoted text string and handles tokenization and lowercasing before classification.

Prolog
?- analyze_text('This product is absolutely amazing! Highly recommend.', Sentiment).
Sentiment = positive.

?- analyze_text('I never said it was bad; it was just slow.', Sentiment).
Sentiment = positive. % 'never bad' -> Positive



CORE RULES SUMMARY


The classification relies on the NetScore, which is calculated as $P_{Score} - N_{Score}

Net Score Condition,Sentiment,Prolog Rule
NetScore>0,Positive,NetScore > 0 -> Sentiment = positive
NetScore<0,Negative,NetScore < 0 -> Sentiment = negative
NetScore=0,Neutral,Sentiment = neutral



PROJECT FILES


social-media-sentiment-analysis/
├── sentiment_analysis.pl      # The core Prolog code (Lexicon, Scoring Rules, Classification)
└── README.md



EXTENDING THE LEXICON

To improve accuracy, you can easily expand the knowledge base by adding more facts to sentiment_analysis.pl:

Prolog
% Example additions
positive(superb).
negative(useless).
negation_word(hardly). 
