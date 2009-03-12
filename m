From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 58/86] [ARM] OMAP3 clock: optimize DPLL rate rounding algorithm
Date: Thu, 12 Mar 2009 11:28:08 -0700
Message-ID: <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255AbZCLScs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:32:48 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:32:46 -0700 (PDT)
In-Reply-To: <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

The previous DPLL rate rounding algorithm counted the divider (N) down
from the maximum to 1.  Since we currently use a broad DPLL rate
tolerance, and lower N values are more power-efficient, we can often
bypass several iterations through the loop by counting N upwards from
1.

Peter de Schrijver <peter.de-schrijver@nokia.com> put up with several
test cycles of this patch - thanks Peter.

linux-omap source commit is 6f6d82bb2f80fa20a841ac3e95a6f44a5a156188.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Peter de Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 2f0eaaa..76e20bc 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -45,7 +45,7 @@
 #define DPLL_MIN_DIVIDER		1
 
 /* Possible error results from _dpll_test_mult */
-#define DPLL_MULT_UNDERFLOW		(1 << 0)
+#define DPLL_MULT_UNDERFLOW		-1
 
 /*
  * Scale factor to mitigate roundoff errors in DPLL rate rounding.
@@ -826,7 +826,7 @@ static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
 			   unsigned long target_rate,
 			   unsigned long parent_rate)
 {
-	int flags = 0, carry = 0;
+	int r = 0, carry = 0;
 
 	/* Unscale m and round if necessary */
 	if (*m % DPLL_SCALE_FACTOR >= DPLL_ROUNDING_VAL)
@@ -847,13 +847,13 @@ static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
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
@@ -892,21 +892,27 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 
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
@@ -918,16 +924,11 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
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
-- 
1.6.1.2

