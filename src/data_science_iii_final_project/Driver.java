
package data_science_iii_final_project;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;


public class Driver {

    public static void main(String[] args) throws UnsupportedEncodingException, IOException {
        
        ArrayList<String> files = new ArrayList<>();
        ArrayList<String> data = new ArrayList<>();
        ArrayList<String> writeMe = new ArrayList<>();
        
        // Read in file
        
        String date = "2018-05-28";
        String dataType = "mutations";
        String cancerType = "lung";
        String page = "p2";
        String folder = dataType + "_" + cancerType + "_" + page;
        
        Generate_FileName fileList = new Generate_FileName(date, folder);
        
        files = fileList.getTitleList();
        
        
        int x = 0;
        for (String line : files) {
            x++;
            System.out.println("file: " + line);
            Read_CSV reader = new Read_CSV(line);
            data = reader.getDataList();
            ParseData parse = new ParseData(data);
            writeMe = parse.getMutations();
            String fileName = "file" + Integer.toString(x) + ".csv";
            Write_CSV write = new Write_CSV(writeMe, fileName);
        }
               
        
        // Let me know how many mutations are in it
        
        //  Write the mutations out to file
        
        
    }
    
}
