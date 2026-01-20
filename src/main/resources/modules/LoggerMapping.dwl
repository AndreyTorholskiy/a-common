%dw 2.0

fun createErrorLoggerMapping(error) = do {
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

fun createInitialRequestMapping(correlationId, attributes, app) = do {	
	var apiName = app.name default "UNKNOWN_NAME"
	var requestedURI = attributes.relativePath 
	var method = attributes.method
	var scheme = attributes.scheme
	---
	{
	    correlationId: correlationId,
	    processingApi: apiName,    
	    (requestedURI: requestedURI) if (!isEmpty(requestedURI)),
	    (method: method) if (!isEmpty(method)),
	    (scheme: scheme) if (!isEmpty(scheme)),
	    timestamp: now(),
		processingStage: "IN_PROGRESS" 
	}
}