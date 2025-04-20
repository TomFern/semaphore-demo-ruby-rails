Rails.application.configure do
  # Other development environment config...

  # Configure file watcher to use polling instead of inotify
  config.file_watcher = ActiveSupport::FileUpdateChecker
  
  # Or for Rails 6+, you can use this more explicit configuration:
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker.new(
  #   [], 
  #   {}, 
  #   polling: true
  # )

  # Optional: Adjust polling interval (in seconds) if needed
  # Lower values check more frequently but use more resources
  # Default is 0.5 seconds
  config.reload_classes_only_on_change = true
  
  # Rest of your development environment config...
end
