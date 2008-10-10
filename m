From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] [omap2] Fix compiler warnings in gpmc.c
Date: Fri, 10 Oct 2008 15:49:51 +0530
Message-ID: <1223633991-32406-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37935 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbYJJKUC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 06:20:02 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9AAJs8R012304
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 05:20:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Fix these compiler warnings:

gpmc.c: In function 'gpmc_init':
gpmc.c:432: warning: 'return' with a value, in function returning void
gpmc.c:439: warning: 'return' with a value, in function returning void

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f3e0271..4365c59 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -429,18 +429,16 @@ void __init gpmc_init(void)
 	gpmc_l3_clk = clk_get(NULL, ck);
 	if (IS_ERR(gpmc_l3_clk)) {
 		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
-		return -ENODEV;
+		BUG();
 	}
 
 	gpmc_base = ioremap(l, SZ_4K);
 	if (!gpmc_base) {
 		clk_put(gpmc_l3_clk);
 		printk(KERN_ERR "Could not get GPMC register memory\n");
-		return -ENOMEM;
+		BUG();
 	}
 
-	BUG_ON(IS_ERR(gpmc_l3_clk));
-
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 	/* Set smart idle mode and automatic L3 clock gating */
-- 
1.5.6

