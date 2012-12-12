require_relative './helpers'
require 'subdomainz'

describe Subdomainz, ".common_subdomain" do
  it "returns the common parts of the domains, starting from the end" do
    Subdomainz.common_subdomain("x.a.b", "y.a.b").should eq "a.b"
    Subdomainz.common_subdomain("x.z.a", "y.a").should eq "a"
    Subdomainz.common_subdomain("x.z.a.b", "y.z.a.b").should eq "z.a.b"
  end

  it "returns an empty string if there's nothing in common" do
    Subdomainz.common_subdomain("a.b.c", "d.e.f").should eq ""
    Subdomainz.common_subdomain("a.b", "a.b.x").should eq ""
  end
end
