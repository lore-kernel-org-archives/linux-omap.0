From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] i2c-omap: fix I2C timeouts due to recursive
 omap_i2c_{un,}idle()
Date: Fri, 10 Oct 2008 10:58:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810101056020.13922@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45420 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758412AbYJJQ6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 12:58:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net, r-woodruff2@ti.com


omap_i2c_unidle() and omap_i2c_idle() are called recursively during
omap_i2c_probe().  This is evidently unexpected and will wipe
out the I2C interrupt enable register the second time that
omap_i2c_idle() is called consecutively.  Any I2C transactions
following a probe of a bus with at least one device on it will then
time out.

Fix by moving omap_i2c_idle() further up in omap_i2c_probe().  Ensure
the I2C controller is marked as idle before the probe starts.  Also
attempt to catch future reappearances of this bug early in development
by warning in omap_i2c_{un,}idle() when they are called recursively.

Problem reported by David Brownell <david-b@pacbell.net>.

Tested on 3430SDP and 2430SDP.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: David Brownell <david-b@pacbell.net>
Cc: Richard Woodruff <r-woodruff2@ti.com>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1e6c3fd..a999606 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -202,6 +202,8 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
 
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
+	WARN_ON(!dev->idle);
+
 	if (dev->iclk != NULL)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
@@ -214,6 +216,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
 	u16 iv;
 
+	WARN_ON(dev->idle);
+
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1)
@@ -748,6 +752,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		*speed = 100; /* Defualt speed */
 
 	dev->speed = *speed;
+	dev->idle = 1;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
 	dev->base = ioremap(mem->start, mem->end - mem->start + 1);
@@ -797,6 +802,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
 		 pdev->id, r >> 4, r & 0xf, dev->speed);
 
+	omap_i2c_idle(dev);
+
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -813,8 +820,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
-	omap_i2c_idle(dev);
-
 	return 0;
 
 err_free_irq:
