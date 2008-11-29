From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 02/12] i2c-omap: Close suspected race between omap_i2c_idle()
	and omap_i2c_isr()
Date: Fri, 28 Nov 2008 17:34:02 -0800
Message-ID: <20081129013402.13428.34357.stgit@localhost>
References: <20081129013318.13428.88465.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081129013318.13428.88465.stgit@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

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

Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
