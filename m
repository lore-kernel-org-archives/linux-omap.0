From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 06/12] mtd: nand: omap: Copy platform data parameters to omap_nand_info data
Date: Fri, 10 Jul 2015 15:23:33 +0300
Message-ID: <1436531019-18088-7-git-send-email-rogerq@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com, bcousson@baylibre.com
Cc: ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Copy all the platform data parameters to the driver's local data
structure 'omap_nand_info' and use it in the entire driver. This will
make it easer for device tree migration.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/omap2.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 25a3d05..407aecf9 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -191,15 +191,19 @@ static struct nand_hw_control omap_gpmc_controller = {
 };
 
 struct omap_nand_info {
-	struct omap_nand_platform_data	*pdata;
 	struct mtd_info			mtd;
 	struct nand_chip		nand;
 	struct platform_device		*pdev;
 
 	int				gpmc_cs;
+	bool				dev_ready;
+	enum nand_io			xfer_type;
+	int				devsize;
+	enum omap_ecc			ecc_opt;
+	struct device_node		*elm_of_node;
+
 	unsigned long			phys_base;
 	void __iomem			*gpmc_base;
-	enum omap_ecc			ecc_opt;
 	struct completion		comp;
 	struct dma_chan			*dma;
 	int				gpmc_irq;
@@ -1717,7 +1721,7 @@ static bool omap2_nand_ecc_check(struct omap_nand_info *info,
 			"CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
 		return false;
 	}
-	if (ecc_needs_elm && !is_elm_present(info, pdata->elm_of_node)) {
+	if (ecc_needs_elm && !is_elm_present(info, info->elm_of_node)) {
 		dev_err(&info->pdev->dev, "ELM not available\n");
 		return false;
 	}
@@ -1802,6 +1806,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->gpmc_cs		= pdata->cs;
 	info->of_node		= pdata->of_node;
 	info->ecc_opt		= pdata->ecc_opt;
+	info->dev_ready	= pdata->dev_ready;
+	info->xfer_type = pdata->xfer_type;
+	info->devsize = pdata->devsize;
+	info->elm_of_node = pdata->elm_of_node;
+
 	mtd			= &info->mtd;
 	mtd->priv		= &info->nand;
 	mtd->name		= dev_name(&pdev->dev);
@@ -1855,7 +1864,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	 * chip delay which is slightly more than tR (AC Timing) of the NAND
 	 * device and read status register until you get a failure or success
 	 */
-	if (pdata->dev_ready) {
+	if (info->dev_ready) {
 		nand_chip->dev_ready = omap_dev_ready;
 		nand_chip->chip_delay = 0;
 	} else {
@@ -1869,15 +1878,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->options |= NAND_SKIP_BBTSCAN;
 
 	/* scan NAND device connected to chip controller */
-	nand_chip->options |= pdata->devsize & NAND_BUSWIDTH_16;
+	nand_chip->options |= info->devsize & NAND_BUSWIDTH_16;
 	if (nand_scan_ident(mtd, 1, NULL)) {
-		dev_err(&info->pdev->dev, "scan failed, may be bus-width mismatch\n");
+		dev_err(&info->pdev->dev,
+			"scan failed, may be bus-width mismatch\n");
 		err = -ENXIO;
 		goto return_error;
 	}
 
 	/* re-populate low-level callbacks based on xfer modes */
-	switch (pdata->xfer_type) {
+	switch (info->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
 		nand_chip->read_buf   = omap_read_buf_pref;
 		nand_chip->write_buf  = omap_write_buf_pref;
@@ -1940,7 +1950,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	default:
 		dev_err(&pdev->dev,
-			"xfer_type(%d) not supported!\n", pdata->xfer_type);
+			"xfer_type(%d) not supported!\n", info->xfer_type);
 		err = -EINVAL;
 		goto return_error;
 	}
-- 
2.1.4
