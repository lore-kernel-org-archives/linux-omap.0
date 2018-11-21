From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v4 3/4] mtd: rawnand: ams-delta: Use GPIO API for data I/O
Date: Wed, 21 Nov 2018 12:08:05 +0100
Message-ID: <20181121110806.32076-4-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121110806.32076-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Don't readw()/writew() data directly from/to GPIO port which is under
control of gpio-omap driver, use GPIO consumer API instead.

The driver should now work with any 8-bit bidirectional GPIO port, not
only OMAP.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/ams-delta.c | 109 +++++++++++++++++--------------
 1 file changed, 61 insertions(+), 48 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index bb50dda05654..8312182088c1 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -18,11 +18,10 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
-#include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_device.h>
 #include <linux/sizes.h>
 
 /*
@@ -38,7 +37,7 @@ struct ams_delta_nand {
 	struct gpio_desc	*gpiod_nwe;
 	struct gpio_desc	*gpiod_ale;
 	struct gpio_desc	*gpiod_cle;
-	void __iomem		*io_base;
+	struct gpio_descs	*data_gpiods;
 	bool			data_in;
 };
 
@@ -67,42 +66,78 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_io_write(struct ams_delta_nand *priv, u8 byte)
+static void ams_delta_write_commit(struct ams_delta_nand *priv)
 {
-	writew(byte, priv->io_base + OMAP_MPUIO_OUTPUT);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
+static void ams_delta_io_write(struct ams_delta_nand *priv, u8 byte)
+{
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	DECLARE_BITMAP(values, BITS_PER_TYPE(byte)) = { byte, };
+
+	gpiod_set_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
+				  data_gpiods->info, values);
+
+	ams_delta_write_commit(priv);
+}
+
+static void ams_delta_dir_output(struct ams_delta_nand *priv, u8 byte)
+{
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	DECLARE_BITMAP(values, BITS_PER_TYPE(byte)) = { byte, };
+	int i;
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		gpiod_direction_output_raw(data_gpiods->desc[i],
+					   test_bit(i, values));
+
+	ams_delta_write_commit(priv);
+
+	priv->data_in = false;
+}
+
 static u8 ams_delta_io_read(struct ams_delta_nand *priv)
 {
 	u8 res;
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	DECLARE_BITMAP(values, BITS_PER_TYPE(res)) = { 0, };
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	res = readw(priv->io_base + OMAP_MPUIO_INPUT_LATCH);
+
+	gpiod_get_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
+				  data_gpiods->info, values);
+
 	gpiod_set_value(priv->gpiod_nre, 1);
 
+	res = values[0];
 	return res;
 }
 
-static void ams_delta_dir_input(struct ams_delta_nand *priv, bool in)
+static void ams_delta_dir_input(struct ams_delta_nand *priv)
 {
-	writew(in ? ~0 : 0, priv->io_base + OMAP_MPUIO_IO_CNTL);
-	priv->data_in = in;
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	int i;
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		gpiod_direction_input(data_gpiods->desc[i]);
+
+	priv->data_in = true;
 }
 
 static void ams_delta_write_buf(struct ams_delta_nand *priv, const u8 *buf,
 				int len)
 {
-	int i;
+	int i = 0;
 
-	if (priv->data_in)
-		ams_delta_dir_input(priv, false);
+	if (len > 0 && priv->data_in)
+		ams_delta_dir_output(priv, buf[i++]);
 
-	for (i = 0; i < len; i++)
-		ams_delta_io_write(priv, buf[i]);
+	while (i < len)
+		ams_delta_io_write(priv, buf[i++]);
 }
 
 static void ams_delta_read_buf(struct ams_delta_nand *priv, u8 *buf, int len)
@@ -110,7 +145,7 @@ static void ams_delta_read_buf(struct ams_delta_nand *priv, u8 *buf, int len)
 	int i;
 
 	if (!priv->data_in)
-		ams_delta_dir_input(priv, true);
+		ams_delta_dir_input(priv);
 
 	for (i = 0; i < len; i++)
 		buf[i] = ams_delta_io_read(priv);
@@ -188,14 +223,9 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct ams_delta_nand *priv;
 	struct nand_chip *this;
 	struct mtd_info *mtd;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	void __iomem *io_base;
 	struct gpio_descs *data_gpiods;
 	int err = 0;
 
-	if (!res)
-		return -ENXIO;
-
 	/* Allocate memory for MTD device structure and private data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct ams_delta_nand),
 			    GFP_KERNEL);
@@ -207,25 +237,13 @@ static int ams_delta_init(struct platform_device *pdev)
 	mtd = nand_to_mtd(this);
 	mtd->dev.parent = &pdev->dev;
 
-	/*
-	 * Don't try to request the memory region from here,
-	 * it should have been already requested from the
-	 * gpio-omap driver and requesting it again would fail.
-	 */
-	io_base = ioremap(res->start, resource_size(res));
-	if (!io_base) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		return -EIO;
-	}
-
-	priv->io_base = io_base;
 	nand_set_controller_data(this, priv);
 
 	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
 	if (IS_ERR(priv->gpiod_rdy)) {
 		err = PTR_ERR(priv->gpiod_rdy);
 		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
-		goto err_unmap;
+		return err;
 	}
 
 	this->ecc.mode = NAND_ECC_SOFT;
@@ -238,42 +256,42 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod_nwp)) {
 		err = PTR_ERR(priv->gpiod_nwp);
 		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
-		goto err_unmap;
+		return err;
 	}
 
 	priv->gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nce)) {
 		err = PTR_ERR(priv->gpiod_nce);
 		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
-		goto err_unmap;
+		return err;
 	}
 
 	priv->gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nre)) {
 		err = PTR_ERR(priv->gpiod_nre);
 		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
-		goto err_unmap;
+		return err;
 	}
 
 	priv->gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->gpiod_nwe)) {
 		err = PTR_ERR(priv->gpiod_nwe);
 		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
-		goto err_unmap;
+		return err;
 	}
 
 	priv->gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_ale)) {
 		err = PTR_ERR(priv->gpiod_ale);
 		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
-		goto err_unmap;
+		return err;
 	}
 
 	priv->gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_cle)) {
 		err = PTR_ERR(priv->gpiod_cle);
 		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
-		goto err_unmap;
+		return err;
 	}
 
 	/* Request array of data pins, initialize them as input */
@@ -281,8 +299,9 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (IS_ERR(data_gpiods)) {
 		err = PTR_ERR(data_gpiods);
 		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
-		goto err_unmap;
+		return err;
 	}
+	priv->data_gpiods = data_gpiods;
 	priv->data_in = true;
 
 	/* Initialize the NAND controller object embedded in ams_delta_nand. */
@@ -293,7 +312,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	/* Scan to find existence of the device */
 	err = nand_scan(this, 1);
 	if (err)
-		goto err_unmap;
+		return err;
 
 	/* Register the partitions */
 	err = mtd_device_register(mtd, partition_info,
@@ -306,9 +325,6 @@ static int ams_delta_init(struct platform_device *pdev)
 err_nand_cleanup:
 	nand_cleanup(this);
 
-err_unmap:
-	iounmap(io_base);
-
 	return err;
 }
 
@@ -319,13 +335,10 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 {
 	struct ams_delta_nand *priv = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
-	void __iomem *io_base = priv->io_base;
 
-	/* Release resources, unregister device */
+	/* Unregister device */
 	nand_release(mtd_to_nand(mtd));
 
-	iounmap(io_base);
-
 	return 0;
 }
 
-- 
2.18.1
