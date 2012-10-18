From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 6/8] ARM: OMAP4: retrigger localtimers after re-enabling gic
Date: Thu, 18 Oct 2012 12:20:08 +0300
Message-ID: <1350552010-28760-7-git-send-email-t-kristo@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43250 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975Ab2JRJUo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 05:20:44 -0400
In-Reply-To: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Colin Cross <ccross@android.com>, Sebastien Jan <s-jan@ti.com>

From: Colin Cross <ccross@android.com>

'Workaround for ROM bug because of CA9 r2pX gic control'
register change disables the gic distributor while the secondary
cpu is being booted.  If a localtimer interrupt on the primary cpu
occurs when the distributor is turned off, the interrupt is lost,
and the localtimer never fires again.

Make the primary cpu wait for the secondary cpu to reenable the
gic distributor (with interrupts off for safety), and then
check if the pending bit is set in the localtimer but not the
gic.  If so, ack it in the localtimer, and reset the timer with
the minimum timeout to trigger a new timer interrupt.

Signed-off-by: Colin Cross <ccross@android.com>
[s-jan@ti.com: adapted to k3.4 + validated functionality]
Signed-off-by: Sebastien Jan <s-jan@ti.com>
[t-kristo@ti.com: dropped generic ARM kernel exports from the code, rebased
 to mainline]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/common.h       |    2 ++
 arch/arm/mach-omap2/omap-smp.c     |   13 ++++++++++++-
 arch/arm/mach-omap2/omap4-common.c |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 70993a9..d29dbaa 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -276,6 +276,8 @@ static inline void __iomem *omap4_get_scu_base(void)
 
 extern void __init gic_init_irq(void);
 extern void gic_dist_disable(void);
+extern bool gic_dist_disabled(void);
+extern void gic_timer_retrigger(void);
 extern void omap_smc1(u32 fn, u32 arg);
 extern void __iomem *omap4_get_sar_ram_base(void);
 extern void omap_do_wfi(void);
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 7d9c0e3..49a08df 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -134,11 +134,22 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 		 * 2) CPU1 must re-enable the GIC distributor on
 		 * it's wakeup path.
 		 */
-		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD))
+		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD)) {
+			local_irq_disable();
 			gic_dist_disable();
+		}
 
 		clkdm_wakeup(cpu1_clkdm);
 		clkdm_allow_idle(cpu1_clkdm);
+
+		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD)) {
+			while (gic_dist_disabled()) {
+				udelay(1);
+				cpu_relax();
+			}
+			gic_timer_retrigger();
+			local_irq_enable();
+		}
 	} else {
 		dsb_sev();
 		booted = true;
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 72cf396..6f94b4e 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/memblock.h>
 #include <linux/of_irq.h>
@@ -24,6 +25,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
+#include <asm/smp_twd.h>
 
 #include <plat/sram.h>
 #include <plat/omap-secure.h>
@@ -42,6 +44,9 @@ static void __iomem *l2cache_base;
 
 static void __iomem *sar_ram_base;
 static void __iomem *gic_dist_base_addr;
+static void __iomem *twd_base;
+
+#define IRQ_LOCALTIMER		29
 
 #ifdef CONFIG_OMAP4_ERRATA_I688
 /* Used to implement memory barrier on DRAM path */
@@ -101,6 +106,9 @@ void __init gic_init_irq(void)
 	gic_dist_base_addr = ioremap(OMAP44XX_GIC_DIST_BASE, SZ_4K);
 	BUG_ON(!gic_dist_base_addr);
 
+	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_4K);
+	BUG_ON(!twd_base);
+
 	/* Static mapping, never released */
 	omap_irq_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
 	BUG_ON(!omap_irq_base);
@@ -116,6 +124,32 @@ void gic_dist_disable(void)
 		__raw_writel(0x0, gic_dist_base_addr + GIC_DIST_CTRL);
 }
 
+bool gic_dist_disabled(void)
+{
+	return !(__raw_readl(gic_dist_base_addr + GIC_DIST_CTRL) & 0x1);
+}
+
+void gic_timer_retrigger(void)
+{
+	u32 twd_int = __raw_readl(twd_base + TWD_TIMER_INTSTAT);
+	u32 gic_int = __raw_readl(gic_dist_base_addr + GIC_DIST_PENDING_SET);
+	u32 twd_ctrl = __raw_readl(twd_base + TWD_TIMER_CONTROL);
+
+	if (twd_int && !(gic_int & BIT(IRQ_LOCALTIMER))) {
+		/*
+		 * The local timer interrupt got lost while the distributor was
+		 * disabled.  Ack the pending interrupt, and retrigger it.
+		 */
+		pr_warn("%s: lost localtimer interrupt\n", __func__);
+		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
+		if (!(twd_ctrl & TWD_TIMER_CONTROL_PERIODIC)) {
+			__raw_writel(1, twd_base + TWD_TIMER_COUNTER);
+			twd_ctrl |= TWD_TIMER_CONTROL_ENABLE;
+			__raw_writel(twd_ctrl, twd_base + TWD_TIMER_CONTROL);
+		}
+	}
+}
+
 #ifdef CONFIG_CACHE_L2X0
 
 void __iomem *omap4_get_l2cache_base(void)
-- 
1.7.4.1

