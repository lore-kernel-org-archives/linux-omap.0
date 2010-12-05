From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 3/5] ARM: GIC: consolidate gic_cpu_base_addr to common GIC code
Date: Sun, 05 Dec 2010 11:34:59 +0000
Message-ID: <E1PPCrr-0004xW-2c@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45864 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab0LELfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 06:35:24 -0500
In-Reply-To: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Anton Vorontsov <avorontsov@mvista.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Every architecture using the GIC has a gic_cpu_base_addr pointer for
GIC 0 for their entry assembly code to use to decode the cause of the
current interrupt.  Move this into the common GIC code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/gic.c                           |    5 +++++
 arch/arm/include/asm/hardware/gic.h             |    2 ++
 arch/arm/mach-cns3xxx/core.c                    |    5 +----
 arch/arm/mach-cns3xxx/core.h                    |    1 -
 arch/arm/mach-msm/board-msm8x60.c               |    6 ++----
 arch/arm/mach-omap2/include/mach/omap4-common.h |    1 -
 arch/arm/mach-omap2/omap4-common.c              |    9 +++++----
 arch/arm/mach-realview/core.c                   |    3 ---
 arch/arm/mach-realview/core.h                   |    1 -
 arch/arm/mach-realview/realview_eb.c            |    6 ++----
 arch/arm/mach-realview/realview_pb1176.c        |    3 +--
 arch/arm/mach-realview/realview_pb11mp.c        |    3 +--
 arch/arm/mach-realview/realview_pba8.c          |    1 -
 arch/arm/mach-realview/realview_pbx.c           |    2 --
 arch/arm/mach-s5pv310/cpu.c                     |    3 ---
 arch/arm/mach-s5pv310/include/mach/smp.h        |    2 --
 arch/arm/mach-vexpress/core.h                   |    2 --
 arch/arm/mach-vexpress/ct-ca9x4.c               |    6 ++----
 18 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 12b6a08..c48634a 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -35,6 +35,9 @@
 
 static DEFINE_SPINLOCK(irq_controller_lock);
 
+/* Address of GIC 0 CPU interface */
+void __iomem *gic_cpu_base_addr;
+
 struct gic_chip_data {
 	unsigned int irq_offset;
 	void __iomem *dist_base;
@@ -309,6 +312,8 @@ static void __cpuinit gic_cpu_init(unsigned int gic_nr, void __iomem *base)
 void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
 	void __iomem *dist_base, void __iomem *cpu_base)
 {
+	if (gic_nr == 0)
+		gic_cpu_base_addr = cpu_base;
 	gic_dist_init(gic_nr, dist_base, irq_start);
 	gic_cpu_init(gic_nr, cpu_base);
 }
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 48876a3..a82a777 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -33,6 +33,8 @@
 #define GIC_DIST_SOFTINT		0xf00
 
 #ifndef __ASSEMBLY__
+extern void __iomem *gic_cpu_base_addr;
+
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index e9c4915..da30078 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -69,13 +69,10 @@ void __init cns3xxx_map_io(void)
 }
 
 /* used by entry-macro.S */
-void __iomem *gic_cpu_base_addr;
-
 void __init cns3xxx_init_irq(void)
 {
-	gic_cpu_base_addr = __io(CNS3XXX_TC11MP_GIC_CPU_BASE_VIRT);
 	gic_init(0, 29, __io(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT),
-		gic_cpu_base_addr);
+		 __io(CNS3XXX_TC11MP_GIC_CPU_BASE_VIRT));
 }
 
 void cns3xxx_power_off(void)
diff --git a/arch/arm/mach-cns3xxx/core.h b/arch/arm/mach-cns3xxx/core.h
index 6b33ec1..ef9e511 100644
--- a/arch/arm/mach-cns3xxx/core.h
+++ b/arch/arm/mach-cns3xxx/core.h
@@ -11,7 +11,6 @@
 #ifndef __CNS3XXX_CORE_H
 #define __CNS3XXX_CORE_H
 
-extern void __iomem *gic_cpu_base_addr;
 extern struct sys_timer cns3xxx_timer;
 
 void __init cns3xxx_map_io(void);
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index aaf8ec8..9b5eb2b 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -28,8 +28,6 @@
 #include <mach/board.h>
 #include <mach/msm_iomap.h>
 
-void __iomem *gic_cpu_base_addr;
-
 unsigned long clk_get_max_axi_khz(void)
 {
 	return 0;
@@ -44,8 +42,8 @@ static void __init msm8x60_init_irq(void)
 {
 	unsigned int i;
 
-	gic_cpu_base_addr = (void *)MSM_QGIC_CPU_BASE;
-	gic_init(0, GIC_PPI_START, MSM_QGIC_DIST_BASE, gic_cpu_base_addr);
+	gic_init(0, GIC_PPI_START, MSM_QGIC_DIST_BASE,
+		 (void *)MSM_QGIC_CPU_BASE);
 
 	/* Edge trigger PPIs except AVS_SVICINT and AVS_SVICINTSWDONE */
 	writel(0xFFFFD7FF, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 2744dfe..5b0270b 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -24,7 +24,6 @@
 extern void __iomem *l2cache_base;
 #endif
 
-extern void __iomem *gic_cpu_base_addr;
 extern void __iomem *gic_dist_base_addr;
 
 extern void __init gic_init_irq(void);
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 3fd3df7..666e852 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -26,21 +26,22 @@
 void __iomem *l2cache_base;
 #endif
 
-void __iomem *gic_cpu_base_addr;
 void __iomem *gic_dist_base_addr;
 
 
 void __init gic_init_irq(void)
 {
+	void __iomem *gic_cpu_base;
+
 	/* Static mapping, never released */
 	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
 	BUG_ON(!gic_dist_base_addr);
 
 	/* Static mapping, never released */
-	gic_cpu_base_addr = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
-	BUG_ON(!gic_cpu_base_addr);
+	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
+	BUG_ON(!gic_cpu_base);
 
-	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base_addr);
+	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
 }
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 07c0815..e292eb8 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -54,9 +54,6 @@
 
 #include "core.h"
 
-/* used by entry-macro.S and platsmp.c */
-void __iomem *gic_cpu_base_addr;
-
 #ifdef CONFIG_ZONE_DMA
 /*
  * Adjust the zones if there are restrictions for DMA access.
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 781bca6..693239d 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -53,7 +53,6 @@ extern struct platform_device realview_i2c_device;
 extern struct mmci_platform_data realview_mmc0_plat_data;
 extern struct mmci_platform_data realview_mmc1_plat_data;
 extern struct clcd_board clcd_plat_data;
-extern void __iomem *gic_cpu_base_addr;
 extern void __iomem *timer0_va_base;
 extern void __iomem *timer1_va_base;
 extern void __iomem *timer2_va_base;
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 241bcbc..6ef5c5e 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -364,9 +364,8 @@ static void __init gic_init_irq(void)
 		writel(0x00000000, __io_address(REALVIEW_SYS_LOCK));
 
 		/* core tile GIC, primary */
-		gic_cpu_base_addr = __io_address(REALVIEW_EB11MP_GIC_CPU_BASE);
 		gic_init(0, 29, __io_address(REALVIEW_EB11MP_GIC_DIST_BASE),
-			 gic_cpu_base_addr);
+			 __io_address(REALVIEW_EB11MP_GIC_CPU_BASE));
 
 #ifndef CONFIG_REALVIEW_EB_ARM11MP_REVB
 		/* board GIC, secondary */
@@ -376,9 +375,8 @@ static void __init gic_init_irq(void)
 #endif
 	} else {
 		/* board GIC, primary */
-		gic_cpu_base_addr = __io_address(REALVIEW_EB_GIC_CPU_BASE);
 		gic_init(0, 29, __io_address(REALVIEW_EB_GIC_DIST_BASE),
-			 gic_cpu_base_addr);
+			 __io_address(REALVIEW_EB_GIC_CPU_BASE));
 	}
 }
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 8047b19..cbdc97a 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -304,10 +304,9 @@ static struct platform_device char_lcd_device = {
 static void __init gic_init_irq(void)
 {
 	/* ARM1176 DevChip GIC, primary */
-	gic_cpu_base_addr = __io_address(REALVIEW_DC1176_GIC_CPU_BASE);
 	gic_init(0, IRQ_DC1176_GIC_START,
 		 __io_address(REALVIEW_DC1176_GIC_DIST_BASE),
-		 gic_cpu_base_addr);
+		 __io_address(REALVIEW_DC1176_GIC_CPU_BASE));
 
 	/* board GIC, secondary */
 	gic_init(1, IRQ_PB1176_GIC_START,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 6120426..8e8ab7d 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -309,9 +309,8 @@ static void __init gic_init_irq(void)
 	writel(0x00000000, __io_address(REALVIEW_SYS_LOCK));
 
 	/* ARM11MPCore test chip GIC, primary */
-	gic_cpu_base_addr = __io_address(REALVIEW_TC11MP_GIC_CPU_BASE);
 	gic_init(0, 29, __io_address(REALVIEW_TC11MP_GIC_DIST_BASE),
-		 gic_cpu_base_addr);
+		 __io_address(REALVIEW_TC11MP_GIC_CPU_BASE));
 
 	/* board GIC, secondary */
 	gic_init(1, IRQ_PB11MP_GIC_START,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 90f492a..841118e 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -273,7 +273,6 @@ static struct platform_device pmu_device = {
 static void __init gic_init_irq(void)
 {
 	/* ARM PB-A8 on-board GIC */
-	gic_cpu_base_addr = __io_address(REALVIEW_PBA8_GIC_CPU_BASE);
 	gic_init(0, IRQ_PBA8_GIC_START,
 		 __io_address(REALVIEW_PBA8_GIC_DIST_BASE),
 		 __io_address(REALVIEW_PBA8_GIC_CPU_BASE));
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 86f28f7..02b755b 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -313,11 +313,9 @@ static void __init gic_init_irq(void)
 {
 	/* ARM PBX on-board GIC */
 	if (core_tile_pbx11mp() || core_tile_pbxa9mp()) {
-		gic_cpu_base_addr = __io_address(REALVIEW_PBX_TILE_GIC_CPU_BASE);
 		gic_init(0, 29, __io_address(REALVIEW_PBX_TILE_GIC_DIST_BASE),
 			 __io_address(REALVIEW_PBX_TILE_GIC_CPU_BASE));
 	} else {
-		gic_cpu_base_addr = __io_address(REALVIEW_PBX_GIC_CPU_BASE);
 		gic_init(0, IRQ_PBX_GIC_START,
 			 __io_address(REALVIEW_PBX_GIC_DIST_BASE),
 			 __io_address(REALVIEW_PBX_GIC_CPU_BASE));
diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index bce3e91..72ab289 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -24,8 +24,6 @@
 
 #include <mach/regs-irq.h>
 
-void __iomem *gic_cpu_base_addr;
-
 extern int combiner_init(unsigned int combiner_nr, void __iomem *base,
 			 unsigned int irq_start);
 extern void combiner_cascade_irq(unsigned int combiner_nr, unsigned int irq);
@@ -122,7 +120,6 @@ void __init s5pv310_init_irq(void)
 {
 	int irq;
 
-	gic_cpu_base_addr = S5P_VA_GIC_CPU;
 	gic_init(0, IRQ_LOCALTIMER, S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
 
 	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
diff --git a/arch/arm/mach-s5pv310/include/mach/smp.h b/arch/arm/mach-s5pv310/include/mach/smp.h
index b7ec252..e1cc6a2 100644
--- a/arch/arm/mach-s5pv310/include/mach/smp.h
+++ b/arch/arm/mach-s5pv310/include/mach/smp.h
@@ -9,8 +9,6 @@
 #include <asm/hardware/gic.h>
 #include <asm/smp_mpidr.h>
 
-extern void __iomem *gic_cpu_base_addr;
-
 /*
  * We use IRQ1 as the IPI
  */
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index 57dd95c..362780d 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -22,5 +22,3 @@ struct map_desc;
 
 void v2m_map_io(struct map_desc *tile, size_t num);
 extern struct sys_timer v2m_timer;
-
-extern void __iomem *gic_cpu_base_addr;
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 25a3ca6..8e0a3b7 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -60,12 +60,10 @@ static void __init ct_ca9x4_map_io(void)
 	v2m_map_io(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
-void __iomem *gic_cpu_base_addr;
-
 static void __init ct_ca9x4_init_irq(void)
 {
-	gic_cpu_base_addr = MMIO_P2V(A9_MPCORE_GIC_CPU);
-	gic_init(0, 29, MMIO_P2V(A9_MPCORE_GIC_DIST), gic_cpu_base_addr);
+	gic_init(0, 29, MMIO_P2V(A9_MPCORE_GIC_DIST),
+		 MMIO_P2V(A9_MPCORE_GIC_CPU));
 }
 
 #if 0
-- 
1.6.2.5

