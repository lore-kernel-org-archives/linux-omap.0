From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 8/8] ARM: OMAP5: clock: No Freqsel on OMAP5 devices
Date: Wed, 20 Feb 2013 20:57:14 +0530
Message-ID: <1361374034-21831-9-git-send-email-santosh.shilimkar@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58210 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935673Ab3BTP0E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:26:04 -0500
In-Reply-To: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

OMAP5 does not have freqsel either, so add the missing
checks for !soc_is_omap54xx()

Reported-by: Archit Taneja <archit@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 0a02aab5..6e3811b 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -310,7 +310,8 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 	 * Set jitter correction. No jitter correction for OMAP4 and 3630
 	 * since freqsel field is no longer present
 	 */
-	if (!soc_is_am33xx() && !cpu_is_omap44xx() && !cpu_is_omap3630()) {
+	if (!soc_is_am33xx() && !cpu_is_omap44xx() && !cpu_is_omap3630()
+            && !soc_is_omap54xx()) {
 		v = __raw_readl(dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
@@ -501,7 +502,8 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 			return -EINVAL;
 
 		/* No freqsel on OMAP4 and OMAP3630 */
-		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
+		if (!cpu_is_omap44xx() && !cpu_is_omap3630()
+		    && !soc_is_omap54xx()) {
 			freqsel = _omap3_dpll_compute_freqsel(clk,
 						dd->last_rounded_n);
 			WARN_ON(!freqsel);
-- 
1.7.9.5

