class PagesController < ApplicationController


    def Home
        redirect_to articles_path if logged_in?
    end
    
    def About
    end
    
end