class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?
    protected
          def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :mobile_number, :email, :password, :password_confirmation, :current_password)}
               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :mobile_number, :email, :password, :current_password)}
          end

     private 

     def authenticate_admin_user? 
          if current_user.has_role? :admin 
               true 
          else 
               flash[:alert] = "You are not authenticated admin."
               redirect_to root_path
          end
     end

end
