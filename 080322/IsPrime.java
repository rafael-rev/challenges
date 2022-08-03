import java.util.Scanner;

public class IsPrime {
    public static void main(String[] args){
        Integer input;
        Scanner scanner = new Scanner(System.in);

        System.out.print("Please enter a number to check: ");
        input = scanner.nextInt();
        scanner.close();

        if(input <= 1){
            System.out.println("false");
        }
        else if(input == 2 || input == 3){
            System.out.println("true");
        }
        else if(input % 2 == 0 || input % 3 == 0 || input % 7 == 0 || input % 5 == 0){
            System.out.println("false");
        }
        else{
            System.out.println("true");
        }
    }
}
