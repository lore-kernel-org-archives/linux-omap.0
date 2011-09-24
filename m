From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 09/24] OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
Date: Sat, 24 Sep 2011 11:44:29 +0530
Message-ID: <1316844884-21700-10-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44270 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1IXGPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 02:15:10 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP WakeupGen is the interrupt controller extension used along
with ARM GIC to wake the CPU out from low power states on
external interrupts.

The WakeupGen unit is responsible for generating the wakeup event
from the incoming interrupts and enable bits. It is implemented
in the MPU always ON power domain. During normal operation,
WakeupGen delivers the external interrupts directly to the GIC.

WakeupGen specification has one restriction as per Veyron version 1.6.
It is SW responsibility to program interrupt enabling/disabling
coherently in the GIC and in the WakeupGen enable registers. That is, a
given interrupt for a given CPU is either enable at both GIC and WakeupGen,
or disable at both, but no mix. That's the reason the WakeupGen is
implemented as an extension of GIC.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/Makefile                      |    2 +-
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |   39 ++++
 arch/arm/mach-omap2/omap-wakeupgen.c              |  226 +++++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c                |    3 +
 4 files changed, 269 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
 create mode 100644 arch/arm/mach-omap2/omap-wakeupgen.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 663f28a..ba8249b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
-obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o
+obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
new file mode 100644
index 0000000..d79321b
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
@@ -0,0 +1,39 @@
+/*
+ * OMAP WakeupGen header file
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
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
+#endif
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
new file mode 100644
index 0000000..22b0269
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -0,0 +1,226 @@
+/*
+ * OMAP WakeupGen Source file
+ *
+ * OMAP WakeupGen is the interrupt controller extension used along
+ * with ARM GIC to wake the CPU out from low power states on
+ * external interrupts. It is responsible for generating wakeup
+ * event from the incoming interrupts and enable bits. It is
+ * implemented in MPU always ON power domain. During normal operation,
+ * WakeupGen delivers external interrupts directly to the GIC.
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
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
+#include <linux/cpu.h>
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
+static void __iomem *wakeupgen_base;
+static DEFINE_PER_CPU(u32 [NR_BANKS], irqmasks);
+static DEFINE_SPINLOCK(wakeupgen_lock);
+static unsigned int irq_target_cpu[NR_IRQS];
+
+/*
+ * Static helper functions.
+ */
+static inline u32 wakeupgen_readl(u8 idx, u32 cpu)
+{
+	return __raw_readl(wakeupgen_base + OMAP_WKG_ENB_A_0 +
+				(cpu * CPU_ENA_OFFSET) + (idx * 4));
+}
+
+static inline void wakeupgen_writel(u32 val, u8 idx, u32 cpu)
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
+		wakeupgen_writel(reg, i, cpu);
+}
+
+static inline int _wakeupgen_get_irq_info(u32 irq, u32 *bit_posn, u8 *reg_index)
+{
+	unsigned int spi_irq;
+
+	/*
+	 * PPIs and SGIs are not supported.
+	 */
+	if (irq < OMAP44XX_IRQ_GIC_START)
+		return -EINVAL;
+
+	/*
+	 * Subtract the GIC offset.
+	 */
+	spi_irq = irq - OMAP44XX_IRQ_GIC_START;
+	if (spi_irq > MAX_IRQS) {
+		pr_err("omap wakeupGen: Invalid IRQ%d\n", irq);
+		return -EINVAL;
+	}
+
+	/*
+	 * Each WakeupGen register controls 32 interrupt.
+	 * i.e. 1 bit per SPI IRQ
+	 */
+	*reg_index = spi_irq >> 5;
+	*bit_posn = spi_irq %= 32;
+
+	return 0;
+}
+
+static void _wakeupgen_clear(unsigned int irq, unsigned int cpu)
+{
+	u32 val, bit_number;
+	u8 i;
+
+	if (_wakeupgen_get_irq_info(irq, &bit_number, &i))
+		return;
+
+	val = wakeupgen_readl(i, cpu);
+	val &= ~BIT(bit_number);
+	wakeupgen_writel(val, i, cpu);
+}
+
+static void _wakeupgen_set(unsigned int irq, unsigned int cpu)
+{
+	u32 val, bit_number;
+	u8 i;
+
+	if (_wakeupgen_get_irq_info(irq, &bit_number, &i))
+		return;
+
+	val = wakeupgen_readl(i, cpu);
+	val |= BIT(bit_number);
+	wakeupgen_writel(val, i, cpu);
+}
+
+static void _wakeupgen_save_masks(unsigned int cpu)
+{
+	u8 i;
+
+	for (i = 0; i < NR_BANKS; i++)
+		per_cpu(irqmasks, cpu)[i] = wakeupgen_readl(i, cpu);
+}
+
+static void _wakeupgen_restore_masks(unsigned int cpu)
+{
+	u8 i;
+
+	for (i = 0; i < NR_BANKS; i++)
+		wakeupgen_writel(per_cpu(irqmasks, cpu)[i], i, cpu);
+}
+
+/*
+ * Architecture specific Mask extension
+ */
+static void wakeupgen_mask(struct irq_data *d)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wakeupgen_lock, flags);
+	_wakeupgen_clear(d->irq, irq_target_cpu[d->irq]);
+	spin_unlock_irqrestore(&wakeupgen_lock, flags);
+}
+
+/*
+ * Architecture specific Unmask extension
+ */
+static void wakeupgen_unmask(struct irq_data *d)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wakeupgen_lock, flags);
+	_wakeupgen_set(d->irq, irq_target_cpu[d->irq]);
+	spin_unlock_irqrestore(&wakeupgen_lock, flags);
+}
+
+/*
+ * Mask or unmask all interrupts on given CPU.
+ *	0 = Mask all interrupts on the 'cpu'
+ *	1 = Unmask all interrupts on the 'cpu'
+ * Ensure that the initial mask is maintained. This is faster than
+ * iterating through GIC registers to arrive at the correct masks.
+ */
+static void wakeupgen_irqmask_all(unsigned int cpu, unsigned int set)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wakeupgen_lock, flags);
+	if (set) {
+		_wakeupgen_save_masks(cpu);
+		_wakeupgen_set_all(cpu, WKG_MASK_ALL);
+	} else {
+		_wakeupgen_set_all(cpu, WKG_UNMASK_ALL);
+		_wakeupgen_restore_masks(cpu);
+	}
+	spin_unlock_irqrestore(&wakeupgen_lock, flags);
+}
+
+/*
+ * Initialise the wakeupgen module.
+ */
+int __init omap_wakeupgen_init(void)
+{
+	int i;
+	unsigned int boot_cpu = smp_processor_id();
+
+	/* Not supported on OMAP4 ES1.0 silicon */
+	if (omap_rev() == OMAP4430_REV_ES1_0) {
+		WARN(1, "WakeupGen: Not supported on OMAP4430 ES1.0\n");
+		return -EPERM;
+	}
+
+	/* Static mapping, never released */
+	wakeupgen_base = ioremap(OMAP44XX_WKUPGEN_BASE, SZ_4K);
+	if (WARN_ON(!wakeupgen_base))
+		return -ENOMEM;
+
+	/* Clear all IRQ bitmasks at wakeupGen level */
+	for (i = 0; i < NR_BANKS; i++) {
+		wakeupgen_writel(0, i, CPU0_ID);
+		wakeupgen_writel(0, i, CPU1_ID);
+	}
+
+	/*
+	 * Override GIC architecture specific functions to add
+	 * OMAP WakeupGen interrupt controller along with GIC
+	 */
+	gic_arch_extn.irq_mask = wakeupgen_mask;
+	gic_arch_extn.irq_unmask = wakeupgen_unmask;
+	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
+
+	/*
+	 * FIXME: Add support to set_smp_affinity() once the core
+	 * GIC code has necessary hooks in place.
+	 */
+
+	/* Associate all the IRQs to boot CPU like GIC init does. */
+	for (i = 0; i < NR_IRQS; i++)
+		irq_target_cpu[i] = boot_cpu;
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 652e319..17274c0 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -23,6 +23,7 @@
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
+#include <mach/omap-wakeupgen.h>
 
 #include "omap4-sar-layout.h"
 
@@ -45,6 +46,8 @@ void __init gic_init_irq(void)
 	omap_irq_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
 	BUG_ON(!omap_irq_base);
 
+	omap_wakeupgen_init();
+
 	gic_init(0, 29, gic_dist_base_addr, omap_irq_base);
 }
 
-- 
1.7.4.1

