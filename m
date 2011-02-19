From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 09/17] omap4: pm: Add WakeupGen save/restore support
Date: Sat, 19 Feb 2011 16:12:30 +0530
Message-ID: <1298112158-28469-10-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34195 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941Ab1BSKmw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:42:52 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

WakeupGen is lost only when device hits off-mode. Though the register
context is retained in MPUSS OFF/OSWR state, hardware recommondation is
to save/restore WakeupGen along with GIC to have consistent interrupt
state at both the blocks. The ROM code restore mechinism also does
restore of wakeupgen on mpu OFF/OSWR

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |    1 +
 arch/arm/mach-omap2/omap-wakeupgen.c              |   74 +++++++++++++++++++++
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c        |    2 +
 arch/arm/mach-omap2/omap4-sar-layout.h            |   11 +++
 4 files changed, 88 insertions(+), 0 deletions(-)

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
index e26a0ed..0f0a5ed 100644
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
@@ -54,6 +57,11 @@ static inline void cpu_writel(u32 val, u8 idx, u32 cpu)
 				(cpu * CPU_ENA_OFFSET) + (idx * 4));
 }
 
+static inline void sar_writel(u32 val, u32 offset, u8 idx)
+{
+	__raw_writel(val, sar_ram_base + offset + (idx * 4));
+}
+
 static void _wakeupgen_set_all(unsigned int cpu, unsigned int reg)
 {
 	u8 i;
@@ -211,3 +219,69 @@ int __init omap_wakeupgen_init(void)
 
 	return 0;
 }
+
+/**
+ * omap_wakeupgen_save() - WakeupGen context save function
+ *
+ * Save WakewupGen context in SAR BANK3. Restore is done by ROM code.
+ * WakeupGen is lost only when DEVICE hits OFF. Though the register
+ * context is retained in MPU OFF/OSWR state, hw recommondation is to
+ * save/restore WakeupGen along with GIC to have consistent interrupt
+ * state at both the blocks.
+ *
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
+	for (i = 0; i < NR_BANKS; i++) {
+		/* Save the CPUx interrupt mask for IRQ 0 to 127 */
+		val = cpu_readl(i, 0);
+		sar_writel(val, WAKEUPGENENB_OFFSET_CPU0, i);
+		val = cpu_readl(i, 1);
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
+	__raw_writel(val, sar_ram_base + AUXCOREBOOT0_OFFSET);
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	__raw_writel(val, sar_ram_base + AUXCOREBOOT1_OFFSET);
+
+	/* Save SyncReq generation logic */
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	__raw_writel(val, sar_ram_base + AUXCOREBOOT0_OFFSET);
+	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
+	__raw_writel(val, sar_ram_base + AUXCOREBOOT1_OFFSET);
+
+	/* Save SyncReq generation logic */
+	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_MASK);
+	__raw_writel(val, sar_ram_base + PTMSYNCREQ_MASK_OFFSET);
+	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_EN);
+	__raw_writel(val, sar_ram_base + PTMSYNCREQ_EN_OFFSET);
+
+	/* Set the Backup Bit Mask status */
+	val = __raw_readl(sar_ram_base + SAR_BACKUP_STATUS_OFFSET);
+	val |= SAR_BACKUP_STATUS_WAKEUPGEN;
+	__raw_writel(val, sar_ram_base + SAR_BACKUP_STATUS_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
index 4140251..a30f19b 100644
--- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
@@ -52,6 +52,7 @@
 
 #include <plat/omap44xx.h>
 #include <mach/omap4-common.h>
+#include <mach/omap-wakeupgen.h>
 
 #include "omap4-sar-layout.h"
 #include "pm.h"
@@ -290,6 +291,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * GIC lost during MPU OFF and OSWR
 	 */
 	if (pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_OFF) {
+		omap_wakeupgen_save();
 		gic_save_context();
 		save_state = 3;
 	}
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index 0a19f49..5a815c4 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -52,6 +52,17 @@
 
 #ifndef __ASSEMBLER__
 
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
 extern void __iomem *sar_ram_base;
 
 #endif
-- 
1.6.0.4

