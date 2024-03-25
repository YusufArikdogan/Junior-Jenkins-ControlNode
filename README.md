# Junior-Jenkins-ControlNode-
# Todo App  

This project aims to create infrastructure using Terraform, installing dependencies with Jenkins, Docker, and Ansible.  
We will use the created server as a control node and set up Jenkis server.  

## Getting Started  

Follow these steps to clone the repository to your local machine and set it up.  

### Prerequisites  

You need to have the following software installed to run the project:  

- Terraform  
- Jenkins  
- Docker  
- Ansible  

### Installation  

1. Clone the repository to your local machine.  
2. Update the values of `user` and `mykey` variables in the `variables.tf` file with your own values.  
3. If desired, specify your zone in the 11th line of the `install-jenkins.tf` file for the server to be deployed in `us-east-1`.  
4. Place your `key.pem` file in the same directory.  
5. Open a terminal in the project directory and execute the following commands one by one:  
    ```  
    terraform init  
    terraform apply -auto-approve  
    ```  
6. Wait for the machines to be created.  
7. Once the machines are ready, copy the SSH command provided in the output to connect to the Jenkins server via SSH. Paste it into the terminal and press 'yes' to confirm.  
8. Copy the `jenkins-initialadminpasswordpath` output from the previous step. Paste it into the Jenkins server's terminal to get the password for Jenkins.  
9. Open the Jenkins interface by clicking on the `junior-level-server` link. Paste the copied password and proceed with the installation.  
10. Click on "Install suggested plugins" and continue.  
11. Follow the prompts to set up Jenkins with your desired username, password, full name, and email address.  
12. Once the installation is complete, log in to the Jenkins interface.  
13. Go to "Manage Jenkins" on the left sidebar.  
14. Install the Terraform, Ansible, Docker, and Locale plugins from the "Manage Plugins" section.  
15. In "Manage Jenkins", go to "Configure System".  
16. Find the "Locale" plugin and check the "Ignore browser preference and force this language to all users" option.  
17. In "Manage Jenkins", navigate to "Tool Configuration".  
18. Add Ansible with the name "ansible" and path /usr/local/bin/   
19. Add Terraform with the name "terraform" and path /usr/local/bin/   
20. Add Docker with the name "docker" and path /usr/bin/  
21. Navigate to Jenkins and click on "Manage Jenkins".  
22. Select "Manage Credentials" from the options.  
23. Click on "Global" domain and then "Add Credentials".  
24. Choose the kind of credential you want to add. For GitHub access, select "Username with password".  
25. Enter your GitHub username in the "Username" field.  
26. For the "Password" field, paste your GitHub token. You can generate a token from your GitHub account settings.  
27. Optionally, add a description such as "GitHub" for better organization.  
28. Click "OK" to save the credential.  
29. Repeat the process to add Docker Hub credentials. Choose "Username with password" again.  
30. Enter your Docker Hub username and paste your Docker Hub token in the respective fields.  
31. Add a description like "docker" for clarity.  
32. Save the credentials.  
33. Now, add SSH credentials for Ansible. Click on "Add Credentials" again.  
34. Choose "SSH Username with private key" this time.  
35. Set the "Username" as ec2-user.  
36. In the "Private Key" field, paste the content of your key.pem file. Open the file in a text editor like Notepad, copy its content, and paste it here.  
37. Provide an ID for the credential like "ansible".  
38. Save the credentials.

With these steps, you have configured Jenkins with the necessary credentials to access GitHub, Docker Hub, and SSH for Ansible.
You can continue from my next GitHub repository...  
