From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 03/17] omap4: Export scu base address
Date: Sat, 19 Feb 2011 16:12:24 +0530
Message-ID: <1298112158-28469-4-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34185 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab1BSKms (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:42:48 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The scu base address needs to be accessed in cpu hotplug
for power management. Hence export the same

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    4 ++++
 arch/arm/mach-omap2/omap-smp.c                  |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 5b0270b..0e5edd8 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -26,6 +26,10 @@ extern void __iomem *l2cache_base;
 
 extern void __iomem *gic_dist_base_addr;
 
+#ifdef CONFIG_SMP
+extern void __iomem *scu_base;
+#endif
+
 extern void __init gic_init_irq(void);
 extern void omap_smc1(u32 fn, u32 arg);
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index b66cfe8..b105a29 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -26,7 +26,7 @@
 #include <mach/omap4-common.h>
 
 /* SCU base address */
-static void __iomem *scu_base;
+void __iomem *scu_base;
 
 static DEFINE_SPINLOCK(boot_lock);
 
-- 
1.6.0.4

