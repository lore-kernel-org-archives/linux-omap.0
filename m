From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: OMAP3+: dpll: optimize noncore dpll locking logic
Date: Fri, 18 May 2012 14:37:18 -0500
Message-ID: <1337369838-15185-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:47924 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967074Ab2ERTh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 15:37:29 -0400
Received: by obbtb18 with SMTP id tb18so5937341obb.5
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 12:37:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Mike Turquette <mturquette@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Vikram Pandita <vikram.pandita@ti.com>

If the dpll is already locked, code can be optimized
to return much earlier than doing redundent set of lock mode
and wait on idlest.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index fc56745..3cfd7c4 100644
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
1.7.9.5

