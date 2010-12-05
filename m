From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 2/5] ARM: GIC: Remove MMIO address from gic_cpu_init, rename to gic_secondary_init
Date: Sun, 05 Dec 2010 11:34:38 +0000
Message-ID: <E1PPCrW-0004xS-L5@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45845 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255Ab0LELet (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 06:34:49 -0500
In-Reply-To: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene.kim@samsung.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Olof Johansson <olof@lixom.net>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org

We don't need to re-pass the base address for the CPU interfaces to the
GIC for secondary CPUs, as it will never be different from the boot CPU
- and even if it was, we'd overwrite the boot CPU's base address.

Get rid of this argument, and rename to gic_secondary_init().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/gic.c               |    7 ++++++-
 arch/arm/include/asm/hardware/gic.h |    2 +-
 arch/arm/mach-omap2/omap-smp.c      |    2 +-
 arch/arm/mach-realview/platsmp.c    |    2 +-
 arch/arm/mach-s5pv310/platsmp.c     |    2 +-
 arch/arm/mach-tegra/platsmp.c       |    2 +-
 arch/arm/mach-ux500/platsmp.c       |    2 +-
 arch/arm/mach-vexpress/platsmp.c    |    2 +-
 8 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 41dce4f..12b6a08 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -276,7 +276,7 @@ static void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
 	writel(1, base + GIC_DIST_CTRL);
 }
 
-void __cpuinit gic_cpu_init(unsigned int gic_nr, void __iomem *base)
+static void __cpuinit gic_cpu_init(unsigned int gic_nr, void __iomem *base)
 {
 	void __iomem *dist_base;
 	int i;
@@ -313,6 +313,11 @@ void __init gic_init(unsigned int gic_nr, unsigned int irq_start,
 	gic_cpu_init(gic_nr, cpu_base);
 }
 
+void __cpuinit gic_secondary_init(unsigned int gic_nr)
+{
+	gic_cpu_init(gic_nr, gic_data[gic_nr].cpu_base);
+}
+
 #ifdef CONFIG_SMP
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 387c6ae..48876a3 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -33,8 +33,8 @@
 #define GIC_DIST_SOFTINT		0xf00
 
 #ifndef __ASSEMBLY__
-void gic_cpu_init(unsigned int gic_nr, void __iomem *base);
 void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
+void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 #endif
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 9e9f70e..9fbac2c 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -50,7 +50,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-	gic_cpu_init(0, gic_cpu_base_addr);
+	gic_secondary_init(0);
 
 	/*
 	 * Synchronise with the boot thread.
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 0092658..6da8a2e 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -69,7 +69,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-	gic_cpu_init(0, gic_cpu_base_addr);
+	gic_secondary_init(0);
 
 	/*
 	 * let the primary processor know we're out of the
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-s5pv310/platsmp.c
index d357c19..15929c1 100644
--- a/arch/arm/mach-s5pv310/platsmp.c
+++ b/arch/arm/mach-s5pv310/platsmp.c
@@ -54,7 +54,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-	gic_cpu_init(0, gic_cpu_base_addr);
+	gic_secondary_init(0);
 
 	/*
 	 * let the primary processor know we're out of the
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 1c0fd92..3b7376c 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -48,7 +48,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-	gic_cpu_init(0, IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x100);
+	gic_secondary_init(0);
 
 	/*
 	 * Synchronise with the boot thread.
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 9e4c678..b5077b4 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -44,7 +44,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-	gic_cpu_init(0, __io_address(UX500_GIC_CPU_BASE));
+	gic_secondary_init(0);
 
 	/*
 	 * let the primary processor know we're out of the
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 6709706..dfb5910 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -51,7 +51,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-	gic_cpu_init(0, gic_cpu_base_addr);
+	gic_secondary_init(0);
 
 	/*
 	 * let the primary processor know we're out of the
-- 
1.6.2.5

