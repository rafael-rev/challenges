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
        // Output array
        List<String> outputArr = new ArrayList<>();
        // Parse sentence into words, each into array

        String[] inpArr = input.split(" ");

        for(String x : inpArr){
            String remainingStr = x.substring(1);
            char firstChar = x.charAt(0);
            outputArr.add(remainingStr+firstChar+"ay");
        }
        String finalOut = String.join(" ", outputArr);
        System.out.println(finalOut);
    }
}
