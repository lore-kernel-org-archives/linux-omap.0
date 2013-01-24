From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 5/6 v2] i2c: omap: wait for transfer completion before sending STP bit
Date: Thu, 24 Jan 2013 09:42:26 +0200
Message-ID: <1359013346-29653-1-git-send-email-balbi@ti.com>
References: <20130124073525.GB27304@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44417 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab3AXHm4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 02:42:56 -0500
In-Reply-To: <20130124073525.GB27304@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, Felipe Balbi <balbi@ti.com>

Later patches will come adding support for
reporting amount of bytes transferred so that
client drivers can count how many bytes are
left to transfer.

This is useful mostly in case of NACKs when
client driver wants to know exactly which
byte got NACKed so it doesn't have to resend
all bytes again.

In order to make that work with OMAP's I2C
controller, we need to prevent sending STP
bit until message is transferred. The reason
behind that is because OMAP_I2C_CNT_REG gets
reset to original value after STP bit is
shifted through I2C_SDA line and that would
prevent us from reading the correct number of
bytes left to transfer.

The full programming model suggested by IP
owner was the following:

- start I2C transfer (without STP bit)
- upon completion or NACK, read I2C_CNT register
- write STP bit to I2C_CON register
- wait for ARDY bit

With this patch we're implementing all steps
except step #2 which will come in a later
patch series. In order to implement full NACK
reporting we need to add a new field to struct
i2c_msg, but that's still under discussion on
what's the best way to do it. For now, we can
prepare the driver to receive that piece of code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Changes since v1:
	- don't wait for ARDY after resetting the IP

 drivers/i2c/busses/i2c-omap.c | 84 +++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 52 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ff88495..7386978 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -479,9 +479,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	}
 
 	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
-			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
-				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
+			OMAP_I2C_IE_NACK | OMAP_I2C_IE_AL)  |
+			((dev->fifo_size) ? (OMAP_I2C_IE_RDR |
+				OMAP_I2C_IE_XDR) : 0);
 
 	dev->pscstate = psc;
 	dev->scllstate = scll;
@@ -511,6 +511,22 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
 	return 0;
 }
 
+static int omap_i2c_wait_for_ardy(struct omap_i2c_dev *dev)
+{
+	unsigned long timeout;
+
+	timeout = jiffies + OMAP_I2C_TIMEOUT;
+	while (!(omap_i2c_read_irqstatus(dev) & OMAP_I2C_STAT_ARDY)) {
+		if (time_after(jiffies, timeout)) {
+			dev_warn(dev->dev, "timeout waiting for access ready\n");
+			return -ETIMEDOUT;
+		}
+		usleep_range(800, 1200);
+	}
+
+	return 0;
+}
+
 static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
 {
 	u16		buf;
@@ -558,6 +574,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
 	unsigned long timeout;
+	int ret = 0;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
@@ -601,35 +618,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (!(msg->flags & I2C_M_RD))
 		w |= OMAP_I2C_CON_TRX;
 
-	if (!dev->b_hw && stop)
-		w |= OMAP_I2C_CON_STP;
-
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 
 	/*
-	 * Don't write stt and stp together on some hardware.
-	 */
-	if (dev->b_hw && stop) {
-		unsigned long delay = jiffies + OMAP_I2C_TIMEOUT;
-		u16 con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
-		while (con & OMAP_I2C_CON_STT) {
-			con = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
-
-			/* Let the user know if i2c is in a bad state */
-			if (time_after(jiffies, delay)) {
-				dev_err(dev->dev, "controller timed out "
-				"waiting for start condition to finish\n");
-				return -ETIMEDOUT;
-			}
-			cpu_relax();
-		}
-
-		w |= OMAP_I2C_CON_STP;
-		w &= ~OMAP_I2C_CON_STT;
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
-	}
-
-	/*
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
 	 */
@@ -642,9 +633,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		return -ETIMEDOUT;
 	}
 
-	if (likely(!dev->cmd_err))
-		return 0;
-
 	/* We have an error */
 	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
 			    OMAP_I2C_STAT_XUDF)) {
@@ -656,14 +644,19 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
-		if (stop) {
-			w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
-			w |= OMAP_I2C_CON_STP;
-			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
-		}
-		return -EREMOTEIO;
+
+		ret = -EREMOTEIO;
+	}
+
+	if (stop) {
+		w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+		w |= OMAP_I2C_CON_STP;
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
+
+		ret = omap_i2c_wait_for_ardy(dev);
 	}
-	return -EIO;
+
+	return ret;
 }
 
 
@@ -977,19 +970,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 			break;
 		}
 
-		/*
-		 * ProDB0017052: Clear ARDY bit twice
-		 */
-		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
-					OMAP_I2C_STAT_AL)) {
-			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
-						OMAP_I2C_STAT_RDR |
-						OMAP_I2C_STAT_XRDY |
-						OMAP_I2C_STAT_XDR |
-						OMAP_I2C_STAT_ARDY));
-			break;
-		}
-
 		if (stat & OMAP_I2C_STAT_RDR) {
 			u8 num_bytes = 1;
 
-- 
1.8.1.rc1.5.g7e0651a

