From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] MTD: NAND: ams-delta: drop omap_read/write, use ioremap
Date: Wed, 15 Dec 2010 15:43:44 +0100
Message-ID: <201012151543.46341.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:46458 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791Ab0LOOoY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 09:44:24 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

There is a common requirement for not using OMAP specific omap_readw() / 
omap_writew() function calls in drivers/, but replace them with 
readw() / writew() on ioremap()ped addresses passed from arch/ instead.

The patch implements this idea for the Amstrad Delta NAND driver. To be 
able to use the modified driver, the board file is updated with the 
platform device I/O resource declaration, which is passed from there.

Created and tested against linux-2.6.37-rc5, on top of recent patch 
'MTD: NAND: ams-delta: convert to platform driver'.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
There is one issue indicated by checkpatch.pl --strict:

  ERROR: space prohibited after that '-' (ctx:WxW)
  #120: FILE: arch/arm/mach-omap1/board-ams-delta.c:188:
  +                               OMAP_MPUIO_IO_CNTL + sizeof(u32) - 1,
                                                                   ^
but this looks like a false positive to me.

 arch/arm/mach-omap1/board-ams-delta.c |   13 ++++++++-
 drivers/mtd/nand/ams-delta.c          |   49 +++++++++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 7 deletions(-)

--- linux-2.6.37-rc5/drivers/mtd/nand/ams-delta.c.orig	2010-12-14 20:58:37.000000000 +0100
+++ linux-2.6.37-rc5/drivers/mtd/nand/ams-delta.c	2010-12-15 15:36:36.000000000 +0100
@@ -5,6 +5,7 @@
  *
  *  Derived from drivers/mtd/toto.c
  *  Converted to platform driver by Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
+ *  Partially stolen from drivers/mtd/nand/plat_nand.c
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -63,9 +64,10 @@ static struct mtd_partition partition_in
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
@@ -76,11 +78,12 @@ static u_char ams_delta_read_byte(struct
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
 
@@ -155,8 +158,13 @@ static int ams_delta_nand_ready(struct m
 static int __devinit ams_delta_init(struct platform_device *pdev)
 {
 	struct nand_chip *this;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	void __iomem *io_base;
 	int err = 0;
 
+	if (!res)
+		return -ENXIO;
+
 	/* Allocate memory for MTD device structure and private data */
 	ams_delta_mtd = kmalloc(sizeof(struct mtd_info) +
 				sizeof(struct nand_chip), GFP_KERNEL);
@@ -178,9 +186,25 @@ static int __devinit ams_delta_init(stru
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
+
 	/* Set address of NAND IO lines */
-	this->IO_ADDR_R = (OMAP1_MPUIO_BASE + OMAP_MPUIO_INPUT_LATCH);
-	this->IO_ADDR_W = (OMAP1_MPUIO_BASE + OMAP_MPUIO_OUTPUT);
+	this->IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
+	this->IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
 	this->read_byte = ams_delta_read_byte;
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;
@@ -196,6 +220,8 @@ static int __devinit ams_delta_init(stru
 	this->chip_delay = 30;
 	this->ecc.mode = NAND_ECC_SOFT;
 
+	platform_set_drvdata(pdev, io_base);
+
 	/* Set chip enabled, but  */
 	ams_delta_latch2_write(NAND_MASK, AMS_DELTA_LATCH2_NAND_NRE |
 					  AMS_DELTA_LATCH2_NAND_NWE |
@@ -215,6 +241,11 @@ static int __devinit ams_delta_init(stru
 	goto out;
 
  out_mtd:
+	platform_set_drvdata(pdev, NULL);
+	iounmap(io_base);
+out_release_io:
+	release_mem_region(res->start, resource_size(res));
+out_free:
 	kfree(ams_delta_mtd);
  out:
 	return err;
@@ -225,9 +256,15 @@ static int __devinit ams_delta_init(stru
  */
 static int __devexit ams_delta_cleanup(struct platform_device *pdev)
 {
+	void __iomem *io_base = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
 	/* Release resources, unregister device */
 	nand_release(ams_delta_mtd);
 
+	iounmap(io_base);
+	release_mem_region(res->start, resource_size(res));
+
 	/* Free the MTD device structure */
 	kfree(ams_delta_mtd);
 
--- linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c.orig	2010-12-14 20:58:37.000000000 +0100
+++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c	2010-12-15 15:26:49.000000000 +0100
@@ -181,9 +181,20 @@ static struct omap_board_config_kernel a
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 };
 
+static struct resource ams_delta_nand_resources[] = {
+	[0] = {
+		.start	= OMAP1_MPUIO_BASE,
+		.end	= OMAP1_MPUIO_BASE +
+				OMAP_MPUIO_IO_CNTL + sizeof(u32) - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
 static struct platform_device ams_delta_nand_device = {
 	.name	= "ams-delta-nand",
-	.id	= -1
+	.id	= -1,
+	.num_resources	= ARRAY_SIZE(ams_delta_nand_resources),
+	.resource	= ams_delta_nand_resources,
 };
 
 static struct resource ams_delta_kp_resources[] = {
