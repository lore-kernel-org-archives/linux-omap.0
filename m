From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] ARM: OMAP2+: drop unused function
Date: Tue, 10 Jun 2014 14:26:36 -0700
Message-ID: <1402435596-5486-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:50619 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbaFJVaP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2014 17:30:15 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so3210066qcy.1
        for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2014 14:30:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

gic_init_irq() is no longer used as of:

    commit b42b918194c4791510ac049e3d507169a7de8544
    Author: Tony Lindgren <tony@atomide.com>
    Date:   Thu May 30 12:53:05 2013 -0700

        ARM: OMAP2+: Remove board-omap4panda.c

Drop it.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
---
 arch/arm/mach-omap2/common.h       |  1 -
 arch/arm/mach-omap2/omap4-common.c | 20 --------------------
 2 files changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index ff029737c8f0..51f6897418b7 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -241,7 +241,6 @@ static inline void __iomem *omap4_get_scu_base(void)
 }
 #endif
 
-extern void __init gic_init_irq(void);
 extern void gic_dist_disable(void);
 extern void gic_dist_enable(void);
 extern bool gic_dist_disabled(void);
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 326cd982a3cb..539e8106eb96 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -102,26 +102,6 @@ void __init omap_barriers_init(void)
 {}
 #endif
 
-void __init gic_init_irq(void)
-{
-	void __iomem *omap_irq_base;
-
-	/* Static mapping, never released */
-	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
-	BUG_ON(!gic_dist_base_addr);
-
-	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_4K);
-	BUG_ON(!twd_base);
-
-	/* Static mapping, never released */
-	omap_irq_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
-	BUG_ON(!omap_irq_base);
-
-	omap_wakeupgen_init();
-
-	gic_init(0, 29, gic_dist_base_addr, omap_irq_base);
-}
-
 void gic_dist_disable(void)
 {
 	if (gic_dist_base_addr)
-- 
1.9.1

