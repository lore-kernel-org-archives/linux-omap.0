From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 18/20] ARM: OMAP4460: wakeupgen: set GIC_CPU0 backup status flag always
Date: Tue, 12 Jun 2012 18:31:33 +0300
Message-ID: <1339515095-9908-19-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52947 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab2FLPc0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 11:32:26 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Without this, CPU0 will crash in the ROM code during wakeup from
device off. This patch also clears the GIC save area, to prevent
ROM code from writing garbage to the GIC registers during wakeup.
The actual GIC restore is done by kernel.

This bug fix applies only to OMAP4460, it is fixed on OMAP4470.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c   |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap4-sar-layout.h |    1 +
 arch/arm/mach-omap2/pm.h               |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index da144ae..59620a4 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -31,6 +31,7 @@
 
 #include "omap4-sar-layout.h"
 #include "common.h"
+#include "pm.h"
 
 #define NR_REG_BANKS		4
 #define MAX_IRQS		128
@@ -383,13 +384,34 @@ int __init omap_wakeupgen_init(void)
 	 */
 	max_spi_reg = gic_readl(GIC_DIST_CTR, 0) & 0x1f;
 
+	/*
+	 * Set CPU0 GIC backup flag permanently for omap4460 GP,
+	 * this is needed because of the ROM code bug that breaks
+	 * GIC during wakeup from device off. This errata fix also
+	 * clears the GIC save area during init to prevent restoring
+	 * garbage to the GIC.
+	 */
+	if (cpu_is_omap446x() && omap_type() == OMAP2_DEVICE_TYPE_GP)
+		pm44xx_errata |= PM_OMAP4_ROM_CPU1_BACKUP_ERRATUM_xxx;
+
 	if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
 		sar_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_16K);
+
+		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_CPU1_BACKUP_ERRATUM_xxx))
+			for (i = SAR_BACKUP_STATUS_OFFSET;
+			     i < WAKEUPGENENB_OFFSET_CPU0; i += 4)
+				sar_writel(0, i, 0);
+
 		sar_writel(GIC_ISR_NON_SECURE, SAR_ICDISR_CPU0_OFFSET, 0);
 		sar_writel(GIC_ISR_NON_SECURE, SAR_ICDISR_CPU1_OFFSET, 0);
 		for (i = 0; i < max_spi_reg; i++)
 			sar_writel(GIC_ISR_NON_SECURE, SAR_ICDISR_SPI_OFFSET,
 				   i);
+
+		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_CPU1_BACKUP_ERRATUM_xxx))
+			__raw_writel(SAR_BACKUP_STATUS_GIC_CPU0,
+				     sar_base + SAR_BACKUP_STATUS_OFFSET);
+
 		iounmap(sar_base);
 		sar_base = NULL;
 	}
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index 57c44fa..b4adfbe 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -64,6 +64,7 @@
 #define SAR_ICDISR_CPU0_OFFSET			(SAR_BANK3_OFFSET + 0x50c)
 #define SAR_ICDISR_CPU1_OFFSET			(SAR_BANK3_OFFSET + 0x510)
 #define SAR_ICDISR_SPI_OFFSET			(SAR_BANK3_OFFSET + 0x514)
+#define SAR_BACKUP_STATUS_GIC_CPU0		0x1
 
 /* WakeUpGen save restore offset from OMAP44XX_SAR_RAM_BASE */
 #define WAKEUPGENENB_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x684)
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index dfaec5e..63af57e 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -91,6 +91,7 @@ static inline void enable_omap3630_toggle_l2_on_restore(void) { }
 #define PM_OMAP4_ROM_SMP_BOOT_ERRATUM_xxx	(1 << 0)
 #define PM_OMAP4_ROM_IVAHD_TESLA_ERRATUM_xxx	(1 << 1)
 #define PM_OMAP4_ROM_L3INSTR_ERRATUM_xxx	(1 << 2)
+#define PM_OMAP4_ROM_CPU1_BACKUP_ERRATUM_xxx	(1 << 3)
 
 #if defined(CONFIG_ARCH_OMAP4)
 extern u16 pm44xx_errata;
-- 
1.7.4.1

