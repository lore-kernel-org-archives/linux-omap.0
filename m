From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v9 3/3] ARM: OMAP2+: gpmc: minimal driver support
Date: Tue, 11 Sep 2012 15:27:05 +0530
Message-ID: <35901c3137e42170066f3efb5026b0749ccdcbb5.1347355380.git.afzal@ti.com>
References: <cover.1347355380.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47527 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754901Ab2IKJ5O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 05:57:14 -0400
In-Reply-To: <cover.1347355380.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Create a minimal driver out of gpmc code.
Responsibilities handled by earlier gpmc
initialization is now achieved in probe.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |  171 +++++++++++++++++++++++++++++++-------------
 1 files changed, 122 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5462666..a628fdc 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
 #include <plat/gpmc.h>
@@ -86,6 +87,12 @@
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
 
+#define	GPMC_REVISION_MAJOR(l)		((l >> 4) & 0xf)
+#define	GPMC_REVISION_MINOR(l)		(l & 0xf)
+
+#define	GPMC_HAS_WR_ACCESS		0x1
+#define	GPMC_HAS_WR_DATA_MUX_BUS	0x2
+
 /* XXX: Only NAND irq has been considered,currently these are the only ones used
  */
 #define	GPMC_NR_IRQ		2
@@ -131,7 +138,10 @@ static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
 static unsigned int gpmc_cs_map;	/* flag for cs which are initialized */
 static int gpmc_ecc_used = -EINVAL;	/* cs using ecc engine */
-
+static struct device *gpmc_dev;
+static int gpmc_irq;
+static resource_size_t phys_base, mem_size;
+static unsigned gpmc_capability;
 static void __iomem *gpmc_base;
 
 static struct clk *gpmc_l3_clk;
@@ -321,10 +331,10 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
 
-	if (cpu_is_omap34xx()) {
+	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
+	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
-	}
 
 	/* caller is expected to have initialized CONFIG1 to cover
 	 * at least sync vs async
@@ -434,6 +444,19 @@ static int gpmc_cs_insert_mem(int cs, unsigned long base, unsigned long size)
 	return r;
 }
 
+static int gpmc_cs_delete_mem(int cs)
+{
+	struct resource	*res = &gpmc_cs_mem[cs];
+	int r;
+
+	spin_lock(&gpmc_mem_lock);
+	r = release_resource(&gpmc_cs_mem[cs]);
+	res->start = res->end = 0;
+	spin_unlock(&gpmc_mem_lock);
+
+	return r;
+}
+
 int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 {
 	struct resource *res = &gpmc_cs_mem[cs];
@@ -770,7 +793,7 @@ static void gpmc_irq_noop(struct irq_data *data) { }
 
 static unsigned int gpmc_irq_noop_ret(struct irq_data *data) { return 0; }
 
-static int gpmc_setup_irq(int gpmc_irq)
+static int gpmc_setup_irq(void)
 {
 	int i;
 	u32 regval;
@@ -814,7 +837,37 @@ static int gpmc_setup_irq(int gpmc_irq)
 	return request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
 }
 
-static void __init gpmc_mem_init(void)
+static __exit int gpmc_free_irq(void)
+{
+	int i;
+
+	if (gpmc_irq)
+		free_irq(gpmc_irq, NULL);
+
+	for (i = 0; i < GPMC_NR_IRQ; i++) {
+		irq_set_handler(gpmc_client_irq[i].irq, NULL);
+		irq_set_chip(gpmc_client_irq[i].irq, &no_irq_chip);
+		irq_modify_status(gpmc_client_irq[i].irq, 0, 0);
+	}
+
+	irq_free_descs(gpmc_irq_start, GPMC_NR_IRQ);
+
+	return 0;
+}
+
+static void __devexit gpmc_mem_exit(void)
+{
+	int cs;
+
+	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
+		if (!gpmc_cs_mem_enabled(cs))
+			continue;
+		gpmc_cs_delete_mem(cs);
+	}
+
+}
+
+static void __devinit gpmc_mem_init(void)
 {
 	int cs;
 	unsigned long boot_rom_space = 0;
@@ -841,65 +894,85 @@ static void __init gpmc_mem_init(void)
 	}
 }
 
-static int __init gpmc_init(void)
+static __devinit int gpmc_probe(struct platform_device *pdev)
 {
 	u32 l;
-	int ret = -EINVAL;
-	int gpmc_irq;
-	char *ck = NULL;
-
-	if (cpu_is_omap24xx()) {
-		ck = "core_l3_ck";
-		if (cpu_is_omap2420())
-			l = OMAP2420_GPMC_BASE;
-		else
-			l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = 20 + OMAP_INTC_START;
-	} else if (cpu_is_omap34xx()) {
-		ck = "gpmc_fck";
-		l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = 20 + OMAP_INTC_START;
-	} else if (cpu_is_omap44xx() || soc_is_omap54xx()) {
-		/* Base address and irq number are same for OMAP4/5 */
-		ck = "gpmc_ck";
-		l = OMAP44XX_GPMC_BASE;
-		gpmc_irq = 20 + OMAP44XX_IRQ_GIC_START;
-	}
+	struct resource *res;
 
-	if (WARN_ON(!ck))
-		return ret;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL)
+		return -ENOENT;
 
-	gpmc_l3_clk = clk_get(NULL, ck);
-	if (IS_ERR(gpmc_l3_clk)) {
-		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);
-		BUG();
-	}
+	phys_base = res->start;
+	mem_size = resource_size(res);
 
-	gpmc_base = ioremap(l, SZ_4K);
+	gpmc_base = devm_request_and_ioremap(&pdev->dev, res);
 	if (!gpmc_base) {
-		clk_put(gpmc_l3_clk);
-		printk(KERN_ERR "Could not get GPMC register memory\n");
-		BUG();
+		dev_err(&pdev->dev, "error: request memory / ioremap\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res == NULL)
+		dev_warn(&pdev->dev, "Failed to get resource: irq\n");
+	else
+		gpmc_irq = res->start;
+
+	gpmc_l3_clk = clk_get(&pdev->dev, "fck");
+	if (IS_ERR(gpmc_l3_clk)) {
+		dev_err(&pdev->dev, "error: clk_get\n");
+		gpmc_irq = 0;
+		return PTR_ERR(gpmc_l3_clk);
 	}
 
 	clk_enable(gpmc_l3_clk);
 
+	gpmc_dev = &pdev->dev;
+
 	l = gpmc_read_reg(GPMC_REVISION);
-	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
-	/* Set smart idle mode and automatic L3 clock gating */
-	l = gpmc_read_reg(GPMC_SYSCONFIG);
-	l &= 0x03 << 3;
-	l |= (0x02 << 3) | (1 << 0);
-	gpmc_write_reg(GPMC_SYSCONFIG, l);
+	if (GPMC_REVISION_MAJOR(l) > 0x4)
+		gpmc_capability = GPMC_HAS_WR_ACCESS | GPMC_HAS_WR_DATA_MUX_BUS;
+	dev_info(gpmc_dev, "GPMC revision %d.%d\n",
+				GPMC_REVISION_MAJOR(l), GPMC_REVISION_MINOR(l));
+
 	gpmc_mem_init();
 
-	ret = gpmc_setup_irq(gpmc_irq);
-	if (ret)
-		pr_err("gpmc: irq-%d could not claim: err %d\n",
-						gpmc_irq, ret);
-	return ret;
+	if (IS_ERR_VALUE(gpmc_setup_irq()))
+		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
+
+	return 0;
+}
+
+static __exit int gpmc_remove(struct platform_device *pdev)
+{
+	gpmc_free_irq();
+	gpmc_mem_exit();
+	gpmc_dev = NULL;
+	return 0;
+}
+
+static struct platform_driver gpmc_driver = {
+	.probe		= gpmc_probe,
+	.remove		= __devexit_p(gpmc_remove),
+	.driver		= {
+		.name	= DEVICE_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static __init int gpmc_init(void)
+{
+	return platform_driver_register(&gpmc_driver);
+}
+
+static __exit void gpmc_exit(void)
+{
+	platform_driver_unregister(&gpmc_driver);
+
 }
+
 postcore_initcall(gpmc_init);
+module_exit(gpmc_exit);
 
 static int __init omap_gpmc_init(void)
 {
-- 
1.7.0.4

