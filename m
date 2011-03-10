From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 11/19] OMAP4: PM: Add WakeupGen save/restore support
Date: Thu, 10 Mar 2011 19:38:07 +0530
Message-ID: <1299766095-23879-12-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53985 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410Ab1CJOIc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:08:32 -0500
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

WakeupGen IP is integrated along with GIC to manage the
interrupt wakeups from CPU low power states. It's located in
always ON power domain. It manages masking/unmasking of
Shared peripheral interrupts(SPI).So the interrupt enable/disable
control should be in sync and consistent at WakeupGen and GIC so
that interrupts are not lost.

Considering this GIC and WakeupGen save and restore is done
together.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |    1 +
 arch/arm/mach-omap2/omap-wakeupgen.c              |   81 +++++++++++++++++++++
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c        |    2 +
 arch/arm/mach-omap2/omap4-sar-layout.h            |   11 +++
 4 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
index f10d106..66f31c3 100644
--- a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
+++ b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
@@ -37,4 +37,5 @@
 
 extern int __init omap_wakeupgen_init(void);
 extern void omap_wakeupgen_irqmask_all(unsigned int cpu, unsigned int set);
+extern void omap_wakeupgen_save(void);
 #endif
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 43ebd22..7b72927 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -24,6 +24,9 @@
 #include <asm/hardware/gic.h>
 
 #include <mach/omap-wakeupgen.h>
+#include <mach/omap4-common.h>
+
+#include "omap4-sar-layout.h"
 
 #define NR_BANKS		4
 #define MAX_IRQS		128
@@ -35,6 +38,7 @@
 
 /* WakeupGen Base addres */
 static void __iomem *wakeupgen_base;
+static void __iomem *sar_base;
 static DEFINE_PER_CPU(u32 [NR_BANKS], irqmasks);
 static DEFINE_SPINLOCK(wakeupgen_lock);
 
@@ -54,6 +58,11 @@ static inline void wakeupgen_writel(u32 val, u8 idx, u32 cpu)
 				(cpu * CPU_ENA_OFFSET) + (idx * 4));
 }
 
+static inline void sar_writel(u32 val, u32 offset, u8 idx)
+{
+	__raw_writel(val, sar_base + offset + (idx * 4));
+}
+
 static void _wakeupgen_set_all(unsigned int cpu, unsigned int reg)
 {
 	u8 i;
@@ -236,3 +245,75 @@ int __init omap_wakeupgen_init(void)
 
 	return 0;
 }
+
+/**
+ * omap_wakeupgen_save() - WakeupGen context save function
+ *
+ * Save WakewupGen context in SAR BANK3. Restore is done by ROM code.
+ * WakeupGen IP is integrated along with GIC to manage the
+ * interrupt wakeups from CPU low power states. It's located in
+ * always ON power domain. It manages masking/unmasking of
+ * Shared peripheral interrupts(SPI).So the interrupt enable/disable
+ * control should be in sync and consistent at WakeupGen and GIC so
+ * that interrupts are not lost. Hence GIC and WakeupGen are saved
+ * and restored together.
+
+ * During normal operation, WakeupGen delivers external interrupts
+ * directly to the GIC. When the CPU asserts StandbyWFI, indicating
+ * it wants to enter lowpower state, the Standby Controller checks
+ * with the WakeupGen unit using the idlereq/idleack handshake to make
+ * sure there is no incoming interrupts.
+ */
+
+void omap_wakeupgen_save(void)
+{
+	u8 i;
+	u32 val;
+
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return;
+
+	if (!sar_base)
+		sar_base = omap4_get_sar_ram_base();
+
+	for (i = 0; i < NR_BANKS; i++) {
+		/* Save the CPUx interrupt mask for IRQ 0 to 127 */
+		val = wakeupgen_readl(i, 0);
+		sar_writel(val, WAKEUPGENENB_OFFSET_CPU0, i);
+		val = wakeupgen_readl(i, 1);
+		sar_writel(val, WAKEUPGENENB_OFFSET_CPU1, i);
+
+		/*
+		 * Disable the secure interrupts for CPUx. The restore
+		 * code blindly restores secure and non-secure interrupt
+		 * masks from SAR RAM. Secure interrupts are not suppose
+		 * to be enabled from HLOS. So overwrite the SAR location
+		 * so that the secure interrupt remains disabled.
+		 */
+		sar_writel(0x0, WAKEUPGENENB_SECURE_OFFSET_CPU0, i);
+		sar_writel(0x0, WAKEUPGENENB_SECURE_OFFSET_CPU1, i);
+	}
+
+	/* Save AuxBoot* registers */
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);
+
+	/* Save SyncReq generation logic */
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);
+
+	/* Save SyncReq generation logic */
+	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_MASK);
+	__raw_writel(val, sar_base + PTMSYNCREQ_MASK_OFFSET);
+	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_EN);
+	__raw_writel(val, sar_base + PTMSYNCREQ_EN_OFFSET);
+
+	/* Set the Backup Bit Mask status */
+	val = __raw_readl(sar_base + SAR_BACKUP_STATUS_OFFSET);
+	val |= SAR_BACKUP_STATUS_WAKEUPGEN;
+	__raw_writel(val, sar_base + SAR_BACKUP_STATUS_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
index 446b956..ddf5b72 100644
--- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
@@ -52,6 +52,7 @@
 
 #include <plat/omap44xx.h>
 #include <mach/omap4-common.h>
+#include <mach/omap-wakeupgen.h>
 
 #include "omap4-sar-layout.h"
 #include "pm.h"
@@ -292,6 +293,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * GIC lost during MPU OFF and OSWR
 	 */
 	if (pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_OFF) {
+		omap_wakeupgen_save();
 		gic_save_context();
 		save_state = 3;
 	}
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index baac4c0..3f3e3c9 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -50,4 +50,15 @@
 #define SAR_BACKUP_STATUS_GIC_CPU0		0x1
 #define SAR_BACKUP_STATUS_GIC_CPU1		0x2
 
+/* WakeUpGen save restore offset from OMAP44XX_SAR_RAM_BASE */
+#define WAKEUPGENENB_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x684)
+#define WAKEUPGENENB_SECURE_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x694)
+#define WAKEUPGENENB_OFFSET_CPU1		(SAR_BANK3_OFFSET + 0x6a4)
+#define WAKEUPGENENB_SECURE_OFFSET_CPU1		(SAR_BANK3_OFFSET + 0x6b4)
+#define AUXCOREBOOT0_OFFSET			(SAR_BANK3_OFFSET + 0x6c4)
+#define AUXCOREBOOT1_OFFSET			(SAR_BANK3_OFFSET + 0x6c8)
+#define PTMSYNCREQ_MASK_OFFSET			(SAR_BANK3_OFFSET + 0x6cc)
+#define PTMSYNCREQ_EN_OFFSET			(SAR_BANK3_OFFSET + 0x6d0)
+#define SAR_BACKUP_STATUS_WAKEUPGEN		0x10
+
 #endif
-- 
1.6.0.4

