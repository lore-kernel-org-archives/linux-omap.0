From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] I2C: Ensure write posting for critical i2c-omap
	writes
Date: Fri, 31 Oct 2008 14:03:38 -0700
Message-ID: <20081031210337.GE28924@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com> <1225480873-30835-2-git-send-email-tony@atomide.com> <1225480873-30835-3-git-send-email-tony@atomide.com> <1225480873-30835-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60066 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbYJaVDk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 17:03:40 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1Kw19f-0007TB-1h
	for linux-omap@vger.kernel.org; Fri, 31 Oct 2008 21:03:39 +0000
Content-Disposition: inline
In-Reply-To: <1225480873-30835-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [081031 12:21]:
> Otherwise we may race, or will get spurious I2C interrupts:
> 
> i2c_omap.1: XDR IRQ while no data to send
> ...

Here's an updated version of this to say "flush posted write" for easy
grepping. Also change previous wmb() to flush.

Tony

--GRPZ8SYKNexpdSJ7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="flush-i2c.patch"

>From df5cf408d3a59a892ba8ff25feed402fdeb53a0d Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 31 Oct 2008 13:56:16 -0700
Subject: [PATCH] I2C: Flush posted write for i2c-omap

Otherwise we may race, or will get spurious I2C interrupts:

i2c_omap.1: XDR IRQ while no data to send
...

Also replace previous wmb() with a readback to flush posted write
there too.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a999606..6d40781 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -220,16 +220,14 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
-	if (dev->rev1)
+	if (dev->rev1) {
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
-	else
+	} else {
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
-	/*
-	 * The wmb() is to ensure that the I2C interrupt mask write
-	 * reaches the I2C controller before the dev->idle store
-	 * occurs.
-	 */
-	wmb();
+
+		/* Flush posted write for interrupt mask before dev->idle = 1 */
+		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+	}
 	dev->idle = 1;
 	clk_disable(dev->fclk);
 	if (dev->iclk != NULL)
@@ -689,6 +687,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					break;
 				}
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
+
+				/* Flush posted write */
+				omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
 			}
 			omap_i2c_ack_stat(dev,
 				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));

--GRPZ8SYKNexpdSJ7--
