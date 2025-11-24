Prolog Sentiment Analyzer (sentiment_analysis.pl)


1. 📚 Sentiment Lexicon (Facts)

This section defines the core knowledge base: facts about which words are generally positive or negative. Neutral words are typically ignored by these rules.

Prolog
% --- Sentiment Lexicon ---

% positive(Word). - Facts defining positive words
positive(excellent).
positive(great).
positive(amazing).
positive(happy).
positive(love).
positive(best).
positive(recommend).
positive(good).
positive(awesome).
positive(fantastic).

% negative(Word). - Facts defining negative words
negative(bad).
negative(terrible).
negative(worst).
negative(hate).
negative(awful).
negative(disappointing).
negative(poor).
negative(slow).
negative(broken).
negative(problem).

% --- Utility Facts ---
% negation_word(Word). - Words that can invert the sentiment of the following word
negation_word(not).
negation_word(never).
negation_word(no).



2. 📝 Sentiment Scoring Rules

This section contains the core logic rules for calculating the sentiment score of a given list of words (a "Tweet").

A. Basic Scoring
The simplest rule counts positive and negative words.

Prolog
% count_sentiment_score(WordList, PosScore, NegScore).
% Recursively counts positive and negative words in a list.

count_sentiment_score([], 0, 0). % Base case: empty list has 0 score

count_sentiment_score([Word|Rest], PosScore, NegScore) :-
    positive(Word),
    count_sentiment_score(Rest, PosRest, NegRest),
    PosScore is PosRest + 1,
    NegScore is NegRest.

count_sentiment_score([Word|Rest], PosScore, NegScore) :-
    negative(Word),
    count_sentiment_score(Rest, PosRest, NegRest),
    PosScore is PosRest,
    NegScore is NegRest + 1.

% Ignore neutral/unknown words
count_sentiment_score([_|Rest], PosScore, NegScore) :-
    \+ positive(_),
    \+ negative(_),
    count_sentiment_score(Rest, PosScore, NegScore).


B. Negation Handling (Advanced Rule)
This rule modifies the score if a negation word precedes a sentiment word (e.g., "not good" becomes negative).

Prolog
% --- Negation Handling (e.g., "not great" is negative) ---

% Special rule for [Negation, SentimentWord | Rest]
count_sentiment_score([Neg, Word|Rest], PosScore, NegScore) :-
    negation_word(Neg),
    positive(Word),
    % Treat "not positive" as one negative point
    count_sentiment_score(Rest, PosRest, NegRest),
    PosScore is PosRest,
    NegScore is NegRest + 1.

count_sentiment_score([Neg, Word|Rest], PosScore, NegScore) :-
    negation_word(Neg),
    negative(Word),
    % Treat "not negative" (double negative) as one positive point
    count_sentiment_score(Rest, PosRest, NegRest),
    PosScore is PosRest + 1,
    NegScore is NegRest.

3. ⚖️ Final Classification Rule
This rule uses the calculated scores to determine the final sentiment label.

Prolog
% --- Main Prediction Rule ---

% classify_sentiment(WordList, Sentiment).
% This is the main predicate the user will query.

classify_sentiment(WordList, Sentiment) :-
    % 1. Calculate the final scores
    count_sentiment_score(WordList, PosScore, NegScore),
    
    % 2. Determine the Net Score
    NetScore is PosScore - NegScore,
    
    % 3. Apply classification logic
    (
        NetScore > 0 -> Sentiment = positive ; % More positive points
        NetScore < 0 -> Sentiment = negative ; % More negative points
        Sentiment = neutral                     % Scores are equal or zero
    ).



4. ⌨️ Utility for Input (Pre-processing)

This predicate helps the user easily convert a sentence string into a list of words (tokens). Note: This requires external Prolog libraries or built-in functions like atom_chars and split_string which may vary by Prolog implementation (SWI-Prolog often works well).

Prolog
% --- Input Utility ---

% analyze_text(TextString, Sentiment).
% Takes a string (TextString) and gives the final Sentiment.
analyze_text(TextString, Sentiment) :-
    % Convert string to lowercase and split into a list of words (tokens)
    % This part is highly implementation-specific (using SWI-Prolog style)
    string_lower(TextString, LowerText),
    split_string(LowerText, " ", "", RawWords),
    % Convert atoms back to a list of tokens/atoms for processing
    maplist(atom_string, Tokens, RawWords),
    
    % Call the main classification predicate
     classify_sentiment(Tokens, sentiment)


How to Query the System

After loading the file (e.g., consult('sentiment_analysis.pl').), you can run queries like this:

Query (Example),Expected Logic,Expected Output
"classify_sentiment([this, product, is, great, not, bad], S).","Pos: 2, Neg: 0. Net: +2",S = positive
"classify_sentiment([i, hate, the, slow, service], S).","Pos: 0, Neg: 2. Net: -2",S = negative
"classify_sentiment([it, was, good, but, disappointing], S).","Pos: 1, Neg: 1. Net: 0",S = neutral
"classify_sentiment([not, great], S).",Negation flips 'great' to negative. Net: -1,S = negative
"analyze_text('I absolutely love this new phone!', S).",(Uses the string utility),S = positive
