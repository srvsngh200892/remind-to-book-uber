module ApplicationHelper
	def formatDate(date)
    # date.strftime("dd/mm/yy".gsub('dd','%d').gsub('mm', '%m').gsub('yy', '%y')) if date.present? 
    date.strftime("%d/%m/%Y") if date.present?
  end

  def formatDateSlim(date)
    # date.strftime("dd/mm/yy".gsub('dd','%d').gsub('mm', '%m').gsub('yy', '%y')) if date.present? 
    date.strftime("%d/%m/%y") if date.present?
  end

  def formatTime(time)
    time.strftime("%H:%M %p") if time.present?
  end

  def formatDateTime(date, format=false)
    if date.present?
      if format
        date.strftime(format)
      else
        date.strftime("%d/%m/%Y @ %I:%M%P")
      end
    end
  end
end
