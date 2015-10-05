class String
  def camelize
    str = self.split('_').map {|w| w.capitalize}.join
    str[0] = str[0].downcase!
    str
  end
end