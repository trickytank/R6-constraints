library(R6)
library(checkmate)

CONSTRAINT <- R6Class(
  "CONSTRAINT",
  private = list(
    x_ = 0
  ),
  active = list(
    x = function(value) {
      if (missing(value)) {
        return(private$x_)
      } else {
        check <- checkmate::checkNumber(value)
        if(is.character(check)) {
          stop("Value attempting to be assigned to x is not valid: ", check)
        }
        value
      }
    },
  )
)

A <- CONSTRAINT$new()
A$x <- 5 # Successful
A$x <- 1L # Successful
A$x <- pi # Successful
A$x <- c(3,5) # Throws an error
A$x <- "SD" # Throws an error

# Unfortunately this means that when printing the object,
# $x is listed as an active binding rather than showing what value we intend to store there.
#


# Would like to be able to use specify it this way, which is far less convoluted.

CONSTRAINT_IDEAL <- R6Class(
  "CONSTRAINT",
  public = list(
    x = 0
  ),
  constraints = list(
    x = checkmate::checkNumber # this can be any function that returns TRUE when the field is within the constraints.
  )
)

# My main problem is I don't know if this is a possible extension of public/private fields,
# or whether this would have to stick to active bindings, with a rewrite of the R6.print method
# to show the values of these constrained fields.


CONSTRAINT_IDEAL_2 <- R6Class(
  "CONSTRAINT",
  public = list(
    x = 0
  ),
  constraints = list(
    x = function(z) { checkmate::checkNumber(z) }
  )
)
