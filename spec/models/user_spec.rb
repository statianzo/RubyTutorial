# == Schema Information
# Schema version: 20100403195625
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "Example User",
      :email => "meh@moo.com"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end

  it "should require a name" do
    no_name = User.new(@valid_attributes.merge(:name => ""))
    no_name.should_not be_valid
  end

  it "should require a email" do
    no_name = User.new(@valid_attributes.merge(:email => ""))
    no_name.should_not be_valid
  end

  it "should reject long names" do
    long_name = "z" * 51
    long_name_user = User.new(@valid_attributes.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid emails" do
    addresses = %w[user@foo.com THE_UsEr@foo.bar.org first.last@meh.jp]
    addresses.each do |address|
      user = User.new(@valid_attributes.merge(:email => address))
      user.should be_valid
    end
  end

  it "should reject invalid emails" do
    addresses = %w[user@foo,com THE_UsEr_at_foo.bar.org first.last@meh.]
    addresses.each do |address|
      user = User.new(@valid_attributes.merge(:email => address))
      user.should_not be_valid
    end
  end

  it "should reject duplicate emails" do
    User.create!(@valid_attributes)
    duplicated_email_user = User.new(@valid_attributes)
    duplicated_email_user.should_not be_valid
  end

  it "should reject identical emails case insensitively" do
    uppercased_email = @valid_attributes[:email].upcase
    User.create!(@valid_attributes)
    duplicated_email_user = User.new(@valid_attributes.merge(:email =>uppercased_email))
    duplicated_email_user.should_not be_valid
  end

end
