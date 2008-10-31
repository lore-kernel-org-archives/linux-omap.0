From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/10] i2c-omap: Clean-up i2c-omap
Date: Thu, 30 Oct 2008 19:29:47 -0700
Message-ID: <1225420189-630-9-git-send-email-tony@atomide.com>
References: <1225420189-630-1-git-send-email-tony@atomide.com>
 <1225420189-630-2-git-send-email-tony@atomide.com>
 <1225420189-630-3-git-send-email-tony@atomide.com>
 <1225420189-630-4-git-send-email-tony@atomide.com>
 <1225420189-630-5-git-send-email-tony@atomide.com>
 <1225420189-630-6-git-send-email-tony@atomide.com>
 <1225420189-630-7-git-send-email-tony@atomide.com>
 <1225420189-630-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64880 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbYJaCaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:30:12 -0400
In-Reply-To: <1225420189-630-8-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Minor sparse, checkpatch and formatting clean-up. Also update copyright=
s.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index a675bf3..f3e46c2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -2,13 +2,16 @@
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
+ *	Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@solidboot.com>
+ *	Syed Khasim <x0khasim@ti.com>
+ *	Nishant Menon <nm@ti.com>
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License as published b=
y
@@ -33,8 +36,7 @@
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
=20
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
@@ -204,7 +206,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	dev->iestate =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1) {
-		iv =3D omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);	/* Read clears */
+		iv =3D omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
=20
@@ -324,9 +326,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
@@ -392,8 +394,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *a=
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
@@ -472,7 +476,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_=
msg msgs[], int num)
=20
 	omap_i2c_unidle(dev);
=20
-	if ((r =3D omap_i2c_wait_for_bb(dev)) < 0)
+	r =3D omap_i2c_wait_for_bb(dev);
+	if (r < 0)
 		goto out;
=20
 	for (i =3D 0; i < num; i++) {
@@ -565,7 +570,7 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 #else
-#define omap_i2c_rev1_isr		0
+#define omap_i2c_rev1_isr		NULL
 #endif
=20
 static irqreturn_t
--=20
1.5.6.rc3.21.g8c6b5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
