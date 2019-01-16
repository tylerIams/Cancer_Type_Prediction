
package data_science_iii_final_project;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;


public class Read_CSV {
 
    String file;
    ArrayList<String> dataList = new ArrayList<>();
    
    public Read_CSV(String file) throws FileNotFoundException, UnsupportedEncodingException, IOException {
        this.file = file;
        Read(file);  
    }
    
    private void Read(String f) throws FileNotFoundException, UnsupportedEncodingException, IOException {
            
        
        BufferedReader bufferedReader = new BufferedReader(
                new InputStreamReader(new FileInputStream(f), "ISO-8859-1"));
            
            
        ArrayList<String> data = new ArrayList<>();
        
        String line;
        while ((line = bufferedReader.readLine()) != null) {
            data.add(line);
        }
        
    setDataList(data);
        
    }
    
    private void setDataList(ArrayList<String> d) {
        dataList = d;
    }
    
    public ArrayList<String> getDataList() {
        return dataList;
    }
    
}
