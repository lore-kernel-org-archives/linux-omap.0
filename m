From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: Check return values for clk_get
Date: Fri,  8 Jan 2010 23:49:05 +0530
Message-ID: <1262974746-5060-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53281 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587Ab0AHSTL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 13:19:11 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o08IJ8ss005807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 8 Jan 2010 12:19:10 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch checks if clk_get() returned success for
the clocks used in function omap2_clk_arch_init().

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index d4217b9..2c2165b 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -316,17 +316,38 @@ static int __init omap2_clk_arch_init(void)
 {
 	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
 	unsigned long osc_sys_rate;
+	short err = 0 ;
 
 	if (!mpurate)
 		return -EINVAL;
 
-	/* XXX test these for success */
 	dpll1_ck = clk_get(NULL, "dpll1_ck");
+	if (dpll1_ck == NULL) {
+		err = 1;
+		pr_err("*** Failed to get dpll1_ck.\n");
+	}
+
 	arm_fck = clk_get(NULL, "arm_fck");
+	if (arm_fck == NULL) {
+		err = 1;
+		pr_err("*** Failed to get arm_fck.\n");
+	}
+
 	core_ck = clk_get(NULL, "core_ck");
+	if (core_ck == NULL) {
+		err = 1;
+		pr_err("*** Failed to get core_ck.\n");
+	}
+
 	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
+	if (osc_sys_ck == NULL) {
+		err = 1;
+		pr_err("*** Failed to get osc_sys_ck.\n");
+	}
+
+	if (err)
+		return 1;
 
-	/* REVISIT: not yet ready for 343x */
 	if (clk_set_rate(dpll1_ck, mpurate))
 		printk(KERN_ERR "*** Unable to set MPU rate\n");
 
-- 
1.6.2.2

