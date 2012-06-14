From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 13/17] i2c: omap: bus: add a receiver flag
Date: Thu, 14 Jun 2012 19:24:23 +0300
Message-ID: <1339691067-919-14-git-send-email-balbi@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339691067-919-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ben-linux@fluff.org
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, w.sang@pengutronix.de, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

that way we can ignore TX IRQs while in receiver
mode and ignore RX IRQs while in transmitter mode.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index be7ac1a..6a7395a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -199,6 +199,7 @@ struct omap_i2c_dev {
 						 */
 	u8			rev;
 	unsigned		b_hw:1;		/* bad h/w fixes */
+	unsigned		receiver:1;	/* true when we're in receiver mode */
 	u16			iestate;	/* Saved interrupt register */
 	u16			pscstate;
 	u16			scllstate;
@@ -538,6 +539,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	init_completion(&dev->cmd_complete);
 	dev->cmd_err = 0;
+	dev->receiver = !!(msg->flags & I2C_M_RD);
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
 
@@ -880,6 +882,13 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 		stat &= bits;
 
+		/* If we're in receiver mode, ignore XDR/XRDY */
+		if (dev->receiver) {
+			stat &= ~(OMAP_I2C_STAT_XDR | OMAP_I2C_STAT_XRDY);
+		} else {
+			stat &= ~(OMAP_I2C_STAT_RDR | OMAP_I2C_STAT_RRDY);
+		}
+
 		if (!stat) {
 			/* my work here is done */
 			omap_i2c_complete_cmd(dev, err);
-- 
1.7.10.4
