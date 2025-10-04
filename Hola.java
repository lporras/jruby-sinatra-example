// Hola.java
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Hola {
    public void saludar() {
        System.out.println("Hola mundo desde Java!");
        LocalDateTime ahora = LocalDateTime.now();
        System.out.println("La hora actual es: " +
            ahora.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }

    public static void main(String[] args) {
        new Hola().saludar();
    }
}