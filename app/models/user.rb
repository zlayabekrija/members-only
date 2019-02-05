class User < ApplicationRecord
    before_create :generate_token
    has_secure_password
    
    def remember_token
        SecureRandom.urlsafe_base64
    end
    
    def encrypt_token
        Digest::SHA1.hexdigest(remember_token.to_s)
    end
    
    # private
    def generate_token
        # get_token_for_send_to_db = generate_some_token
        self.remember_token = encrypt_token
    end
end
