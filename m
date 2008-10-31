From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/10] i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()
Date: Thu, 30 Oct 2008 19:29:48 -0700
Message-ID: <1225420189-630-10-git-send-email-tony@atomide.com>
References: <1225420189-630-1-git-send-email-tony@atomide.com>
 <1225420189-630-2-git-send-email-tony@atomide.com>
 <1225420189-630-3-git-send-email-tony@atomide.com>
 <1225420189-630-4-git-send-email-tony@atomide.com>
 <1225420189-630-5-git-send-email-tony@atomide.com>
 <1225420189-630-6-git-send-email-tony@atomide.com>
 <1225420189-630-7-git-send-email-tony@atomide.com>
 <1225420189-630-8-git-send-email-tony@atomide.com>
 <1225420189-630-9-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64899 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbYJaCaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:30:14 -0400
In-Reply-To: <1225420189-630-9-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, David Brownell <david-b@pacbell.net>, Richard Woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

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
Acked-by; Steve Sakoman <steve@sakoman.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f3e46c2..b09f03f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -191,6 +191,8 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
 
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
+	WARN_ON(!dev->idle);
+
 	if (dev->iclk != NULL)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
@@ -203,6 +205,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
 	u16 iv;
 
+	WARN_ON(dev->idle);
+
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev1) {
@@ -744,6 +748,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		*speed = 100; /* Defualt speed */
 
 	dev->speed = *speed;
+	dev->idle = 1;
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
 	dev->base = ioremap(mem->start, mem->end - mem->start + 1);
@@ -792,6 +797,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
 		 pdev->id, r >> 4, r & 0xf, dev->speed);
 
+	omap_i2c_idle(dev);
+
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -808,8 +815,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
-	omap_i2c_idle(dev);
-
 	return 0;
 
 err_free_irq:
-- 
1.5.6.rc3.21.g8c6b5

