package api.utility.data;

import java.util.Random;

public class LicensePlateGenerator {

	private static final String[] LETTERS = { "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "R",
			"S", "T", "U", "V", "W", "X", "Y", "Z" };
	private static final String[] NUMBERS = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };

	public static String generateLicensePlate() {
		StringBuilder licensePlate = new StringBuilder();

		Random random = new Random();

		// Add three random letters
		for (int i = 0; i < 3; i++) {
			int randomIndex = random.nextInt(LETTERS.length);
			licensePlate.append(LETTERS[randomIndex]);
		}

		// Add two random numbers
		for (int i = 0; i < 2; i++) {
			int randomIndex = random.nextInt(NUMBERS.length);
			licensePlate.append(NUMBERS[randomIndex]);
		}

		// Add tow more random letters
		for (int i = 0; i < 2; i++) {
			int randomIndex = random.nextInt(LETTERS.length);
			licensePlate.append(LETTERS[randomIndex]);
		}

		return licensePlate.toString();
	}

	public static void main(String[] args) {
		String generatedLicensePlate = generateLicensePlate();
		System.out.println("Generated License Plate: " + generatedLicensePlate);
	}
}
