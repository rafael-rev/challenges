package com.raf;

import java.util.Scanner;

import com.raf.platin.PigLatin;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Please enter a sentence to PigLatin-ize: ");
        String inputString = scanner.nextLine();
        System.out.println("RESULT: "+PigLatin.encode(inputString));
        scanner.close();
    }
}
