From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2] OMAP: clock: optimize dpll locking logic
Date: Fri, 4 Nov 2011 00:12:29 -0700
Message-ID: <1320390749-19698-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41427 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab1KDHMe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 03:12:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org
Cc: Todd Poynor <toddpoynor@google.com>, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

If the dpll is already locked, code can be optimized
to return much earlier than doing redundent set of lock mode
and wait on idlest.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Reviewed-by: Todd Poynor <toddpoynor@google.com>
---
v1: initial draft

v2: fix review comments

 arch/arm/mach-omap2/dpll3xxx.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f77022b..2d4f6bd 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -135,11 +135,20 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
  */
 static int _omap3_noncore_dpll_lock(struct clk *clk)
 {
+	const struct dpll_data *dd;
 	u8 ai;
-	int r;
+	u8 state = 1;
+	int r = 0;
 
 	pr_debug("clock: locking DPLL %s\n", clk->name);
 
+	dd = clk->dpll_data;
+	state <<= __ffs(dd->idlest_mask);
+
+	/* Check if already locked */
+	if ((__raw_readl(dd->idlest_reg) & dd->idlest_mask) == state)
+		goto done;
+
 	ai = omap3_dpll_autoidle_read(clk);
 
 	omap3_dpll_deny_idle(clk);
@@ -151,6 +160,7 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
 	if (ai)
 		omap3_dpll_allow_idle(clk);
 
+done:
 	return r;
 }
 
-- 
1.7.5.4

