From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] i2c-omap: Clean-up i2c-omap, v2
Date: Thu, 25 Sep 2008 10:27:05 +0300
Message-ID: <20080925072704.GA5222@atomide.com>
References: <1222326994-26836-1-git-send-email-tony@atomide.com> <1222326994-26836-2-git-send-email-tony@atomide.com> <1222326994-26836-3-git-send-email-tony@atomide.com> <1222326994-26836-4-git-send-email-tony@atomide.com> <1222326994-26836-5-git-send-email-tony@atomide.com> <1222326994-26836-6-git-send-email-tony@atomide.com> <1222326994-26836-7-git-send-email-tony@atomide.com> <1222326994-26836-8-git-send-email-tony@atomide.com> <1222326994-26836-9-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AkbCVLjbJ9qUtAXD"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60852 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYIYH1K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 03:27:10 -0400
Content-Disposition: inline
In-Reply-To: <1222326994-26836-9-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c@lm-sensors.org
Cc: linux-omap@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080925 10:18]:
> Minor checkpatch and formatting clean-up. Also update copyrights.

Oops, left out the last hunk too to avoid merge conflicts, here's an
updated version of this patch.

Tony

--AkbCVLjbJ9qUtAXD
Content-Type: text/x-diff; charset=iso-8859-1
Content-Disposition: inline; filename="0008-i2c-omap-Clean-up-i2c-omap.patch"
Content-Transfer-Encoding: 8bit

>From a50275a85a81be007c74293b5519c3cbb01f6fa5 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 25 Sep 2008 10:23:55 +0300
Subject: [PATCH] i2c-omap: Clean-up i2c-omap

Minor checkpatch and formatting clean-up. Also update copyrights.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9ac64c7..3dc608c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -2,13 +2,15 @@
  * TI OMAP I2C master mode driver
  *
  * Copyright (C) 2003 MontaVista Software, Inc.
- * Copyright (C) 2004 Texas Instruments.
- *
- * Updated to work with multiple I2C interfaces on 24xx by
- * Tony Lindgren <tony@atomide.com> and Imre Deak <imre.deak@nokia.com>
  * Copyright (C) 2005 Nokia Corporation
+ * Copyright (C) 2004 - 2007 Texas Instruments.
  *
- * Cleaned up by Juha Yrjölä <juha.yrjola@nokia.com>
+ * Originally written by MontaVista Software, Inc.
+ * Additional contributions by:
+ *	Tony Lindgren <tony@atomide.com>
+ *	Imre Deak <imre.deak@nokia.com>
+ *	Juha Yrjölä <juha.yrjola@nokia.com>
+ *	Syed Khasim <x0khasim@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -33,8 +35,7 @@
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
@@ -215,7 +216,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1)
-		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);	/* Read clears */
+		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
 	/*
@@ -334,9 +335,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
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
@@ -402,8 +403,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		w |= OMAP_I2C_CON_XA;
 	if (!(msg->flags & I2C_M_RD))
 		w |= OMAP_I2C_CON_TRX;
+
 	if (!dev->b_hw && stop)
 		w |= OMAP_I2C_CON_STP;
+
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 
 	/*
@@ -475,7 +478,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	omap_i2c_unidle(dev);
 
-	if ((r = omap_i2c_wait_for_bb(dev)) < 0)
+	r = omap_i2c_wait_for_bb(dev)
+	if (r < 0)
 		goto out;
 
 	for (i = 0; i < num; i++) {
-- 
1.5.6.rc3.21.g8c6b5


--AkbCVLjbJ9qUtAXD--
