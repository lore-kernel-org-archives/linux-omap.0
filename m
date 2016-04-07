From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 17/17] mtd: nand: omap2: Implement NAND ready using gpiolib
Date: Thu, 7 Apr 2016 13:08:35 +0300
Message-ID: <1460023715-19332-18-git-send-email-rogerq@ti.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460023715-19332-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com, boris.brezillon@free-electrons.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The GPMC WAIT pin status are now available over gpiolib.
Update the omap_dev_ready() function to use gpio instead of
directly accessing GPMC register space.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  2 ++
 drivers/mtd/nand/omap2.c                           | 29 ++++++++++++++--------
 include/linux/platform_data/mtd-nand-omap2.h       |  2 +-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index ff3215d2..3ee7e20 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -48,6 +48,7 @@ Optional properties:
 		locating ECC errors for BCHx algorithms. SoC devices which have
 		ELM hardware engines should specify this device node in .dtsi
 		Using ELM for ECC error correction frees some CPU cycles.
+ - rb-gpios:	GPIO specifier for the ready/busy# pin.
 
 For inline partition table parsing (optional):
 
@@ -78,6 +79,7 @@ Example for an AM33xx board:
 			nand-bus-width = <16>;
 			ti,nand-ecc-opt = "bch8";
 			ti,nand-xfer-type = "polled";
+			rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 
 			gpmc,sync-clk-ps = <0>;
 			gpmc,cs-on-ns = <0>;
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 35b8f33..e0b2b2f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
@@ -182,6 +183,8 @@ struct omap_nand_info {
 	struct nand_ecclayout		oobinfo;
 	/* fields specific for BCHx_HW ECC scheme */
 	struct device			*elm_dev;
+	/* NAND ready gpio */
+	struct gpio_desc		*ready_gpiod;
 };
 
 static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
@@ -1023,21 +1026,16 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 }
 
 /**
- * omap_dev_ready - calls the platform specific dev_ready function
+ * omap_dev_ready - checks the NAND Ready GPIO line
  * @mtd: MTD device structure
+ *
+ * Returns true if ready and false if busy.
  */
 static int omap_dev_ready(struct mtd_info *mtd)
 {
-	unsigned int val = 0;
 	struct omap_nand_info *info = mtd_to_omap(mtd);
 
-	val = readl(info->reg.gpmc_status);
-
-	if ((val & 0x100) == 0x100) {
-		return 1;
-	} else {
-		return 0;
-	}
+	return gpiod_get_value(info->ready_gpiod);
 }
 
 /**
@@ -1755,7 +1753,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->gpmc_cs = pdata->cs;
 		info->reg = pdata->reg;
 		info->ecc_opt = pdata->ecc_opt;
-		info->dev_ready	= pdata->dev_ready;
+		if (pdata->dev_ready)
+			dev_info(&pdev->dev, "pdata->dev_ready is deprecated\n");
+
 		info->xfer_type = pdata->xfer_type;
 		info->devsize = pdata->devsize;
 		info->elm_of_node = pdata->elm_of_node;
@@ -1787,6 +1787,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
 	nand_chip->cmd_ctrl  = omap_hwcontrol;
 
+	info->ready_gpiod = devm_gpiod_get_optional(&pdev->dev, "rb",
+						    GPIOD_IN);
+	if (IS_ERR(info->ready_gpiod)) {
+		dev_err(dev, "failed to get ready gpio\n");
+		return PTR_ERR(info->ready_gpiod);
+	}
+
 	/*
 	 * If RDY/BSY line is connected to OMAP then use the omap ready
 	 * function and the generic nand_wait function which reads the status
@@ -1794,7 +1801,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	 * chip delay which is slightly more than tR (AC Timing) of the NAND
 	 * device and read status register until you get a failure or success
 	 */
-	if (info->dev_ready) {
+	if (info->ready_gpiod) {
 		nand_chip->dev_ready = omap_dev_ready;
 		nand_chip->chip_delay = 0;
 	} else {
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 7f6de53..17d57a1 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -71,7 +71,6 @@ struct omap_nand_platform_data {
 	int			cs;
 	struct mtd_partition	*parts;
 	int			nr_parts;
-	bool			dev_ready;
 	bool			flash_bbt;
 	enum nand_io		xfer_type;
 	int			devsize;
@@ -82,5 +81,6 @@ struct omap_nand_platform_data {
 	/* deprecated */
 	struct gpmc_nand_regs	reg;
 	struct device_node	*of_node;
+	bool			dev_ready;
 };
 #endif
-- 
2.5.0
