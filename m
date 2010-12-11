From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] MTD: NAND: ams-delta: convert to platform driver
Date: Sat, 11 Dec 2010 18:40:02 +0100
Message-ID: <201012111840.05270.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In its current form, the driver may break unrelated machines if built into the 
kernel, hence is not suitable for inclusion into a kernel built for multiple 
OMAP1 machines. Convert it to a platform driver, that should be free from that 
issue.

While being at it, get rid of depreciated omap_read/write(), use ioremap() 
instead.

Created and tested against linux-2.6.37-rc5 on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---

 arch/arm/mach-omap1/board-ams-delta.c |    6 +
 drivers/mtd/nand/Kconfig              |    1
 drivers/mtd/nand/ams-delta.c          |  107 ++++++++++++++++++++++++++--------
 3 files changed, 90 insertions(+), 24 deletions(-)

--- linux-2.6.37-rc5/drivers/mtd/nand/ams-delta.c.orig	2010-12-09 23:08:16.000000000 +0100
+++ linux-2.6.37-rc5/drivers/mtd/nand/ams-delta.c	2010-12-11 17:47:21.000000000 +0100
@@ -4,6 +4,7 @@
  *  Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
  *
  *  Derived from drivers/mtd/toto.c
+ *  Converted to platform driver by Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -62,9 +63,10 @@ static struct mtd_partition partition_in
 static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd->priv;
+	void __iomem *io_base = this->priv;
 
-	omap_writew(0, (OMAP1_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
-	omap_writew(byte, this->IO_ADDR_W);
+	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
+	writew(byte, this->IO_ADDR_W);
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NWE, 0);
 	ndelay(40);
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NWE,
@@ -75,11 +77,12 @@ static u_char ams_delta_read_byte(struct
 {
 	u_char res;
 	struct nand_chip *this = mtd->priv;
+	void __iomem *io_base = this->priv;
 
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NRE, 0);
 	ndelay(40);
-	omap_writew(~0, (OMAP1_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
-	res = omap_readw(this->IO_ADDR_R);
+	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
+	res = readw(this->IO_ADDR_R);
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NRE,
 			       AMS_DELTA_LATCH2_NAND_NRE);
 
@@ -148,21 +151,27 @@ static int ams_delta_nand_ready(struct m
 	return gpio_get_value(AMS_DELTA_GPIO_PIN_NAND_RB);
 }
 
+static struct resource ams_delta_nand_resource __initdata = {
+	.start		= OMAP1_MPUIO_BASE,
+	.end		= OMAP1_MPUIO_BASE + OMAP_MPUIO_IO_CNTL,
+};
+
 /*
  * Main initialization routine
  */
-static int __init ams_delta_init(void)
+static int __devinit ams_delta_init(struct platform_device *pdev)
 {
 	struct nand_chip *this;
+	struct resource *res = &ams_delta_nand_resource;
+	void __iomem *io_base;
 	int err = 0;
 
 	/* Allocate memory for MTD device structure and private data */
-	ams_delta_mtd = kmalloc(sizeof(struct mtd_info) +
+	ams_delta_mtd = kzalloc(sizeof(struct mtd_info) +
 				sizeof(struct nand_chip), GFP_KERNEL);
 	if (!ams_delta_mtd) {
-		printk (KERN_WARNING "Unable to allocate E3 NAND MTD device structure.\n");
-		err = -ENOMEM;
-		goto out;
+		dev_err(&pdev->dev, "unable to allocate device structure.\n");
+		return -ENOMEM;
 	}
 
 	ams_delta_mtd->owner = THIS_MODULE;
@@ -170,16 +179,29 @@ static int __init ams_delta_init(void)
 	/* Get pointer to private data */
 	this = (struct nand_chip *) (&ams_delta_mtd[1]);
 
-	/* Initialize structures */
-	memset(ams_delta_mtd, 0, sizeof(struct mtd_info));
-	memset(this, 0, sizeof(struct nand_chip));
-
 	/* Link the private data with the MTD structure */
 	ams_delta_mtd->priv = this;
 
+	if (!request_mem_region(res->start, resource_size(res),
+			dev_name(&pdev->dev))) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		err = -EBUSY;
+		goto out_free;
+	}
+
+	io_base = ioremap(res->start, resource_size(res));
+	if (io_base == NULL) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		err = -EIO;
+		goto out_release_io;
+	}
+
+	this->priv = io_base;
+	ams_delta_mtd->name = dev_name(&pdev->dev);
+
 	/* Set address of NAND IO lines */
-	this->IO_ADDR_R = (OMAP1_MPUIO_BASE + OMAP_MPUIO_INPUT_LATCH);
-	this->IO_ADDR_W = (OMAP1_MPUIO_BASE + OMAP_MPUIO_OUTPUT);
+	this->IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
+	this->IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
 	this->read_byte = ams_delta_read_byte;
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;
@@ -189,7 +211,7 @@ static int __init ams_delta_init(void)
 		this->dev_ready = ams_delta_nand_ready;
 	} else {
 		this->dev_ready = NULL;
-		printk(KERN_NOTICE "Couldn't request gpio for Delta NAND ready.\n");
+		dev_notice(&pdev->dev, "couldn't request NAND ready GPIO.\n");
 	}
 	/* 25 us command delay time */
 	this->chip_delay = 30;
@@ -204,35 +226,72 @@ static int __init ams_delta_init(void)
 	/* Scan to find existance of the device */
 	if (nand_scan(ams_delta_mtd, 1)) {
 		err = -ENXIO;
-		goto out_mtd;
+		goto out;
 	}
 
+#ifdef CONFIG_MTD_PARTITIONS
 	/* Register the partitions */
 	add_mtd_partitions(ams_delta_mtd, partition_info,
 			   ARRAY_SIZE(partition_info));
+#endif
+	err = add_mtd_device(ams_delta_mtd);
 
-	goto out;
+	if (!err)
+		return err;
 
- out_mtd:
+	nand_release(ams_delta_mtd);
+out:
+	ams_delta_latch2_write(NAND_MASK, 0);
+	iounmap(io_base);
+out_release_io:
+	release_mem_region(res->start, resource_size(res));
+out_free:
 	kfree(ams_delta_mtd);
- out:
 	return err;
 }
 
-module_init(ams_delta_init);
-
 /*
  * Clean up routine
  */
-static void __exit ams_delta_cleanup(void)
+static int __devexit ams_delta_cleanup(struct platform_device *pdev)
 {
+	struct nand_chip *chip = ams_delta_mtd->priv;
+	void __iomem *io_base = chip->priv;
+	struct resource *res = &ams_delta_nand_resource;
+
 	/* Release resources, unregister device */
 	nand_release(ams_delta_mtd);
 
+	ams_delta_latch2_write(NAND_MASK, 0);
+	iounmap(io_base);
+	release_mem_region(res->start, resource_size(res));
+
 	/* Free the MTD device structure */
 	kfree(ams_delta_mtd);
+
+	return 0;
+}
+
+static struct platform_driver ams_delta_nand_driver = {
+	.probe		= ams_delta_init,
+	.remove		= __devexit_p(ams_delta_cleanup),
+	.driver		= {
+		.name	= "ams-delta-nand",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init ams_delta_nand_init(void)
+{
+	return platform_driver_register(&ams_delta_nand_driver);
+}
+module_init(ams_delta_nand_init);
+
+static void __exit ams_delta_nand_exit(void)
+{
+	platform_driver_unregister(&ams_delta_nand_driver);
 }
-module_exit(ams_delta_cleanup);
+module_exit(ams_delta_nand_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jonathan McDowell <noodles@earth.li>");
--- linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c.orig	2010-12-09 23:13:04.000000000 +0100
+++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c	2010-12-11 16:23:51.000000000 +0100
@@ -181,6 +181,11 @@ static struct omap_board_config_kernel a
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 };
 
+static struct platform_device ams_delta_nand_device = {
+	.name	= "ams-delta-nand",
+	.id	= -1
+};
+
 static struct resource ams_delta_kp_resources[] = {
 	[0] = {
 		.start	= INT_KEYBOARD,
@@ -273,6 +278,7 @@ void __init amsdelta_reserve(void)
 }
 
 static struct platform_device *ams_delta_devices[] __initdata = {
+	&ams_delta_nand_device,
 	&ams_delta_kp_device,
 	&ams_delta_lcd_device,
 	&ams_delta_led_device,
--- linux-2.6.37-rc5/drivers/mtd/nand/Kconfig.orig	2010-12-09 23:08:16.000000000 +0100
+++ linux-2.6.37-rc5/drivers/mtd/nand/Kconfig	2010-12-11 15:58:12.000000000 +0100
@@ -96,6 +96,7 @@ config MTD_NAND_SPIA
 config MTD_NAND_AMS_DELTA
 	tristate "NAND Flash device on Amstrad E3"
 	depends on MACH_AMS_DELTA
+	default y
 	help
 	  Support for NAND flash on Amstrad E3 (Delta).
