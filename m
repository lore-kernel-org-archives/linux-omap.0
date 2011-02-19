From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 01/17] omap4: pm: Add omap WakeupGen module support
Date: Sat, 19 Feb 2011 16:12:22 +0530
Message-ID: <1298112158-28469-2-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34197 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961Ab1BSKmx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:42:53 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds OMAP WakeupGen support. The WakeupGen unit is responsible
for generating wakeup event from the incoming interrupts and enable bits.
The WakeupGen is implemented in MPU Always-On power domain. During normal
operation, WakeupGen delivers external interrupts directly to the GIC.
When the CPUx asserts StandbyWFI, indicating it wants to enter lowpower
state, the Standby Controller checks with the WakeupGen unit using the
idlereq/idleack handshake to make sure there is no incoming interrupts.
The GIC and WakeupGen needs to be kept in synchronisation for proper
interrupt functioning.

Hence this patch hooks up the omap WakeupGen mask/unmask along with GIC using
architecture specific hooks.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/Makefile                      |    3 +-
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |   40 ++++
 arch/arm/mach-omap2/omap-wakeupgen.c              |  213 +++++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c                |    3 +
 4 files changed, 258 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
 create mode 100644 arch/arm/mach-omap2/omap-wakeupgen.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 72f2891..54ff219 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -24,7 +24,8 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
-obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
+obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o \
+					   omap-wakeupgen.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
new file mode 100644
index 0000000..f10d106
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
@@ -0,0 +1,40 @@
+/*
+ * OMAP WakeupGen header file
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef OMAP_ARCH_WAKEUPGEN_H
+#define OMAP_ARCH_WAKEUPGEN_H
+
+#define OMAP_WKG_CONTROL_0			0x00
+#define OMAP_WKG_ENB_A_0			0x10
+#define OMAP_WKG_ENB_B_0			0x14
+#define OMAP_WKG_ENB_C_0			0x18
+#define OMAP_WKG_ENB_D_0			0x1c
+#define OMAP_WKG_ENB_SECURE_A_0			0x20
+#define OMAP_WKG_ENB_SECURE_B_0			0x24
+#define OMAP_WKG_ENB_SECURE_C_0			0x28
+#define OMAP_WKG_ENB_SECURE_D_0			0x2c
+#define OMAP_WKG_ENB_A_1			0x410
+#define OMAP_WKG_ENB_B_1			0x414
+#define OMAP_WKG_ENB_C_1			0x418
+#define OMAP_WKG_ENB_D_1			0x41c
+#define OMAP_WKG_ENB_SECURE_A_1			0x420
+#define OMAP_WKG_ENB_SECURE_B_1			0x424
+#define OMAP_WKG_ENB_SECURE_C_1			0x428
+#define OMAP_WKG_ENB_SECURE_D_1			0x42c
+#define OMAP_AUX_CORE_BOOT_0			0x800
+#define OMAP_AUX_CORE_BOOT_1			0x804
+#define OMAP_PTMSYNCREQ_MASK			0xc00
+#define OMAP_PTMSYNCREQ_EN			0xc04
+#define OMAP_TIMESTAMPCYCLELO			0xc08
+#define OMAP_TIMESTAMPCYCLEHI			0xc0c
+
+extern int __init omap_wakeupgen_init(void);
+extern void omap_wakeupgen_irqmask_all(unsigned int cpu, unsigned int set);
+#endif
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
new file mode 100644
index 0000000..e26a0ed
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -0,0 +1,213 @@
+/*
+ * OMAP WakeupGen Source file
+ *
+ * The WakeupGen unit is responsible for generating wakeup event from the
+ * incoming interrupts and enable bits. The WakeupGen is implemented in MPU
+ * always-On power domain. The WakeupGen consists of two sub-units, one for
+ * each CPU and manages only SPI interrupts. Hardware requirements is that
+ * the GIC and WakeupGen should be kept in sync for proper operation.
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+
+#include <asm/hardware/gic.h>
+
+#include <mach/omap-wakeupgen.h>
+
+#define NR_BANKS		4
+#define MAX_IRQS		128
+#define WKG_MASK_ALL		0x00000000
+#define WKG_UNMASK_ALL		0xffffffff
+#define CPU_ENA_OFFSET		0x400
+#define CPU0_ID			0x0
+#define CPU1_ID			0x1
+
+/* WakeupGen Base addres */
+static void __iomem *wakeupgen_base;
+static DEFINE_PER_CPU(u32 [NR_BANKS], irqmasks);
+static DEFINE_SPINLOCK(wakeupgen_lock);
+
+/*
+ * Static helper functions
+ */
+
+static inline u32 cpu_readl(u8 idx, u32 cpu)
+{
+	return __raw_readl(wakeupgen_base + OMAP_WKG_ENB_A_0 +
+				(cpu * CPU_ENA_OFFSET) + (idx * 4));
+}
+
+static inline void cpu_writel(u32 val, u8 idx, u32 cpu)
+{
+	__raw_writel(val, wakeupgen_base + OMAP_WKG_ENB_A_0 +
+				(cpu * CPU_ENA_OFFSET) + (idx * 4));
+}
+
+static void _wakeupgen_set_all(unsigned int cpu, unsigned int reg)
+{
+	u8 i;
+
+	for (i = 0; i < NR_BANKS; i++)
+		cpu_writel(reg, i, cpu);
+}
+
+static void _wakeupgen_set(unsigned int irq, unsigned int set)
+{
+	unsigned int val, spi_irq;
+	unsigned int cpu = smp_processor_id();
+	u8 i;
+
+	/*
+	 * PPIs and SGIs are not supported
+	 */
+	if (irq < OMAP44XX_IRQ_GIC_START)
+		return;
+
+	/*
+	 * Subtract the GIC offset
+	 */
+	spi_irq = irq - OMAP44XX_IRQ_GIC_START;
+	if (spi_irq > MAX_IRQS) {
+		pr_err("omap wakeupGen: Invalid IRQ%d\n", irq);
+		return ;
+	}
+
+	/*
+	 * Each wakeup gen register controls 32
+	 * interrupts. i.e 1 bit per SPI IRQ
+	 */
+	i = spi_irq >> 5;
+	spi_irq %= 32;
+
+	val = cpu_readl(i, cpu);
+	if (set)
+		val |= BIT(spi_irq);
+	else
+		val &= ~BIT(spi_irq);
+	cpu_writel(val, i, cpu);
+}
+
+static void _wakeupgen_save_masks(unsigned int cpu)
+{
+	u8 i;
+
+	for (i = 0; i < NR_BANKS; i++)
+		per_cpu(irqmasks, cpu)[i] = cpu_readl(i, cpu);
+}
+
+static void _wakeupgen_restore_masks(unsigned int cpu)
+{
+	u8 i;
+
+	for (i = 0; i < NR_BANKS; i++)
+		cpu_writel(per_cpu(irqmasks, cpu)[i], i, cpu);
+}
+
+/*
+ * Architecture specific Mask extensiom
+ */
+static void wakeupgen_mask(struct irq_data *d)
+{
+	spin_lock(&wakeupgen_lock);
+	_wakeupgen_set(d->irq, 0);
+	spin_unlock(&wakeupgen_lock);
+}
+
+/*
+ * Architecture specific Unmask extensiom
+ */
+static void wakeupgen_unmask(struct irq_data *d)
+{
+
+	spin_lock(&wakeupgen_lock);
+	_wakeupgen_set(d->irq, 1);
+	spin_unlock(&wakeupgen_lock);
+}
+
+#ifdef CONFIG_PM
+/*
+ * Architecture specific set_wake extension
+ */
+static int wakeupgen_set_wake(struct irq_data *d, unsigned int on)
+{
+	spin_lock(&wakeupgen_lock);
+	_wakeupgen_set(d->irq, on);
+	spin_unlock(&wakeupgen_lock);
+
+	return 0;
+}
+
+#else
+#define wakeupgen_set_wake	NULL
+#endif
+
+/**
+ * omap_wakeupgen_irqmask_all() -  Mask or unmask interrupts
+ * @cpu - CPU ID
+ * @set - The IRQ register mask.
+ *	0 = Mask all interrupts on the 'cpu'
+ *	1 = Unmask all interrupts on the 'cpu'
+ *
+ * Ensure that the initial mask is maintained. This is faster than
+ * iterating through GIC rgeisters to arrive at the correct masks
+ */
+void omap_wakeupgen_irqmask_all(unsigned int cpu, unsigned int set)
+{
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return;
+
+	spin_lock(&wakeupgen_lock);
+	if (set) {
+		_wakeupgen_save_masks(cpu);
+		_wakeupgen_set_all(cpu, WKG_MASK_ALL);
+	} else {
+		_wakeupgen_set_all(cpu, WKG_UNMASK_ALL);
+		_wakeupgen_restore_masks(cpu);
+	}
+	spin_unlock(&wakeupgen_lock);
+}
+
+/*
+ * Initialse the wakeupgen module
+ */
+int __init omap_wakeupgen_init(void)
+{
+	u8 i;
+
+	/* Not supported on on OMAP4 ES1.0 silicon */
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN(1, "WakeupGen: Not supported on OMAP4430 ES1.0\n");
+		return -EPERM;
+	}
+
+	/* Static mapping, never released */
+	wakeupgen_base = ioremap(OMAP44XX_WKUPGEN_BASE, SZ_4K);
+	BUG_ON(!wakeupgen_base);
+
+	/* Clear all IRQ bitmasks at wakeupGen level */
+	for (i = 0; i < NR_BANKS; i++) {
+		cpu_writel(0, i, CPU0_ID);
+		cpu_writel(0, i, CPU1_ID);
+	}
+
+	/*
+	 * Override gic architecture specific fucntioms to add
+	 * OMAP WakeupGen interrupt controller along with GIC
+	 */
+	gic_arch_extn.irq_mask = wakeupgen_mask;
+	gic_arch_extn.irq_unmask = wakeupgen_unmask;
+	gic_arch_extn.irq_set_wake = wakeupgen_set_wake;
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 1926864..559d227 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -21,6 +21,7 @@
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
+#include <mach/omap-wakeupgen.h>
 
 #ifdef CONFIG_CACHE_L2X0
 void __iomem *l2cache_base;
@@ -41,6 +42,8 @@ void __init gic_init_irq(void)
 	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
 	BUG_ON(!gic_cpu_base);
 
+	omap_wakeupgen_init();
+
 	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
 }
 
-- 
1.6.0.4

