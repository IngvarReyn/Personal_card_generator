def get_name
  begin
    puts "Введите фамилию имя и отчество"
    name = STDIN.gets.chomp
  end until name =~ /\A(?=\A.{,100}\z) *[a-zа-яё]+ +[a-zа-яё]+ +[a-zа-яё]+ *\z/i
  # regexp не позволяет строке быть длиннее 100 символов и при этом позволяет
  # вводить лишние пробелы

  name = name.scan(/[a-zа-яё]+/).map(&:capitalize).join(" ")
  # строка очищается от лишних пробелов, форматируется регистр
end


def get_description
  begin
    puts "Опишите деятельность человека (не более 60 символов)"
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
    puts "Введите номер телефона (только цифры)"
    print ("+7")
    phone = STDIN.gets.chomp
  end until phone =~ /\A\d{10}\z/

  "Телефон: +7 #{phone[0,3]} #{phone[3,3]}-#{phone[6,2]}-#{phone[8,2]}"
end


def get_email
  begin
    puts "Введите адрес электронной почты"
    print ("Email: ")
    email = STDIN.gets.chomp.downcase
  end until email =~ /\A(?=\A.{,100}\z)[\w\.\-]+@[a-z\d\-]+\.[a-z]{2,}\z/

  "Email: #{email}"
end