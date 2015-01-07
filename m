From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 06/21] ARM: tegra: remove old LIC support
Date: Wed,  7 Jan 2015 17:42:41 +0000
Message-ID: <1420652576-22309-7-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:57032 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbbAGRnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 12:43:23 -0500
In-Reply-To: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

Now that all DTs have been updated, entierely drop support for
the non-DT code.

This is likely to break platforms that do not update their DT,
so print a warning at boot time.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/iomap.h |  15 ----
 arch/arm/mach-tegra/irq.c   | 201 +-------------------------------------------
 arch/arm/mach-tegra/irq.h   |   6 --
 3 files changed, 2 insertions(+), 220 deletions(-)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index ee79808..81dc950 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -31,21 +31,6 @@
 #define TEGRA_ARM_INT_DIST_BASE		0x50041000
 #define TEGRA_ARM_INT_DIST_SIZE		SZ_4K
 
-#define TEGRA_PRIMARY_ICTLR_BASE	0x60004000
-#define TEGRA_PRIMARY_ICTLR_SIZE	SZ_64
-
-#define TEGRA_SECONDARY_ICTLR_BASE	0x60004100
-#define TEGRA_SECONDARY_ICTLR_SIZE	SZ_64
-
-#define TEGRA_TERTIARY_ICTLR_BASE	0x60004200
-#define TEGRA_TERTIARY_ICTLR_SIZE	SZ_64
-
-#define TEGRA_QUATERNARY_ICTLR_BASE	0x60004300
-#define TEGRA_QUATERNARY_ICTLR_SIZE	SZ_64
-
-#define TEGRA_QUINARY_ICTLR_BASE	0x60004400
-#define TEGRA_QUINARY_ICTLR_SIZE	SZ_64
-
 #define TEGRA_TMR1_BASE			0x60005000
 #define TEGRA_TMR1_SIZE			SZ_8
 
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index b37141d..a1befd3 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -30,43 +30,9 @@
 #include "board.h"
 #include "iomap.h"
 
-#define ICTLR_CPU_IEP_VFIQ	0x08
-#define ICTLR_CPU_IEP_FIR	0x14
-#define ICTLR_CPU_IEP_FIR_SET	0x18
-#define ICTLR_CPU_IEP_FIR_CLR	0x1c
-
-#define ICTLR_CPU_IER		0x20
-#define ICTLR_CPU_IER_SET	0x24
-#define ICTLR_CPU_IER_CLR	0x28
-#define ICTLR_CPU_IEP_CLASS	0x2C
-
-#define ICTLR_COP_IER		0x30
-#define ICTLR_COP_IER_SET	0x34
-#define ICTLR_COP_IER_CLR	0x38
-#define ICTLR_COP_IEP_CLASS	0x3c
-
-#define FIRST_LEGACY_IRQ 32
-#define TEGRA_MAX_NUM_ICTLRS	5
-
 #define SGI_MASK 0xFFFF
 
-static int num_ictlrs;
-
-static void __iomem *ictlr_reg_base[] = {
-	IO_ADDRESS(TEGRA_PRIMARY_ICTLR_BASE),
-	IO_ADDRESS(TEGRA_SECONDARY_ICTLR_BASE),
-	IO_ADDRESS(TEGRA_TERTIARY_ICTLR_BASE),
-	IO_ADDRESS(TEGRA_QUATERNARY_ICTLR_BASE),
-	IO_ADDRESS(TEGRA_QUINARY_ICTLR_BASE),
-};
-
 #ifdef CONFIG_PM_SLEEP
-static u32 cop_ier[TEGRA_MAX_NUM_ICTLRS];
-static u32 cop_iep[TEGRA_MAX_NUM_ICTLRS];
-static u32 cpu_ier[TEGRA_MAX_NUM_ICTLRS];
-static u32 cpu_iep[TEGRA_MAX_NUM_ICTLRS];
-
-static u32 ictlr_wake_mask[TEGRA_MAX_NUM_ICTLRS];
 static void __iomem *tegra_gic_cpu_base;
 #endif
 
@@ -83,140 +49,7 @@ bool tegra_pending_sgi(void)
 	return false;
 }
 
-static inline void tegra_irq_write_mask(unsigned int irq, unsigned long reg)
-{
-	void __iomem *base;
-	u32 mask;
-
-	BUG_ON(irq < FIRST_LEGACY_IRQ ||
-		irq >= FIRST_LEGACY_IRQ + num_ictlrs * 32);
-
-	base = ictlr_reg_base[(irq - FIRST_LEGACY_IRQ) / 32];
-	mask = BIT((irq - FIRST_LEGACY_IRQ) % 32);
-
-	__raw_writel(mask, base + reg);
-}
-
-static void tegra_mask(struct irq_data *d)
-{
-	if (d->hwirq < FIRST_LEGACY_IRQ)
-		return;
-
-	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IER_CLR);
-}
-
-static void tegra_unmask(struct irq_data *d)
-{
-	if (d->hwirq < FIRST_LEGACY_IRQ)
-		return;
-
-	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IER_SET);
-}
-
-static void tegra_ack(struct irq_data *d)
-{
-	if (d->hwirq < FIRST_LEGACY_IRQ)
-		return;
-
-	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IEP_FIR_CLR);
-}
-
-static void tegra_eoi(struct irq_data *d)
-{
-	if (d->hwirq < FIRST_LEGACY_IRQ)
-		return;
-
-	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IEP_FIR_CLR);
-}
-
-static int tegra_retrigger(struct irq_data *d)
-{
-	if (d->hwirq < FIRST_LEGACY_IRQ)
-		return 0;
-
-	tegra_irq_write_mask(d->hwirq, ICTLR_CPU_IEP_FIR_SET);
-
-	return 1;
-}
-
 #ifdef CONFIG_PM_SLEEP
-static int tegra_set_wake(struct irq_data *d, unsigned int enable)
-{
-	u32 irq = d->hwirq;
-	u32 index, mask;
-
-	if (irq < FIRST_LEGACY_IRQ ||
-		irq >= FIRST_LEGACY_IRQ + num_ictlrs * 32)
-		return -EINVAL;
-
-	index = ((irq - FIRST_LEGACY_IRQ) / 32);
-	mask = BIT((irq - FIRST_LEGACY_IRQ) % 32);
-	if (enable)
-		ictlr_wake_mask[index] |= mask;
-	else
-		ictlr_wake_mask[index] &= ~mask;
-
-	return 0;
-}
-
-static int tegra_legacy_irq_suspend(void)
-{
-	unsigned long flags;
-	int i;
-
-	local_irq_save(flags);
-	for (i = 0; i < num_ictlrs; i++) {
-		void __iomem *ictlr = ictlr_reg_base[i];
-		/* Save interrupt state */
-		cpu_ier[i] = readl_relaxed(ictlr + ICTLR_CPU_IER);
-		cpu_iep[i] = readl_relaxed(ictlr + ICTLR_CPU_IEP_CLASS);
-		cop_ier[i] = readl_relaxed(ictlr + ICTLR_COP_IER);
-		cop_iep[i] = readl_relaxed(ictlr + ICTLR_COP_IEP_CLASS);
-
-		/* Disable COP interrupts */
-		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
-
-		/* Disable CPU interrupts */
-		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
-
-		/* Enable the wakeup sources of ictlr */
-		writel_relaxed(ictlr_wake_mask[i], ictlr + ICTLR_CPU_IER_SET);
-	}
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-static void tegra_legacy_irq_resume(void)
-{
-	unsigned long flags;
-	int i;
-
-	local_irq_save(flags);
-	for (i = 0; i < num_ictlrs; i++) {
-		void __iomem *ictlr = ictlr_reg_base[i];
-		writel_relaxed(cpu_iep[i], ictlr + ICTLR_CPU_IEP_CLASS);
-		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
-		writel_relaxed(cpu_ier[i], ictlr + ICTLR_CPU_IER_SET);
-		writel_relaxed(cop_iep[i], ictlr + ICTLR_COP_IEP_CLASS);
-		writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
-		writel_relaxed(cop_ier[i], ictlr + ICTLR_COP_IER_SET);
-	}
-	local_irq_restore(flags);
-}
-
-static struct syscore_ops tegra_legacy_irq_syscore_ops = {
-	.suspend = tegra_legacy_irq_suspend,
-	.resume = tegra_legacy_irq_resume,
-};
-
-int tegra_legacy_irq_syscore_init(void)
-{
-	register_syscore_ops(&tegra_legacy_irq_syscore_ops);
-
-	return 0;
-}
-
 static int tegra_gic_notifier(struct notifier_block *self,
 			      unsigned long cmd, void *v)
 {
@@ -251,7 +84,6 @@ static void tegra114_gic_cpu_pm_registration(void)
 	cpu_pm_register_notifier(&tegra_gic_notifier_block);
 }
 #else
-#define tegra_set_wake NULL
 static void tegra114_gic_cpu_pm_registration(void) { }
 #endif
 
@@ -262,37 +94,8 @@ static const struct of_device_id tegra_ictlr_match[] __initconst = {
 
 void __init tegra_init_irq(void)
 {
-	int i;
-	void __iomem *distbase;
-
-	if (of_find_matching_node(NULL, tegra_ictlr_match))
-		goto skip_extn_setup;
-
-	tegra_legacy_irq_syscore_init();
-
-	distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
-	num_ictlrs = readl_relaxed(distbase + GIC_DIST_CTR) & 0x1f;
-
-	if (num_ictlrs > ARRAY_SIZE(ictlr_reg_base)) {
-		WARN(1, "Too many (%d) interrupt controllers found. Maximum is %d.",
-			num_ictlrs, ARRAY_SIZE(ictlr_reg_base));
-		num_ictlrs = ARRAY_SIZE(ictlr_reg_base);
-	}
-
-	for (i = 0; i < num_ictlrs; i++) {
-		void __iomem *ictlr = ictlr_reg_base[i];
-		writel(~0, ictlr + ICTLR_CPU_IER_CLR);
-		writel(0, ictlr + ICTLR_CPU_IEP_CLASS);
-	}
-
-	gic_arch_extn.irq_ack = tegra_ack;
-	gic_arch_extn.irq_eoi = tegra_eoi;
-	gic_arch_extn.irq_mask = tegra_mask;
-	gic_arch_extn.irq_unmask = tegra_unmask;
-	gic_arch_extn.irq_retrigger = tegra_retrigger;
-	gic_arch_extn.irq_set_wake = tegra_set_wake;
-	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
+	if (!of_find_matching_node(NULL, tegra_ictlr_match))
+		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
 
-skip_extn_setup:
 	tegra114_gic_cpu_pm_registration();
 }
diff --git a/arch/arm/mach-tegra/irq.h b/arch/arm/mach-tegra/irq.h
index bc05ce5..5142649 100644
--- a/arch/arm/mach-tegra/irq.h
+++ b/arch/arm/mach-tegra/irq.h
@@ -19,10 +19,4 @@
 
 bool tegra_pending_sgi(void);
 
-#ifdef CONFIG_PM_SLEEP
-int tegra_legacy_irq_syscore_init(void);
-#else
-static inline int tegra_legacy_irq_syscore_init(void) { return 0; }
-#endif
-
 #endif
-- 
2.1.4

