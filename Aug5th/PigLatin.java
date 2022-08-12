package Aug5th;
import java.util.Scanner;

public class PigLatin {
    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        // get input
        System.out.print("Please enter a word to convert: ");
        String input = scanner.nextLine();
        scanner.close();
        System.out.println(toPigLatin(input));
        
    }

    public static String toPigLatin(String word){
        StringBuilder sb = new StringBuilder(word);
        
        sb.deleteCharAt(0).append(word.charAt(0) + "ay");
        return sb.toString();
    }
}
