#!/bin/bash

# Create all required Passwords
# password1 = RDS mainuser password
# password2 = Admin Server root user
# password3 = Admin Server ec2-user user
# password4 = AdminRW sql user password
# password5 = WebPHPRW sql user password 
# password6 = JavaMail sql user password
# password7 = SNS sql user password 
# password8 = Web1 root user
# password9 = Web1 ec2-user user
# password10 = Web2 root user
# password11 = Web2 ec2-user user
# password12 = Web3 root user
# password13 = Web3 ec2-user user
# password14 = Web4 root user
# password15 = Web4 ec2-user user
# password16 = Web5 root user
# password17 = Web5 ec2-user user
# password18 = Web6 root user
# password19 = Web6 ec2-user user
# password20 = AESKey for PHP Sessions

# Check Directory first
where=$(pwd)
where="${where: -12}"
if test "$where" = "aws-scripted"; then
	echo "running from correct directory"
else
	echo "must be run from aws directory with ./credentials/createpasswords.sh"
	exit
fi

# Fully Qualified Path to AWS Directory
basedir=/home/davidg/Documents/Projects/aws-scripted

cd $basedir/credentials

# Save old_passwords for historical
now=$(date +"%m_%d_%Y")
mv passwords.sh oldpasswords/passwords_$now.sh

# Start and Initialize the Passwords Script
echo "#!/bin/bash" > passwords.sh

echo "RDS Main User password (max 16)"
newpassword=$(openssl rand -base64 10)
newpassword=$(echo $newpassword | tr '/' '0')
echo "password1=$newpassword" >> passwords.sh

for (( i=2; i<=20; i++ ))
do
	# Randomly discard some Passwords
	randdiscard=$[1+$[RANDOM%10]]
	echo "next password $randdiscard"
	for (( j=1; j<=$randdiscard; j++ ))
	do
		newpassword=$(openssl rand -base64 33)
		echo "discarded 1"
	done
	newpassword=$(openssl rand -base64 33)
	newpassword=$(echo $newpassword | tr '/' '0')
	echo "password$i=$newpassword" >> passwords.sh
done

# Make the final generated Script executable
chmod +x passwords.sh

cd $basedir
