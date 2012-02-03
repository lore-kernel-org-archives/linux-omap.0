From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 1/1] ARM: OMAP3+: dpll: Configure autoidle mode only if its supported
Date: Fri, 3 Feb 2012 17:20:19 +0530
Message-ID: <1328269819-10025-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56540 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753720Ab2BCLuZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 06:50:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Bedia <vaibhav.bedia@ti.com>

The current DPLL code enables and disables autoidle features
without checking whether the autoidle register is available.
Fix this by putting a check for the existence of the autoidle
register in the DPLL data.

With such a check in place, for DPLLs which do not support this
feature, simply skipping the autoidle_reg entry in the DPLL data
is sufficient.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 57c4c7c..bf0db5d 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -142,7 +142,8 @@ static int _omap3_noncore_dpll_lock(struct clk *clk)

 	ai = omap3_dpll_autoidle_read(clk);

-	omap3_dpll_deny_idle(clk);
+	if (ai)
+		omap3_dpll_deny_idle(clk);

 	_omap3_dpll_write_clken(clk, DPLL_LOCKED);

@@ -186,8 +187,6 @@ static int _omap3_noncore_dpll_bypass(struct clk *clk)

 	if (ai)
 		omap3_dpll_allow_idle(clk);
-	else
-		omap3_dpll_deny_idle(clk);

 	return r;
 }
@@ -216,8 +215,6 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)

 	if (ai)
 		omap3_dpll_allow_idle(clk);
-	else
-		omap3_dpll_deny_idle(clk);

 	return 0;
 }
@@ -520,6 +517,9 @@ u32 omap3_dpll_autoidle_read(struct clk *clk)

 	dd = clk->dpll_data;

+	if (!dd->autoidle_reg)
+		return -EINVAL;
+
 	v = __raw_readl(dd->autoidle_reg);
 	v &= dd->autoidle_mask;
 	v >>= __ffs(dd->autoidle_mask);
@@ -546,6 +546,12 @@ void omap3_dpll_allow_idle(struct clk *clk)

 	dd = clk->dpll_data;

+	if (!dd->autoidle_reg) {
+		pr_debug("clock: DPLL %s: autoidle not supported\n",
+			clk->name);
+		return;
+	}
+
 	/*
 	 * REVISIT: CORE DPLL can optionally enter low-power bypass
 	 * by writing 0x5 instead of 0x1.  Add some mechanism to
@@ -555,6 +561,7 @@ void omap3_dpll_allow_idle(struct clk *clk)
 	v &= ~dd->autoidle_mask;
 	v |= DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask);
 	__raw_writel(v, dd->autoidle_reg);
+
 }

 /**
@@ -573,6 +580,12 @@ void omap3_dpll_deny_idle(struct clk *clk)

 	dd = clk->dpll_data;

+	if (!dd->autoidle_reg) {
+		pr_debug("clock: DPLL %s: autoidle not supported\n",
+			clk->name);
+		return;
+	}
+
 	v = __raw_readl(dd->autoidle_reg);
 	v &= ~dd->autoidle_mask;
 	v |= DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask);
--
1.7.0.4

