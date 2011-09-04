From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 06/25] OMAP4: Export omap4_get_base*() rather than global address pointers
Date: Sun, 4 Sep 2011 19:24:07 +0530
Message-ID: <1315144466-9395-7-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36776 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab1IDNzq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:55:46 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch exports APIs to get base address for GIC
distributor, CPU interface, SCU and PL310 L2 Cache which
are used in OMAP4 PM code.

This was suggested by Kevin Hilman <khilman@ti.com> during
OMAP4 PM code review.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |   11 +++++++++--
 arch/arm/mach-omap2/omap-smp.c                  |    5 +++++
 arch/arm/mach-omap2/omap4-common.c              |    7 ++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 552b5e7..ba629fc 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -19,10 +19,17 @@
 #ifndef __ASSEMBLER__
 
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
index 4904025..090db8f 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -27,7 +27,7 @@
 #include <mach/omap4-common.h>
 
 #ifdef CONFIG_CACHE_L2X0
-void __iomem *l2cache_base;
+static void __iomem *l2cache_base;
 #endif
 
 void __iomem *gic_dist_base_addr;
@@ -96,6 +96,11 @@ void __init gic_init_irq(void)
 
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

