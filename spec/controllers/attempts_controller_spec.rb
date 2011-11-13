require 'spec_helper'

describe AttemptsController do
  render_views
  
  describe "GET 'index'" do
		describe "for non-signed-in users" do
			it "should deny access" do
			  get :index
			  response.should redirect_to(new_user_session_path)
		  end
		end

		describe "for signed-in users" do
		  before(:each) do 
		    test_sign_in(Factory(:user))
	    end
	    
			it "should be successful" do
			  get :index
			  response.should be_successful
		  end
		  
			it "should have the right title" do
			  get :index
			  response.should have_selector(:title, :content => "Contact Attempts")
		  end
		  
			it "should have an element for each attempt"
			it "should have an element for each company"
			it "should have an element for each estimated value"
			it "should have an element for each verbal"
			it "should have a link to each show page"
			it "should have a link to each edit page"
			it "should paginate contact attempts"
			it "should have a link to create a new attempt"
		end
  end

	describe "GET 'show'" do
	  before(:each) do
	    @attempt = Factory(:attempt)
    end
    
		describe "for non-signed-in users" do
			it "should deny access" do
			  get :show, :id => @attempt
			  response.should redirect_to(new_user_session_path)
		  end
		end
		
		describe "for signed-in users" do
		  before(:each) do
		    test_sign_in(Factory(:user))
	    end
	    
			it "should be successful" do
			  get :show, :id => @attempt
			  response.should be_successful
		  end
		  
			it "should find the right attempt" do 
			  get :show, :id => @attempt
			  assigns(:attempt).should == @attempt
		  end
		  
			it "should have the right title" do
			  get :show, :id => @attempt
			  response.should have_selector(:title, :content => "Attempt ##{@attempt.id}")
		  end
			
			it "should have an element for the campaign name"
			it "should have an element for the company"
			it "should have an element for the email"
			it "should have an element for the phone number"
			it "should have an element for the fax"
			it "should have an element for the verbal"
			
			it "should have a link to the edit page" do
			  get :show, :id => @attempt
			  response.should have_selector(:a, :href => edit_attempt_path(@attempt))
		  end
		  
			it "should have a link back to the index" do
			  get :show, :id => @attempt
			  response.should have_selector(:a, :href => attempts_path)
		  end
		  
			it "should redirect back to the index if the attempt doesn't exist"
		end
	end

	describe "GET 'new'" do
		describe "for non-signed-in users" do
			it "should deny access" do
			  get :new
			  response.should redirect_to(new_user_session_path)
		  end
		end
		
		describe "for signed-in users" do
		  before(:each) do
		    test_sign_in(Factory(:user))
	    end
	    
			it "should be successful" do
			  get :new
			  response.should be_successful
		  end
		  
			it "should have the right title" do
			  get :new
			  response.should have_selector(:title, :content => "New Contact Attempt")
		  end
		  
			it "should have a field for the campaign name"
			it "should have a field for the company name"
			it "should have a field for the phone confirmation"
			it "should have a field for the email confirmation"
			it "should have a field for the fax confirmation"
			it "should have a field for the verbal confirmation"
			it "should have a field for the value"
			
			it "should have a link back to the index" do
			  get :new
			  response.should have_selector(:a, :href => attempts_path)
		  end
		end
	end

	describe "POST 'create'" do
	  before(:each) do
	    @user = Factory(:user)
	    @attr = {
	      :campaign => Factory(:campaign),
        :company  => Factory(:company),
        :user     => @user
	    }
    end
	  
		describe "for non-signed in users" do
			it "should deny access" do
			  post :create, :attempt => @attr
			  response.should redirect_to(new_user_session_path)
		  end
		end
		
		describe "for signed-in users" do
		  before(:each) do
		    test_sign_in(@user)
	    end
	    
			describe "failure" do
				it "should have the right title" do
				  post :create, :attempt => @attr.merge(:campaign => nil, :company => nil, :user => nil)
				  response.should have_selector(:title, :content => "New Contact Attempt")
			  end
			  
				it "should render the 'new' page" do
				  post :create, :attempt => @attr.merge(:campaign => nil, :company => nil, :user => nil)
				  response.should render_template(:new)
			  end
			  
				it "should not create an attempt" do
				  lambda do
				    post :create, :attempt => @attr.merge(:campaign => nil, :company => nil, :user => nil)
			    end.should_not change(Attempt, :count)
		    end
			end

			describe "success" do
				it "should create an attempt" do
				  lambda do
				    post :create, :attempt => @attr
			    end.should change(Attempt, :count).by(1)
		    end
				  
				it "should redirect to the index" do
				  post :create, :attempt => @attr
				  response.should redirect_to(attempts_path)
			  end
			  
			  it "should have correct message" do
			    post :create, :attempt => @attr
			    flash[:success].should =~ /contact attempt successfully created/i
			  end
			end
		end
	end

	describe "GET 'edit'" do
	  before(:each) do 
	    @attempt = Factory(:attempt)
    end
    
		describe "for non-signed-in users" do
			it "should deny access" do
			  get :edit, :id => @attempt
			  response.should redirect_to(new_user_session_path)
		  end
		end
		
    describe "for signed-in users" do;
      before(:each) do
        test_sign_in(Factory(:user))
      end
      
			it "should be successful" do
			  get :edit, :id => @attempt
			  response.should be_successful
		  end
		  
			it "should have the right title" do
			  get :edit, :id => @attempt
			  response.should have_selector(:title, :content => "Editing Attempt")
		  end
		  
			it "should have a field for the campaign name"
			it "should have a field for the company name"
			it "should have a form for the phone confirmation"
			it "should have a field for the email confirmation"
			it "should have a field for the fax confirmation"
			it "should have a field for the the verbal confirmation"
			it "should have a field for the value"
			
			it "should have a link to the show page" do
			  get :edit, :id => @attempt
			  response.should have_selector(:a, :href => attempt_path(@attempt))
		  end
		  
			it "should have a link back to the index" do
			  get :edit, :id => @attempt
			  response.should have_selector(:a, :href => attempts_path)
		  end
		  
			it "should redirect back to the index if the attempt doesn't exist"
		end
	end

	describe "PUT 'update'" do
	  before(:each) do
	    @attempt = Factory(:attempt)
	    @attr = {
	      :campaign => Factory(:campaign),
	      :company  => Factory(:company),
	      :value    => 500
	    }
    end
    
		describe "for non-signed-in users" do
			it "should deny access" do
			  put :update, :id => @attempt, :attempt => @attr
			  response.should redirect_to(new_user_session_path)
		  end
		end
		
		describe "for signed-in users" do
		  before(:each) do
		    test_sign_in(Factory(:user))
	    end 
	    
			describe "failure" do
				it "should render the 'edit' page" do
				  put :update, :id => @attempt, :attempt => { :campaign => nil, :company => nil, :value => nil }
				  response.should render_template(:edit)
			  end
			  
				it "should have the right title" do
				  put :update, :id => @attempt, :attempt => { :campaign => nil, :company => nil, :value => nil }
				  response.should have_selector(:title, :content => "Editing Attempt")
			  end
			end

			describe "success" do
				it "should change the attempt's attributes" do
				  put :update, :id => @attempt, :attempt => @attr
				  @attempt.reload
				  @attempt.campaign.should == @attr[:campaign]
				  @attempt.company.should == @attr[:company]
				  @attempt.value.should == @attr[:value]
			  end
			  
				it "should have a success message" do
				  put :update, :id => @attempt, :attempt => @attr
				  flash[:success].should =~ /contact attempt successfully updated/i
			  end
			end
		end
	end

	describe "DELETE 'destroy'" do
	  before(:each) do
	    @attempt = Factory(:attempt)
    end
	    
		describe "for a non-signed in user" do
			it "should deny access" do
			  delete :destroy, :id => @attempt
		  end
		end
		
		describe "for a signed-in user" do
		  before(:each) do
		    @user = test_sign_in(Factory(:user))
	    end
	    
			describe "as a non-admin user" do
				it "should protect the action" do
				  delete :destroy, :id => @attempt
				  response.should_not be_successful
			  end
			end

			describe "as an admin user" do
			  before(:each) do
			    @user.admin = true
		    end
		    
				it "should destroy the attempt" do
				  lambda do
				    delete :destroy, :id => @attempt
			    end.should change(Attempt, :count).by(-1)
		    end
		    
				it "should redirect to the index" do
				  delete :destroy, :id => @attempt
				  response.should redirect_to(attempts_path)
			  end
			end
		end
	end
end