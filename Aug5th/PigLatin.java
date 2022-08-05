package Aug5th;
import java.util.Scanner;

public class PigLatin {
    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        // get input
        System.out.print("Please enter a word to convert: ");
        String input = scanner.nextLine();
        scanner.close();
        // parse the string
        String remainingStr = input.substring(1);
        char firstChar = input.charAt(0);
        // recombine string
        System.out.println(remainingStr+firstChar+"ay");

        

    }
}
