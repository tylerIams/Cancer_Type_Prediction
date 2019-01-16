package data_science_iii_final_project;

import java.util.ArrayList;

public class ParseData {

    ArrayList<String> dat = new ArrayList<>();
    ArrayList<String> mutation = new ArrayList<>();

    public ParseData(ArrayList<String> data) {
        dat = data;
        Parse();
    }

    private void Parse() {
        int x = 0;
        for (String line : dat) {

            if (line.contains("symbol") && x == 0) {
                mutation.add(line);
                x++;
            }
            
            if (line.contains("genomic_dna_change")) {
                mutation.add(line);
                mutation.add("\n");
                x = 0;
            }
        }
 
    }

    public ArrayList<String> getMutations() {
    return mutation;
    }
    
    
}
