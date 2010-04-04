require 'spec_helper'

describe UsersController do
  integrate_views

  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
      User.stub!(:find, @user.id).and_return(@user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should have right title" do
      get :show, :id => @user
      response.should have_tag("title", /#{@user.name}/)
    end

    it "should display users name" do
      get :show, :id => @user
      response.should have_tag("h2", /#{@user.name}/)
    end

    it "should display gravatar" do
      get :show, :id => @user
      response.should have_tag("h2>img", :class => "gravatar")
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have correct title" do
      get 'new'
      response.should have_tag("title", /Sign up/)
    end
  end
end
