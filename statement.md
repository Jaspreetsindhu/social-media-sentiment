STATEMENT FILE: Prolog Sentiment Analyzer 











📄1. ⚙️ PROGRAM IDENTIFICATION


. File Name: sentiment_analysis.pl
. Purpose: Sentiment Analysis Classification (Positive, Negative, Neutral)
. Methodology: Lexicon-Based, Rule-Driven Inference
. Language: Prolog (Recommended Interpreter: SWI-Prolog)



2. 💡 CONCEPTUAL DESIGN


The system operates based on logical facts (the sentiment lexicon) and rules defined to calculate a Net Sentiment Score for a given list of tokens.

A. Lexicon (Facts)
The core knowledge base consists of:
               . positive/1: Defines words that contribute $+1$ to the score.
               . negative/1: Defines words that contribute $-1$ to the score.
               . negation_word/1: Defines words that invert the sentiment of the following word (e.g., "not bad" $\rightarrow$ Positive).
               
               
               
B. Scoring Logic (Rules)

The recursive predicate count_sentiment_score/3 calculates the total positive and negative counts. The logic includes an advanced rule to handle negation, where a negated positive word counts as $-1$, and a negated negative word counts as $+1$.


C. Final Classification

The classify_sentiment/2 rule determines the final label by comparing $P_{Score}$ and $N_{Score}$:
                                   
                                   $$NetScore = P_{Score} - N_{Score}$$
                                   
. If $NetScore > 0$: Positive
. If $NetScore < 0$: Negative
. If $NetScore = 0$: NeutralShutterstock



3. 🔑 KEY PREDICATES



Predicate,Arity,Description,Usage Example
classify_sentiment,2,Main classifier. Takes a list of atoms (tokens) and returns the sentiment atom.,"?- classify_sentiment([it, was, great], S)."
count_sentiment_score,3,Internal rule. Recursively calculates total positive and negative scores from a list of tokens.,"?- count_sentiment_score([good, bad], P, N)."
analyze_text,2,Utility (SWI-Prolog specific). Takes a raw text string and returns the sentiment.,"?- analyze_text('I love it.', S)."



4. 📝 MAINTENANCE AND EXTENSION


To improve the model's performance and coverage:

1. Lexicon Expansion: Add more domain-specific facts to positive/1 and negative/1.
2. Intensity Handling: Add rules for intensity modifiers (e.g., very, extremely) to potentially multiply the score (e.g., very good $\rightarrow +2$).
3. Stop Word Filtering: Implement an explicit rule to filter common stop words before classification for efficiency.
