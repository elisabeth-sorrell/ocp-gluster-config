output "cluster_private_ips" {
  value = ["${aws_instance.cluster.*.private_ip}"]
}

output "cluster_instance_ids" {
  value = ["${aws_instance.cluster.*.instance_id}"]
}

output "cluster_instance_azs" {
  value = ["${aws_instance.cluster.*.availability_zone}"]
}
