open(aminoAcids, "NP_068799.fasta") or die("Couldn't open Amino Acids file"); # Opens file to edit
my %proteinCounts = ("A",0,"C",0,"D",0,"E",0,"F",0,"G",0,"H",0,"I",0,"K",0,"L",0,"M",0, # Declares and initializes the hash
		"N",0,"P",0,"Q",0,"R",0,"S",0,"T",0,"V",0,"W",0,"Y",0);

# Gets rid of the newline characters
chomp(my @protein = <aminoAcids>);
 
# Gets rid of the header line
shift @protein; 

# Splits and joins the array
$protein = join "", @protein; # Make it one string 
@protein = split ('', $protein);

# Counts up appearances of each acid
foreach $acid(@protein) {
	$proteinCounts{$acid}++;
}

# Counts up number of acids that didn't appear and prints the others in
# alphabetical order
my $counter;
my $lettersNotAppearing = "";
foreach $value (sort keys %proteinCounts)
{
	if( $proteinCounts{$value} == 0) {
		$counter++;
		$lettersNotAppearing .= "$value ";
	}
    print "$value $proteinCounts{$value} ";
}

# Prints how many acids appeared and which ones didn't
print "\nNumber of different amino acids: ", (keys %proteinCounts) - $counter, "\nNo occurrences of: $lettersNotAppearing\n";

# Prints each acid in greatest-to-least order of appearance
foreach $value (reverse sort {$proteinCounts{$a} cmp $proteinCounts{$b} }
           keys %proteinCounts)
{
    print "$value $proteinCounts{$value} ";
}

 