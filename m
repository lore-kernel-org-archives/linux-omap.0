From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 03/19] OMAP4: PM: Export omap4_get_base*() rather than global address pointers
Date: Thu, 10 Mar 2011 19:37:59 +0530
Message-ID: <1299766095-23879-4-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53974 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab1CJOI2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:08:28 -0500
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch exports APIs to get base address for GIC
distributor, CPU interface, SCU and PL310 L2 Cache which
are used in OMAP4 PM code.

This was suggested by Kevin Hilman <khilman@ti.com> during
OMAP4 PM code review.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |   13 +++++++++++--
 arch/arm/mach-omap2/omap-smp.c                  |    6 ++++++
 arch/arm/mach-omap2/omap4-common.c              |   21 ++++++++++++++++++---
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index de441c0..106edef 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -25,11 +25,20 @@
 #endif
 
 #ifdef CONFIG_CACHE_L2X0
-extern void __iomem *l2cache_base;
+extern void __iomem *omap4_get_l2cache_base(void);
 #endif
 
-extern void __iomem *gic_dist_base_addr;
+#ifdef CONFIG_SMP
+extern void __iomem *omap4_get_scu_base(void);
+#else
+static inline void __iomem *omap4_get_scu_base(void)
+{
+	return NULL;
+}
+#endif
 
+extern void __iomem *omap4_get_gic_dist_base(void);
+extern void __iomem *omap4_get_gic_cpu_base(void);
 extern void __init gic_init_irq(void);
 extern void omap_smc1(u32 fn, u32 arg);
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index b66cfe8..4fcaa4a 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -30,6 +30,12 @@ static void __iomem *scu_base;
 
 static DEFINE_SPINLOCK(boot_lock);
 
+
+void __iomem *omap4_get_scu_base(void)
+{
+	return scu_base;
+}
+
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	/*
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 8f9b97d..fdacb9e 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -24,15 +24,25 @@
 #include <mach/omap-wakeupgen.h>
 
 #ifdef CONFIG_CACHE_L2X0
-void __iomem *l2cache_base;
+static void __iomem *l2cache_base;
 #endif
 
-void __iomem *gic_dist_base_addr;
+static void __iomem *gic_dist_base_addr;
+static void __iomem *gic_cpu_base;
 
 
+void __iomem *omap4_get_gic_dist_base(void)
+{
+	return gic_dist_base_addr;
+}
+
+void __iomem *omap4_get_gic_cpu_base(void)
+{
+	return gic_cpu_base;
+}
+
 void __init gic_init_irq(void)
 {
-	void __iomem *gic_cpu_base;
 
 	/* Static mapping, never released */
 	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
@@ -51,6 +61,11 @@ void __init gic_init_irq(void)
 
 #ifdef CONFIG_CACHE_L2X0
 
+void __iomem *omap4_get_l2cache_base(void)
+{
+	return l2cache_base;
+}
+
 static void omap4_l2x0_disable(void)
 {
 	/* Disable PL310 L2 Cache controller */
-- 
1.6.0.4

