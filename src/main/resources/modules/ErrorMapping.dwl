%dw 2.0

fun createErrorMapping(errorType, errorMessage) = {
	error: {
		errorType: (errorType.namespace) ++ ":" ++ (errorType.identifier),
		errorMessage: errorMessage,
		timestamp: now()
	}
}
