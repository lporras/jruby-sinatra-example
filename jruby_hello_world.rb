java_import 'java.time.LocalDateTime'
java_import 'java.time.format.DateTimeFormatter'

class Hola
  def saludar
    puts "Hola mundo desde JRuby!"

    ahora = LocalDateTime.now
    formato = DateTimeFormatter.of_pattern("yyyy-MM-dd HH:mm:ss")
    puts "La hora actual (usando Java) es: #{ahora.format(formato)}"
  end
end

Hola.new.saludar
