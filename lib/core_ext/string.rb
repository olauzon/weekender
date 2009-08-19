class String

  # Aligns each line n spaces.
  #
  # CREDIT: Gavin Sinclair
  #
  def tab(n)
    gsub(/^ */, ' ' * n)
  end

  def add(string)
    self << "\n#{string}"
  end

end
