From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] OMAP3 clock: optimize DPLL rate rounding algorithm
Date: Wed, 12 Nov 2008 11:51:01 -0700
Message-ID: <20081112185035.31228.89899.stgit@localhost.localdomain>
References: <20081112183754.31228.73844.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56915 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYKLSxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 13:53:16 -0500
In-Reply-To: <20081112183754.31228.73844.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Peter de Schrijver <peter.de-schrijver@nokia.com>

The previous DPLL rate rounding algorithm counted the divider (N) down
from the maximum to 1.  Since we currently use a broad DPLL rate
tolerance, and lower N values are more power-efficient, we can often
bypass several iterations through the loop by counting N upwards from
1.

Peter de Schrijver <peter.de-schrijver@nokia.com> put up with several
test cycles of this patch - thanks Peter.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Peter de Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clock.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 7aefabb..bd3be45 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -48,7 +48,7 @@
 #define DPLL_MIN_DIVIDER		1
 
 /* Possible error results from _dpll_test_mult */
-#define DPLL_MULT_UNDERFLOW		(1 << 0)
+#define DPLL_MULT_UNDERFLOW		-1
 
 /*
  * Scale factor to mitigate roundoff errors in DPLL rate rounding.
@@ -877,7 +877,7 @@ static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
 			   unsigned long target_rate,
 			   unsigned long parent_rate)
 {
-	int flags = 0, carry = 0;
+	int r = 0, carry = 0;
 
 	/* Unscale m and round if necessary */
 	if (*m % DPLL_SCALE_FACTOR >= DPLL_ROUNDING_VAL)
@@ -898,13 +898,13 @@ static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
 	if (*m < DPLL_MIN_MULTIPLIER) {
 		*m = DPLL_MIN_MULTIPLIER;
 		*new_rate = 0;
-		flags = DPLL_MULT_UNDERFLOW;
+		r = DPLL_MULT_UNDERFLOW;
 	}
 
 	if (*new_rate == 0)
 		*new_rate = _dpll_compute_new_rate(parent_rate, *m, n);
 
-	return flags;
+	return r;
 }
 
 /**
@@ -943,21 +943,27 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 
 	dd->last_rounded_rate = 0;
 
-	for (n = dd->max_divider; n >= DPLL_MIN_DIVIDER; n--) {
+	for (n = DPLL_MIN_DIVIDER; n <= dd->max_divider; n++) {
 
 		/* Compute the scaled DPLL multiplier, based on the divider */
 		m = scaled_rt_rp * n;
 
 		/*
-		 * Since we're counting n down, a m overflow means we can
-		 * can immediately skip to the next n
+		 * Since we're counting n up, a m overflow means we
+		 * can bail out completely (since as n increases in
+		 * the next iteration, there's no way that m can
+		 * increase beyond the current m)
 		 */
 		if (m > scaled_max_m)
-			continue;
+			break;
 
 		r = _dpll_test_mult(&m, n, &new_rate, target_rate,
 				    clk->parent->rate);
 
+		/* m can't be set low enough for this n - try with a larger n */
+		if (r == DPLL_MULT_UNDERFLOW)
+			continue;
+
 		e = target_rate - new_rate;
 		pr_debug("clock: n = %d: m = %d: rate error is %d "
 			 "(new_rate = %ld)\n", n, m, e, new_rate);
@@ -969,16 +975,11 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 			min_e_n = n;
 
 			pr_debug("clock: found new least error %d\n", min_e);
-		}
 
-		/*
-		 * Since we're counting n down, a m underflow means we
-		 * can bail out completely (since as n decreases in
-		 * the next iteration, there's no way that m can
-		 * increase beyond the current m)
-		 */
-		if (r & DPLL_MULT_UNDERFLOW)
-			break;
+			/* We found good settings -- bail out now */
+			if (min_e <= clk->dpll_data->rate_tolerance)
+				break;
+		}
 	}
 
 	if (min_e < 0) {


