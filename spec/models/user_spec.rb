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
      :email => "meh@moo.com",
      :password => "foobar",
      :password_confirmation => "foobar"
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
  
  describe "password validations" do

    it "should require a password" do
      User.new(@valid_attributes.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require matching confirmation" do
      User.new(@valid_attributes.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      User.new(@valid_attributes.merge(:password => short, :password_confirmation => short)).
        should_not be_valid
    end

    
    it "should reject long passwords" do
      long = "a" * 41
      User.new(@valid_attributes.merge(:password => long, :password_confirmation => long)).
        should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@valid_attributes)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has password? method" do

      it "should be true if passwords match" do
        @user.has_password?(@valid_attributes[:password]).should be_true
      end
      
      it "should be false if passwords dont match" do
        @user.has_password?("invalid").should be_false
      end
    end

    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@valid_attributes[:email], "incorrect")
        wrong_password_user.should be_nil
      end
      
      it "should return nil on no user for email" do
        fake_user = User.authenticate("meh@baz.com", @valid_attributes[:password])
        fake_user.should be_nil
      end

      it "should return user on email/password match" do
        matched_user = User.authenticate(@valid_attributes[:email], @valid_attributes[:password])
        matched_user.should == @user
      end
    end
  end

end
