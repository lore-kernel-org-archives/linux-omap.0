From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] OMAP: clock: optimize dpll locking logic
Date: Wed, 2 Nov 2011 00:12:58 -0700
Message-ID: <1320217978-3088-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53779 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab1KBHNH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Nov 2011 03:13:07 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pA27D7dS032035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 2 Nov 2011 02:13:07 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pA27D6kr013828
	for <linux-omap@vger.kernel.org>; Wed, 2 Nov 2011 02:13:06 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pA27D6AQ003261
	for <linux-omap@vger.kernel.org>; Wed, 2 Nov 2011 02:13:06 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

If the dpll is already locked, code can be optimized
to return much earlier than doing redundent set of lock mode
and wait on idlest.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f77022b..d100391 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -135,8 +135,9 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
  */
 static int _omap3_noncore_dpll_lock(struct clk *clk)
 {
+	const struct dpll_data *dd;
 	u8 ai;
-	int r;
+	int r = 0;
 
 	pr_debug("clock: locking DPLL %s\n", clk->name);
 
@@ -144,10 +145,16 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)
 
 	omap3_dpll_deny_idle(clk);
 
+	dd = clk->dpll_data;
+	/* Check if already locked */
+	if ((__raw_readl(dd->idlest_reg) & dd->idlest_mask) == 1)
+		goto done;
+
 	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
 
 	r = _omap3_wait_dpll_status(clk, 1);
 
+done:
 	if (ai)
 		omap3_dpll_allow_idle(clk);
 
-- 
1.7.5.4

