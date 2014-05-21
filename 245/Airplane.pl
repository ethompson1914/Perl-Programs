# Eric Thompson
# I had some help from John Stathakis and Tim Cooke

# Variables
my $numberOfSeats;
my @initialSeatAssignments;
my @seatsTaken;
my @occupiedSeats;
my $timesCorrect   = 0.0;
my $percentCorrect = 0.0;

$numberOfSeats = $ARGV[0];
$numRuns       = $ARGV[1];

# Multiple runs
for ( $runs = 0 ; $runs < $numRuns ; $runs++ ) {

	for ( $k = 0 ; $k < $numberOfSeats ; $k++ ) {
		$initialSeatAssignments[$k] = $k;
	}
	
	# Doesn't work yet
#	# Shuffles the initialSeatAssignments
#	for ( $b = 0 ; $b < $numberOfSeats ; $b++ ) {
#		my $numberChosen = 0;
#		while (!$numberChosen) {
#			my $randomTest = int(rand(@_[0]));
#			if (!($randomTest ~~ @initialSeatAssignments)) {
#				$numberChosen = 1;
#				$initialSeatAssignments[$b] = $randomTest;
#			}
#		}
#		
#	}

	# Initializes seatsTaken array to all 0s
	for ( $k = 0 ; $k <= $numberOfSeats ; $k++ ) {
		$seatsTaken[$k] = 0;
	}

	# Initializes seatsTaken array to all 0s
	for ( $k = 0 ; $k <= $numberOfSeats ; $k++ ) {
		$initialSeatAssignments[$k] = $k;
	}

	# First person takes a random seat
	$randomSeat = int( rand($numberOfSeats) ) + 1;
	$seatsTaken[$randomSeat] = 1;

	for ( $f = 2 ; $f <= $numberOfSeats ; $f++ ) {

		if ( $seatsTaken[ $initialSeatAssignments[$f] ] == 0 ) {
			$seatsTaken[ $initialSeatAssignments[$f] ] = $f;
		}
		else {
			$lookingForSeat = 1;
			while ( $lookingForSeat == 1 ) {
				$randomSeat = int( rand($numberOfSeats) ) + 1;
				if ( $seatsTaken[$randomSeat] == 0 ) {
					$seatsTaken[$randomSeat] = $f;
					$lookingForSeat = 0;
				}
			}
		}
	}	

	# Whether or not the last person sat in his assigned seat
	if ( $seatsTaken[$numberOfSeats] == $numberOfSeats ) {
		$timesCorrect++;
	}
}

# Calculates the number of times the last person sat in his assigned seat
$percentCorrect = $timesCorrect / $numRuns * 100;

# Output
print "The last person sat in his seat ", $percentCorrect,
  " percent of the time.";
