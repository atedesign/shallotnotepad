#!/usr/local/bin/perl
#!/C:/Perl/site/lib
use Tk;
use utf8;
use vars qw/$TOP/;

# Main Window
my $mw = new MainWindow;

#Making a text area
my $txt = $mw -> Scrolled('Text', -width => 50,-scrollbars=>'e') -> pack (), -setgrid => true;

#Declare that there is a menu
my $mbar = $mw -> Menu();
$mw -> configure(-menu => $mbar);

#The Main Buttons
my $file = $mbar -> cascade(-label=>"File", -underline=>0, -tearoff => 0);
my $others = $mbar -> cascade(-label =>"Others", -underline=>0, -tearoff => 0);
my $help = $mbar -> cascade(-label =>"Help", -underline=>0, -tearoff => 0);

## File Menu ##
$file -> command(-label => "New", -underline=>0, 
		-command=>sub { $txt -> delete('1.0','end');} );
$file -> checkbutton(-label =>"Open", -underline => 0,
		-command => [\&openfunction, "Open"]);
$file -> command(-label =>"Save", -underline => 0,
		-command => [\&savefunction, "Save"]);
$file -> separator();
$file -> command(-label =>"Exit", -underline => 1,
		-command => sub { exit } );

## Others Menu ##
my $insert = $others -> cascade(-label =>"Insert", -underline => 0, -tearoff => 0);
		
		$insert -> command(-label =>"Highlight", 
	-command => [\&highlight, "Highlight"]);
	$insert -> command(-label =>"Underline", 
	-command => [\&underline, "Underline"]);
		$insert -> command(-label =>"Title", 
	-command => [\&bold, "Title"]);
	$insert -> command(-label =>"Stippling", 
	-command => [\&stippling, "Stippling"]);
	
	$insert -> command(-label =>"Find & Replace", 
	-command => [\&find_replace, "Find & Replace"]);
$insert -> command(-label =>"Name", 
	-command => sub { $txt->insert('end',"Name : Thaddeus Roebuck Badgercock\n");});
$insert -> command(-label =>"Bullet Point", -command=>sub { 
	$txt->insert('end',"⚫\t");});
$insert -> command(-label =>"Email", 
	-command=> sub {$txt->insert('end',"E-Mail :\n");});
$others -> command(-label =>"Insert All", -underline => 7,
	-command => sub { $txt->insert('end',"Name : Thaddeus Roebuck Badgercock
Website : 
E-Mail :");
  	});

## Help ##
$help -> command(-label =>"About", -command => sub { 
	$txt->delete('1.0','end');
	$txt->insert('end',
	"About
----------
This is a simple text editor written in Perl Tk. This program is licensed under the GNU Public License and is Free Software.
"); });


## Tags ##
$txt->tag(qw/configure bgstipple  -background black -borderwidth 0
	    -bgstipple gray12/);
$txt->tag(qw/configure bold    -font C_bold/);
$txt->tag(qw/configure color1 -background/ => '#a0b7ce');
$txt->tag(qw/configure raised -background white -relief raised/);
$txt->tag(qw/configure sunken -background white -relief sunken/);
$txt->tag(qw/configure underline  -underline on/);

MainLoop; 

sub find_replace {
	$txt->FindAndReplacePopUp;
}

sub stippling {
 $txt->insert('insert', '  ', 'bgstipple');
    $txt->SetCursor( 'insert - 1 chars' );
} # end style

sub bold {
	 $txt->insert('insert', '  ', 'bold');
    $txt->SetCursor( 'insert - 1 chars' );
}

sub highlight {
 $txt->insert('insert', '  ', 'color1');
    $txt->SetCursor( 'insert - 1 chars' );
 }
 
 sub raised {
	  $txt->insert('insert', '  ', 'raised');
    $txt->SetCursor( 'insert - 1 chars' );
 }
 
  sub underline {
 $txt->insert('insert', '  ', 'underline');
    $txt->SetCursor( 'insert - 1 chars' );
 }


sub savefunction {
     my $fileDataToSave=$txt->get("1.0","end"); 
    # Trigger dialog
    $filename = $mw->getSaveFile( -title =>  "Selecting file to Save",
             -defaultextension => '.rtf', -initialdir => '.' );
    # save the file 
    open(my $fh, '>', $filename) or die $!;
   print $fh $fileDataToSave;
   close $fh;
}

sub openfunction {
	  # function to get file dialog box
     $filename = $mw->getOpenFile( -title => "Selecting file to Load",
     -defaultextension => '.txt', -initialdir => '.' );
     open($fh, '<', $filename) or die $!;
     my $file_content = do { local $/; <$fh> };
     close $fh;
    $txt->Contents($file_content)
}

sub menuClicked {
	my ($opt) = @_;
	$mw->messageBox(-message=>"You have clicked $opt.
This function is not implemented yet.");
}

#todo:
#figure out how to package as monolithic executables for various platforms

