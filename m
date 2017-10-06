From: Ladislav Michl <ladis@linux-mips.org>
Subject: [RESEND PATCH] mtd: nand: omap2: Remove omap_nand_platform_data
Date: Fri, 6 Oct 2017 12:35:43 +0200
Message-ID: <20171006103543.gnb2hxq7msallyzl@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-omap@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-Id: linux-omap@vger.kernel.org

As driver is now configured using DT, omap_nand_platform_data structure
is no longer needed.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Resend to linux-mtd as other part this patch was depending on
 was merged months ago via linux-omap tree...

 drivers/mtd/nand/omap2.c                     | 40 +++++++---------------------
 include/linux/platform_data/mtd-nand-omap2.h | 17 ------------
 2 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 54540c8fa1a2..b1fc070c8279 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1588,8 +1588,7 @@ static bool is_elm_present(struct omap_nand_info *info,
 	return true;
 }
 
-static bool omap2_nand_ecc_check(struct omap_nand_info *info,
-				 struct omap_nand_platform_data	*pdata)
+static bool omap2_nand_ecc_check(struct omap_nand_info *info)
 {
 	bool ecc_needs_bch, ecc_needs_omap_bch, ecc_needs_elm;
 
@@ -1804,7 +1803,6 @@ static const struct mtd_ooblayout_ops omap_sw_ooblayout_ops = {
 static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
-	struct omap_nand_platform_data	*pdata = NULL;
 	struct mtd_info			*mtd;
 	struct nand_chip		*nand_chip;
 	int				err;
@@ -1814,6 +1812,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 	int				min_oobbytes = BADBLOCK_MARKER_LENGTH;
 	int				oobbytes_per_step;
 
+	if (!dev->of_node)
+		return -EINVAL;
+
 	info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
 				GFP_KERNEL);
 	if (!info)
@@ -1821,29 +1822,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	info->pdev = pdev;
 
-	if (dev->of_node) {
-		if (omap_get_dt_info(dev, info))
-			return -EINVAL;
-	} else {
-		pdata = dev_get_platdata(&pdev->dev);
-		if (!pdata) {
-			dev_err(&pdev->dev, "platform data missing\n");
-			return -EINVAL;
-		}
-
-		info->gpmc_cs = pdata->cs;
-		info->reg = pdata->reg;
-		info->ecc_opt = pdata->ecc_opt;
-		if (pdata->dev_ready)
-			dev_info(&pdev->dev, "pdata->dev_ready is deprecated\n");
-
-		info->xfer_type = pdata->xfer_type;
-		info->devsize = pdata->devsize;
-		info->elm_of_node = pdata->elm_of_node;
-		info->flash_bbt = pdata->flash_bbt;
-	}
+	if (omap_get_dt_info(dev, info))
+		return -EINVAL;
 
-	platform_set_drvdata(pdev, info);
 	info->ops = gpmc_omap_get_nand_ops(&info->reg, info->gpmc_cs);
 	if (!info->ops) {
 		dev_err(&pdev->dev, "Failed to get GPMC->NAND interface\n");
@@ -2002,7 +1983,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
-	if (!omap2_nand_ecc_check(info, pdata)) {
+	if (!omap2_nand_ecc_check(info)) {
 		err = -EINVAL;
 		goto return_error;
 	}
@@ -2167,10 +2148,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 	if (err)
 		goto return_error;
 
-	if (dev->of_node)
-		mtd_device_register(mtd, NULL, 0);
-	else
-		mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
+	err = mtd_device_register(mtd, NULL, 0);
+	if (err)
+		goto return_error;
 
 	platform_set_drvdata(pdev, mtd);
 
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 25e267f1970c..619df2431e75 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -64,21 +64,4 @@ struct gpmc_nand_regs {
 	void __iomem	*gpmc_bch_result5[GPMC_BCH_NUM_REMAINDER];
 	void __iomem	*gpmc_bch_result6[GPMC_BCH_NUM_REMAINDER];
 };
-
-struct omap_nand_platform_data {
-	int			cs;
-	struct mtd_partition	*parts;
-	int			nr_parts;
-	bool			flash_bbt;
-	enum nand_io		xfer_type;
-	int			devsize;
-	enum omap_ecc           ecc_opt;
-
-	struct device_node	*elm_of_node;
-
-	/* deprecated */
-	struct gpmc_nand_regs	reg;
-	struct device_node	*of_node;
-	bool			dev_ready;
-};
 #endif

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
