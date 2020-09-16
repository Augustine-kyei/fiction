pipeline {
    
    
    
   // environment {
   // registry = "1115024/php-testing"
    //registryCredential= "dockerhub"
    //dockerImage = "1115024/php-testing :$BUILD_NUMBER"
 // }
    
    
    
    //def app
    agent none

    stages {
        stage('Job 1: Installing Puppet Agent') {
            agent {label 'Slave 1'}
            steps {
                echo 'The steps as follows:'
                
                sh 'wget https://apt.puppetlabs.com/puppet6-release-xenial.deb'
                sh 'sudo dpkg -i puppet6-release-xenial.deb'
                sh 'sudo apt-get update'
                sh 'sudo ufw allow 8140/tcp'
                sh 'sudo apt-get install puppet-agent'
                
                sh 'sudo systemctl start puppet'
                sh 'sudo systemctl enable puppet'
                sh ' systemctl status puppet'
                
            }
            
        } 
        stage ('Job2 Certificate Sign') {
        agent any 
        steps{
            sh 'sudo ufw allow 8140/tcp'
            sh 'sudo systemctl start puppet'
            sh 'sudo systemctl enable puppet'
            sh ' systemctl status puppet'
            
            echo 'sigining certificates from puppet agent'
            sh ' sudo /opt/puppetlabs/bin/puppetserver ca list --all'
            sh 'sudo /opt/puppetlabs/bin/puppetserver ca list --certname ip-172-31-34-81.us-east-2.compute.internal'
            
            
        }
        }
        
        stage ('Job3 :Triggering Puppet Agent to Install Docker ') {
            
            agent {label 'Slave 1'}
            steps {
                echo 'triggering puppet agent \n to pull a catalog from puppet master'
                sh 'sudo /opt/puppetlabs/bin/puppet agent --test'
                sh 'sudo systemctl status docker'
            }
            post {
                
                always {
                    
                    sh 'exit 0'
                }
                
            }
        }
            
            stage ('job4, Docker Container Deployment for a PHP Website'){
                
                agent {label 'Slave 1'}
                
                steps {
                    git 'https://github.com/Augustine-kyei/fiction.git'
                    
                     sh ' cd /tmp/workspace/Edureka_DevOps_Project docker '
                     sh 'sudo docker build -t 1115024/php-testing:$BUILD_NUMBER .'
                     sh 'sudo docker login -u 1115024 -p Dada1212? '
                     sh 'sudo docker push 1115024/php-testing:$BUILD_NUMBER'
                    
                   
                }
                
                
                
            
            }
        

           
            
        
        
        
    }
}
