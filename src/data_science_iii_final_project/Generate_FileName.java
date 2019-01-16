
package data_science_iii_final_project;

import java.util.ArrayList;

public class Generate_FileName {
    
    ArrayList<String> fileName = new ArrayList<>();
    String begFName = "mutations.";
    String date;
    String folder;
        
    public Generate_FileName(String date, String folder) {
        this.date = date;
        this.folder = folder;
        assembleTitle();
    }
    
    // Assemble the rest of the title
    
    private void assembleTitle() {
        
        for (int i = 0; i <= 97; i++) {
            if (i == 0) {
                String n = folder + "/" + begFName + date + ".txt";
                fileName.add(n);
            }
            
            else {
               String number = Integer.toString(i);
               String n = folder + "/" + begFName + date + " (" + number + ").txt";
               fileName.add(n);
            }
        }     
    }
    
    public ArrayList<String> getTitleList() {
        return fileName;
    }
    
    
}
