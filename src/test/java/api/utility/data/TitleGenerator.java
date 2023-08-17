package api.utility.data;

import java.util.Random;

public class TitleGenerator {

	private static final String[] TITLES = {
	        "Mr.", "Ms.", "Mrs.", "Dr.", "Prof.", "Sir", "Madam"
	    };

	    private static final Random random = new Random();

	    public static String generateTitle() {
	        int index = random.nextInt(TITLES.length);
	        return TITLES[index];
	    }

	    public static void main(String[] args) {
	        String title = generateTitle();
	        System.out.println("Generated Title: " + title);
	    }
}
