class DocumentValidator

    def self.call(cpf)
        {
            status: 200,
            valid: cpf.blank?? false : true,
            errors: fetch_errors(cpf)
        }
   rescue StandardError => exception
       Rails.logger.error("\n\n\n\n mano deu um erro aki ... #{exception.message} - #{exception.class}")
       {
           error: exception.message
       }
    end

    private

    def self.fetch_errors(cpf)
       errors = []

        errors << 'voce precisa passar um cpf' if cpf.blank?

       errors << 'cpf nao é valido' if !is_valid(cpf)
        
       errors
    end

   def self.is_valid(cpf) 
     return is_valid_steep1(cpf) && is_valid_steep2(cpf) ? true : false     
   end

  def self.is_valid_steep1(cpf)
    cpf = cpf.delete("^0-9")     
    count =0;
    result = 0;
    i =10;      
     if cpf.size== 11         
         9.times do           
            result = result + cpf[count].to_i*i        
            count+= 1 
            i-=1
         end
         result =  (result*10)%11   
         result == 10 ? 0 : result          
         return result == cpf[9].to_i ? true : false              
     else         
        return   false
     end 
  end

  def self.is_valid_steep2(cpf)
    cpf = cpf.delete("^0-9")     
    count =0;
    result = 0;
    i =11;   
         10.times do           
            result = result + cpf[count].to_i*i        
            count+= 1 
            i-=1
         end    
         result =  (result*10)%11 
         result == 10 ? 0 : result               
         return result == cpf[10].to_i ? true : false             
     end
end
