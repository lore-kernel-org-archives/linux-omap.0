From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/8] i2c: omap: wait for transfer completion before sending STP bit
Date: Mon, 22 Oct 2012 12:46:56 +0300
Message-ID: <1350899218-13624-7-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350899218-13624-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 101 ++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 62 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c65d526..8104aa2 100644
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
@@ -470,6 +476,22 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
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
@@ -515,7 +537,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
 	unsigned long timeout;
-	int ret;
+	int ret = 0;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
@@ -556,35 +578,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
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
@@ -594,36 +590,36 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		ret = -ETIMEDOUT;
-		goto err_i2c_init;
+		omap_i2c_init(dev);
+		goto out;
 	}
 
 	if ((dev->cmd_err & OMAP_I2C_STAT_AL)
 			|| (dev->cmd_err & OMAP_I2C_STAT_ROVR)
 			|| (dev->cmd_err & OMAP_I2C_STAT_XUDF)) {
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
+		omap_i2c_init(dev);
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
 
@@ -947,19 +937,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
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
1.8.0.rc0
