From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP: Fix compiler warnings in gpmc.c
Date: Thu, 30 Oct 2008 19:11:15 -0700
Message-ID: <1225419078-32213-2-git-send-email-tony@atomide.com>
References: <1225419078-32213-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54013 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbYJaCLV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:11:21 -0400
In-Reply-To: <1225419078-32213-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Sanjeev Premi <premi@ti.com>, Tony Lindgren <tony@atomide.com>

From: Sanjeev Premi <premi@ti.com>

Fix these compiler warnings:

gpmc.c: In function 'gpmc_init':
gpmc.c:432: warning: 'return' with a value, in function returning void
gpmc.c:439: warning: 'return' with a value, in function returning void

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 763bdbe..2249049 100644
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
1.5.6.rc3.21.g8c6b5

