### original get_pred_ci_no_der()


get_pred_ci_gp <- function(eb_par, x, x_test, y, n_draw = 1000) {
    K11 <- compute_cov_1d(x, x, tau = eb_par[2], h = eb_par[3])
    K12 <- compute_cov_1d(x, x_test, tau = eb_par[2], h = eb_par[3])
    K22 <- compute_cov_1d(x_test, x_test, tau = eb_par[2], h = eb_par[3])
    Ky <- K11 + diag(eb_par[1] ^ 2, length(x))
    
    Sig_test <- K22 - emulator::quad.form.inv(Ky, K12) 
    Sig_test <- as.matrix(Matrix::nearPD(Sig_test)$mat)
    R <- chol(Ky)
    # B <- forwardsolve(t(R), y)
    # aa <- backsolve(R, forwardsolve(t(R), y))
    mu_test <- crossprod(K12, backsolve(R, forwardsolve(t(R), y)))  ## no mu
    pred_f <- mvnfast::rmvn(n_draw, mu = mu_test, sigma = Sig_test)
    PI_pred_f <- apply(pred_f, 2, quantile, prob = c(0.025, 0.975))
    # CI_Low_f <- apply(pred_f, 2, quantile, prob = 0.025)
    # CI_High_f <- apply(pred_f, 2, quantile, prob = 0.975)
    return(list(mu_test = mu_test, ci_low = PI_pred_f[1, ], 
                ci_high = PI_pred_f[2, ], pred_f = pred_f))
}

# get_pred_ci_no_der <- function(eb_par, x, x_test, y, alpha = 2, n_draw = 1000) {
#     K11 <- computeCov_new_h(x, x, alpha = alpha, tau = eb_par[2], 
#                             h = eb_par[3])
#     K12 <- computeCov_new_h(x, x_test, alpha = alpha, tau = eb_par[2], 
#                             h = eb_par[3])
#     K22 <- computeCov_new_h(x_test, x_test, alpha = alpha, tau = eb_par[2], 
#                             h = eb_par[3])
#     Ky <- K11 + diag(eb_par[1] ^ 2, length(x))
#     
#     Sig_test <- K22 - quad.form.inv(Ky, K12) 
#     Sig_test <- as.matrix(nearPD(Sig_test)$mat)
#     R <- chol(Ky)
#     B <- forwardsolve(t(R), y)
#     aa <- backsolve(R, B)
#     mu_test <- crossprod(K12, aa)  ## no mu
#     pred_f <- rmvn(n_draw, mu = mu_test, sigma = Sig_test)
#     CI_Low_f <- apply(pred_f, 2, quantile, prob = 0.025)
#     CI_High_f <- apply(pred_f, 2, quantile, prob = 0.975)
#     return(list(mu_test = mu_test, ci_low = CI_Low_f, ci_high = CI_High_f, 
#                 pred_f = pred_f))
# }
# 
# 
# get_pred_ci_gp_new <- function(eb_par, x, x_test, y, H0_x, n_draw = 1000) {
#     K11 <- se_ker(H0 = H0_x, tau = eb_par[2], h = eb_par[3])
#     K12 <- compute_cov_1d(x, x_test, tau = eb_par[2], h = eb_par[3])
#     K22 <- compute_cov_1d(x_test, x_test, tau = eb_par[2], h = eb_par[3])
#     Ky <- K11 + diag(eb_par[1] ^ 2, length(x))
#     
#     Sig_test <- K22 - emulator::quad.form.inv(Ky, K12) 
#     Sig_test <- as.matrix(Matrix::nearPD(Sig_test)$mat)
#     R <- chol(Ky)
#     # B <- forwardsolve(t(R), y)
#     # aa <- backsolve(R, forwardsolve(t(R), y))
#     mu_test <- crossprod(K12, backsolve(R, forwardsolve(t(R), y)))  ## no mu
#     pred_f <- rmvn(n_draw, mu = mu_test, sigma = Sig_test)
#     PI_pred_f <- apply(pred_f, 2, quantile, prob = c(0.025, 0.975))
#     # CI_Low_f <- apply(pred_f, 2, quantile, prob = 0.025)
#     # CI_High_f <- apply(pred_f, 2, quantile, prob = 0.975)
#     return(list(mu_test = mu_test, ci_low = PI_pred_f[1, ], 
#                 ci_high = PI_pred_f[2, ], pred_f = pred_f))
# }








