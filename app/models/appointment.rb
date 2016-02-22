class Appointment < ActiveRecord::Base
	validates :name, presence: true
	validates :phone_number, presence: true
	validates :time, presence: true

	after_create :reminder

	@@REMINDER_TIME = 5.minutes

	def reminder
		@twilio_number = '+16572050018'
		@client = Twilio::REST::Client.new 'AC3ed1bd440985eeeba70563aeeb7d2e9d','e7a902fa613187d672360ed38572b083'
    	time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
    	reminder = "Hi #{self.name}. Just a reminder that you have an appointment coming up at #{time_str}."
    	message = @client.account.messages.create(
      		:from => @twilio_number,
      		:to => self.phone_number,
      		:body => reminder,
    	)
    	puts message.to
 	 end

  	def when_to_run
    	time - @@REMINDER_TIME
 	end

  	handle_asynchronously :reminder, :run_at => Proc.new { |i| i.when_to_run }
end
