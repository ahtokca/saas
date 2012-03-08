module ApplicationHelper
  
  def sortable(column, title = nil)
    title ||= column.titleize
    current = column == sort_column
    css_class = current ? "current #{sort_direction}" : nil
    id_name = current ? "#{column}_header" : nil
    direction = current && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class, :id => id_name}
  end

end
