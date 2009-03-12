From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 57/86] [ARM] OMAP3 clock: remove unnecessary dpll_data dereferences
Date: Thu, 12 Mar 2009 11:28:07 -0700
Message-ID: <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757239AbZCLSco (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:32:44 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:32:42 -0700 (PDT)
In-Reply-To: <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Remove some clutter from omap2_dpll_round_rate().

linux-omap source commit is 4625dceb8583c02a6d67ededc9f6a8347b6b8cb7.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 886f73f..2f0eaaa 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -877,19 +877,22 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 	int m, n, r, e, scaled_max_m;
 	unsigned long scaled_rt_rp, new_rate;
 	int min_e = -1, min_e_m = -1, min_e_n = -1;
+	struct dpll_data *dd;
 
 	if (!clk || !clk->dpll_data)
 		return ~0;
 
+	dd = clk->dpll_data;
+
 	pr_debug("clock: starting DPLL round_rate for clock %s, target rate "
 		 "%ld\n", clk->name, target_rate);
 
 	scaled_rt_rp = target_rate / (clk->parent->rate / DPLL_SCALE_FACTOR);
-	scaled_max_m = clk->dpll_data->max_multiplier * DPLL_SCALE_FACTOR;
+	scaled_max_m = dd->max_multiplier * DPLL_SCALE_FACTOR;
 
-	clk->dpll_data->last_rounded_rate = 0;
+	dd->last_rounded_rate = 0;
 
-	for (n = clk->dpll_data->max_divider; n >= DPLL_MIN_DIVIDER; n--) {
+	for (n = dd->max_divider; n >= DPLL_MIN_DIVIDER; n--) {
 
 		/* Compute the scaled DPLL multiplier, based on the divider */
 		m = scaled_rt_rp * n;
@@ -909,7 +912,7 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 			 "(new_rate = %ld)\n", n, m, e, new_rate);
 
 		if (min_e == -1 ||
-		    min_e >= (int)(abs(e) - clk->dpll_data->rate_tolerance)) {
+		    min_e >= (int)(abs(e) - dd->rate_tolerance)) {
 			min_e = e;
 			min_e_m = m;
 			min_e_n = n;
@@ -932,17 +935,17 @@ long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
 		return ~0;
 	}
 
-	clk->dpll_data->last_rounded_m = min_e_m;
-	clk->dpll_data->last_rounded_n = min_e_n;
-	clk->dpll_data->last_rounded_rate =
-		_dpll_compute_new_rate(clk->parent->rate, min_e_m,  min_e_n);
+	dd->last_rounded_m = min_e_m;
+	dd->last_rounded_n = min_e_n;
+	dd->last_rounded_rate = _dpll_compute_new_rate(clk->parent->rate,
+						       min_e_m,  min_e_n);
 
 	pr_debug("clock: final least error: e = %d, m = %d, n = %d\n",
 		 min_e, min_e_m, min_e_n);
 	pr_debug("clock: final rate: %ld  (target rate: %ld)\n",
-		 clk->dpll_data->last_rounded_rate, target_rate);
+		 dd->last_rounded_rate, target_rate);
 
-	return clk->dpll_data->last_rounded_rate;
+	return dd->last_rounded_rate;
 }
 
 /*-------------------------------------------------------------------------
-- 
1.6.1.2

