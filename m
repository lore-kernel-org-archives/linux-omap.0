From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH RESEND v3] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Tue, 17 Jul 2018 19:05:52 +0200
Message-ID: <20180717170552.17735-1-jmkrzyszt@gmail.com>
References: <20180709193850.20191-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709193850.20191-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Krzysztof Kozlowski <krzk@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Shreeya Patel <shreeya.patel23498@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Now as Amstrad Delta board - the only user of this driver - provides
GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
use the table to locate required GPIO pins.

Declare static variables for storing GPIO descriptors and replace
gpio_ function calls with their gpiod_ equivalents.

Pin naming used by the driver should be followed while respective GPIO
lookup table is initialized by a board init code.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changlog:
v1: Fix handling of devm_gpiod_get_optional() return values - thanks to
    Andy Shevchenko.
v2: Remove problematic error code conversion, no longer needed if used
    on top of commit d08605a64e67 ("ARM: OMAP1: ams-delta: move late
    devices back to init_machine") and commit 8853daf3b4ac ("gpiolib:
    Defer on non-DT find_chip_by_name() failure") already in linux-next.

 drivers/mtd/nand/raw/ams-delta.c | 121 ++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 59 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 37a3cc21c7bc..09b2f9fda5b9 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -20,23 +20,28 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 
 #include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <mach/board-ams-delta.h>
-
 #include <mach/hardware.h>
 
 /*
  * MTD structure for E3 (Delta)
  */
 static struct mtd_info *ams_delta_mtd = NULL;
+static struct gpio_desc *gpiod_rdy;
+static struct gpio_desc *gpiod_nce;
+static struct gpio_desc *gpiod_nre;
+static struct gpio_desc *gpiod_nwp;
+static struct gpio_desc *gpiod_nwe;
+static struct gpio_desc *gpiod_ale;
+static struct gpio_desc *gpiod_cle;
 
 /*
  * Define partitions for flash devices
@@ -70,9 +75,9 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->IO_ADDR_W);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 0);
+	gpiod_set_value(gpiod_nwe, 0);
 	ndelay(40);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 1);
+	gpiod_set_value(gpiod_nwe, 1);
 }
 
 static u_char ams_delta_read_byte(struct mtd_info *mtd)
@@ -81,11 +86,11 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 	struct nand_chip *this = mtd_to_nand(mtd);
 	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
 
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 0);
+	gpiod_set_value(gpiod_nre, 0);
 	ndelay(40);
 	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 	res = readw(this->IO_ADDR_R);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 1);
+	gpiod_set_value(gpiod_nre, 1);
 
 	return res;
 }
@@ -120,12 +125,9 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 {
 
 	if (ctrl & NAND_CTRL_CHANGE) {
-		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NCE,
-				(ctrl & NAND_NCE) == 0);
-		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_CLE,
-				(ctrl & NAND_CLE) != 0);
-		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_ALE,
-				(ctrl & NAND_ALE) != 0);
+		gpiod_set_value(gpiod_nce, !(ctrl & NAND_NCE));
+		gpiod_set_value(gpiod_cle, !!(ctrl & NAND_CLE));
+		gpiod_set_value(gpiod_ale, !!(ctrl & NAND_ALE));
 	}
 
 	if (cmd != NAND_CMD_NONE)
@@ -134,41 +136,9 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
 {
-	return gpio_get_value(AMS_DELTA_GPIO_PIN_NAND_RB);
+	return gpiod_get_value(gpiod_rdy);
 }
 
-static const struct gpio _mandatory_gpio[] = {
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NCE,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nce",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NRE,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nre",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NWP,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nwp",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NWE,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nwe",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_ALE,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "nand_ale",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_CLE,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "nand_cle",
-	},
-};
 
 /*
  * Main initialization routine
@@ -216,12 +186,17 @@ static int ams_delta_init(struct platform_device *pdev)
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;
 	this->cmd_ctrl = ams_delta_hwcontrol;
-	if (gpio_request(AMS_DELTA_GPIO_PIN_NAND_RB, "nand_rdy") == 0) {
-		this->dev_ready = ams_delta_nand_ready;
-	} else {
-		this->dev_ready = NULL;
-		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
+
+	gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
+	if (IS_ERR(gpiod_rdy)) {
+		err = PTR_ERR(gpiod_rdy);
+		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
+		goto out_mtd;
 	}
+
+	if (gpiod_rdy)
+		this->dev_ready = ams_delta_nand_ready;
+
 	/* 25 us command delay time */
 	this->chip_delay = 30;
 	this->ecc.mode = NAND_ECC_SOFT;
@@ -230,9 +205,42 @@ static int ams_delta_init(struct platform_device *pdev)
 	platform_set_drvdata(pdev, io_base);
 
 	/* Set chip enabled, but  */
-	err = gpio_request_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-	if (err)
-		goto out_gpio;
+	gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nwp)) {
+		err = PTR_ERR(gpiod_nwp);
+		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nce)) {
+		err = PTR_ERR(gpiod_nce);
+		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nre)) {
+		err = PTR_ERR(gpiod_nre);
+		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nwe)) {
+		err = PTR_ERR(gpiod_nwe);
+		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_ale)) {
+		err = PTR_ERR(gpiod_ale);
+		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+	gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_cle)) {
+		err = PTR_ERR(gpiod_cle);
+		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
 
 	/* Scan to find existence of the device */
 	err = nand_scan(ams_delta_mtd, 1);
@@ -246,9 +254,6 @@ static int ams_delta_init(struct platform_device *pdev)
 	goto out;
 
  out_mtd:
-	gpio_free_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-out_gpio:
-	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 out_free:
 	kfree(this);
@@ -266,8 +271,6 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	/* Release resources, unregister device */
 	nand_release(ams_delta_mtd);
 
-	gpio_free_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 
 	/* Free the MTD device structure */
-- 
2.16.4
