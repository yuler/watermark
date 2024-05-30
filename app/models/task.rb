class Task < ApplicationRecord
  has_one_attached :input
  has_one_attached :output

  after_create_commit :generate_output

  private
    # Use ffmpeg to generate the output file
    # `ffmpeg -i input.png -vf "curves=psfile=watermark.acv:interp=pchip" -update 1 output.png`
    def generate_output
      input.open do |file|
        output_path = file.path.sub(/\.png\z/, ".output.png")

        input.open do |file|
          # Run the ffmpeg command
          system("ffmpeg -i #{file.path} -vf \"curves=psfile=watermark.acv:interp=pchip\" -update 1 #{output_path} -y")
          # Save to output to the database
          output.attach(io: File.open(output_path), filename: File.basename(output_path))
        end
      end
    end
end
