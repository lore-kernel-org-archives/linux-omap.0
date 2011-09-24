From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 02/24] OMAP4: Export omap4_get_base*() rather than global address pointers
Date: Sat, 24 Sep 2011 11:44:22 +0530
Message-ID: <1316844884-21700-3-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44245 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1IXGPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 02:15:00 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch exports APIs to get base address for GIC
distributor, CPU interface, SCU and PL310 L2 Cache which
are used in OMAP4 PM code.

This was suggested by Kevin Hilman <khilman@ti.com> during
OMAP4 PM code review.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |   11 +++++++++--
 arch/arm/mach-omap2/omap-smp.c                  |    5 +++++
 arch/arm/mach-omap2/omap4-common.c              |    7 ++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index e4bd87619..b28ad10 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -25,10 +25,17 @@
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
 
 extern void __init gic_init_irq(void);
 extern void omap_smc1(u32 fn, u32 arg);
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index ce65e93..8e9b491 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -31,6 +31,11 @@ static void __iomem *scu_base;
 
 static DEFINE_SPINLOCK(boot_lock);
 
+void __iomem *omap4_get_scu_base(void)
+{
+	return scu_base;
+}
+
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	/*
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index a6c33e4..a12896a 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -25,7 +25,7 @@
 #include <mach/omap4-common.h>
 
 #ifdef CONFIG_CACHE_L2X0
-void __iomem *l2cache_base;
+static void __iomem *l2cache_base;
 #endif
 
 void __iomem *gic_dist_base_addr;
@@ -46,6 +46,11 @@ void __init gic_init_irq(void)
 
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
1.7.4.1

