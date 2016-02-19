From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 09/26] mtd: nand: omap: Clean up device tree support
Date: Fri, 19 Feb 2016 23:15:31 +0200
Message-ID: <1455916548-3441-10-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Move NAND specific device tree parsing to NAND driver.

The NAND controller node must have a compatible id, register space
resource and interrupt resource.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c              |   5 +-
 drivers/memory/omap-gpmc.c                   | 143 +++++++--------------------
 drivers/mtd/nand/omap2.c                     | 133 +++++++++++++++++++++----
 include/linux/platform_data/mtd-nand-omap2.h |   3 +-
 4 files changed, 152 insertions(+), 132 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 04e6998..f6ac027 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -97,10 +97,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 	gpmc_nand_res[2].start = gpmc_get_client_irq(GPMC_IRQ_COUNT_EVENT);
 
 	memset(&s, 0, sizeof(struct gpmc_settings));
-	if (gpmc_nand_data->of_node)
-		gpmc_read_settings_dt(gpmc_nand_data->of_node, &s);
-	else
-		gpmc_set_legacy(gpmc_nand_data, &s);
+	gpmc_set_legacy(gpmc_nand_data, &s);
 
 	s.device_nand = true;
 
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index d75f417..13b900e 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -30,7 +30,6 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/omap-gpmc.h>
-#include <linux/mtd/nand.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/platform_data/mtd-nand-omap2.h>
@@ -1822,105 +1821,6 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 		of_property_read_bool(np, "gpmc,time-para-granularity");
 }
 
-#if IS_ENABLED(CONFIG_MTD_NAND)
-
-static const char * const nand_xfer_types[] = {
-	[NAND_OMAP_PREFETCH_POLLED]		= "prefetch-polled",
-	[NAND_OMAP_POLLED]			= "polled",
-	[NAND_OMAP_PREFETCH_DMA]		= "prefetch-dma",
-	[NAND_OMAP_PREFETCH_IRQ]		= "prefetch-irq",
-};
-
-static int gpmc_probe_nand_child(struct platform_device *pdev,
-				 struct device_node *child)
-{
-	u32 val;
-	const char *s;
-	struct gpmc_timings gpmc_t;
-	struct omap_nand_platform_data *gpmc_nand_data;
-
-	if (of_property_read_u32(child, "reg", &val) < 0) {
-		dev_err(&pdev->dev, "%s has no 'reg' property\n",
-			child->full_name);
-		return -ENODEV;
-	}
-
-	gpmc_nand_data = devm_kzalloc(&pdev->dev, sizeof(*gpmc_nand_data),
-				      GFP_KERNEL);
-	if (!gpmc_nand_data)
-		return -ENOMEM;
-
-	gpmc_nand_data->cs = val;
-	gpmc_nand_data->of_node = child;
-
-	/* Detect availability of ELM module */
-	gpmc_nand_data->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
-	if (gpmc_nand_data->elm_of_node == NULL)
-		gpmc_nand_data->elm_of_node =
-					of_parse_phandle(child, "elm_id", 0);
-
-	/* select ecc-scheme for NAND */
-	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
-		pr_err("%s: ti,nand-ecc-opt not found\n", __func__);
-		return -ENODEV;
-	}
-
-	if (!strcmp(s, "sw"))
-		gpmc_nand_data->ecc_opt = OMAP_ECC_HAM1_CODE_SW;
-	else if (!strcmp(s, "ham1") ||
-		 !strcmp(s, "hw") || !strcmp(s, "hw-romcode"))
-		gpmc_nand_data->ecc_opt =
-				OMAP_ECC_HAM1_CODE_HW;
-	else if (!strcmp(s, "bch4"))
-		if (gpmc_nand_data->elm_of_node)
-			gpmc_nand_data->ecc_opt =
-				OMAP_ECC_BCH4_CODE_HW;
-		else
-			gpmc_nand_data->ecc_opt =
-				OMAP_ECC_BCH4_CODE_HW_DETECTION_SW;
-	else if (!strcmp(s, "bch8"))
-		if (gpmc_nand_data->elm_of_node)
-			gpmc_nand_data->ecc_opt =
-				OMAP_ECC_BCH8_CODE_HW;
-		else
-			gpmc_nand_data->ecc_opt =
-				OMAP_ECC_BCH8_CODE_HW_DETECTION_SW;
-	else if (!strcmp(s, "bch16"))
-		if (gpmc_nand_data->elm_of_node)
-			gpmc_nand_data->ecc_opt =
-				OMAP_ECC_BCH16_CODE_HW;
-		else
-			pr_err("%s: BCH16 requires ELM support\n", __func__);
-	else
-		pr_err("%s: ti,nand-ecc-opt invalid value\n", __func__);
-
-	/* select data transfer mode for NAND controller */
-	if (!of_property_read_string(child, "ti,nand-xfer-type", &s))
-		for (val = 0; val < ARRAY_SIZE(nand_xfer_types); val++)
-			if (!strcasecmp(s, nand_xfer_types[val])) {
-				gpmc_nand_data->xfer_type = val;
-				break;
-			}
-
-	gpmc_nand_data->flash_bbt = of_get_nand_on_flash_bbt(child);
-
-	val = of_get_nand_bus_width(child);
-	if (val == 16)
-		gpmc_nand_data->devsize = NAND_BUSWIDTH_16;
-
-	gpmc_read_timings_dt(child, &gpmc_t);
-	gpmc_nand_init(gpmc_nand_data, &gpmc_t);
-
-	return 0;
-}
-#else
-static int gpmc_probe_nand_child(struct platform_device *pdev,
-				 struct device_node *child)
-{
-	return 0;
-}
-#endif
-
 #if IS_ENABLED(CONFIG_MTD_ONENAND)
 static int gpmc_probe_onenand_child(struct platform_device *pdev,
 				 struct device_node *child)
@@ -2039,9 +1939,42 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		goto err;
 	}
 
-	ret = of_property_read_u32(child, "bank-width", &gpmc_s.device_width);
-	if (ret < 0)
-		goto err;
+	if (of_node_cmp(child->name, "nand") == 0) {
+		/* NAND specific setup */
+		u32 val;
+
+		/* Warn about older DT blobs with no compatible property */
+		if (!of_property_read_bool(child, "compatible")) {
+			dev_warn(&pdev->dev,
+				 "Incompatible NAND node: missing compatible");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		val = of_get_nand_bus_width(child);
+		switch (val) {
+		case 8:
+			gpmc_s.device_width = GPMC_DEVWIDTH_8BIT;
+			break;
+		case 16:
+			gpmc_s.device_width = GPMC_DEVWIDTH_16BIT;
+			break;
+		default:
+			dev_err(&pdev->dev, "%s: invalid 'nand-bus-width'\n",
+				child->name);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		/* disable write protect */
+		gpmc_configure(GPMC_CONFIG_WP, 0);
+		gpmc_s.device_nand = true;
+	} else {
+		ret = of_property_read_u32(child, "bank-width",
+					   &gpmc_s.device_width);
+		if (ret < 0)
+			goto err;
+	}
 
 	gpmc_cs_show_timings(cs, "before gpmc_cs_program_settings");
 	ret = gpmc_cs_program_settings(cs, &gpmc_s);
@@ -2125,9 +2058,7 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 		if (!child->name)
 			continue;
 
-		if (of_node_cmp(child->name, "nand") == 0)
-			ret = gpmc_probe_nand_child(pdev, child);
-		else if (of_node_cmp(child->name, "onenand") == 0)
+		if (of_node_cmp(child->name, "onenand") == 0)
 			ret = gpmc_probe_onenand_child(pdev, child);
 		else
 			ret = gpmc_probe_generic_child(pdev, child);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 9e99199..0a637c4 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_mtd.h>
 
 #include <linux/mtd/nand_bch.h>
 #include <linux/platform_data/elm.h>
@@ -177,10 +178,11 @@ struct omap_nand_info {
 	struct gpmc_nand_regs		reg;
 	struct gpmc_nand_ops		*ops;
 	/* generated at runtime depending on ECC algorithm and layout selected */
+	bool				flash_bbt;
+	/* generated at runtime depending on ECC algorithm and layout */
 	struct nand_ecclayout		oobinfo;
 	/* fields specific for BCHx_HW ECC scheme */
 	struct device			*elm_dev;
-	struct device_node		*of_node;
 };
 
 static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
@@ -1643,10 +1645,84 @@ static bool omap2_nand_ecc_check(struct omap_nand_info *info,
 	return true;
 }
 
+static const char * const nand_xfer_types[] = {
+	[NAND_OMAP_PREFETCH_POLLED] = "prefetch-polled",
+	[NAND_OMAP_POLLED] = "polled",
+	[NAND_OMAP_PREFETCH_DMA] = "prefetch-dma",
+	[NAND_OMAP_PREFETCH_IRQ] = "prefetch-irq",
+};
+
+static int omap_get_dt_info(struct device *dev, struct omap_nand_info *info)
+{
+	struct device_node *child = dev->of_node;
+	int i;
+	const char *s;
+
+	/* In old bindings, CS num is embedded in reg property */
+	if (of_property_read_u32(child, "reg", &info->gpmc_cs) < 0) {
+		dev_err(dev, "reg not found in DT\n");
+		return -EINVAL;
+	}
+
+	/* detect availability of ELM module. Won't be present pre-OMAP4 */
+	info->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
+	if (!info->elm_of_node)
+		dev_dbg(dev, "ti,elm-id not in DT\n");
+
+	/* select ecc-scheme for NAND */
+	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
+		dev_err(dev, "ti,nand-ecc-opt not found\n");
+		return -EINVAL;
+	}
+
+	if (!strcmp(s, "sw")) {
+		info->ecc_opt = OMAP_ECC_HAM1_CODE_SW;
+	} else if (!strcmp(s, "ham1") ||
+		   !strcmp(s, "hw") || !strcmp(s, "hw-romcode")) {
+		info->ecc_opt =	OMAP_ECC_HAM1_CODE_HW;
+	} else if (!strcmp(s, "bch4")) {
+		if (info->elm_of_node)
+			info->ecc_opt = OMAP_ECC_BCH4_CODE_HW;
+		else
+			info->ecc_opt = OMAP_ECC_BCH4_CODE_HW_DETECTION_SW;
+	} else if (!strcmp(s, "bch8")) {
+		if (info->elm_of_node)
+			info->ecc_opt = OMAP_ECC_BCH8_CODE_HW;
+		else
+			info->ecc_opt = OMAP_ECC_BCH8_CODE_HW_DETECTION_SW;
+	} else if (!strcmp(s, "bch16")) {
+		info->ecc_opt =	OMAP_ECC_BCH16_CODE_HW;
+	} else {
+		dev_err(dev, "unrecognized value for ti,nand-ecc-opt\n");
+		return -EINVAL;
+	}
+
+	/* select data transfer mode */
+	if (!of_property_read_string(child, "ti,nand-xfer-type", &s)) {
+		for (i = 0; i < ARRAY_SIZE(nand_xfer_types); i++) {
+			if (!strcasecmp(s, nand_xfer_types[i])) {
+				info->xfer_type = i;
+				goto next;
+			}
+		}
+
+		dev_err(dev, "unrecognized value for ti,nand-xfer-type\n");
+		return -EINVAL;
+	}
+
+next:
+	of_get_nand_on_flash_bbt(child);
+
+	if (of_get_nand_bus_width(child) == 16)
+		info->devsize = NAND_BUSWIDTH_16;
+
+	return 0;
+}
+
 static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
-	struct omap_nand_platform_data	*pdata;
+	struct omap_nand_platform_data	*pdata = NULL;
 	struct mtd_info			*mtd;
 	struct nand_chip		*nand_chip;
 	struct nand_ecclayout		*ecclayout;
@@ -1656,39 +1732,47 @@ static int omap_nand_probe(struct platform_device *pdev)
 	unsigned			sig;
 	unsigned			oob_index;
 	struct resource			*res;
-
-	pdata = dev_get_platdata(&pdev->dev);
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "platform data missing\n");
-		return -ENODEV;
-	}
+	struct device			*dev = &pdev->dev;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
 				GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, info);
+	info->pdev = pdev;
 
+	if (dev->of_node) {
+		if (omap_get_dt_info(dev, info))
+			return -EINVAL;
+	} else {
+		pdata = dev_get_platdata(&pdev->dev);
+		if (!pdata) {
+			dev_err(&pdev->dev, "platform data missing\n");
+			return -EINVAL;
+		}
+
+		info->gpmc_cs = pdata->cs;
+		info->reg = pdata->reg;
+		info->ecc_opt = pdata->ecc_opt;
+		info->dev_ready	= pdata->dev_ready;
+		info->xfer_type = pdata->xfer_type;
+		info->devsize = pdata->devsize;
+		info->elm_of_node = pdata->elm_of_node;
+		info->flash_bbt = pdata->flash_bbt;
+	}
+
+	platform_set_drvdata(pdev, info);
 	info->ops = gpmc_omap_get_nand_ops(&info->reg, info->gpmc_cs);
 	if (!info->ops) {
 		dev_err(&pdev->dev, "Failed to get GPMC->NAND interface\n");
 		return -ENODEV;
 	}
-	info->pdev		= pdev;
-	info->gpmc_cs		= pdata->cs;
-	info->of_node		= pdata->of_node;
-	info->ecc_opt		= pdata->ecc_opt;
-	info->dev_ready	= pdata->dev_ready;
-	info->xfer_type = pdata->xfer_type;
-	info->devsize = pdata->devsize;
-	info->elm_of_node = pdata->elm_of_node;
 
 	nand_chip		= &info->nand;
 	mtd			= nand_to_mtd(nand_chip);
 	mtd->dev.parent		= &pdev->dev;
 	nand_chip->ecc.priv	= NULL;
-	nand_set_flash_node(nand_chip, pdata->of_node);
+	nand_set_flash_node(nand_chip, dev->of_node);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	nand_chip->IO_ADDR_R = devm_ioremap_resource(&pdev->dev, res);
@@ -1717,7 +1801,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->chip_delay = 50;
 	}
 
-	if (pdata->flash_bbt)
+	if (info->flash_bbt)
 		nand_chip->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
 	else
 		nand_chip->options |= NAND_SKIP_BBTSCAN;
@@ -2039,7 +2123,10 @@ scan_tail:
 		goto return_error;
 	}
 
-	mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
+	if (dev->of_node)
+		mtd_device_register(mtd, NULL, 0);
+	else
+		mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
 
 	platform_set_drvdata(pdev, mtd);
 
@@ -2070,11 +2157,17 @@ static int omap_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id omap_nand_ids[] = {
+	{ .compatible = "ti,omap2-nand", },
+	{},
+};
+
 static struct platform_driver omap_nand_driver = {
 	.probe		= omap_nand_probe,
 	.remove		= omap_nand_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
+		.of_match_table = of_match_ptr(omap_nand_ids),
 	},
 };
 
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index a067f58..ff27e5a 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -76,11 +76,10 @@ struct omap_nand_platform_data {
 	int			devsize;
 	enum omap_ecc           ecc_opt;
 
-	/* for passing the partitions */
-	struct device_node	*of_node;
 	struct device_node	*elm_of_node;
 
 	/* deprecated */
 	struct gpmc_nand_regs	reg;
+	struct device_node	*of_node;
 };
 #endif
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
