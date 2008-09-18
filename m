From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 6/7] OMAP3 clock: DPLLs should enter bypass if new rate is
	sys_ck
Date: Thu, 18 Sep 2008 10:30:31 -0600
Message-ID: <20080918163028.9452.19955.stgit@localhost.localdomain>
References: <20080918162835.9452.71873.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58256 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbYIRQ4Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 12:56:25 -0400
In-Reply-To: <20080918162835.9452.71873.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

This patch causes a DPLL to enter bypass when it is instructed to set
its rate to that of its bypass clock.  Previously this was only possible
after setting the DPLL rate, then disabling and re-enabling it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |   40 ++++++++++++++++++++++++++++-----------
 1 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 6963f2e..520fc35 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -371,13 +371,17 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
  * @clk: struct clk * of DPLL to set
  * @rate: rounded target rate
  *
- * Program the DPLL with the rounded target rate.  Returns -EINVAL upon
- * error, or 0 upon success.
+ * Set the DPLL CLKOUT to the target rate.  If the DPLL can enter
+ * low-power bypass, and the target rate is the bypass source clock
+ * rate, then configure the DPLL for bypass.  Otherwise, round the
+ * target rate if it hasn't been done already, then program and lock
+ * the DPLL.  Returns -EINVAL upon error, or 0 upon success.
  */
 static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
 	u16 freqsel;
 	struct dpll_data *dd;
+	int ret;
 
 	if (!clk || !rate)
 		return -EINVAL;
@@ -389,18 +393,32 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	if (rate == omap2_get_dpll_rate(clk))
 		return 0;
 
-	if (dd->last_rounded_rate != rate)
-		omap2_dpll_round_rate(clk, rate);
+	if (dd->bypass_clk->rate == rate &&
+	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 
-	if (dd->last_rounded_rate == 0)
-		return -EINVAL;
+		pr_debug("clock: %s: set rate: entering bypass.\n", clk->name);
+
+		ret = _omap3_noncore_dpll_bypass(clk);
+
+	} else {
+
+		if (dd->last_rounded_rate != rate)
+			omap2_dpll_round_rate(clk, rate);
 
-	freqsel = _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
-	if (!freqsel)
-		WARN_ON(1);
+		if (dd->last_rounded_rate == 0)
+			return -EINVAL;
 
-	omap3_noncore_dpll_program(clk, dd->last_rounded_m, dd->last_rounded_n,
-				   freqsel);
+		freqsel = _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
+		if (!freqsel)
+			WARN_ON(1);
+
+		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
+			 clk->name, rate);
+
+		ret = omap3_noncore_dpll_program(clk, dd->last_rounded_m,
+						 dd->last_rounded_n, freqsel);
+
+	}
 
 	omap3_dpll_recalc(clk);
 


