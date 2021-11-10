class PersonalCard

  def initialize
    @image       = get_image
    @name        = get_name
    @description = get_description
    @phone       = get_phone
    @email       = get_email
  end


  def get_image
    begin
      puts "Чтобы добавить фотографию в визитную карточку " +
      "введите ссылку на существующий файл в формате .jpg или .png"
      link = STDIN.gets.chomp
    end until File.exist?(link) && link[-4,4] =~ /\.(?:jpg|png)/
    
    link
  end


  def get_name
    begin
      puts "Введите фамилию имя и отчество:"
      name = STDIN.gets.chomp
    end until name =~
                   /\A(?=\A.{,100}\z) *[a-zа-яё]+ +[a-zа-яё]+ +[a-zа-яё]+ *\z/i
    # regexp не позволяет строке быть длиннее 100 символов и при этом позволяет
    # вводить лишние пробелы

    name = name.scan(/[a-zа-яё]+/i).map(&:capitalize).join(" ")
    # строка очищается от лишних пробелов, форматируется регистр
  end


  def get_description
    begin
      puts "Опишите деятельность человека (не более 60 символов):"
      description = STDIN.gets.chomp
    end while description.size > 60 && description =~ /<.+>/
    # regexp проверяет наличие вредоносного кода в описании

    description.strip!
    description[0] = description[0].upcase
    # описание всегда будет начинаться с большой буквы и не будет содержать
    # пробелов в начале и конце строки

    description
  end


  def get_phone
    begin
      puts "Введите номер телефона (только цифры):"
      print ("+7")
      phone = STDIN.gets.chomp
    end until phone =~ /\A\d{10}\z/

    "Телефон: +7 #{phone[0,3]} #{phone[3,3]}-#{phone[6,2]}-#{phone[8,2]}"
  end


  def get_email
    begin
      puts "Введите адрес электронной почты:"
      print ("Email: ")
      email = STDIN.gets.chomp.downcase
    end until email =~ /\A(?=\A.{,100}\z)[\w\.\-]+@[a-z\d\-]+\.[a-z]{2,}\z/

    "Email: #{email}"
  end


  def create_html_doc
    folder_path = File.dirname(__FILE__)
    file_path   = folder_path + "/personal_cards/pcard_#{@name}.html"
    file        = File.new(file_path, "w:UTF-8")

    file.puts("<!DOCTYPE html>\n")
    file.puts("<html lang = \"ru\">\n")
    file.puts("<head>\n  <meta charset=\"UTF-8\">\n" +
      "  <link href=\"#{folder_path + "/personal_cards/style.css"}\"" +
      " rel=\"stylesheet\" type=\"text/css\">\n</head>\n\n")
    file.puts("<body>\n#{create_body}</body>\n")
    file.puts("</html>")
    file.close
  end


  def create_body
    tab     = " "*2
    img_tag = tab*2 + "<img src = \"#{@image}\" alt = \"Личное фото\">\n"
    p_tags  = [@name, @description, @phone, @email]
    p_tags  = p_tags.map { |el| tab*2 + "<p>#{el}</p>\n" }.join

    tab + "<div class = \"card\">\n#{img_tag + p_tags}#{tab}</div>\n"
  end
end