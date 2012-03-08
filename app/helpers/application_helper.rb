module ApplicationHelper
  
  def sortable(column_names, column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column(column) ? "current #{sort_direction}" : nil
    direction = column == sort_column(column) && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
  
  def sort_column(column_names, column=nil)
    column_names.include?(params[:sort]) ? params[:sort] : column
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
