require "thor"
require "tty-prompt"

class Kuberails < Thor
  class_option :e, :banner => 'ENVIRONMENT', :required => true

  desc "build OBJ", "Build flota object"
  def build
    exec "./cicd/build.sh #{options[:e]}"
  end

  desc "deploy OBJ", "Deploy flota object"
  def deploy
    exec "./cicd/deploy.sh #{options[:e]}"
  end

  desc "refresh_secrets", "Refresh flota secrets, and pods"
  def refresh_secrets
    exec "./cicd/deploy-secrets.sh #{options[:e]}"
  end

  desc "logs -e ENVIRONMENT", "Get flota logs for environment"
  def logs
    pods_options = %x[kubectl get pods | grep #{options[:e]}].split("\n")
    pod_name = select(pods_options)
    exec "kubectl logs #{pod_name} -f"
  end

  desc "bash -e ENVIRONMENT", "Get flota pods for environment"
  option :n, :banner => 'NAVIGABLE', :required => false
  def bash
    pods_options = %x[kubectl get pods | grep #{options[:e]}].split("\n")
    pod_name = select(pods_options)
    exec "kubectl exec -it #{pod_name} /bin/sh"
  end

  desc "console -e ENVIRONMENT", "Get flota pods for environment"
  option :n, :banner => 'NAVIGABLE', :required => false
  def console
    pods_options = %x[kubectl get pods | grep #{options[:e]}].split("\n")
    pod_name = select(pods_options)
    exec "kubectl exec -it #{pod_name} ./bin/rails c"
  end

  desc "object -e ENVIRONMENT", "Get flota object for environment"
  option :n, :banner => 'NAVIGABLE', :required => false
  def object(object_name, pod_name=nil)
    k8_object(object_name, pod_name)
  end

  desc "pods -e ENVIRONMENT", "Get flota pods for environment"
  option :n, :banner => 'NAVIGABLE', :required => false
  def pods(pod_name=nil)
    k8_object("pods", pod_name)
  end

  desc "ingress -e ENVIRONMENT", "Get flota ingress for environment"
  option :n, :banner => 'NAVIGABLE', :required => false
  def ingress(pod_name=nil)
    k8_object("ingresses", pod_name)
  end

  desc "services -e ENVIRONMENT", "Get flota services for environment"
  option :n, :banner => 'NAVIGABLE', :required => false
  def services(pod_name=nil)
    k8_object("services", pod_name)
  end

  def self.exit_on_failure?
    true
  end

  private

  def k8_object(k8_obj, pod_name=nil)
    if pod_name
      exec "kubectl describe #{k8_obj} #{pod_name}"
    else
      k8_obj_options = %x[kubectl get #{k8_obj} | grep #{options[:e]}].split("\n")
      if options[:n]
        pod_name = select(k8_obj_options)
        exec "kubectl describe #{k8_obj} #{pod_name}"
      else
        puts k8_obj_options
      end
    end
  end

  def select(select_options)
    select_options.unshift "quit!"
    result = prompt.select("Choose your option?", select_options)
    option_name = result.split(" ").first
    exit if option_name == "quit!"
    option_name
  end

  def prompt
    @prompt ||= TTY::Prompt.new
  end

end

Kuberails.start(ARGV)