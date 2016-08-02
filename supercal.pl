#!c:/xampp/perl/bin/perl

use strict;
use warnings;
use CGI qw(:standard);

print qq(Content-type: text/html\n\n);

my $result_num;

print <<EOM;

<!DOCTYPE html>

<html>
<head>
<style>
.warn {
	color: red;
}
table {
	border: 1px solid #ddd;
	border-collapse: collapse;
}
td {
	text-align: center;
	padding: 5px;
}
</style>
<script>
function facs(){
	var doing_math = document.getElementById("do_math");
	var doing_math_symbol = doing_math.options[doing_math.selectedIndex].value;
	if (doing_math_symbol == "!"){
		document.getElementById("second_val_not").disabled = true;
	}
}
</script>
<meta charset="UTF-8">
</head>
<body>
<form action = "supercal.pl" method="POST">
<table>
	<th valign="center" colspan="5">Simple Perl Calculator</th>
	<tr>
		<td><input type="text" name="first_num" maxlength="10"></td>
		<td>
			<select id="do_math" name="operation" onchange="facs()">
				<option value="+">+</option>
				<option value="-">-</option>
				<option value="*">*</option>
				<option value="/">/</option>
				<option value="!">!</option>
			</select>
		</td>
		<td><input type="text" name="second_num" id="second_val_not" maxlength="10"></td>
		<td><input type="Submit" value="Submit"></td>
EOM

my $first_num_val = param('first_num');
my $second_num_val = param('second_num');
my $operate = param('operation');

if ($operate eq "!"){
	#if($second_num_val ne ""){print "<span class='warn'>Second Input Unnecessary in a factorial</span>";}	
	if ($first_num_val =~ /^[0-9,.E]+$/i){
		$result_num = &factorialing($first_num_val);
	}
	else{print "<span class='warn'>Numeric input only!</span>";}
}
elsif ($first_num_val =~ /^[0-9,.E]+$/i && $second_num_val =~ /^[0-9,.E]+$/i){
	if ($operate eq "+"){
		$result_num = $first_num_val + $second_num_val;
	}
	elsif ($operate eq "-"){
		$result_num = $first_num_val - $second_num_val;
	}
	elsif ($operate eq "*"){
		$result_num = $first_num_val * $second_num_val;
	}
	elsif ($operate eq "/"){
		if ($second_num_val eq 0){
			print "<span class=\"warn\">Cannot Divide by Zero(0)!</span>";
		}
		else{
			$result_num = $first_num_val / $second_num_val;
		}
	}
}
else {
	print "<span class='warn'>Numeric input only!</span>";
}
sub factorialing {
  my($num) = @_;
  if ($num le 1) {
    return 1;   # stop at 1, factorial doesn't multiply times zero
  } else {
    return $num*factorialing($num - 1);   # call factorial function recursively
  }
}
print <<EOM;
	</tr>
	<tr>
		<td>$first_num_val</td>
		<td>$operate</td>
		<td>$second_num_val</td>
		<td> = $result_num</td>
	</tr>
</table>
</form>
</body>
</html>

EOM

# print "1+2 = ", 1+2;


#print $operate;



