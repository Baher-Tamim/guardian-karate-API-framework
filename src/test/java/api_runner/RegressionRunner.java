package api_runner;

import com.intuit.karate.junit5.Karate;

public class RegressionRunner {

	@Karate.Test
	public Karate runTest()	{
		// Address for out feature files
		// tags. for certain test
		return Karate.run("classpath:features") // address for feature file
				.tags("@Regression");
	}
}
