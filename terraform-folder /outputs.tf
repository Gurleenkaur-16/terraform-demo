#output "ec2_public_ip" {
#  value = aws_instance.my_instance[*].public_ip  #morethan two
#}

#output "ec2_public_dns" {
#  value = aws_instance.my_instance[*].public_dns  #morethan two
#}

#output "ec2_private_ip" {
# value = aws_instance.my_instance.private_ip  #single output
#}
 
 #output for each 
output "ec2_public_ip" {
   value = [
    for instance in aws_instance.my_instance : instance.public_ip
   ]
}
