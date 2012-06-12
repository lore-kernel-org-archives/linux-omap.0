From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 14/20] ARM: OMAP4: PM: Mark the PPI and SPI interrupts as non-secure for GP
Date: Tue, 12 Jun 2012 18:31:29 +0300
Message-ID: <1339515095-9908-15-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52936 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab2FLPcW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 11:32:22 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Axel Haslam <axelhaslam@gmail.com>

From: Axel Haslam <axelhaslam@gmail.com>

ROM code restores part of the GIC context during wakeup from device
off mode from the SAR RAM. If the PPI and SPI interrupts are not
marked as non-secure on GP chips, this crashes the device during
wakeup, thus mark them as non-secure.

Signed-off-by: Axel Haslam <axelhaslam@gmail.com>
[t-kristo@ti.com: fixed commit message, merged multiple patches to one]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/common.h           |    1 +
 arch/arm/mach-omap2/omap-wakeupgen.c   |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c     |    8 ++++++++
 arch/arm/mach-omap2/omap4-sar-layout.h |    3 +++
 4 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index a793ab3..22addd0 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -247,6 +247,7 @@ static inline void __iomem *omap4_get_scu_base(void)
 
 extern void __init gic_init_irq(void);
 extern void gic_dist_disable(void);
+extern u32 gic_readl(u32 offset, u8 idx);
 extern void omap_smc1(u32 fn, u32 arg);
 extern void __iomem *omap4_get_sar_ram_base(void);
 extern void omap_do_wfi(void);
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 1cffb3a..da144ae 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -39,6 +39,7 @@
 #define CPU_ENA_OFFSET		0x400
 #define CPU0_ID			0x0
 #define CPU1_ID			0x1
+#define GIC_ISR_NON_SECURE	0xffffffff
 
 static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
@@ -337,6 +338,7 @@ int __init omap_wakeupgen_init(void)
 {
 	int i;
 	unsigned int boot_cpu = smp_processor_id();
+	int max_spi_reg;
 
 	/* Not supported on OMAP4 ES1.0 silicon */
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
@@ -372,6 +374,26 @@ int __init omap_wakeupgen_init(void)
 	for (i = 0; i < NR_IRQS; i++)
 		irq_target_cpu[i] = boot_cpu;
 
+	/*
+	 * Find out how many interrupts are supported.
+	 * OMAP4 supports max of 128 SPIs where as GIC can support
+	 * up to 1020 interrupt sources. On OMAP4, maximum SPIs are
+	 * fused in DIST_CTR bit-fields as 128. Hence the code is safe
+	 * from reserved register writes since its well within 1020.
+	 */
+	max_spi_reg = gic_readl(GIC_DIST_CTR, 0) & 0x1f;
+
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
+		sar_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_16K);
+		sar_writel(GIC_ISR_NON_SECURE, SAR_ICDISR_CPU0_OFFSET, 0);
+		sar_writel(GIC_ISR_NON_SECURE, SAR_ICDISR_CPU1_OFFSET, 0);
+		for (i = 0; i < max_spi_reg; i++)
+			sar_writel(GIC_ISR_NON_SECURE, SAR_ICDISR_SPI_OFFSET,
+				   i);
+		iounmap(sar_base);
+		sar_base = NULL;
+	}
+
 	irq_hotplug_init();
 	irq_pm_init();
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 4e2da77..33decee 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -114,6 +114,14 @@ void gic_dist_disable(void)
 		__raw_writel(0x0, gic_dist_base_addr + GIC_DIST_CTRL);
 }
 
+u32 gic_readl(u32 offset, u8 idx)
+{
+	if (!gic_dist_base_addr)
+		return 0;
+
+	return __raw_readl(gic_dist_base_addr + offset + 4 * idx);
+}
+
 #ifdef CONFIG_CACHE_L2X0
 
 void __iomem *omap4_get_l2cache_base(void)
diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
index e99955f..57c44fa 100644
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -61,6 +61,9 @@
 #define SAR_BACKUP_STATUS_OFFSET		(SAR_BANK3_OFFSET + 0x500)
 #define SAR_SECURE_RAM_SIZE_OFFSET		(SAR_BANK3_OFFSET + 0x504)
 #define SAR_SECRAM_SAVED_AT_OFFSET		(SAR_BANK3_OFFSET + 0x508)
+#define SAR_ICDISR_CPU0_OFFSET			(SAR_BANK3_OFFSET + 0x50c)
+#define SAR_ICDISR_CPU1_OFFSET			(SAR_BANK3_OFFSET + 0x510)
+#define SAR_ICDISR_SPI_OFFSET			(SAR_BANK3_OFFSET + 0x514)
 
 /* WakeUpGen save restore offset from OMAP44XX_SAR_RAM_BASE */
 #define WAKEUPGENENB_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x684)
-- 
1.7.4.1

