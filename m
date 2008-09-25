From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/8] i2c-omap: Clean-up i2c-omap
Date: Thu, 25 Sep 2008 10:16:34 +0300
Message-ID: <1222326994-26836-9-git-send-email-tony@atomide.com>
References: <1222326994-26836-1-git-send-email-tony@atomide.com>
 <1222326994-26836-2-git-send-email-tony@atomide.com>
 <1222326994-26836-3-git-send-email-tony@atomide.com>
 <1222326994-26836-4-git-send-email-tony@atomide.com>
 <1222326994-26836-5-git-send-email-tony@atomide.com>
 <1222326994-26836-6-git-send-email-tony@atomide.com>
 <1222326994-26836-7-git-send-email-tony@atomide.com>
 <1222326994-26836-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55651 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbYIYHRE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:17:04 -0400
In-Reply-To: <1222326994-26836-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c@lm-sensors.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Minor checkpatch and formatting clean-up. Also update copyrights.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index 9ac64c7..0c5d101 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -2,13 +2,15 @@
  * TI OMAP I2C master mode driver
  *
  * Copyright (C) 2003 MontaVista Software, Inc.
- * Copyright (C) 2004 Texas Instruments.
- *
- * Updated to work with multiple I2C interfaces on 24xx by
- * Tony Lindgren <tony@atomide.com> and Imre Deak <imre.deak@nokia.com=
>
  * Copyright (C) 2005 Nokia Corporation
+ * Copyright (C) 2004 - 2007 Texas Instruments.
  *
- * Cleaned up by Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
+ * Originally written by MontaVista Software, Inc.
+ * Additional contributions by:
+ *	Tony Lindgren <tony@atomide.com>
+ *	Imre Deak <imre.deak@nokia.com>
+ *	Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
+ *	Syed Khasim <x0khasim@ti.com>
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License as published b=
y
@@ -33,8 +35,7 @@
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
=20
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
@@ -215,7 +216,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	dev->iestate =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1)
-		iv =3D omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);	/* Read clears */
+		iv =3D omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
 	/*
@@ -334,9 +335,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
=20
 	/* Enable interrupts */
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
-			   (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
-			    OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			    OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
+			(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
+			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
 				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0));
 	return 0;
 }
@@ -402,8 +403,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *a=
dap,
 		w |=3D OMAP_I2C_CON_XA;
 	if (!(msg->flags & I2C_M_RD))
 		w |=3D OMAP_I2C_CON_TRX;
+
 	if (!dev->b_hw && stop)
 		w |=3D OMAP_I2C_CON_STP;
+
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
=20
 	/*
@@ -475,7 +478,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_=
msg msgs[], int num)
=20
 	omap_i2c_unidle(dev);
=20
-	if ((r =3D omap_i2c_wait_for_bb(dev)) < 0)
+	r =3D omap_i2c_wait_for_bb(dev)
+	if (r < 0)
 		goto out;
=20
 	for (i =3D 0; i < num; i++) {
@@ -745,7 +749,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev->base =3D (void __iomem *) IO_ADDRESS(mem->start);
 	platform_set_drvdata(pdev, dev);
=20
-	if ((r =3D omap_i2c_get_clocks(dev)) !=3D 0)
+	r =3D omap_i2c_get_clocks(dev)
+	if (r !=3D 0)
 		goto err_free_mem;
=20
 	omap_i2c_unidle(dev);
--=20
1.5.6.rc3.21.g8c6b5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
