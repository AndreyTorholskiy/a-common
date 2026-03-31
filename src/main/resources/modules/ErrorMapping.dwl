%dw 2.0

fun createErrorMapping(error) = do {
	// Variable to store downstream errors
	var downstreamError = error.errorMessage.payload.error default null
	
	// Variables if not downstream errors were occurred
	var localErrorNamespace = error.errorType.namespace default "UNKNOWN"
	var localErrorIdentifier = error.errorType.identifier default "INTERNAL_ERROR"
	
	// Mapping logic
	var finalErrorType = if (downstreamError != null and downstreamError.errorType != null)
							downstreamError.errorType
						else 
							localErrorNamespace ++ ":" ++ localErrorIdentifier
							
	var finalErrorMessage = if (downstreamError != null and downstreamError.errorMessage != null)
								downstreamError.errorMessage
							else
								error.description default "An unexpected error occurred. No error object was passed"
	---
	error: {
		errorType: finalErrorType,
		errorMessage: finalErrorMessage,
		timestamp: now()
    }
}