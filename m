From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for data read/write
Date: Tue,  7 Aug 2018 00:29:11 +0200
Message-ID: <20180806222918.12644-6-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Don't readw()/writew() data directly from/to GPIO port which is under
control of gpio-omap driver, use GPIO API instead.

Degrade of performance on Amstrad Delta is completely not acceptable.

The driver should work with any 8+-bit bidirectional GPIO port, not
only OMAP.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 97 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 59 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 09d6901fc94d..78996ddf82e0 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -24,13 +24,10 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_device.h>
 
-#include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <mach/hardware.h>
-
 /*
  * MTD structure for E3 (Delta)
  */
@@ -44,7 +41,7 @@ struct ams_delta_nand {
 	struct gpio_desc	*gpiod_nwe;
 	struct gpio_desc	*gpiod_ale;
 	struct gpio_desc	*gpiod_cle;
-	void __iomem		*io_base;
+	struct gpio_descs	*data_gpiods;
 };
 
 /*
@@ -76,10 +73,14 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	unsigned long bits = byte;
+	int i;
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		gpiod_direction_output_raw(data_gpiods->desc[i],
+					   test_bit(i, &bits));
 
-	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
-	writew(byte, this->IO_ADDR_W);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
@@ -87,18 +88,28 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 
 static u_char ams_delta_read_byte(struct mtd_info *mtd)
 {
-	u_char res;
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	unsigned long bits = 0;
+	int i, value_array[data_gpiods->ndescs];
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		gpiod_direction_input(data_gpiods->desc[i]);
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
-	res = readw(this->IO_ADDR_R);
+
+	gpiod_get_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
+				  value_array);
+
 	gpiod_set_value(priv->gpiod_nre, 1);
 
-	return res;
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		if (value_array[i])
+			__set_bit(i, &bits);
+
+	return bits;
 }
 
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
@@ -159,14 +170,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct ams_delta_nand *priv;
 	struct nand_chip *this;
 	struct mtd_info *mtd;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	void __iomem *io_base;
-	struct gpio_descs *data_gpiods;
 	int err = 0;
 
-	if (!res)
-		return -ENXIO;
-
 	/* Allocate memory for MTD device structure and private data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct ams_delta_nand),
 			    GFP_KERNEL);
@@ -179,25 +184,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	mtd = nand_to_mtd(this);
 	mtd->dev.parent = &pdev->dev;
 
-	/*
-	 * Don't try to request the memory region from here,
-	 * it should have been already requested from the
-	 * gpio-omap driver and requesting it again would fail.
-	 */
-
-	io_base = ioremap(res->start, resource_size(res));
-	if (io_base == NULL) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		err = -EIO;
-		goto out_free;
-	}
-
-	priv->io_base = io_base;
 	nand_set_controller_data(this, priv);
 
-	/* Set address of NAND IO lines */
-	this->IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
-	this->IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
 	this->read_byte = ams_delta_read_byte;
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;
@@ -207,7 +195,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod_rdy)) {
 		err = PTR_ERR(priv->gpiod_rdy);
 		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	if (priv->gpiod_rdy)
@@ -225,66 +213,60 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod_nwp)) {
 		err = PTR_ERR(priv->gpiod_nwp);
 		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nce)) {
 		err = PTR_ERR(priv->gpiod_nce);
 		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nre)) {
 		err = PTR_ERR(priv->gpiod_nre);
 		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nwe)) {
 		err = PTR_ERR(priv->gpiod_nwe);
 		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_ale)) {
 		err = PTR_ERR(priv->gpiod_ale);
 		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	priv->gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_cle)) {
 		err = PTR_ERR(priv->gpiod_cle);
 		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 	/* Request array of data pins, initialize them as input */
-	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
-	if (IS_ERR(data_gpiods)) {
-		err = PTR_ERR(data_gpiods);
+	priv->data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
+	if (IS_ERR(priv->data_gpiods)) {
+		err = PTR_ERR(priv->data_gpiods);
 		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
 	if (err)
-		goto out_mtd;
+		return err;
 
 	/* Register the partitions */
 	mtd_device_register(mtd, partition_info, ARRAY_SIZE(partition_info));
 
-	goto out;
-
- out_mtd:
-	iounmap(io_base);
-out_free:
- out:
-	return err;
+	return 0;
 }
 
 /*
@@ -294,13 +276,10 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 {
 	struct ams_delta_nand *priv = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
-	void __iomem *io_base = priv->io_base;
 
-	/* Release resources, unregister device */
+	/* Unregister device */
 	nand_release(mtd);
 
-	iounmap(io_base);
-
 	return 0;
 }
 
-- 
2.16.4
