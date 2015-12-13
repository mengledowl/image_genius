AppConfig.configuration do |config|
  # all paths/directories are relative to the directory that this project is in
  # set the directory where the new files should be saved
  # config.output_path = 'output/pics/'

  # set the directory that your files are in
  config.input_path = "../../Pictures/sample-images/"

  # set output directory policy - defaults to :destroy
  # :ignore to ignore any pre-existing files and subdirectories
  # :destroy to wipe them all and start with a fresh directory
  # config.output_directory_policy = :ignore
end