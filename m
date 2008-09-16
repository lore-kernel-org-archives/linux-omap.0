From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/6] OMAP3 clock: DPLLs should enter bypass if new rate is
	sys_ck
Date: Tue, 16 Sep 2008 06:16:50 -0600
Message-ID: <20080916121639.4666.78175.stgit@localhost.localdomain>
References: <20080916121521.4666.61245.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58344 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbYIPMRl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:17:41 -0400
In-Reply-To: <20080916121521.4666.61245.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

This patch causes a DPLL to enter bypass when it is instructed to set
its rate to that of the parent clock.  Previously this was only possible
after setting the DPLL rate, then disabling and re-enabling it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |   35 ++++++++++++++++++++++++-----------
 1 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 6963f2e..a2b8d1e 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -371,13 +371,17 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
  * @clk: struct clk * of DPLL to set
  * @rate: rounded target rate
  *
- * Program the DPLL with the rounded target rate.  Returns -EINVAL upon
- * error, or 0 upon success.
+ * Set the DPLL CLKOUT to the target rate.  If the DPLL can enter
+ * low-power bypass, and the target rate is the sys_clk rate, then
+ * configure the DPLL for bypass.  Otherwise, round the target rate if
+ * it hasn't been done already, then program and lock the DPLL.
+ * Returns -EINVAL upon error, or 0 upon success.
  */
 static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
 	u16 freqsel;
 	struct dpll_data *dd;
+	int ret;
 
 	if (!clk || !rate)
 		return -EINVAL;
@@ -389,18 +393,27 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	if (rate == omap2_get_dpll_rate(clk))
 		return 0;
 
-	if (dd->last_rounded_rate != rate)
-		omap2_dpll_round_rate(clk, rate);
+	if (clk->parent->rate == rate &&
+	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 
-	if (dd->last_rounded_rate == 0)
-		return -EINVAL;
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
+		ret = omap3_noncore_dpll_program(clk, dd->last_rounded_m,
+						 dd->last_rounded_n, freqsel);
+
+	}
 
 	omap3_dpll_recalc(clk);
 


