From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Wed, 14 Nov 2012 16:22:45 +0200
Message-ID: <1352902965-25666-1-git-send-email-balbi@ti.com>
References: <20121114112050.GG5954@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121114112050.GG5954-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

if we allow compiler reorder our writes, we could
fall into a situation where dev->buf_len is reset
for no apparent reason.

This bug was found with a simple script which would
transfer data to an i2c client from 1 to 1024 bytes
(a simple for loop), when we got to transfer sizes
bigger than the fifo size, dev->buf_len was reset
to zero before we had an oportunity to handle XDR
Interrupt. Because dev->buf_len was zero, we entered
omap_i2c_transmit_data() to transfer zero bytes,
which would mean we would just silently exit
omap_i2c_transmit_data() without actually writing
anything to DATA register. That would cause XDR
IRQ to trigger forever and we would never transfer
the remaining bytes.

After adding the memory barrier, we also drop resetting
dev->buf_len to zero in omap_i2c_xfer_msg() because
both omap_i2c_transmit_data() and omap_i2c_receive_data()
will act until dev->buf_len reaches zero, rendering the
other write in omap_i2c_xfer_msg() redundant.

This patch has been tested with pandaboard for a few
iterations of the script mentioned above.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---

Changes since v2:
	- add a comment

Changes since v1:
        - use barrier() instead of wmb()

 drivers/i2c/busses/i2c-omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..e88fc26 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -522,6 +522,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	dev->buf = msg->buf;
 	dev->buf_len = msg->len;
 
+	/* make sure writes to dev->buf_len are ordered */
+	barrier();
+
 	omap_i2c_write_reg(dev, OMAP_I2C_CNT_REG, dev->buf_len);
 
 	/* Clear the FIFO Buffers */
@@ -579,7 +582,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 */
 	timeout = wait_for_completion_timeout(&dev->cmd_complete,
 						OMAP_I2C_TIMEOUT);
-	dev->buf_len = 0;
 	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		omap_i2c_init(dev);
-- 
1.8.0
