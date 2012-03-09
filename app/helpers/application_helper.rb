module ApplicationHelper
  
  def th_sortable(column, title = nil, ratings=[])
    title ||= column.titleize
    current = column == sort_column
    css_class = current ? "hilite" : nil
    id_name = "#{column}_header"
    direction = current && sort_direction == "asc" ? "desc" : "asc"
    capture_haml do
      haml_tag :th, :class => css_class do
        haml_concat link_to title, {:sort => column, :direction => direction, :ratings => array_to_hash(ratings)}, {:id => id_name}
      end
    end
  end
  
  def array_to_hash(a)
    Hash[*a.collect { |v| [v, v*2] }.flatten]
  end

end
