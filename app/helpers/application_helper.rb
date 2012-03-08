module ApplicationHelper
  
  def th_sortable(column, title = nil)
    title ||= column.titleize
    current = column == sort_column
    css_class = current ? "current #{sort_direction}" : nil
    id_name = "#{column}_header"
    direction = current && sort_direction == "asc" ? "desc" : "asc"
    haml_tag :th, :class => css_class do
      link_to title, {:sort => column, :direction => direction}, {:id => id_name}
    end
  end

end
