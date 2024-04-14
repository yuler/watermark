class Task < ApplicationRecord
  has_one_attached :input
  has_one_attached :output

  after_create_commit :generate_output

  private
    # Use ffmpeg to generate the output file
    # `ffmpeg -i input -vf "colorlevels=rimin=0.99:gimin=0.99:bimin=0.99" output -y`
    def generate_output
      input.open do |file|
        output_path = file.path.sub(/\.png\z/, ".output.png")

        input.open do |file|
          system("ffmpeg -i #{file.path} -vf \"colorlevels=rimin=0.99:gimin=0.99:bimin=0.99\" #{output_path} -y")
          # Save to output to the database
          output.attach(io: File.open(output_path), filename: File.basename(output_path))
        end
      end
    end
end
