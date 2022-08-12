package com.raf.platin;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;


public class PigLatin {
    public static String encode(String sentence){
        List<String> outputArr = new ArrayList<>();
        // Parse sentence into words, each into array
        String[] inpArr = sentence.split(" ");
        for(String x : inpArr){
            if(x.endsWith(".") || x.endsWith("!") || x.endsWith("?")){
                return "Invalid input.";
            }else{
                StringBuilder sb = new StringBuilder(x);
                sb.deleteCharAt(0).append(x.charAt(0) + "ay");
                outputArr.add(sb.toString());
            }
        }
        String finalOut = String.join(" ", outputArr);
        return finalOut;
    }
}
