require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
    response.should render_template('pages/home')
  end
  
  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should render_template('pages/contact')
  end

  it "should have a About page at '/about'" do
    get '/about'
    response.should render_template('pages/about')
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should render_template('pages/help')
  end

  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should render_template('users/new')
  end

  describe "when not signed in" do
    it "should have signin link" do
      get '/'
      response.should have_tag("a[href=?]", signin_path, "Sign in")
    end
  end

end
