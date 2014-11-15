## This function makes a matrix that supports caching
## and then caches the inverse of the matrix

## This function assumes the matrix is invertible.  Error checking needed (later)
##   since that is not always true

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  ## Set the matrix given values y
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  ## Get the matrix
  get <- function() x
  ## Set the inverse given the inverse 'solve'
  setinv <- function(solve) m <<- solve
  ## Get the inverse, which is m
  getinv <- function() m
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}

## Caches the inverse of x

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  
  m<-x$getinv()
  if(!is.null(m)) {
    ## m is not null, inv exists
    message("Getting Cached Data")
    return(m)
  }
  ## Got here because m is null, inv does not exist
  ## Put x into data
  data <- x$get()
  ## invert data and put into m
  m <- solve(data)
  x$setinv(m)
  ## Return m
  m
  }