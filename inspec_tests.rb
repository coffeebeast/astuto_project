control "env_file_permissions" do
    impact 1.0
    title "File permissions: ensure that the env file is not world read-writable"

    describe file("/astuto_app/.env") do
    it { should exist }
    it { should be_file }
    its("mode") { should cmp 0600}
    end
end

control "web_service" do
    impact 1.0
    title "Service: ensure that the web service is running on the expected port"

    describe port(3000) do
        it { should be_listening }
    end

    describe http("http://10.13.37.22:3000") do
        its("status") { should cmp 200 }
        its("body") { should include "DevSecOpsTests"}
    end

end

control "database_service" do
    impact 1.0
    title "Service: ensure that the database is protected"

    describe port(5432) do
        it { should_not be_listening }
    end
end
