require 'spec_helper'

describe UsersController do
    
    ########Test the add functions#######
    login_user
    #current user is not nil
    it "should have a current_user" do
	subject.current_user.should_not be_nil
    end
    
    #No Events For User
    describe "new user with no events yet" do
        it "should give 'Example Event' for this user's event view" do
		@request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(subject.current_user.email, "123")
		post :view_events
		response.body.should == [{id: '0', title: 'Example Event!', start_time: '1200', end_time: '1400'}].to_json
        end
    end

    #a user that has multiple events
    describe "a user that has multiple events" do
	  it "returns correct number of events when view events" do
		@expected = {title: "Testing", start_time: 1400, end_time: 2200}
		#we use the following to create new events directly instead of doing it via submit_new_event because we want to test this action only
		subject.current_user.events.create(@expected)
		subject.current_user.events.create(@expected)
		@request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(subject.current_user.email, "123")
		post :view_events
		parsed = ActiveSupport::JSON.decode(response.body)
		parsed.size.should == 2 
		first_row = parsed.first.symbolize_keys
		first_row[:id].should == 1
		first_row[:title].should == "Testing"
		first_row[:start_time].should == 1400
		first_row[:end_time].should == 2200
	  end
    end
=begin
    #ADD TWO USERS
    describe "should let server add two users with correct format" do
        it "should return SUCCESS" do
            User.delete_all
            new_User = User.new
            new_User.user = 'user1'
            new_User.save
            post :add, :user => "user2", :password => "pw", :format => :json
            response.body.should == {:errCode => 1, :count => 1}.to_json
        end
    end
    
    #USERNAME IS BLANK
    describe "should not let user create username if blank" do
        it "should return error -3" do
            expect { post :add, :user => "", :password => "hello", :format => :json }.to change(User, :count).by(0)
            response.body.should == {:errCode => -3}.to_json
        end
    end

    #DUPLICATE PASSWORDS ALLOWED
    describe "should let duplicate passwords" do
        it "should return SUCCESS" do
            User.delete_all
            new_User = User.new
            new_User.user = 'user1'
            new_User.password="pw"
            new_User.save
            post :add, :user => "user2", :password => "pw", :format => :json
            response.body.should == {:errCode => 1, :count => 1}.to_json
        end
    end

    #TOO MANY CHARACTERS: USERNAME
    describe "more than 128 characters not allowed for username" do
        it "should return error -3" do
            expect { post :add, :user => "lfjaeljriaejrlkjeakljrlkaejslkrjaklsjrkleasjklrjasljrlkajslrkjaslrjklasaehrlashrkjhaklhrahreahjrlasjrlkasjlrkjlasjrasljrkelsajahjfkgdahfjadhfhdakjfhkahflahfjahfkhgasjfgkdaygfhjgasjgejagfjasgfaegsfgajkfgaehjfgeahjksgfjegahfjgajsegfjekasgfjgakjgfakjgfjkgaejgfhjkaegsr", :password => "hello", :format => :json }.to change(User, :count).by(0)
            response.body.should == {:errCode => -3}.to_json
        end
    end

    #TOO MANY CHARACTERS: PASSWORD
    describe "more than 128 characters not allowed for password" do
        it "should return error -4" do
            expect { post :add, :user => "user1", :password => "lfjaeljriaejrlkjeakljrlkaejslkrjaklsjrkleasjklrjasljrlkajslrkjaslrjklasaehrlashrkjhaklhrahreahjrlasjrlkasjlrkjlasjrasljrkelsajahjfkgdahfjadhfhdakjfhkahflahfjahfkhgasjfgkdaygfhjgasjgejagfjasgfaegsfgajkfgaehjfgeahjksgfjegahfjgajsegfjekasgfjgakjgfakjgfjkgaejgfhjkaegsr", :format => :json }.to change(User, :count).by(0)
            response.body.should == {:errCode => -4}.to_json
        end
    end

    ########Test the login functions########
    
    #CORRECT LOGIN
    describe "should login and increment count" do
        it "should return SUCCESS" do
            User.delete_all
            new_User = User.new
            new_User.user = 'user1'
            new_User.password='pw'
            new_User.count = 1
            new_User.save
            post :login, :user => "user1", :password => "pw", :format => :json
            response.body.should == {:errCode => 1, :count => 2}.to_json
        end
    end

    #NEW USER
    describe "should not be able to login" do
        it "should return error -1" do
            User.delete_all
            post :login, :user => "user1", :password => "pw", :format => :json
            response.body.should == {:errCode => -1}.to_json
        end
    end
    
    #WRONG PASSWORD
    describe "should login and increment count" do
        it "should return error -4" do
            User.delete_all
            new_User = User.new
            new_User.user = 'user1'
            new_User.password='pw'
            new_User.count = 1
            new_User.save
            post :login, :user => "user1", :password => "wrong", :format => :json
            response.body.should == {:errCode => -4}.to_json
        end
    end
=end

end


