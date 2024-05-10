output "cidr-my-vpc" {
  value = aws_vpc.my-vpc.id
}
output "cidr-hg-vpc" {
  value = aws_vpc.hg-vpc.id
}
output "public-subnet-myvpc-1" {
  value = aws_subnet.public-subnet-myvpc-1.id

}
output "public-subnet-myvpc-2" {
  value = aws_subnet.public-subnet-myvpc-2.id
  
}
output "public-subnet-hgvpc-1" {
  value = aws_subnet.public-subnet-hgvpc-1.id
  
}
output "public-subnet-hgvpc-2" {
  value = aws_subnet.public-subnet-hgvpc-1.id
  
}