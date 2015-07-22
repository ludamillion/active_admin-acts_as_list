module ActiveAdmin
  module ActsAsList
    module Helper
      # Call this inside your index do...end block to make your resource sortable.
      #
      # Example:
      #
      # #app/admin/players.rb
      #
      #  ActiveAdmin.register Player do
      #    index do
      #      # This adds columns for moving up, down, top and bottom.
      #      sortable_columns
      #      #...
      #      column :firstname
      #      column :lastname
      #      default_actions
      #    end
      #  end
      def sortable_columns
        column 'Position' do |resource|
          links = ''.html_safe
          unless resource.first?
            links += include_column_move_to_top(resource)
            links += include_column_move_up(resource)
          end
          unless resource.last?
            links += include_column_move_down(resource)
            links += include_column_move_to_bottom(resource)
          end
          links
        end
      end

      # Call this inside your resource definition to add the needed member actions
      # for your sortable resource.
      #
      # Example:
      #
      # #app/admin/players.rb
      #
      #  ActiveAdmin.register Player do
      #    # Sort players by position
      #    config.sort_order = 'position'
      #
      #    # Add member actions for positioning.
      #    sortable_member_actions
      #  end
      def sortable_member_actions
        include_member_action_move_to_top
        include_member_action_move_to_bottom
        include_member_action_move_up
        include_member_action_move_down
      end

      private

      def include_column_move_to_top(resource)
        link_to(generate_path_for_action(:move_to_top, resource), :class => "member_link icon") do
          content_tag(:i, '', class: "icon-angle-double-up", title: "Move to top")
        end
      end

      def include_column_move_up(resource)
        link_to(generate_path_for_action(:move_up, resource), :class => "member_link icon") do
          content_tag(:i, '', class: "icon-angle-up", title: "Move up")
        end
      end

      def include_column_move_down(resource)
        link_to(generate_path_for_action(:move_down, resource), :class => "member_link icon") do
          content_tag(:i, '', class: "icon-angle-down", title: "Move down")
        end
      end

      def include_column_move_to_bottom(resource)
        link_to(generate_path_for_action(:move_to_bottom, resource), :class => "member_link icon") do
          content_tag(:i, '', class: "icon-angle-double-down", title: "Move to bottom")
        end
      end

      def include_member_action_move_to_top
        member_action :move_to_top do
          if resource.first?
            redirect_to :back, :notice => "That #{resource_class.model_name.human.titleize} is already at the top"
            return
          end

          resource.move_to_top
          redirect_to :back, :notice => "Moved #{resource_class.model_name.human.titleize} to top"
        end
      end

      def include_member_action_move_to_bottom
        member_action :move_to_bottom do
          if resource.last?
            redirect_to :back, :notice => "That #{resource_class.model_name.human.titleize} is already at the bottom"
            return
          end

          resource.move_to_bottom
          redirect_to :back, :notice => "Moved #{resource_class.model_name.human.titleize} to bottom"
        end
      end

      def include_member_action_move_up
        member_action :move_up do
          if resource.first?
            redirect_to :back, :notice => "#{resource_class.model_name.human.titleize} cannot be moved any further up"
            return
          end

          resource.move_higher
          redirect_to :back, :notice => "#{resource_class.model_name.human.titleize} moved up"
        end
      end

      def include_member_action_move_down
        member_action :move_down do
          if resource.last?
            redirect_to :back, :notice => "#{resource_class.model_name.human.titleize} cannot be moved any futher down"
            return
          end

          resource.move_lower
          redirect_to :back, :notice => "#{resource_class.model_name.human.titleize} moved down"
        end
      end

      def generate_path_for_action(action, resource)
        self.send("#{action}_admin_#{resource.class.model_name.underscore.gsub("/", "_")}_path".to_sym, resource)
      end

    end
  end
end
