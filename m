From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v3 5/7] i2c: omap: wait for transfer completion before sending STP bit
Date: Thu, 25 Oct 2012 15:34:34 +0300
Message-ID: <1351168474-15757-1-git-send-email-balbi@ti.com>
References: <1351167915-15079-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46038 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab2JYMko (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 08:40:44 -0400
In-Reply-To: <1351167915-15079-6-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Benoit Cousson <b-cousson@ti.com>, w.sang@pengutronix.de, ben-linux@fluff.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, michael@amarulasolutions.com, Felipe Balbi <balbi@ti.com>

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
patch adding such support.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Changes since v2:
	- remove unnecessary omap_i2c_init() which was added during a rebase.

 drivers/i2c/busses/i2c-omap.c | 88 ++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 20f9ad6..726b916 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -438,9 +438,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
 	/* Enable interrupts */
 	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
-			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
-				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
+			OMAP_I2C_IE_NACK | OMAP_I2C_IE_AL)  |
+			((dev->fifo_size) ? (OMAP_I2C_IE_RDR |
+				OMAP_I2C_IE_XDR) : 0);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 	if (dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		dev->pscstate = psc;
@@ -470,6 +470,22 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
 	return 0;
 }
 
+static int omap_i2c_wait_for_ardy(struct omap_i2c_dev *dev)
+{
+	unsigned long timeout;
+
+	timeout = jiffies + OMAP_I2C_TIMEOUT;
+	while (!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_ARDY)) {
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
@@ -515,7 +531,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
 	unsigned long timeout;
-	int ret;
+	int ret = 0;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
@@ -556,35 +572,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
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
@@ -594,36 +584,35 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		ret = -ETIMEDOUT;
-		goto err_i2c_init;
+		omap_i2c_init(dev);
+		goto out;
 	}
 
 	/* We have an error */
 	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
 			    OMAP_I2C_STAT_XUDF)) {
 		ret = -EIO;
-		goto err_i2c_init;
+		omap_i2c_init(dev);
+		goto out;
 	}
 
 	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
 
-		if (stop) {
-			w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
-			w |= OMAP_I2C_CON_STP;
-			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
-		}
-
 		ret = -EREMOTEIO;
-		goto err;
 	}
 
-	return 0;
+out:
 
-err_i2c_init:
-	omap_i2c_init(dev);
+	if (stop) {
+		w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+		w |= OMAP_I2C_CON_STP;
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
+
+		ret = omap_i2c_wait_for_ardy(dev);
+	}
 
-err:
 	return ret;
 }
 
@@ -947,19 +936,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
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
1.8.0

