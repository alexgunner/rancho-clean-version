class ReportsController < ApplicationController
	def index

	end

	def orders_report
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)
		
		store = params[:store]["store_id"]
		
		@orders = []
		@total_sold = 0
		@total_sold2 = 0
		Order.all.each do |order|
			if order.created_at >= @init_date and order.created_at <= (@final_date +1.day) and order.status == true and order.branch_id.to_s == store.to_s
				@orders.push(order)
				@total_sold += order.total_order_amount
			end
		end
	end

	def products_report
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)


		@branch_products = BranchProduct.all
		store = params[:store]["store_id"]
		if store == "2"
			redirect_to 'http://hiper.rocotopicante.com/products_report?utf8=✓&init_date[initial_date(1i)]=' + initial_year.to_s + '&init_date[initial_date(2i)]=' + initial_month.to_s + '&init_date[initial_date(3i)]=' + initial_day.to_s + '&end_date[final_date(1i)]=' + final_year.to_s + '&end_date[final_date(2i)]=' + final_month.to_s + '&end_date[final_date(3i)]=' + final_day.to_s + '&store[store_id]=' + store + '&commit=Aceptar'
		end
		if store == "1"
			redirect_to 'http://mikhuna.rocotopicante.com/products_report?utf8=%E2%9C%93&init_date[initial_date(1i)]=' + initial_year.to_s + '&init_date[initial_date(2i)]=' + initial_month.to_s + '&init_date[initial_date(3i)]=' + initial_day.to_s + '&end_date[final_date(1i)]=' + final_year.to_s + '&end_date[final_date(2i)]=' + final_month.to_s + '&end_date[final_date(3i)]=' + final_day.to_s + '&store[store_id]=' + store + '&commit=Aceptar'
		end
	end

	def orders_report_excel
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)

		@orders = []
		@total_sold = 0
		Order.all.each do |order|
			if order.created_at >= @init_date and order.created_at <= @final_date and order.status == true
				@orders.push(order)
				order.order_items.each do |order_item|
					if order_item.branch_product_id != nil
						@total_sold += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost
					else
						@total_sold += order_item.quantity * Combo.find(order_item.combo_id).sale_cost
					end
				end
			end
		end

		render xlsx: "orders_report"
	end

	def products_report_excel
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)


		@branch_products = BranchProduct.all

		render xlsx: "products_report"
	end

	def accounting_report
		
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)
		
		store = params[:store]["store_id"]

		@total_sold = 0
		invoices1 = Invoice.all.where(invoice_date: @init_date..@final_date)
		invoices1 = invoices1.order(invoice_number: :asc)
		@invoices = []
		invoices1.each do |i|
			if i.order.branch_id == store.to_i
				@invoices.push i
				@total_sold += i.invoice_amount
			end
		end

		
		#Order.all.each do |order|
		#	if order.created_at >= @init_date and order.created_at <= @final_date and order.status == true and !order.nit.empty? and order.branch_id == store.to_i
		#		@orders.push(order)
		#		order.order_items.each do |order_item|
		#			if order_item.branch_product_id != nil
		#				@total_sold += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost
		#			else
		#				@total_sold += order_item.quantity * Combo.find(order_item.combo_id).sale_cost
		#			end
		#		end
		#	end
		#end

		filepath = "#{Rails.root}/public/accounting_report.txt"

		File.open(filepath, "w") do |ar|
			@invoices.each_with_index do |invoice, index|
				if !Invoice.find_by(order_id: invoice.order.id).nil?
					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						valid = "V"
					else
						valid = "A"
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						if invoice.order.nit.empty?
							txt_nit = invoice.nit.to_s
						else
							txt_nit = invoice.nit.to_s
						end
					else
						txt_nit = invoice.nit.to_s
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						if invoice.order.name.empty?
							txt_name = invoice.name.to_s
						else
							txt_name = invoice.name.upcase.to_s
						end
					else
						txt_name = "ANULADA"
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						#txt_total = number_to_currency(total, unit: "", separator: ",", delimiter: ".", precision: 2)
						txt_total = invoice.invoice_amount
					else
						txt_total = 0
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						txt_control_code = invoice.invoice_code
						txt_control_code = txt_control_code.to_s
					else
						txt_control_code = "0"
					end

					if invoice.order.branch_id == 1
						txt_sis = "3"
					end
					if invoice.order.branch_id == 2
						txt_sis = "4"
					end 

					txt_row = txt_sis + "|" + (index + 1).to_s + "|" + invoice.invoice_date.strftime("%d/%m/%Y").to_s + "|" + invoice.invoice_number.to_s + "|" + invoice.invoice_authorization + "|" + valid + "|" + txt_nit + "|" + txt_name + "|" + txt_total.to_s + "|0.00|0.00|0.00|" + txt_total.to_s + "|0.00|" + txt_total.to_s + "|" + (txt_total * 0.13).round(2).to_s + "|" + txt_control_code
					ar.puts txt_row
				end
			end
		end
	end


	def accounting_report_disabled
		initial_date = params[:init_date]
		final_date = params[:end_date]

		initial_year = initial_date["initial_date(1i)"]
		initial_month = initial_date["initial_date(2i)"]
		initial_day = initial_date["initial_date(3i)"]

		initial_year = initial_year.to_i
		initial_month = initial_month.to_i
		initial_day = initial_day.to_i
		@init_date = Date.new(initial_year, initial_month, initial_day)


		final_year = final_date["final_date(1i)"]
		final_month = final_date["final_date(2i)"]
		final_day = final_date["final_date(3i)"]

		final_year = final_year.to_i
		final_month = final_month.to_i
		final_day = final_day.to_i
		@final_date = Date.new(final_year, final_month, final_day)
		
		store = params[:store]["store_id"]
		invoices1 = Invoice.where(invoice_date: @init_date..@final_date)
		@invoices = []
		invoices1.each do |invoice|
			if invoice.order.branch_id == store.to_i and invoice.order.order_state == false
				@invoices.push invoice
			end
		end
		

		#@orders = []
		@total_sold = 0
		#Order.all.each do |order|
		#	if order.created_at >= @init_date and order.created_at <= @final_date and order.status == true and order.order_state == false
		#		@orders.push(order)
		#		order.order_items.each do |order_item|
		#			if order_item.branch_product_id != nil
		#				@total_sold += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost
		#			else
		#				@total_sold += order_item.quantity * Combo.find(order_item.combo_id).sale_cost
		#			end
		#		end
		#	end
		#end

		filepath = "#{Rails.root}/public/accounting_report_disabled.txt"
		count = 0
		File.open(filepath, "w") do |ar|
			@invoices.each_with_index do |invoice, index|
				if !Invoice.find_by(order_id: invoice.order.id).nil? and invoice.order.order_state == false
					count += 1
					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						valid = "V"
					else
						valid = "A"
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						if invoice.order.nit.empty?
							txt_nit = "00"
						else
							txt_nit = invoice.order.nit.to_s
						end
					else
						txt_nit = "00"
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						if invoice.order.name.empty?
							txt_name = "SN"
						else
							txt_name = invoice.order.name.upcase
						end
					else
						txt_name = "ANULADA"
					end

					total = 0
					invoice.order.order_items.each do |order_item| 
						if order_item.branch_product_id != nil 
							total += order_item.quantity * BranchProduct.find(order_item.branch_product_id).sale_cost 
						else 
							total += order_item.quantity * Combo.find(order_item.combo_id).sale_cost 
						end 
					end 

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						#txt_total = number_to_currency(total, unit: "", separator: ",", delimiter: ".", precision: 2)
						txt_total = total
					else
						txt_total = 0
					end

					if Order.find(invoice.order.id).order_state == true or Order.find(invoice.order.id).order_state.nil?
						txt_control_code = invoice.invoice_code
						txt_control_code = txt_control_code.to_s
					else
						txt_control_code = "0"
					end

					if invoice.order.branch_id == 1
                                                txt_sis = "3"
                                        end
                                        if invoice.order.branch_id == 2
                                                txt_sis = "4"
                                        end

					txt_row = txt_sis + "|" + (count).to_s + "|" + invoice.invoice_date.strftime("%d/%m/%Y").to_s + "|" + invoice.invoice_number.to_s + "|" + invoice.invoice_authorization + "|" + valid + "|" + txt_nit + "|" + txt_name + "|" + txt_total.to_s + "|0.00|0.00|0.00|" + txt_total.to_s + "|0.00|" + txt_total.to_s + "|" + (txt_total * 0.13).round(2).to_s + "|" + txt_control_code
					ar.puts txt_row
				end
			end
		end

	end

	def accounting_txt
		send_file("#{Rails.root}/public/accounting_report.txt", filename: "accounting.txt")
	end

	def accounting_disabled_txt
		send_file("#{Rails.root}/public/accounting_report_disabled.txt", filename: "accounting_report_disabled.txt")
	end
end
