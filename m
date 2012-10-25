From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/13] ARM: OMAP2+: PRCM: remove omap2_cm_wait_idlest()
Date: Thu, 25 Oct 2012 17:21:19 -0600
Message-ID: <20121025232118.17558.54964.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38292 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab2JYXYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:24:05 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Now that all users of mach-omap2/omap2_cm_wait_idlest() have been removed,
delete the function and its supporting macros and prototypes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm.c             |   39 --------------------------------
 arch/arm/plat-omap/include/plat/prcm.h |    2 --
 2 files changed, 41 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 8cb55d3..827769c 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -44,45 +44,6 @@ void __iomem *cm_base;
 void __iomem *cm2_base;
 void __iomem *prcm_mpu_base;
 
-#define MAX_MODULE_ENABLE_WAIT		100000
-
-/**
- * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness
- * @reg: physical address of module IDLEST register
- * @mask: value to mask against to determine if the module is active
- * @idlest: idle state indicator (0 or 1) for the clock
- * @name: name of the clock (for printk)
- *
- * Returns 1 if the module indicated readiness in time, or 0 if it
- * failed to enable in roughly MAX_MODULE_ENABLE_WAIT microseconds.
- *
- * XXX This function is deprecated.  It should be removed once the
- * hwmod conversion is complete.
- */
-int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
-				const char *name)
-{
-	int i = 0;
-	int ena = 0;
-
-	if (idlest)
-		ena = 0;
-	else
-		ena = mask;
-
-	/* Wait for lock */
-	omap_test_timeout(((__raw_readl(reg) & mask) == ena),
-			  MAX_MODULE_ENABLE_WAIT, i);
-
-	if (i < MAX_MODULE_ENABLE_WAIT)
-		pr_debug("cm: Module associated with clock %s ready after %d loops\n",
-			 name, i);
-	else
-		pr_err("cm: Module associated with clock %s didn't enable in %d tries\n",
-		       name, MAX_MODULE_ENABLE_WAIT);
-
-	return (i < MAX_MODULE_ENABLE_WAIT) ? 1 : 0;
-};
 
 void __init omap2_set_globals_prcm(void __iomem *prm, void __iomem *cm,
 				   void __iomem *cm2, void __iomem *prcm_mpu)
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index a950a83..3ccee9f 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -30,8 +30,6 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
-			 const char *name);
 void __init omap2_set_globals_prcm(void __iomem *prm, void __iomem *cm,
 				   void __iomem *cm2, void __iomem *prcm_mpu);
 


