### log marginal likelihood for standard GP
## original log_marginal_lik_gp_0_h() 

# log_mar_lik_gp <- function(theta, y, x_vec = NULL, H0 = NULL) {
#     if (is.null(H0)) {
#         H0 <- outer(as.vector(x_vec), as.vector(x_vec), 
#                     FUN = function(x1, x2) (x1 - x2))
#     }
#     K <- power_expo_h(H0, theta[2], theta[3])
#     n <- length(y)
#     return(-mvnfast::dmvn(y, rep(0L, n), K + diag(theta[1] ^ 2, n), log = TRUE))
# }



log_mar_lik_gp <- function(theta, y, H0) {
    
    # K <- compute_cov_1d(idx1 = x_vec, tau = theta[2], h = theta[3])
    K <- se_ker(H0 = H0, tau = theta[2], h = theta[3])
    n <- length(y)
    return(-mvnfast::dmvn(y, rep(0L, n), K + diag(theta[1] ^ 2, n), log = TRUE))
}

# microbenchmark(log_mar_lik_gp_new(theta = c(1, 1, 1), y = YY[[1]]$y, 
#                                   x_vec = YY[[1]]$x),
#                log_mar_lik_gp(theta = c(1, 1, 1), y = YY[[1]]$y, 
#                               H0 = H0_diff[[1]]), times = 5000)




