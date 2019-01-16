
package data_science_iii_final_project;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class Write_CSV {
    
    public Write_CSV(ArrayList<String> muts, String fileName) throws FileNotFoundException {
        
        System.out.println("HERE");
        
        PrintWriter pw = new PrintWriter(new File(fileName));
        StringBuilder sb = new StringBuilder();
        
        sb.append("cancer_type");
        sb.append(',');
        sb.append("gene");
        sb.append(',');
        sb.append("cancer_type");
        sb.append(',');
        sb.append("genomic_dna_change");
        sb.append(',');
        sb.append("cancer_type");
        sb.append('\n');
        
        
        for (String line : muts) {
            sb.append("leukemia");
            sb.append(',');
            sb.append(line);
        }
        
        pw.write(sb.toString());
        pw.close();
        
    }
    
}
