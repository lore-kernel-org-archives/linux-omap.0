From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 1/5] ARM: GIC: provide a single initialization function for boot CPU
Date: Sun, 05 Dec 2010 11:34:18 +0000
Message-ID: <E1PPCrC-0004xO-Fs@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47148 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab0LELec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 06:34:32 -0500
In-Reply-To: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Anton Vorontsov <avorontsov@mvista.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene.kim@samsung.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Olof Johansson <olof@lixom.net>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org

Provide gic_init() which initializes the GIC distributor and current
CPU's GIC interface for the boot (or single) CPU.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/gic.c                    |   11 +++++++++--
 arch/arm/include/asm/hardware/gic.h      |    2 +-
 arch/arm/mach-cns3xxx/core.c             |    4 ++--
 arch/arm/mach-msm/board-msm8x60.c        |    3 +--
 arch/arm/mach-omap2/omap4-common.c       |    4 ++--
 arch/arm/mach-realview/realview_eb.c     |   12 ++++++------
 arch/arm/mach-realview/realview_pb1176.c |   10 ++++++----
 arch/arm/mach-realview/realview_pb11mp.c |    9 +++++----
 arch/arm/mach-realview/realview_pba8.c   |    5 +++--
 arch/arm/mach-realview/realview_pbx.c    |   11 +++++------
 arch/arm/mach-s5pv310/cpu.c              |    3 +--
 arch/arm/mach-tegra/irq.c                |    4 ++--
 arch/arm/mach-ux500/cpu.c                |    4 ++--
 arch/arm/mach-vexpress/ct-ca9x4.c        |    3 +--
 14 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 772f95f..41dce4f 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -207,8 +207,8 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 	set_irq_chained_handler(irq, gic_handle_cascade_irq);
 }
 
-void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
-			  unsigned int irq_start)
+static void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
+	unsigned int irq_start)
 {
 	unsigned int max_irq, i;
 	u32 cpumask = 1 << smp_processor_id();
@@ -306,6 +306,13 @@ void __cpuinit gic_cpu_init(unsigned int gic_nr, void __iomem *base)
 	writel(1, base + GIC_CPU_CTRL);
 }
 
+void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
+	void __iomem *dist_base, void __iomem *cpu_base)
+{
+	gic_dist_init(gic_nr, dist_base, irq_start);
+	gic_cpu_init(gic_nr, cpu_base);
+}
+
 #ifdef CONFIG_SMP
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 7f34333..387c6ae 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -33,8 +33,8 @@
 #define GIC_DIST_SOFTINT		0xf00
 
 #ifndef __ASSEMBLY__
-void gic_dist_init(unsigned int gic_nr, void __iomem *base, unsigned int irq_start);
 void gic_cpu_init(unsigned int gic_nr, void __iomem *base);
+void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 #endif
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 9ca4d58..e9c4915 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -74,8 +74,8 @@ void __iomem *gic_cpu_base_addr;
 void __init cns3xxx_init_irq(void)
 {
 	gic_cpu_base_addr = __io(CNS3XXX_TC11MP_GIC_CPU_BASE_VIRT);
-	gic_dist_init(0, __io(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT), 29);
-	gic_cpu_init(0, gic_cpu_base_addr);
+	gic_init(0, 29, __io(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT),
+		gic_cpu_base_addr);
 }
 
 void cns3xxx_power_off(void)
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 7486a68..aaf8ec8 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -44,9 +44,8 @@ static void __init msm8x60_init_irq(void)
 {
 	unsigned int i;
 
-	gic_dist_init(0, MSM_QGIC_DIST_BASE, GIC_PPI_START);
 	gic_cpu_base_addr = (void *)MSM_QGIC_CPU_BASE;
-	gic_cpu_init(0, MSM_QGIC_CPU_BASE);
+	gic_init(0, GIC_PPI_START, MSM_QGIC_DIST_BASE, gic_cpu_base_addr);
 
 	/* Edge trigger PPIs except AVS_SVICINT and AVS_SVICINTSWDONE */
 	writel(0xFFFFD7FF, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 2f89555..3fd3df7 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -35,12 +35,12 @@ void __init gic_init_irq(void)
 	/* Static mapping, never released */
 	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
 	BUG_ON(!gic_dist_base_addr);
-	gic_dist_init(0, gic_dist_base_addr, 29);
 
 	/* Static mapping, never released */
 	gic_cpu_base_addr = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
 	BUG_ON(!gic_cpu_base_addr);
-	gic_cpu_init(0, gic_cpu_base_addr);
+
+	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base_addr);
 }
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index f269710..241bcbc 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -365,20 +365,20 @@ static void __init gic_init_irq(void)
 
 		/* core tile GIC, primary */
 		gic_cpu_base_addr = __io_address(REALVIEW_EB11MP_GIC_CPU_BASE);
-		gic_dist_init(0, __io_address(REALVIEW_EB11MP_GIC_DIST_BASE), 29);
-		gic_cpu_init(0, gic_cpu_base_addr);
+		gic_init(0, 29, __io_address(REALVIEW_EB11MP_GIC_DIST_BASE),
+			 gic_cpu_base_addr);
 
 #ifndef CONFIG_REALVIEW_EB_ARM11MP_REVB
 		/* board GIC, secondary */
-		gic_dist_init(1, __io_address(REALVIEW_EB_GIC_DIST_BASE), 64);
-		gic_cpu_init(1, __io_address(REALVIEW_EB_GIC_CPU_BASE));
+		gic_init(1, 64, __io_address(REALVIEW_EB_GIC_DIST_BASE),
+			 __io_address(REALVIEW_EB_GIC_CPU_BASE));
 		gic_cascade_irq(1, IRQ_EB11MP_EB_IRQ1);
 #endif
 	} else {
 		/* board GIC, primary */
 		gic_cpu_base_addr = __io_address(REALVIEW_EB_GIC_CPU_BASE);
-		gic_dist_init(0, __io_address(REALVIEW_EB_GIC_DIST_BASE), 29);
-		gic_cpu_init(0, gic_cpu_base_addr);
+		gic_init(0, 29, __io_address(REALVIEW_EB_GIC_DIST_BASE),
+			 gic_cpu_base_addr);
 	}
 }
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index a412561..8047b19 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -305,12 +305,14 @@ static void __init gic_init_irq(void)
 {
 	/* ARM1176 DevChip GIC, primary */
 	gic_cpu_base_addr = __io_address(REALVIEW_DC1176_GIC_CPU_BASE);
-	gic_dist_init(0, __io_address(REALVIEW_DC1176_GIC_DIST_BASE), IRQ_DC1176_GIC_START);
-	gic_cpu_init(0, gic_cpu_base_addr);
+	gic_init(0, IRQ_DC1176_GIC_START,
+		 __io_address(REALVIEW_DC1176_GIC_DIST_BASE),
+		 gic_cpu_base_addr);
 
 	/* board GIC, secondary */
-	gic_dist_init(1, __io_address(REALVIEW_PB1176_GIC_DIST_BASE), IRQ_PB1176_GIC_START);
-	gic_cpu_init(1, __io_address(REALVIEW_PB1176_GIC_CPU_BASE));
+	gic_init(1, IRQ_PB1176_GIC_START,
+		 __io_address(REALVIEW_PB1176_GIC_DIST_BASE),
+		 __io_address(REALVIEW_PB1176_GIC_CPU_BASE));
 	gic_cascade_irq(1, IRQ_DC1176_PB_IRQ1);
 }
 
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 117b95b..6120426 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -310,12 +310,13 @@ static void __init gic_init_irq(void)
 
 	/* ARM11MPCore test chip GIC, primary */
 	gic_cpu_base_addr = __io_address(REALVIEW_TC11MP_GIC_CPU_BASE);
-	gic_dist_init(0, __io_address(REALVIEW_TC11MP_GIC_DIST_BASE), 29);
-	gic_cpu_init(0, gic_cpu_base_addr);
+	gic_init(0, 29, __io_address(REALVIEW_TC11MP_GIC_DIST_BASE),
+		 gic_cpu_base_addr);
 
 	/* board GIC, secondary */
-	gic_dist_init(1, __io_address(REALVIEW_PB11MP_GIC_DIST_BASE), IRQ_PB11MP_GIC_START);
-	gic_cpu_init(1, __io_address(REALVIEW_PB11MP_GIC_CPU_BASE));
+	gic_init(1, IRQ_PB11MP_GIC_START,
+		 __io_address(REALVIEW_PB11MP_GIC_DIST_BASE),
+		 __io_address(REALVIEW_PB11MP_GIC_CPU_BASE));
 	gic_cascade_irq(1, IRQ_TC11MP_PB_IRQ1);
 }
 
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 929b8dc..90f492a 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -274,8 +274,9 @@ static void __init gic_init_irq(void)
 {
 	/* ARM PB-A8 on-board GIC */
 	gic_cpu_base_addr = __io_address(REALVIEW_PBA8_GIC_CPU_BASE);
-	gic_dist_init(0, __io_address(REALVIEW_PBA8_GIC_DIST_BASE), IRQ_PBA8_GIC_START);
-	gic_cpu_init(0, __io_address(REALVIEW_PBA8_GIC_CPU_BASE));
+	gic_init(0, IRQ_PBA8_GIC_START,
+		 __io_address(REALVIEW_PBA8_GIC_DIST_BASE),
+		 __io_address(REALVIEW_PBA8_GIC_CPU_BASE));
 }
 
 static void __init realview_pba8_timer_init(void)
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index b9f9e20..86f28f7 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -314,14 +314,13 @@ static void __init gic_init_irq(void)
 	/* ARM PBX on-board GIC */
 	if (core_tile_pbx11mp() || core_tile_pbxa9mp()) {
 		gic_cpu_base_addr = __io_address(REALVIEW_PBX_TILE_GIC_CPU_BASE);
-		gic_dist_init(0, __io_address(REALVIEW_PBX_TILE_GIC_DIST_BASE),
-			      29);
-		gic_cpu_init(0, __io_address(REALVIEW_PBX_TILE_GIC_CPU_BASE));
+		gic_init(0, 29, __io_address(REALVIEW_PBX_TILE_GIC_DIST_BASE),
+			 __io_address(REALVIEW_PBX_TILE_GIC_CPU_BASE));
 	} else {
 		gic_cpu_base_addr = __io_address(REALVIEW_PBX_GIC_CPU_BASE);
-		gic_dist_init(0, __io_address(REALVIEW_PBX_GIC_DIST_BASE),
-			      IRQ_PBX_GIC_START);
-		gic_cpu_init(0, __io_address(REALVIEW_PBX_GIC_CPU_BASE));
+		gic_init(0, IRQ_PBX_GIC_START,
+			 __io_address(REALVIEW_PBX_GIC_DIST_BASE),
+			 __io_address(REALVIEW_PBX_GIC_CPU_BASE));
 	}
 }
 
diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index 82ce4aa..bce3e91 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -123,8 +123,7 @@ void __init s5pv310_init_irq(void)
 	int irq;
 
 	gic_cpu_base_addr = S5P_VA_GIC_CPU;
-	gic_dist_init(0, S5P_VA_GIC_DIST, IRQ_LOCALTIMER);
-	gic_cpu_init(0, S5P_VA_GIC_CPU);
+	gic_init(0, IRQ_LOCALTIMER, S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
 
 	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
 		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 50a8dfb..5407de0 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -94,8 +94,8 @@ void __init tegra_init_irq(void)
 		writel(0, ictlr_to_virt(i) + ICTLR_CPU_IEP_CLASS);
 	}
 
-	gic_dist_init(0, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE), 29);
-	gic_cpu_init(0, IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
+	gic_init(0, 29, IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE),
+		 IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
 
 	gic = get_irq_chip(29);
 	gic_unmask_irq = gic->unmask;
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 73fb1a5..a9ea28b 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -61,8 +61,8 @@ void __init ux500_init_devices(void)
 
 void __init ux500_init_irq(void)
 {
-	gic_dist_init(0, __io_address(UX500_GIC_DIST_BASE), 29);
-	gic_cpu_init(0, __io_address(UX500_GIC_CPU_BASE));
+	gic_init(0, 29, __io_address(UX500_GIC_DIST_BASE),
+		 __io_address(UX500_GIC_CPU_BASE));
 
 	/*
 	 * Init clocks here so that they are available for system timer
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index fd25ccd..25a3ca6 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -65,8 +65,7 @@ void __iomem *gic_cpu_base_addr;
 static void __init ct_ca9x4_init_irq(void)
 {
 	gic_cpu_base_addr = MMIO_P2V(A9_MPCORE_GIC_CPU);
-	gic_dist_init(0, MMIO_P2V(A9_MPCORE_GIC_DIST), 29);
-	gic_cpu_init(0, gic_cpu_base_addr);
+	gic_init(0, 29, MMIO_P2V(A9_MPCORE_GIC_DIST), gic_cpu_base_addr);
 }
 
 #if 0
-- 
1.6.2.5

