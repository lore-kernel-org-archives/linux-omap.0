From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 17/24] OMAP4: PM: Add WakeupGen and secure GIC low power support
Date: Sat, 24 Sep 2011 11:44:37 +0530
Message-ID: <1316844884-21700-18-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44275 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab1IXGPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 02:15:16 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Add WakeupGen and secure GIC low power support to save and restore
it's registers. WakeupGen Registers are saved to pre-defined SAR RAM layout
and the restore is automatically done by hardware(ROM code) while coming
out of MPUSS OSWR or Device off state. Secure GIC is saved using secure
API and restored by hardware like WakeupGen.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c   |  129 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap4-sar-layout.h |   15 ++++
 2 files changed, 144 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 12b00e0..bdd7210 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -22,10 +22,16 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/cpu.h>
+#include <linux/notifier.h>
+#include <linux/cpu_pm.h>
 
 #include <asm/hardware/gic.h>
 
 #include <mach/omap-wakeupgen.h>
+#include <mach/omap4-common.h>
+#include <mach/omap-secure.h>
+
+#include "omap4-sar-layout.h"
 
 #define NR_BANKS		4
 #define MAX_IRQS		128
@@ -36,6 +42,7 @@
 #define CPU1_ID			0x1
 
 static void __iomem *wakeupgen_base;
+static void __iomem *sar_base;
 static DEFINE_PER_CPU(u32 [NR_BANKS], irqmasks);
 static DEFINE_SPINLOCK(wakeupgen_lock);
 static unsigned int irq_target_cpu[NR_IRQS];
@@ -55,6 +62,11 @@ static inline void wakeupgen_writel(u32 val, u8 idx, u32 cpu)
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
@@ -180,6 +192,91 @@ static void wakeupgen_irqmask_all(unsigned int cpu, unsigned int set)
 	spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 
+/*
+ * Save WakeupGen interrupt context in SAR BANK3. Restore is done by
+ * ROM code. WakeupGen IP is integrated along with GIC to manage the
+ * interrupt wakeups from CPU low power states. It manages
+ * masking/unmasking of Shared peripheral interrupts(SPI). So the
+ * interrupt enable/disable control should be in sync and consistent
+ * at WakeupGen and GIC so that interrupts are not lost.
+ */
+static void irq_save_context(void)
+{
+	u32 i, val;
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
+
+/*
+ * Clear WakeupGen SAR backup status.
+ */
+void irq_sar_clear(void)
+{
+	u32 val;
+	val = __raw_readl(sar_base + SAR_BACKUP_STATUS_OFFSET);
+	val &= ~SAR_BACKUP_STATUS_WAKEUPGEN;
+	__raw_writel(val, sar_base + SAR_BACKUP_STATUS_OFFSET);
+}
+
+/*
+ * Save GIC and Wakeupgen interrupt context using secure API
+ * for HS/EMU devices.
+ */
+static void irq_save_secure_context(void)
+{
+	u32 ret;
+	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEGIC_INDEX,
+				FLAG_START_CRITICAL,
+				0, 0, 0, 0, 0);
+	if (ret != API_HAL_RET_VALUE_OK)
+		pr_err("GIC and Wakeupgen context save failed\n");
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int __cpuinit irq_cpu_hotplug_notify(struct notifier_block *self,
 					 unsigned long action, void *hcpu)
@@ -210,6 +307,37 @@ static void __init irq_hotplug_init(void)
 {}
 #endif
 
+#ifdef CONFIG_CPU_PM
+static int irq_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
+{
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+			irq_save_context();
+		else
+			irq_save_secure_context();
+		break;
+	case CPU_CLUSTER_PM_EXIT:
+		if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+			irq_sar_clear();
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block irq_notifier_block = {
+	.notifier_call = irq_notifier,
+};
+
+static void __init irq_pm_init(void)
+{
+	cpu_pm_register_notifier(&irq_notifier_block);
+}
+#else
+static void __init irq_pm_init(void)
+{}
+#endif
+
 /*
  * Initialise the wakeupgen module.
  */
@@ -253,6 +381,7 @@ int __init omap_wakeupgen_init(void)
 		irq_target_cpu[i] = boot_cpu;
 
 	irq_hotplug_init();
+	irq_pm_init();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index 970a2ee..aa14a8d 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -28,4 +28,19 @@
 #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
 #define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
 
+#define SAR_BACKUP_STATUS_OFFSET		(SAR_BANK3_OFFSET + 0x500)
+#define SAR_SECURE_RAM_SIZE_OFFSET		(SAR_BANK3_OFFSET + 0x504)
+#define SAR_SECRAM_SAVED_AT_OFFSET		(SAR_BANK3_OFFSET + 0x508)
+
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
1.7.4.1

