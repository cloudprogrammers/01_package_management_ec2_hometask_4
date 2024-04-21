# Linux Package and Software Management
Welcome to this practical session where you will dive into the world of Linux package management on an AWS EC2 instance running Ubuntu. This lesson is created to provide you with the necessary skills to install, manage, and verify software applications using the Advanced Packaging Tool (apt) and manage service statuses.

## _What you will learn_

- **Understanding apt and Repositories**  Learn how package managers work in Linux, with a focus on `apt` for Ubuntu. You'll explore how to add repositories and install software from these repositories.
- **Installing and Managing Services** Gain skills in installing crucial software like Python, Docker, and Nginx, and managing these services on Ubuntu.
- **User and Group Management:** Reinforce your knowledge of user management by adding users to groups, which is key for managing permissions for software like Docker.
- **Scripting for System Monitoring** Develop a Bash script to verify installations and service statuses, enhancing your scripting skills and system monitoring capabilities.

## Prerequisites
Before starting, ensure you have the following:
- An active AWS account with access rights to manage EC2 instances.
- A running EC2 instance created from Ubuntu image. Type of instance - t2 or t3.micro or equivalent

# EXERCISES

## Exercise 1: Installing and Configuring AWS CLI

AWS CLI (Command Line Interface) is an essential tool for managing AWS services. It allows you to control multiple AWS services directly from the command line. Basically it lets you control AWS cloud resources from your own computer. . Setting up and understanding AWS CLI and profiles is crucial for efficient AWS resource management.

**Objective**
Learn how to install and configure the AWS Command Line Interface (AWS CLI) on your local machine.

**Task 1: Installing AWS CLI:**

Start by installing the `aws-cli` on your local machine. 
`aws-cli` is a tool, just like any other tools in Linux like `ls` `pwd`, and it will enable us to control and interact with AWS resources from our computer.

[Click here](https://docs.google.com/document/d/1UTd-wV1fwjQzxkusgAN3_42aBnaATJAhXBZMZ1jX8vk/edit?usp=sharing) to understand more about this tool. The study material will guide you, so you have working tool on your computer.

When your installation succeeds, verfiy if you can use the `aws` tool to get information about the EC2 instances on your account from your computer. Start terminal and issue command:

```
aws ec2 describe-instances
```
If everything is  configured correctly, this command should return a list of your EC2 instances or an empty response if no instances are running.
Troubleshooting:
If you encounter problems, verify the following:

1. **Permissions:** Ensure your IAM user has sufficient permissions to perform the operations.
2. **Region Settings:** Check if the default region is correctly set in your AWS CLI configuration.
3. **Credential Validity:** Confirm that the AWS Access Key ID and Secret Access Key are still valid and have not been deactivated.

## Exercise 2: Installing applications and tools via `apt`

**Task 1. Introduction to Package Managers:** 
Package managers are crucial tools in Linux environments, allowing users to install, update, and manage software packages from centralized repositories. Ubuntu uses `apt` (Advanced Package Tool), which interfaces with repositories defined in `/etc/apt/sources.list` and its include files. `apt` handles package downloads, installation, and dependency management seamlessly.
The `/etc/apt/sources.list` file on Debian-based systems lists the "sources" or repositories that the system uses to fetch software packages. This file can contain links to multiple repositories, which might include the main Ubuntu repositories, third-party repositories, or even private repositories for specific software. Entries in this file dictate from where apt can install or upgrade packages.

**1. Update Package Lists**
Before installing new packages, it's good practice to update your package lists to ensure you install the latest versions available.

1. Connect to your EC2 instance via SSH.
2. Update `apt` package lists:

```sh
sudo apt update
```

**2. Install Python** 
Python is often pre-installed on many Linux distributions, but you may need a different version or to ensure it is installed.
Install Python using `apt`:

```sh
sudo apt install python3
```
This command searches for the Python package in the repositories and installs it along with any necessary dependencies.

**2. Verify Installation**
Check the installed version of Python:
```
python3 --version
```
This command displays the version of Python installed, confirming the success of your installation.
The process we did is a basic version of how all packages and software is installed on linux.
[Click here](https://docs.google.com/document/d/1YDXJZZvaI-9cyHB8B1Zys-fQTgMf57VQaIFhLhn1ow4/edit?usp=sharing) to understand more and learn about more advanced scenario - the 3-step method to install **custom** software on Linux.

**What we did so far ?**
**Understanding Repositories and Package Management** 
We delved into the role of software repositories in Linux, which are vital for the easy installation, updates, and maintenance of software, managed via `/etc/apt/sources.list` and the `/etc/apt/sources.list.d/` directory.

**Adding Custom Repositories and Verifying Installations**
We learned how to add custom repositories to access more software options, involving steps like importing security keys with `apt-key add`, ensuring compatibility with `lsb_release -cs`, and using tee for adding repository entries safely.

**Command Flags and Configuration File Management**
Detailed insights were provided into apt command flags, particularly -y for automating installations and upgrades, and explained the functionality of apt-get remove which keeps configuration files intact, useful for maintaining settings between software installations.

## Exercise 3: Installing Docker Using a Repository
**Objective** Learn how to add external repositories and install software from them—specifically, `Docker` and `docker-compose`.
In this exercise, you'll learn how to install Docker on your Ubuntu EC2 instance by adding a custom repository. Docker is a powerful platform that allows you to develop, ship, and run applications inside containers. This process involves setting up the Docker repository and installing Docker from it, which provides the most updated and compatible versions for your system.

**1. Prepare Your System:** 
Update your package index using the `apt-get update` command. As before, this ensures you have the latest information about all the packages available through your current repositories.
```
sudo apt-get update
```

**2.Install Required Packages**
Install packages necessary to allow `apt` to use a repository over HTTPS
```
sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common
```
If prompted for consent, type 'Y' (Yes)
A popup informing about pending kernel update may show up. Press enter to agree for restarting necessary services (like cron).

**3. Add Docker’s Official GPG Key**
Import Docker's official GPG key to ensure the integrity and authenticity of the packages you install

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

**4. Verify the Fingerprint**
Confirm that you now have the key with the fingerprint below to ensure that the key is correct
```
sudo apt-key fingerprint 0EBFCD88
```

**5. Set Up the Stable Repository** 
Add the Docker repository to your system's software sources

```
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable"
```

**6. Install Docker CE (Community Edition)**
1. Update your `apt` package index again

```
sudo apt-get update
```

2. Install the latest version of Docker Community Edition

```
sudo apt-get install docker-ce
```

3. Verify Docker is Installed Correctly

```
sudo systemctl status docker
```

Check the installation by verifying that Docker daemon is running.
The message should say that the Docker daemon is running.

**Summary**
You now understand how to add a new repository to your Ubuntu system, a crucial skill for installing software not available in the default Ubuntu repositories.

We walked through installing Docker using the official Docker repository. This method ensures that you receive software that is fully tested and compatible with your distribution

You also learned how to use commands like apt-transport-https, curl, and software-properties-common to manage software sources securely.

## Exercise 4: Installing nginx
**Objective** 
In this exercise, you will install Nginx on your Ubuntu EC2 instance. Nginx is a tool that helps deliver web pages to people who visit your website. It’s known for being very efficient and easy to set up. You can use Nginx in two main ways:

1. **As a Web Server:** Nginx can directly send out web pages when someone visits your site. This is useful for showing static content, which includes images, HTML files, and stylesheets that don’t change often.
2. **As a Reverse Proxy:** Sometimes, you might have complex applications running on your server that create web pages dynamically (these could be shopping carts, dynamic forms, etc.). Nginx can manage the requests from visitors and pass them to these more complex applications in the background, then deliver the applications' responses back to the visitors. This helps in managing traffic more efficiently and keeping things secure.

**What are backend services?**
These are programs or services running on a server that aren't directly accessed by users but instead support the front-facing part of a website or web application, handling tasks like database management, user authentication, and more.
By installing Nginx, you’ll get hands-on experience with a versatile tool that can both serve simple websites and manage complex web applications.

1. **Update Package List**
Ensure your package lists are up to date to avoid missing out on the latest software versions
```
sudo apt-get update
```
2. **Install Nginx**
Install Nginx using the `apt-get` command. This will install Nginx and any required dependencies:
```
sudo apt-get install nginx
```
3. **Verify Installation**
```
sudo systemctl status nginx
```
The nginx service should be 
4. **Configuring Firewall**
If your EC2 instance has UFW firewall enabled, you need to allow HTTP and HTTPS traffic
```
sudo ufw allow 'Nginx Full'
```

5. Test Web Server
Use the `curl` command to test that Nginx is correctly handling HTTP requests.
```
curl http://localhost
```

# Key Points to Remember

**1. Script Permissions and the Use of Shebang (#!)**
Scripts need to be executable to run. Using `chmod +x scriptname.sh` changes the script's permissions, making it executable. The shebang `(#!)` at the beginning of scripts specifies the interpreter, ensuring scripts run under the correct environment.

** Capturing and Processing User Input:**
User input handling, through read commands or script parameters, enables interactive scripts and dynamic execution paths based on user decisions. It enhances the script's flexibility and user-friendliness.


# Commands Reference

| Command | Description |
| ------ | ------ |
| `ssh -i ~/.ssh/hero_key hero@Your-Instance-IP` | Connects to an EC2 instance using SSH with the specified key and user. |
| `vim ec2_info.sh` | Opens the Vim editor to create or edit a script file named ec2_info.sh. |
| `chmod +x ec2_info.sh` | Makes the script executable. |
| `./ec2_info.sh <option>` | Runs the script |
| `curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` | Requests a new token for accessing the EC2 instance metadata with a specified TTL (Time To Live). |
| `curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/` | Uses the obtained token to fetch metadata from the EC2 instance. |