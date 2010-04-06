require 'spec_helper'

describe SessionsController do
  integrate_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    it "should have the right title" do
      get :new
      response.should have_tag("title", /sign in/i)
    end
  end

  describe "Post 'create'" do
    describe "invalid signin" do
      before(:each) do
        @attr = { :email => "example@example.com", :password => "mahpass"}
        User.should_receive(:authenticate).
          with(@attr[:email],@attr[:password]).
          and_return(nil)
      end

      it "should reject invalid user" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should have the right title" do
        post :create, :session => @attr
        response.should have_tag("title", /sign in/i)
      end
    end

    describe "valid combination" do
      before(:each) do
        @user = Factory(:user)
        @attr = {:email => @user.email, :password => @user.password}
        User.should_receive(:authenticate).
          with(@attr[:email], @attr[:password]).
          and_return(@user)
      end
      it "should accept valid login" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      it "should redirect to show page" do
        post :create, :session => @attr
        redirect_to user_path(@user)
      end
    end

    describe "DELETE 'destroy'" do
      it "should sign a user out" do
        test_sign_in(Factory(:user))
        controller.should be_signed_in
        delete :destroy
        controller.should_not be_signed_in
        response.should redirect_to(root_path)
      end
    end

  end
end
