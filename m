From: Tony Lindgren <tony@atomide.com>
Subject: Re: [i2c] [PATCH 8/8] i2c-omap: Clean-up i2c-omap
Date: Fri, 17 Oct 2008 08:41:41 -0700
Message-ID: <20081017154140.GN15820@atomide.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-2-git-send-email-tony@atomide.com> <1222329234-31473-3-git-send-email-tony@atomide.com> <1222329234-31473-4-git-send-email-tony@atomide.com> <1222329234-31473-5-git-send-email-tony@atomide.com> <1222329234-31473-6-git-send-email-tony@atomide.com> <1222329234-31473-7-git-send-email-tony@atomide.com> <1222329234-31473-8-git-send-email-tony@atomide.com> <1222329234-31473-9-git-send-email-tony@atomide.com> <20080929223125.GV2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wjoFZxbW4tu+iR6v"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64637 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbYJQPmB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 11:42:01 -0400
Content-Disposition: inline
In-Reply-To: <20080929223125.GV2716@fluff.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: i2c@lm-sensors.org, linux-omap@vger.kernel.org


--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Ben Dooks <ben-linux@fluff.org> [080929 15:31]:
> On Thu, Sep 25, 2008 at 10:53:54AM +0300, Tony Lindgren wrote:
> > Minor checkpatch and formatting clean-up. Also update copyrights.
> 
> looks ok, assuming it doesn't get broken by any changes
> from the review comments i've made earlier in the series.

Here's this one updated with one sparse fix to change the
#define omap_i2c_rev1_isr NULL instead of 0.

Tony

--wjoFZxbW4tu+iR6v
Content-Type: text/x-diff; charset=iso-8859-1
Content-Disposition: inline; filename="0008-i2c-omap-Clean-up-i2c-omap.patch"
Content-Transfer-Encoding: 8bit

>From 8537c8bb8753f3e3c5dd23ec15ba59c3562812a1 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 17 Oct 2008 07:49:27 -0700
Subject: [PATCH] i2c-omap: Clean-up i2c-omap

Minor sparse, checkpatch and formatting clean-up. Also update copyrights.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5560064..17166a2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -2,13 +2,16 @@
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
+ *	Juha Yrjölä <juha.yrjola@solidboot.com>
+ *	Syed Khasim <x0khasim@ti.com>
+ *	Nishant Menon <nm@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -33,8 +36,7 @@
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
@@ -204,7 +206,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1)
-		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);	/* Read clears */
+		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
 	/*
@@ -323,9 +325,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
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
@@ -391,8 +393,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		w |= OMAP_I2C_CON_XA;
 	if (!(msg->flags & I2C_M_RD))
 		w |= OMAP_I2C_CON_TRX;
+
 	if (!dev->b_hw && stop)
 		w |= OMAP_I2C_CON_STP;
+
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 
 	/*
@@ -471,7 +475,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	omap_i2c_unidle(dev);
 
-	if ((r = omap_i2c_wait_for_bb(dev)) < 0)
+	r = omap_i2c_wait_for_bb(dev);
+	if (r < 0)
 		goto out;
 
 	for (i = 0; i < num; i++) {
@@ -564,7 +569,7 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 #else
-#define omap_i2c_rev1_isr		0
+#define omap_i2c_rev1_isr		NULL
 #endif
 
 static irqreturn_t
-- 
1.5.6.rc3.21.g8c6b5


--wjoFZxbW4tu+iR6v--
