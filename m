From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/5] omap4: Remove 'FIXME: omap44xx_sram_init not implemented'
Date: Sat, 12 Feb 2011 16:59:47 +0530
Message-ID: <1297510187-31547-6-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51748 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447Ab1BLLaA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Feb 2011 06:30:00 -0500
In-Reply-To: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The omap44xx_sram_init() implements functionality to push some
code on SRAM whenever the code can't be executed from external
memory. The low power and DVFS code can be executed from
external DDR itself thanks to OMAP4  memory controller hardware
support. So on OMAP4, sram_push kind of functionality isn't needed.

Hence remove the FIXME warning added for implementing sram push
feature on OMAP4.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index e26e504..2d7bded 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -405,20 +405,6 @@ static inline int omap34xx_sram_init(void)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP4
-static int __init omap44xx_sram_init(void)
-{
-	printk(KERN_ERR "FIXME: %s not implemented\n", __func__);
-
-	return -ENODEV;
-}
-#else
-static inline int omap44xx_sram_init(void)
-{
-	return 0;
-}
-#endif
-
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
@@ -432,8 +418,6 @@ int __init omap_sram_init(void)
 		omap243x_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
-	else if (cpu_is_omap44xx())
-		omap44xx_sram_init();
 
 	return 0;
 }
-- 
1.6.0.4

