%dw 2.0

fun createErrorMapping(error) = do {
	var errorNamespace = error.errorType.namespace default "UNKNOWN"
	var errorIdentifier = error.errorType.identifier default "INTERNAL_ERROR"
	var errorMessage = error.detailedDescription default "An unexpected error occurred. No error object was passed"
	---
	error: {
		errorType: errorNamespace ++ ":" ++ errorIdentifier,
		errorMessage: errorMessage,
		timestamp: now()
	}
}
