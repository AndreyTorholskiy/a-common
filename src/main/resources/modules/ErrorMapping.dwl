%dw 2.0

fun createErrorMapping(error) = do {
	// Variable to store downstream errors
	var downstreamError = error.errorMessage.payload default null
	
	// Variables if not downstream errors were occurred
	var localErrorNamespace = error.errorType.namespace default "UNKNOWN"
	var localErrorIdentifier = error.errorType.identifier default "INTERNAL_ERROR"
	
	// Mapping logic
	var finalErrorType = if (downstreamError != null and downstreamError.errorInfo.errorType != null)
							downstreamError.errorInfo.errorType
						else 
							localErrorNamespace ++ ":" ++ localErrorIdentifier
							
	var finalErrorMessage = if (downstreamError != null and downstreamError.errorInfo.errorMessage != null)
								downstreamError.errorInfo.errorMessage
							else
								error.description default "An unexpected error occurred. No error object was passed"
	---
	errorInfo: {
		errorType: finalErrorType,
		errorMessage: finalErrorMessage,
		timestamp: now()
    }
}