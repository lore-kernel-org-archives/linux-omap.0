From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v2] MTD: NAND: ams-delta: convert to platform driver
Date: Tue, 14 Dec 2010 21:09:40 +0100
Message-ID: <201012142109.42784.jkrzyszt@tis.icnet.pl>
References: <201012111840.05270.jkrzyszt@tis.icnet.pl> <1292346023.2538.103.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:59760 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459Ab0LNUbX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 15:31:23 -0500
In-Reply-To: <1292346023.2538.103.camel@localhost>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-mtd@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org

In its current form, the driver may interfere with different hardware on 
different boards if built into the kernel, hence is not suitable for 
inclusion into a defconfig, inteded to be usable with multiple OMAP1 cpu and 
machine types.

Convert it to a platform driver, that should be free from this issue.

Created and tested against linux-2.6.37-rc5 on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Tuesday 14 December 2010 18:00:23 Artem Bityutskiy wrote:
> Sorry, but would it please be possible to split this few small patches -
> this one is too difficult to review, at least for me.

v1 -> v2 changes:
- remove any changes that were not essential for actually converting the 
  driver to a platform driver and modifying its user, ie. the Amstrad Delta 
  board, to register a corresponding platform device on startup,
- re-word the commit message a little bit.

 arch/arm/mach-omap1/board-ams-delta.c |    6 ++++++
 drivers/mtd/nand/ams-delta.c          |   31 ++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

--- linux-2.6.37-rc5/drivers/mtd/nand/ams-delta.c.orig	2010-12-14 20:25:58.000000000 +0100
+++ linux-2.6.37-rc5/drivers/mtd/nand/ams-delta.c	2010-12-14 20:26:40.000000000 +0100
@@ -4,6 +4,7 @@
  *  Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
  *
  *  Derived from drivers/mtd/toto.c
+ *  Converted to platform driver by Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -151,7 +152,7 @@ static int ams_delta_nand_ready(struct m
 /*
  * Main initialization routine
  */
-static int __init ams_delta_init(void)
+static int __devinit ams_delta_init(struct platform_device *pdev)
 {
 	struct nand_chip *this;
 	int err = 0;
@@ -219,20 +222,40 @@ static int __init ams_delta_init(void)
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
 	/* Release resources, unregister device */
 	nand_release(ams_delta_mtd);
 
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
+++ linux-2.6.37-rc5/arch/arm/mach-omap1/board-ams-delta.c	2010-12-14 20:26:40.000000000 +0100
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

