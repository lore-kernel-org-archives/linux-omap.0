From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 04/12] mtd: nand: omap: Move gpmc_update_nand_reg to nand driver
Date: Fri, 10 Jul 2015 15:23:31 +0300
Message-ID: <1436531019-18088-5-git-send-email-rogerq@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com, bcousson@baylibre.com
Cc: ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

GPMC and NAND drivers share the same register space but never use the
same registers. As there is no clear address seperation between the
registers for GPMC and NAND, we can't easily split it up into 2 regions
i.e. one for GPMC and other for NAND. Instead, we simply remap the entire
register space in both the drivers. The NAND driver doesn't re-request
the region as it is already requested by the GPMC driver (parent).

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c              |   8 +-
 drivers/memory/omap-gpmc.c                   |  54 +----------
 drivers/mtd/nand/omap2.c                     | 132 ++++++++++++++++++++++++---
 include/linux/omap-gpmc.h                    |   3 +-
 include/linux/platform_data/mtd-nand-omap2.h |   3 +-
 5 files changed, 129 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index b960876..ff578d4 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -78,7 +78,8 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 	struct gpmc_settings s;
 	struct platform_device *pdev;
 	struct resource gpmc_nand_res[] = {
-		{ .flags = IORESOURCE_MEM, },
+		{ .flags = IORESOURCE_MEM, },	/* GPMC I/O space */
+		{ .flags = IORESOURCE_MEM, },	/* GPMC register space */
 		{ .flags = IORESOURCE_IRQ, },
 	};
 
@@ -92,7 +93,8 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		return err;
 	}
 	gpmc_nand_res[0].end = gpmc_nand_res[0].start + NAND_IO_SIZE - 1;
-	gpmc_nand_res[1].start = gpmc_get_irq();
+	gpmc_get_mem_resource(&gpmc_nand_res[1]);
+	gpmc_nand_res[2].start = gpmc_get_irq();
 
 	memset(&s, 0, sizeof(struct gpmc_settings));
 	if (gpmc_nand_data->of_node)
@@ -119,8 +121,6 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 	if (err < 0)
 		goto out_free_cs;
 
-	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
-
 	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt)) {
 		pr_err("omap2-nand: Unsupported NAND ECC scheme selected\n");
 		err = -EINVAL;
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 50806e7..dd55a51 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -54,17 +54,6 @@
 #define GPMC_PREFETCH_CONFIG2	0x1e4
 #define GPMC_PREFETCH_CONTROL	0x1ec
 #define GPMC_PREFETCH_STATUS	0x1f0
-#define GPMC_ECC_CONFIG		0x1f4
-#define GPMC_ECC_CONTROL	0x1f8
-#define GPMC_ECC_SIZE_CONFIG	0x1fc
-#define GPMC_ECC1_RESULT        0x200
-#define GPMC_ECC_BCH_RESULT_0   0x240   /* not available on OMAP2 */
-#define	GPMC_ECC_BCH_RESULT_1	0x244	/* not available on OMAP2 */
-#define	GPMC_ECC_BCH_RESULT_2	0x248	/* not available on OMAP2 */
-#define	GPMC_ECC_BCH_RESULT_3	0x24c	/* not available on OMAP2 */
-#define	GPMC_ECC_BCH_RESULT_4	0x300	/* not available on OMAP2 */
-#define	GPMC_ECC_BCH_RESULT_5	0x304	/* not available on OMAP2 */
-#define	GPMC_ECC_BCH_RESULT_6	0x308	/* not available on OMAP2 */
 
 /* GPMC ECC control settings */
 #define GPMC_ECC_CTRL_ECCCLEAR		0x100
@@ -117,9 +106,6 @@
 #define GPMC_CS_CONFIG5		0x10
 #define GPMC_CS_CONFIG6		0x14
 #define GPMC_CS_CONFIG7		0x18
-#define GPMC_CS_NAND_COMMAND	0x1c
-#define GPMC_CS_NAND_ADDRESS	0x20
-#define GPMC_CS_NAND_DATA	0x24
 
 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)
@@ -1030,44 +1016,10 @@ int gpmc_configure(int cmd, int wval)
 }
 EXPORT_SYMBOL(gpmc_configure);
 
-void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
+void gpmc_get_mem_resource(struct resource *res)
 {
-	int i;
-
-	reg->gpmc_status = gpmc_base + GPMC_STATUS;
-	reg->gpmc_irqstatus = gpmc_base + GPMC_IRQSTATUS;
-	reg->gpmc_irqenable = gpmc_base + GPMC_IRQENABLE;
-	reg->gpmc_nand_command = gpmc_base + GPMC_CS0_OFFSET +
-				GPMC_CS_NAND_COMMAND + GPMC_CS_SIZE * cs;
-	reg->gpmc_nand_address = gpmc_base + GPMC_CS0_OFFSET +
-				GPMC_CS_NAND_ADDRESS + GPMC_CS_SIZE * cs;
-	reg->gpmc_nand_data = gpmc_base + GPMC_CS0_OFFSET +
-				GPMC_CS_NAND_DATA + GPMC_CS_SIZE * cs;
-	reg->gpmc_prefetch_config1 = gpmc_base + GPMC_PREFETCH_CONFIG1;
-	reg->gpmc_prefetch_config2 = gpmc_base + GPMC_PREFETCH_CONFIG2;
-	reg->gpmc_prefetch_control = gpmc_base + GPMC_PREFETCH_CONTROL;
-	reg->gpmc_prefetch_status = gpmc_base + GPMC_PREFETCH_STATUS;
-	reg->gpmc_ecc_config = gpmc_base + GPMC_ECC_CONFIG;
-	reg->gpmc_ecc_control = gpmc_base + GPMC_ECC_CONTROL;
-	reg->gpmc_ecc_size_config = gpmc_base + GPMC_ECC_SIZE_CONFIG;
-	reg->gpmc_ecc1_result = gpmc_base + GPMC_ECC1_RESULT;
-
-	for (i = 0; i < GPMC_BCH_NUM_REMAINDER; i++) {
-		reg->gpmc_bch_result0[i] = gpmc_base + GPMC_ECC_BCH_RESULT_0 +
-					   GPMC_BCH_SIZE * i;
-		reg->gpmc_bch_result1[i] = gpmc_base + GPMC_ECC_BCH_RESULT_1 +
-					   GPMC_BCH_SIZE * i;
-		reg->gpmc_bch_result2[i] = gpmc_base + GPMC_ECC_BCH_RESULT_2 +
-					   GPMC_BCH_SIZE * i;
-		reg->gpmc_bch_result3[i] = gpmc_base + GPMC_ECC_BCH_RESULT_3 +
-					   GPMC_BCH_SIZE * i;
-		reg->gpmc_bch_result4[i] = gpmc_base + GPMC_ECC_BCH_RESULT_4 +
-					   i * GPMC_BCH_SIZE;
-		reg->gpmc_bch_result5[i] = gpmc_base + GPMC_ECC_BCH_RESULT_5 +
-					   i * GPMC_BCH_SIZE;
-		reg->gpmc_bch_result6[i] = gpmc_base + GPMC_ECC_BCH_RESULT_6 +
-					   i * GPMC_BCH_SIZE;
-	}
+	res->start =  phys_base;
+	res->end = res->start + mem_size - 1;
 }
 
 int gpmc_get_irq(void)
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 9dbb2be..3d0f73c 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -140,6 +140,39 @@
 #define GPMC_IRQ_FIFOEVENT	BIT(0)
 #define GPMC_IRQ_TERMCOUNT	BIT(1)
 
+/* GPMC register offsets */
+#define GPMC_REVISION		0x00
+#define GPMC_SYSCONFIG		0x10
+#define GPMC_SYSSTATUS		0x14
+#define GPMC_IRQSTATUS		0x18
+#define GPMC_IRQENABLE		0x1c
+#define GPMC_TIMEOUT_CONTROL	0x40
+#define GPMC_ERR_ADDRESS	0x44
+#define GPMC_ERR_TYPE		0x48
+#define GPMC_CONFIG		0x50
+#define GPMC_STATUS		0x54
+#define GPMC_CS_NAND_COMMAND	0x7c
+#define GPMC_CS_NAND_ADDRESS	0x80
+#define GPMC_CS_NAND_DATA	0x84
+#define GPMC_PREFETCH_CONFIG1	0x1e0
+#define GPMC_PREFETCH_CONFIG2	0x1e4
+#define GPMC_PREFETCH_CONTROL	0x1ec
+#define GPMC_PREFETCH_STATUS	0x1f0
+#define GPMC_ECC_CONFIG		0x1f4
+#define GPMC_ECC_CONTROL	0x1f8
+#define GPMC_ECC_SIZE_CONFIG	0x1fc
+#define GPMC_ECC1_RESULT        0x200
+#define GPMC_ECC_BCH_RESULT_0   0x240   /* not available on OMAP2 */
+#define	GPMC_ECC_BCH_RESULT_1	0x244	/* not available on OMAP2 */
+#define	GPMC_ECC_BCH_RESULT_2	0x248	/* not available on OMAP2 */
+#define	GPMC_ECC_BCH_RESULT_3	0x24c	/* not available on OMAP2 */
+#define GPMC_ECC_BCH_RESULT_4	0x300	/* not available on OMAP2 */
+#define GPMC_ECC_BCH_RESULT_5	0x304	/* not available on OMAP2 */
+#define GPMC_ECC_BCH_RESULT_6	0x308	/* not available on OMAP2 */
+
+#define GPMC_CS_SIZE		0x30
+#define	GPMC_BCH_SIZE		0x10
+
 static u_char bch16_vector[] = {0xf5, 0x24, 0x1c, 0xd0, 0x61, 0xb3, 0xf1, 0x55,
 				0x2e, 0x2c, 0x86, 0xa3, 0xed, 0x36, 0x1b, 0x78,
 				0x48, 0x76, 0xa9, 0x3b, 0x97, 0xd1, 0x7a, 0x93,
@@ -162,6 +195,7 @@ struct omap_nand_info {
 
 	int				gpmc_cs;
 	unsigned long			phys_base;
+	void __iomem			*gpmc_base;
 	enum omap_ecc			ecc_opt;
 	struct completion		comp;
 	struct dma_chan			*dma;
@@ -1672,20 +1706,64 @@ static bool omap2_nand_ecc_check(struct omap_nand_info *info,
 	return true;
 }
 
+static void gpmc_update_nand_reg(struct omap_nand_info *info)
+{
+	int i;
+	struct gpmc_nand_regs *reg = &info->reg;
+	int cs = info->gpmc_cs;
+	void __iomem *gpmc_base = info->gpmc_base;
+
+	reg->gpmc_status = gpmc_base + GPMC_STATUS;
+	reg->gpmc_irqstatus = gpmc_base + GPMC_IRQSTATUS;
+	reg->gpmc_irqenable = gpmc_base + GPMC_IRQENABLE;
+	reg->gpmc_nand_command = gpmc_base + GPMC_CS_NAND_COMMAND +
+				 GPMC_CS_SIZE * cs;
+	reg->gpmc_nand_address = gpmc_base + GPMC_CS_NAND_ADDRESS +
+				 GPMC_CS_SIZE * cs;
+	reg->gpmc_nand_data = gpmc_base + GPMC_CS_NAND_DATA +
+				 GPMC_CS_SIZE * cs;
+	reg->gpmc_prefetch_config1 = gpmc_base + GPMC_PREFETCH_CONFIG1;
+	reg->gpmc_prefetch_config2 = gpmc_base + GPMC_PREFETCH_CONFIG2;
+	reg->gpmc_prefetch_control = gpmc_base + GPMC_PREFETCH_CONTROL;
+	reg->gpmc_prefetch_status = gpmc_base + GPMC_PREFETCH_STATUS;
+	reg->gpmc_ecc_config = gpmc_base + GPMC_ECC_CONFIG;
+	reg->gpmc_ecc_control = gpmc_base + GPMC_ECC_CONTROL;
+	reg->gpmc_ecc_size_config = gpmc_base + GPMC_ECC_SIZE_CONFIG;
+	reg->gpmc_ecc1_result = gpmc_base + GPMC_ECC1_RESULT;
+
+	for (i = 0; i < GPMC_BCH_NUM_REMAINDER; i++) {
+		reg->gpmc_bch_result0[i] = gpmc_base + GPMC_ECC_BCH_RESULT_0 +
+					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result1[i] = gpmc_base + GPMC_ECC_BCH_RESULT_1 +
+					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result2[i] = gpmc_base + GPMC_ECC_BCH_RESULT_2 +
+					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result3[i] = gpmc_base + GPMC_ECC_BCH_RESULT_3 +
+					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result4[i] = gpmc_base + GPMC_ECC_BCH_RESULT_4 +
+					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result5[i] = gpmc_base + GPMC_ECC_BCH_RESULT_5 +
+					   GPMC_BCH_SIZE * i;
+		reg->gpmc_bch_result6[i] = gpmc_base + GPMC_ECC_BCH_RESULT_6 +
+					   GPMC_BCH_SIZE * i;
+	}
+}
+
 static int omap_nand_probe(struct platform_device *pdev)
 {
-	struct omap_nand_info		*info;
-	struct omap_nand_platform_data	*pdata;
-	struct mtd_info			*mtd;
-	struct nand_chip		*nand_chip;
-	struct nand_ecclayout		*ecclayout;
-	int				err;
-	int				i;
-	dma_cap_mask_t			mask;
-	unsigned			sig;
-	unsigned			oob_index;
-	struct resource			*res;
-	struct mtd_part_parser_data	ppdata = {};
+	struct omap_nand_info *info;
+	struct omap_nand_platform_data *pdata;
+	struct mtd_info	*mtd;
+	struct nand_chip *nand_chip;
+	struct nand_ecclayout *ecclayout;
+	int err;
+	int i;
+	dma_cap_mask_t mask;
+	unsigned sig;
+	unsigned oob_index;
+	struct resource	*res;
+	struct mtd_part_parser_data ppdata = {};
+	struct device *dev = &pdev->dev;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata == NULL) {
@@ -1702,7 +1780,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	info->pdev		= pdev;
 	info->gpmc_cs		= pdata->cs;
-	info->reg		= pdata->reg;
 	info->of_node		= pdata->of_node;
 	info->ecc_opt		= pdata->ecc_opt;
 	mtd			= &info->mtd;
@@ -1712,8 +1789,14 @@ static int omap_nand_probe(struct platform_device *pdev)
 	nand_chip		= &info->nand;
 	nand_chip->ecc.priv	= NULL;
 
+	/* GPMC external I/O space */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nand_chip->IO_ADDR_R = devm_ioremap_resource(&pdev->dev, res);
+	if (!res) {
+		dev_err(dev, "Can't get memory resource 0\n");
+		return -EINVAL;
+	}
+
+	nand_chip->IO_ADDR_R = devm_ioremap_resource(dev, res);
 	if (IS_ERR(nand_chip->IO_ADDR_R))
 		return PTR_ERR(nand_chip->IO_ADDR_R);
 
@@ -1724,6 +1807,27 @@ static int omap_nand_probe(struct platform_device *pdev)
 	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
 	nand_chip->cmd_ctrl  = omap_hwcontrol;
 
+	/* GPMC internal registers */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(dev, "Can't get memory resource 1\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * This resource is already requested by the GPMC driver
+	 * so we can't request it again. Instead, we just ioremap it.
+	 * This driver doesn't access the same registers as the GPMC
+	 * driver so it is safe.
+	 */
+	info->gpmc_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!info->gpmc_base) {
+		dev_err(dev, "Can't ioremap resource 1\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	gpmc_update_nand_reg(info);
+
 	/*
 	 * If RDY/BSY line is connected to OMAP then use the omap ready
 	 * function and the generic nand_wait function which reads the status
diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index c7d291c..36f33ba 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/platform_data/gpmc-omap.h>
+#include <linux/ioport.h>
 
 #define GPMC_CONFIG_WP		0x00000005
 
@@ -18,7 +19,7 @@ extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
 struct gpmc_nand_regs;
 struct device_node;
 
-extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
+extern void gpmc_get_mem_resource(struct resource *res);
 extern int gpmc_get_irq(void);
 
 extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 5a48a43..4427f92 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -77,10 +77,11 @@ struct omap_nand_platform_data {
 	enum nand_io		xfer_type;
 	int			devsize;
 	enum omap_ecc           ecc_opt;
-	struct gpmc_nand_regs	reg;
 
 	/* for passing the partitions */
 	struct device_node	*of_node;
 	struct device_node	*elm_of_node;
+
+	struct gpmc_nand_regs	reg;		/* deprecated */
 };
 #endif
-- 
2.1.4
