From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 09/19] OMAP4: PM: Add GIC distributor and interface enable/disable accessory API
Date: Thu, 10 Mar 2011 19:38:05 +0530
Message-ID: <1299766095-23879-10-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50201 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab1CJOIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 09:08:43 -0500
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

The power management code needs to have access to enable/disable the
gic cpu interface and distributor based on targetted low power
states.

These APIs are suppose to me moved to common ARM GIC library and patch
for the same was posted earlier. The GIC code refactoring is ongoing
and hence for time being this is kept under OMAP code so that OMAP4
PM can continue to work.

Discussion thread:
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42940.html

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    5 +++-
 arch/arm/mach-omap2/omap4-common.c              |   24 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index a6ce905..a4b3beb 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -44,6 +44,10 @@ extern void __iomem *omap4_get_gic_dist_base(void);
 extern void __iomem *omap4_get_gic_cpu_base(void);
 extern void __iomem *omap4_get_sar_ram_base(void);
 extern void __init gic_init_irq(void);
+extern void gic_cpu_enable(void);
+extern void gic_cpu_disable(void);
+extern void gic_dist_enable(void);
+extern void gic_dist_disable(void);
 extern void omap_smc1(u32 fn, u32 arg);
 
 /*
@@ -64,7 +68,6 @@ extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern void omap4_cpu_suspend(unsigned int cpu, unsigned int save_state);
 extern void omap4_cpu_resume(void);
-
 #else
 
 static inline int omap4_enter_lowpower(unsigned int cpu,
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 97d7d8a..9dd50b7 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -61,6 +61,30 @@ void __init gic_init_irq(void)
 	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
 }
 
+/*
+ * FIXME: Remove this GIC APIs once common GIG library starts
+ * supporting it.
+ */
+void gic_cpu_enable(void)
+{
+	__raw_writel(0xf0, gic_cpu_base + GIC_CPU_PRIMASK);
+	__raw_writel(1, gic_cpu_base + GIC_CPU_CTRL);
+}
+
+void gic_cpu_disable(void)
+{
+	__raw_writel(0, gic_cpu_base + GIC_CPU_CTRL);
+}
+
+void gic_dist_enable(void)
+{
+	__raw_writel(0x1, gic_dist_base_addr + GIC_DIST_CTRL);
+}
+void gic_dist_disable(void)
+{
+	__raw_writel(0, gic_dist_base_addr + GIC_CPU_CTRL);
+}
+
 #ifdef CONFIG_CACHE_L2X0
 
 void __iomem *omap4_get_l2cache_base(void)
-- 
1.6.0.4

