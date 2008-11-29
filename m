From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/12] i2c-omap: Close suspected race between omap_i2c_idle()
	and omap_i2c_isr()
Date: Fri, 28 Nov 2008 17:28:20 -0800
Message-ID: <20081129012820.13042.56229.stgit@localhost>
References: <20081129012612.13042.12283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53620 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbYK2B2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:28:20 -0500
In-Reply-To: <20081129012612.13042.12283.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: i2c-linux@vger.kernel.org, ben-linux@fluff.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

omap_i2c_idle() sets an internal flag, "dev->idle", instructing its
ISR to decline interrupts.  It sets this flag before it actually masks
the interrupts on the I2C controller.  This is problematic, since an
I2C interrupt could arrive after dev->idle is set, but before the
interrupt source is masked.  When this happens, Linux disables the I2C
controller's IRQ, causing all future transactions on the bus to fail.

Symptoms, happening on about 7% of boots:

   irq 56: nobody cared (try booting with the "irqpoll" option)
   <warning traceback here>
   Disabling IRQ #56
   i2c_omap i2c_omap.1: controller timed out

In omap_i2c_idle(), this patch sets dev->idle only after the interrupt
mask write to the I2C controller has left the ARM write buffer.
That's probably the major offender.  For additional prophylaxis, in
omap_i2c_unidle(), the patch clears the dev->idle flag before
interrupts are enabled, rather than afterwards.

The patch has survived twenty-two reboots on the 3430SDP here without
wedging I2C1.  Not absolutely dispositive, but promising!

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 17476ec..5ca0e00 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -181,22 +181,26 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 	if (dev->iclk != NULL)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
+	dev->idle = 0;
 	if (dev->iestate)
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
-	dev->idle = 0;
 }
 
 static void omap_i2c_idle(struct omap_i2c_dev *dev)
 {
 	u16 iv;
 
-	dev->idle = 1;
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
-	if (dev->rev1)
+	if (dev->rev1) {
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG);	/* Read clears */
-	else
+	} else {
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
+
+		/* Flush posted write before the dev->idle store occurs */
+		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+	}
+	dev->idle = 1;
 	clk_disable(dev->fclk);
 	if (dev->iclk != NULL)
 		clk_disable(dev->iclk);

