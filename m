From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 05/18] ARM: OMAP5: PM: Enables ES2 PM mode by default
Date: Mon, 25 Mar 2013 15:34:57 +0530
Message-ID: <1364205910-32392-6-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42642 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832Ab3CYKD5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:03:57 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Enables MPUSS ES2 power management mode using ES2_PM_MODE in
AMBA_IF_MODE register.

0x0: ES1 behavior, CPU cores would enter and exit OFF mode together. Broken
0x1: ES2 behavior, CPU cores are allowed to enter/exit OFF mode independently.

The AMBA_IF_MODE register value is stored on SAR RAM and restored by
ROM code.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-secure.h    |    2 ++
 arch/arm/mach-omap2/omap-wakeupgen.c |   19 +++++++++++++++++++
 arch/arm/mach-omap2/omap-wakeupgen.h |    1 +
 3 files changed, 22 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 0e72917..82b3c4c 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -42,6 +42,8 @@
 #define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
 #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
 
+#define OMAP5_MON_AMBA_IF_INDEX		0x108
+
 /* Secure PPA(Primary Protected Application) APIs */
 #define OMAP4_PPA_L2_POR_INDEX		0x23
 #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index f8bb3b9..8bcaa8c 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -42,6 +42,7 @@
 #define CPU1_ID			0x1
 #define OMAP4_NR_BANKS		4
 #define OMAP4_NR_IRQS		128
+#define OMAP5_AMBA_IF_PM_MODE	(1 << 5)
 
 static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
@@ -265,6 +266,11 @@ static inline void omap5_irq_save_context(void)
 	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
 	__raw_writel(val, sar_base + OMAP5_AUXCOREBOOT1_OFFSET);
 
+	/* Save AMBA_IF_PM_MODE regsiter */
+	val = __raw_readl(wakeupgen_base + OMAP_AMBA_IF_MODE);
+	val |= OMAP5_AMBA_IF_PM_MODE;
+	__raw_writel(val, sar_base + OMAP5_AMBA_IF_MODE_OFFSET);
+
 	/* Set the Backup Bit Mask status */
 	val = __raw_readl(sar_base + OMAP5_SAR_BACKUP_STATUS_OFFSET);
 	val |= SAR_BACKUP_STATUS_WAKEUPGEN;
@@ -402,6 +408,7 @@ int __init omap_wakeupgen_init(void)
 {
 	int i;
 	unsigned int boot_cpu = smp_processor_id();
+	u32 val;
 
 	/* Not supported on OMAP4 ES1.0 silicon */
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
@@ -443,6 +450,18 @@ int __init omap_wakeupgen_init(void)
 	for (i = 0; i < max_irqs; i++)
 		irq_target_cpu[i] = boot_cpu;
 
+	/*
+	 * Enables OMAP5 ES2 PM Mode using ES2_PM_MODE in AMBA_IF_MODE
+	 * 0x0:	ES1 behavior, CPU cores would enter and exit OFF mode together.
+	 * 0x1:	ES2 behavior, CPU cores are allowed to enter/exit OFF mode
+	 * independently.
+	 */
+	if (soc_is_omap54xx()) {
+		val = __raw_readl(wakeupgen_base + OMAP_AMBA_IF_MODE);
+		val |= OMAP5_AMBA_IF_PM_MODE;
+		omap_smc1(OMAP5_MON_AMBA_IF_INDEX, val);
+	}
+
 	irq_hotplug_init();
 	irq_pm_init();
 
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.h b/arch/arm/mach-omap2/omap-wakeupgen.h
index b0fd16f..b3c8ecc 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.h
+++ b/arch/arm/mach-omap2/omap-wakeupgen.h
@@ -27,6 +27,7 @@
 #define OMAP_WKG_ENB_E_1			0x420
 #define OMAP_AUX_CORE_BOOT_0			0x800
 #define OMAP_AUX_CORE_BOOT_1			0x804
+#define OMAP_AMBA_IF_MODE			0x80c
 #define OMAP_PTMSYNCREQ_MASK			0xc00
 #define OMAP_PTMSYNCREQ_EN			0xc04
 #define OMAP_TIMESTAMPCYCLELO			0xc08
-- 
1.7.9.5

