From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 8/8] mtd: rawnand: ams-delta: Use GPIO callbacks for data I/O
Date: Thu, 19 Jul 2018 01:57:10 +0200
Message-ID: <20180718235710.18242-9-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Don't readw()/writew() data directly from/to GPIO port which is under
control of gpio-omap driver, use GPIO chip callbacks instead.

Thanks to utilization of get/set_multiple() callbacks, performance
degrade is minor for typical data transfers.

The driver should now work with any 8+-bit bidirectional GPIO port,
not only OMAP.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

# Conflicts:
#	drivers/mtd/nand/raw/ams-delta.c
---
 arch/arm/mach-omap1/board-ams-delta.c |  11 ----
 drivers/mtd/nand/raw/ams-delta.c      | 119 +++++++++++++++-------------------
 2 files changed, 52 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 16f7bbe47607..08e732bc1cd2 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -321,20 +321,9 @@ struct modem_private_data {
 
 static struct modem_private_data modem_priv;
 
-static struct resource ams_delta_nand_resources[] = {
-	[0] = {
-		.start	= OMAP1_MPUIO_BASE,
-		.end	= OMAP1_MPUIO_BASE +
-				OMAP_MPUIO_IO_CNTL + sizeof(u32) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
 static struct platform_device ams_delta_nand_device = {
 	.name	= "ams-delta-nand",
 	.id	= -1,
-	.num_resources	= ARRAY_SIZE(ams_delta_nand_resources),
-	.resource	= ams_delta_nand_resources,
 };
 
 #define OMAP_GPIO_LABEL		"gpio-0-15"
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index bd501f385e78..8fac8d2a444a 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -25,13 +25,11 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <mach/hardware.h>
-
 /*
  * MTD structure for E3 (Delta)
  */
@@ -45,7 +43,9 @@ struct ams_delta_nand {
 	struct gpio_desc	*gpiod_nwe;
 	struct gpio_desc	*gpiod_ale;
 	struct gpio_desc	*gpiod_cle;
-	void __iomem		*io_base;
+	struct gpio_chip	*data_gpioc;
+	unsigned long		data_mask;
+	int			data_width;
 };
 
 /*
@@ -73,43 +73,55 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
+static void ams_delta_write_commit(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = &priv->nand_chip;
-
-	writew(byte, this->IO_ADDR_W);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
+static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
+{
+	struct gpio_chip *data_gpioc = priv->data_gpioc;
+	unsigned long bits = byte;
+
+	data_gpioc->set_multiple(data_gpioc, &priv->data_mask, &bits);
+
+	ams_delta_write_commit(priv);
+}
+
 static void ams_delta_write_first_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	void __iomem *io_base = priv->io_base;
+	struct gpio_chip *data_gpioc = priv->data_gpioc;
+	unsigned long bits = byte;
+	int i;
 
-	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
+	for (i = 0; i < priv->data_width; i++)
+		data_gpioc->direction_output(data_gpioc, i, test_bit(i, &bits));
 
-	ams_delta_write_next_byte(priv, byte);
+	ams_delta_write_commit(priv);
 }
 
 static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = &priv->nand_chip;
-	u_char res;
+	struct gpio_chip *data_gpioc = priv->data_gpioc;
+	unsigned long bits;
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	res = readw(this->IO_ADDR_R);
+	data_gpioc->get_multiple(data_gpioc, &priv->data_mask, &bits);
 	gpiod_set_value(priv->gpiod_nre, 1);
 
-	return res;
+	return bits;
 }
 
 static u_char ams_delta_read_first_byte(struct ams_delta_nand *priv)
 {
-	void __iomem *io_base = priv->io_base;
+	struct gpio_chip *data_gpioc = priv->data_gpioc;
+	int i;
 
-	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
+	for (i = 0; i < priv->data_width; i++)
+		data_gpioc->direction_input(data_gpioc, i);
 
 	return ams_delta_read_next_byte(priv);
 }
@@ -188,16 +200,11 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct ams_delta_nand *priv;
 	struct nand_chip *this;
 	struct mtd_info *mtd;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	void __iomem *io_base;
 	struct gpio_descs *data_gpiods;
 	struct gpio_chip *data_gpioc;
 	unsigned long mask, bits;
 	int i, err = 0;
 
-	if (!res)
-		return -ENXIO;
-
 	/* Allocate memory for MTD device structure and private data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct ams_delta_nand),
 			    GFP_KERNEL);
@@ -210,25 +217,8 @@ static int ams_delta_init(struct platform_device *pdev)
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
@@ -238,7 +228,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (IS_ERR(priv->gpiod_rdy)) {
 		err = PTR_ERR(priv->gpiod_rdy);
 		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	if (priv->gpiod_rdy)
@@ -256,49 +246,49 @@ static int ams_delta_init(struct platform_device *pdev)
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
 	/* Request array of data pins, initialize them as output and set low */
 	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_OUT_LOW);
 	if (IS_ERR(data_gpiods)) {
 		err = PTR_ERR(data_gpiods);
 		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
-		goto out_mtd;
+		return err;
 	}
 
 	/* Use GPIO chip of first data GPIO pin descriptor */
@@ -312,7 +302,7 @@ static int ams_delta_init(struct platform_device *pdev)
 		err = -EINVAL;
 		dev_err(&pdev->dev,
 			"data GPIO chip does not support get/set_multiple()\n");
-		goto out_mtd;
+		return err;
 	}
 
 	/* Verify if get_multiple() returns all pins low as initialized above */
@@ -321,13 +311,13 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"data GPIO chip get_multiple() failed: %d\n", err);
-		goto out_mtd;
+		return err;
 	}
 	if (bits) {
 		err = -EINVAL;
 		dev_err(&pdev->dev,
 			"mismmatch of data GPIO initial value: %lu\n", bits);
-		goto out_mtd;
+		return err;
 	}
 
 	/* Verify each data GPIO pin */
@@ -337,7 +327,7 @@ static int ams_delta_init(struct platform_device *pdev)
 			err = -EINVAL;
 			dev_err(&pdev->dev, "GPIO chip mismatch of data bit %d\n",
 				i);
-			goto out_mtd;
+			return err;
 		}
 
 		/* Require all pins active high (not inverted) */
@@ -346,7 +336,7 @@ static int ams_delta_init(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"unsupported polarity of data GPIO bit %d\n",
 				i);
-			goto out_mtd;
+			return err;
 		}
 
 		/*
@@ -360,13 +350,13 @@ static int ams_delta_init(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"data bit %d GPIO chip get() failed: %d\n", i,
 				err);
-			goto out_mtd;
+			return err;
 		}
 		if (!err) {
 			err = -EINVAL;
 			dev_err(&pdev->dev, "mismatch of data GPIO bit %d value\n",
 				i);
-			goto out_mtd;
+			return err;
 		}
 
 		/*
@@ -379,14 +369,18 @@ static int ams_delta_init(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"unsupported mode of data GPIO bit %d\n",
 				i);
-			goto out_mtd;
+			return err;
 		}
 	}
 
+	priv->data_gpioc = data_gpioc;
+	priv->data_width = data_gpiods->ndescs;
+	priv->data_mask = (1 << data_gpiods->ndescs) - 1;
+
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
 	if (err)
-		goto out_mtd;
+		return err;
 
 	/* As soon as the device is found, release write protection */
 	gpiod_set_value(priv->gpiod_nwp, 1);
@@ -394,13 +388,7 @@ static int ams_delta_init(struct platform_device *pdev)
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
@@ -410,16 +398,13 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 {
 	struct ams_delta_nand *priv = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
-	void __iomem *io_base = priv->io_base;
 
 	/* Apply write protection */
 	gpiod_set_value(priv->gpiod_nwp, 0);
 
-	/* Release resources, unregister device */
+	/* Unregister device */
 	nand_release(mtd);
 
-	iounmap(io_base);
-
 	return 0;
 }
 
-- 
2.16.4
