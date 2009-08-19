class Date

  def day_name
    strftime('%A')
  end

  def month_name
    strftime('%B')
  end

  def day_of_month
    strftime('%d').to_i
  end

end
