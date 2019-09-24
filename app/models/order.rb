class Order < ApplicationRecord
	belongs_to :branch
	has_many :order_items
	has_many :order_discounts
	has_one :invoice

	include Algorithm::Literalizer
	include Invoicing::ControlCodeGenerator

	def order_total2
		total = 0
        order_items.each do |order_item| 
	        if order_item.branch_product_id != nil 
	        	if order_item.branch_product_id != 23 and order_item.branch_product_id != 24 and order_item.branch_product_id != 25 and order_item.branch_product_id != 26 and order_item.branch_product_id != 27 and order_item.branch_product_id != 28 and order_item.branch_product_id != 29
	        		total += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost 	
	        	end
	        	
	        else 
	        	total += order_item.quantity * Combo.find(order_item.combo_id).sale_cost 
	        end 
	    end 
	    if order_state == true or order_state.nil? 
	       return total
	    else 
	        return 0
	    end 
	    
	end

	def	literal amount
		literate_es amount
	end

	def code_control num, nit, amount, branch
		if branch == 1
   			dosi = Dosification.first
		end
		if branch == 2
			dosi = Dosification.second
		end
		auth_number = dosi.authorization_number
		in_key = dosi.dosification_key
		in_number = num
		in_nit = nit
		in_am = amount
		in_year = created_at.strftime("%Y")
		in_month = created_at.strftime("%m")
		in_day = created_at.strftime("%d")
		in_date = in_year.to_s + in_month.to_s + in_day.to_s
		in_final_date = in_date.to_i
		control_code_for authorization: auth_number, number: in_number, nit: in_nit, date: in_final_date, amount: in_am, key: in_key
	end
	
	def show_code_control auth_number, in_number, in_nit, in_final_date, in_am, in_key
		control_code_for authorization: auth_number, number: in_number, nit: in_nit, date: in_final_date, amount: in_am, key: in_key
	end

	def self.get_orders_since start_id
		orders = []
	    Order.all.each do |order|
	      if order.id.to_i >= start_id
	        orders.push order
	      end
	    end
	    
	    filepath = "#{Rails.root}/public/orders.txt"

		File.open(filepath, "w") do |order_row|
			row_content = ""
			orders.each do |file_order|
				row_content += "'" + file_order.created_at.to_s + "', "
				
				



				#row_content = "Order.create" 

				#if file_order.name.nil? or file_order.name == ""
				#	row_content += " name: ''"
				#else
				#	row_content += " name: '" + file_order.name.to_s + "'"
				#end

				#if file_order.nit.nil? or file_order.nit == ""
				#	row_content += ", nit: ''"
				#else
				#	row_content += ", nit: '" + file_order.nit.to_s + "'"
				#end

				#if file_order.amount_payed.nil?
				#	row_content += ", amount_payed: 0"
				#else
				#	row_content += ", amount_payed: " + file_order.amount_payed.to_s
				#end

				#if file_order.details.nil? or file_order.details == ""
				#	row_content += ", details: ''"
				#else
				#	row_content += ", details: '" + file_order.details.to_s + "'"
				#end

				#row_content += + ", branch_id: " + file_order.branch_id.to_s + ", status: " + file_order.status.to_s + ", order_total: " + file_order.order_total.to_s

				#order_row.puts row_content
			end
			order_row.puts row_content
		end

  	end

end
