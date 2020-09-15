module DrawCell
  module_function

  def call(cell)
    cell&.live? ? 'o ' : '. '
  end
end
