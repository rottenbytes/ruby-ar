class Ar
  VERSION="0.1"

  ArMagic = "!<arch>\n"
  ArMagicPad = "\n"

  attr_reader :sourcefile, :files

  def initialize(filename, options = {})
    @sourcefile = filename
    @files = Hash.new
  end

  def load()
    fp = open(@sourcefile, "r+")
    magic = fp.read(ArMagic.length)
    if magic != ArMagic
      raise "Magic not found !"
    end

    begin
      filename = ""
      while filename != nil
        filename = fp.read(16)
        if filename.nil?
          return
        end
        filename.gsub!(/\/\s+$/,"")
        filename.strip!
        @files[filename] = Hash.new
        @files[filename]["date"] = fp.read(12).to_i
        @files[filename]["uid"] = fp.read(6).to_i
        @files[filename]["gid"] = fp.read(6).to_i
        @files[filename]["filemode"] = fp.read(8).to_i
        @files[filename]["filesize"] = fp.read(10).to_i
        if @files[filename]["filesize"] != 0
          fp.read(2)
          @files[filename]["payload"] = fp.read(@files[filename]["filesize"])
        else
          @files.delete(filename)
        end
      end
    rescue Exception => e
      puts e.message
      return
    end
  end

  def dump(filename, path = "./")
    dump_path = File.join(path, filename)
    File.open(dump_path, "w+") do |f|
      f.write(@files[filename]["payload"])
    end
  end

  def files
    @files.keys
  end

  def get_payload(filename)
    raise "File not in archive" unless self.files.include?(filename)
    @files[filename]["payload"]
  end
end
