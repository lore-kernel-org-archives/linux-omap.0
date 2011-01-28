From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v9 3/7] omap: gpmc: enable irq mode in gpmc
Date: Fri, 28 Jan 2011 15:42:05 +0530
Message-ID: <1296209529-22696-4-git-send-email-s-ghorai@ti.com>
References: <1296209529-22696-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50558 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab1A1KMV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 05:12:21 -0500
In-Reply-To: <1296209529-22696-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>

add support the irq mode in GPMC.
gpmc_init() function move after omap_init_irq() as it has dependecy on irq.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   45 +++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/io.c               |    2 -
 arch/arm/plat-omap/include/plat/gpmc.h |    5 +++-
 arch/arm/plat-omap/include/plat/irqs.h |    9 +++++-
 4 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1b7b3e7..382dea8 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -14,6 +14,7 @@
  */
 #undef DEBUG
 
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -22,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-types.h>
 #include <plat/gpmc.h>
@@ -100,6 +102,8 @@ static void __iomem *gpmc_base;
 
 static struct clk *gpmc_l3_clk;
 
+static irqreturn_t gpmc_handle_irq(int irq, void *dev);
+
 static void gpmc_write_reg(int idx, u32 val)
 {
 	__raw_writel(val, gpmc_base + idx);
@@ -497,6 +501,10 @@ int gpmc_cs_configure(int cs, int cmd, int wval)
 	u32 regval = 0;
 
 	switch (cmd) {
+	case GPMC_ENABLE_IRQ:
+		gpmc_write_reg(GPMC_IRQENABLE, wval);
+		break;
+
 	case GPMC_SET_IRQ_STATUS:
 		gpmc_write_reg(GPMC_IRQSTATUS, wval);
 		break;
@@ -678,9 +686,10 @@ static void __init gpmc_mem_init(void)
 	}
 }
 
-void __init gpmc_init(void)
+static int __init gpmc_init(void)
 {
-	u32 l;
+	u32 l, irq;
+	int cs, ret = -EINVAL;
 	char *ck = NULL;
 
 	if (cpu_is_omap24xx()) {
@@ -698,7 +707,7 @@ void __init gpmc_init(void)
 	}
 
 	if (WARN_ON(!ck))
-		return;
+		return ret;
 
 	gpmc_l3_clk = clk_get(NULL, ck);
 	if (IS_ERR(gpmc_l3_clk)) {
@@ -723,6 +732,36 @@ void __init gpmc_init(void)
 	l |= (0x02 << 3) | (1 << 0);
 	gpmc_write_reg(GPMC_SYSCONFIG, l);
 	gpmc_mem_init();
+
+	/* initalize the irq_chained */
+	irq = OMAP_GPMC_IRQ_BASE;
+	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
+		set_irq_handler(irq, handle_simple_irq);
+		set_irq_flags(irq, IRQF_VALID);
+		irq++;
+	}
+
+	ret = request_irq(INT_34XX_GPMC_IRQ,
+			gpmc_handle_irq, IRQF_SHARED, "gpmc", gpmc_base);
+	if (ret)
+		pr_err("gpmc: irq-%d could not claim: err %d\n",
+						INT_34XX_GPMC_IRQ, ret);
+	return ret;
+}
+postcore_initcall(gpmc_init);
+
+static irqreturn_t gpmc_handle_irq(int irq, void *dev)
+{
+	u8 cs;
+
+	if (irq != INT_34XX_GPMC_IRQ)
+		return IRQ_HANDLED;
+	/* check cs to invoke the irq */
+	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1)) >> CS_NUM_SHIFT) & 0x7;
+	if (OMAP_GPMC_IRQ_BASE+cs <= OMAP_GPMC_IRQ_END)
+		generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
+
+	return IRQ_HANDLED;
 }
 
 #ifdef CONFIG_ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e66687b..b60287c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -30,7 +30,6 @@
 
 #include <plat/sram.h>
 #include <plat/sdrc.h>
-#include <plat/gpmc.h>
 #include <plat/serial.h>
 
 #include "clock2xxx.h"
@@ -408,7 +407,6 @@ void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 		_omap2_init_reprogram_sdrc();
 	}
-	gpmc_init();
 
 	omap_irq_base_init();
 }
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 85ded59..9c060da 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -41,6 +41,8 @@
 #define GPMC_NAND_ADDRESS	0x0000000b
 #define GPMC_NAND_DATA		0x0000000c
 
+#define GPMC_ENABLE_IRQ		0x0000000d
+
 /* ECC commands */
 #define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
 #define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
@@ -78,6 +80,8 @@
 #define WR_RD_PIN_MONITORING		0x00600000
 #define GPMC_PREFETCH_STATUS_FIFO_CNT(val)	((val >> 24) & 0x7F)
 #define GPMC_PREFETCH_STATUS_COUNT(val)	(val & 0x00003fff)
+#define GPMC_IRQ_FIFOEVENTENABLE	0x01
+#define GPMC_IRQ_COUNT_EVENT		0x02
 
 /*
  * Note that all values in this struct are in nanoseconds except sync_clk
@@ -135,7 +139,6 @@ extern int gpmc_prefetch_enable(int cs, int dma_mode,
 extern int gpmc_prefetch_reset(int cs);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
-extern void gpmc_init(void);
 extern int gpmc_read_status(int cmd);
 extern int gpmc_cs_configure(int cs, int cmd, int wval);
 extern int gpmc_nand_read(int cs, int cmd);
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 2910de9..1b91168 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -318,6 +318,7 @@
 #define INT_34XX_PRCM_MPU_IRQ	11
 #define INT_34XX_MCBSP1_IRQ	16
 #define INT_34XX_MCBSP2_IRQ	17
+#define INT_34XX_GPMC_IRQ	20
 #define INT_34XX_MCBSP3_IRQ	22
 #define INT_34XX_MCBSP4_IRQ	23
 #define INT_34XX_CAM_IRQ	24
@@ -411,7 +412,13 @@
 #define TWL_IRQ_END		TWL6030_IRQ_END
 #endif
 
-#define NR_IRQS			TWL_IRQ_END
+/* GPMC related */
+#define OMAP_GPMC_IRQ_BASE	(TWL_IRQ_END)
+#define OMAP_GPMC_NR_IRQS	7
+#define OMAP_GPMC_IRQ_END	(OMAP_GPMC_IRQ_BASE + OMAP_GPMC_NR_IRQS)
+
+
+#define NR_IRQS			OMAP_GPMC_IRQ_END
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
-- 
1.7.0.4

