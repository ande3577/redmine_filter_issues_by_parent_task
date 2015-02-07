module RedmineFilterIssuesByParentTask
  module Patches
    module CustomizeNotificationUsersHelperPatch
      def self.included(base)
        unloadable
        
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method_chain :initialize_available_filters, :parent_task
        end
      end
      
      module ClassMethods
      end
      
      module InstanceMethods
        def initialize_available_filters_with_parent_task
          initialize_available_filters_without_parent_task
          add_available_filter "parent_id", :name => l(:field_parent_issue), :type => :integer
        end
      end
      
    end
  end
end

IssueQuery.send(:include, RedmineFilterIssuesByParentTask::Patches::CustomizeNotificationUsersHelperPatch) unless IssueQuery.included_modules.include?(RedmineFilterIssuesByParentTask::Patches::CustomizeNotificationUsersHelperPatch)