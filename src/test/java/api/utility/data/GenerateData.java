package api.utility.data;

public class GenerateData {

	// Generating random 10 digit phone number
		// @return String random phone number
		
		public static String getPhoneNumber()	{
			String phoneNumber = "510";
			for (int i = 0; i < 7; i ++)	{
				phoneNumber += (int) (Math.random() * 10);
			}
			return phoneNumber;
		}
		
		public static void main(String[] args) {
			String number = getPhoneNumber();
			System.out.println(number);
			System.out.println(number.length());
			String email = getEmail();
			GenerateData data = new GenerateData();
			System.out.println(data.getEmail());
			System.out.println(getUsername());
		}
		
		// Generating random email
		// @return String random email
		
		public static String getEmail()	{
			String prefix = "apitest";
			String provider = "@gmail.com";
			
			// apitest(random number)@gmail.com
			
			int random = (int) (Math.random() * 1000);
			String email = prefix + random + provider;
			return email;
		}
		
		// public static void main(String[] args) {
			
			// GenerateData data = new GenerateData();
			// System.out.println(data.getEmail());	
		// }

		public static String getUsername()	{
			String prefix = "api_user";
			int random = (int)(Math.random()*10000);
			return prefix.concat(String.valueOf(random));
		}

}
