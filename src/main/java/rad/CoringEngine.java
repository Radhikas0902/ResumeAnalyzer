package rad;

import opennlp.tools.postag.POSModel;
import opennlp.tools.postag.POSTaggerME;
import opennlp.tools.tokenize.Tokenizer;
import opennlp.tools.tokenize.TokenizerModel;

import java.io.InputStream;
import java.util.*;

public class CoringEngine {

    private static final Set<String> STOPWORDS = Set.of(
        "the", "is", "at", "which", "on", "a", "an", "and", "in", "to", "for", "of", "with", "as", "by"
    );

    public static List<String> extractKeywords(String text) {
        List<String> keywords = new ArrayList<>();
        try (
            InputStream tokenModelIn = CoringEngine.class.getResourceAsStream("/models/en-token.bin");
            InputStream posModelIn = CoringEngine.class.getResourceAsStream("/models/en-pos-maxent.bin")
        ) {
            TokenizerModel tokenModel = new TokenizerModel(tokenModelIn);
            Tokenizer tokenizer = new opennlp.tools.tokenize.TokenizerME(tokenModel);
            String[] tokens = tokenizer.tokenize(text.toLowerCase());

            POSModel posModel = new POSModel(posModelIn);
            POSTaggerME tagger = new POSTaggerME(posModel);
            String[] tags = tagger.tag(tokens);

            for (int i = 0; i < tokens.length; i++) {
                String word = tokens[i];
                String tag = tags[i];
                if ((tag.startsWith("NN") || tag.startsWith("VB") || tag.startsWith("JJ")) && !STOPWORDS.contains(word)) {
                    if (!keywords.contains(word)) {
                        keywords.add(word);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return keywords;
    }

    public static int calculateATIScore(List<String> resumeKeywords, List<String> jobKeywords) {
        int matchedCount = 0;
        for (String keyword : jobKeywords) {
            if (resumeKeywords.contains(keyword)) {
                matchedCount++;
            }
        }
        return jobKeywords.isEmpty() ? 0 : (int) (((double) matchedCount / jobKeywords.size()) * 100);
    }

    public static List<String> extractMissingKeywords(List<String> resumeKeywords, List<String> jobKeywords) {
        List<String> missing = new ArrayList<>();
        for (String keyword : jobKeywords) {
            if (!resumeKeywords.contains(keyword)) {
                missing.add(keyword);
            }
        }
        return missing;
    }
}
