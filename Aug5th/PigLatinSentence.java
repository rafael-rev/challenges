package Aug5th;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;


public class PigLatinSentence {
    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        // get input
        System.out.print("Please enter a space separated sentence to convert: ");
        String input = scanner.nextLine();
        scanner.close();
        
        System.out.println(sentenceToPigLatin(input));
    }

    public static String sentenceToPigLatin(String sentence){
        List<String> outputArr = new ArrayList<>();
        // Parse sentence into words, each into array
        String[] inpArr = sentence.split(" ");

        for(String x : inpArr){
            StringBuilder sb = new StringBuilder(x);
            sb.deleteCharAt(0).append(x.charAt(0) + "ay");
            outputArr.add(sb.toString());
        }
        String finalOut = String.join(" ", outputArr);
        return finalOut;
    }
}
