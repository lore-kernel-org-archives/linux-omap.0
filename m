From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2] omap3: Check return values for clk_get()
Date: Thu, 28 Jan 2010 20:46:44 +0530
Message-ID: <1264691804-29427-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59349 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab0A1PQt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 10:16:49 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0SFGj5R027943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 09:16:48 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch checks if clk_get() returned success for
the clocks used in function omap2_clk_arch_init().

This version incorporates review comments from
Kevin Hilman and Paul Walmsley.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 1f1b5a6..ad09f04 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/err.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -184,6 +185,7 @@ static int __init omap3xxx_clk_arch_init(void)
 {
 	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
 	unsigned long osc_sys_rate;
+	bool err = 0 ;
 
 	if (!cpu_is_omap34xx())
 		return 0;
@@ -193,9 +195,23 @@ static int __init omap3xxx_clk_arch_init(void)
 
 	/* XXX test these for success */
 	dpll1_ck = clk_get(NULL, "dpll1_ck");
+	if (WARN(IS_ERR(dpll1_ck), "Failed to get dpll1_ck.\n"))
+		err = 1;
+
 	arm_fck = clk_get(NULL, "arm_fck");
+	if (WARN(IS_ERR(arm_fck), "Failed to get arm_fck.\n"))
+		err = 1;
+
 	core_ck = clk_get(NULL, "core_ck");
+	if (WARN(IS_ERR(core_ck), "Failed to get core_ck.\n"))
+		err = 1;
+
 	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
+	if (WARN(IS_ERR(osc_sys_ck), "Failed to get osc_sys_ck.\n"))
+		err = 1;
+
+	if (err)
+		return -ENOENT;
 
 	/* REVISIT: not yet ready for 343x */
 	if (clk_set_rate(dpll1_ck, mpurate))
-- 
1.6.2.2

