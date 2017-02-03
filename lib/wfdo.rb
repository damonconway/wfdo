require 'json'
require 'net/http'
require 'uri'

class Wfdo
  def initialize(port='9999', proto='http', user='wildfly', pass='Cee1geev', host)
    @uri = URI("#{proto}://#{user}:#{pass}@#{host}:#{port}/management")
    @req = Net::HTTP::Get.new(@uri)
    req.basic_auth 'user', 'pass'
    @res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    @cluster_info = JSON.parse(res)
    cluster_info['server-group'].each do |k,v|
      @server_groups << k
    end
    cluster_info['host'].each do |k,v|
      @hosts << k unless k == 'master'
    end
    cluster_info['deployment'].each do |k,v|
      @deployments << k
    end
  end

  def drain(group=false, host=false, server=false)
    url = "#{@uri}/"
  end

  def is_drained(group)
  end

  def deploy_add(file, group)
  end

  def deploy_del(file, group)
  end

  def deploy_test()
  end

  def group_disable()
  end

  def group_enable()
  end

  private

  def do_or_print(cmd)
    puts cmd if @pretend or @verbose
    res = true if @pretend
    res = system cmd unless @pretend
    if res == true
      return res
    else
      return $?
    end
  end

  def server_list(hc, group)
  end

end
