#!/bin/bash

# Get a list of all nodes in the Kubernetes cluster
nodes=$(kubectl get nodes -o jsonpath='{.items[*].metadata.name}')

# Iterate through each node and retrieve the kernel version
for node in $nodes; do
    echo "Node: $node"
    
    # Get the external IP address of the node
    node_ip=$(kubectl get node $node -o jsonpath='{.status.addresses[?(@.type=="ExternalIP")].address}')

    # SSH into the node and retrieve the kernel version
    kernel_version=$(ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $node_ip "uname -r")

    echo "Kernel Version: $kernel_version"
    echo "-----------------------------"
done
