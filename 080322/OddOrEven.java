import java.util.Scanner;

public class OddOrEven {
    public static void main(String[] args){
        Integer input;
        Scanner scanner = new Scanner(System.in);

        System.out.print("Please enter a number to check: ");
        input = scanner.nextInt();
        scanner.close();

        if(input % 2 == 0){
            System.out.println("The number "+input+" is EVEN!");
        }else{
            System.out.println("The number "+input+" is ODD!");
        }
    }
}