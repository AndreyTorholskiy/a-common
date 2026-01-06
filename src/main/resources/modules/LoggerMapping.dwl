%dw 2.0

fun createErrorLoggerMapping(error: Error) = do {
	var flowName = (error.failingComponent splitBy "/processors")[0] default "UNKNOWN_FLOW"
	var sourceName = (error.dslSource splitBy " ")[0][1 to -1] default "UNKNOWN_SOURCE"
	var configFileLocation = (error.failingComponent splitBy "@")[1] default "UNKNOWN_FILE"
	---
	{
		flowName: flowName,
		sourceName: sourceName,
		configFileLocation: configFileLocation
	}
}
