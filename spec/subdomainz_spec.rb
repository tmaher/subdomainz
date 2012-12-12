require_relative './helpers'
require 'subdomainz'

describe Subdomainz, "#common_subdomain" do
  it "returns the common parts of the domains, starting from the end" do
    common_subdomain("x.a.b", "y.a.b").must_equal "a.b"
    common_subdomain("x.z.a", "y.a").must_equal "a"
    common_subdomain("x.z.a.b", "y.z.a.b").must_equal "z.a.b"
  end

  it "returns an empty string if there's nothing in common" do
    common_subdomain("a.b.c", "d.e.f").must_equal ""
    common_subdomain("a.b", "a.b.x").must_equal ""
  end
end
