pod = node['webtrends']['pod']
pod_data = data_bag_item('pods', pod)
c_hosts = pod_data['cache_hosts']

#Generic
installdir = node['webtrends']['installdir']
buildURLs = data_bag("buildURLs")
build_url = data_bag_item('buildURLs', 'latest')
install_url = build_url['url']
install_url << "dx/"

#Recipe specific
cfg_cmds = node['webtrends']['dx']['v2']['cfg_cmd']
app_pool = node['webtrends']['dx']['v2']['app_pool']
install_url << node['webtrends']['dx']['v2']['file_name']
installdir << node['webtrends']['dx']['v2']['dir']


windows_zipfile "#{installdir}" do
	source "#{install_url}"
	action :unzip	
	not_if {File.directory?("#{installdir}")}
end

template "#{installdir}\\web.config" do
	source "webConfigv2.erb"
	variables(
		:cache_hosts => c_hosts
	)
end

iis_pool "#{app_pool}" do
	thirty_two_bit :true
action [:add, :config]
end

iis_app "DX" do
	path "/v2"
	application_pool "#{app_pool}"
	physical_path "#{installdir}"
end

iis_config "\"DX/v2\" -section:system.webServer/handlers /+\"[name='svc-ISAPI-2.0_64bit',path='*.SVC',verb='*',modules='IsapiModule',scriptProcessor='C:\\Windows\\Microsoft.NET\\Framework\\v2.0.50727\\aspnet_isapi.dll']\"" do
	action :config	
	notifies :create, "ruby_block[v1cfg_flag]" #Running delayed notification so multiple run-once commands get run
	not_if {node.attribute?("dxv2_configured")}
end

iis_config "DX/v2\" -section:system.webServer/handlers /+\"[name='svc-ISAPI-2.0_32bit',path='*.SVC',verb='*',modules='IsapiModule',scriptProcessor='C:\\Windows\\Microsoft.NET\\Framework\\v2.0.50727\\aspnet_isapi.dll']" do
	action :config	
	notifies :create, "ruby_block[v1cfg_flag]" #Running delayed notification so multiple run-once commands get run
	not_if {node.attribute?("dxv2_configured")}
end

ruby_block "v2cfg_flag" do
	block do
		node.set['dxv2_configured']
		node.save
	end
	action :nothing
end