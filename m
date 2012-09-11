From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 12/23] i2c: omap: bus: add a receiver flag
Date: Tue, 11 Sep 2012 15:12:07 +0530
Message-ID: <1347356538-23835-13-git-send-email-shubhrajyoti@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50913 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758603Ab2IKJnn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 05:43:43 -0400
In-Reply-To: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

that way we can ignore TX IRQs while in receiver
mode and ignore RX IRQs while in transmitter mode.

Signed-off-by: Felipe Balbi <balbi@ti.com>
[Remove unnecessary braces]
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0da8169..3be147a 100644
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
@@ -492,6 +493,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->cmd_err = 0;
+	dev->receiver = !!(msg->flags & I2C_M_RD);
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
 
@@ -837,6 +839,12 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 		stat &= bits;
 
+		/* If we're in receiver mode, ignore XDR/XRDY */
+		if (dev->receiver)
+			stat &= ~(OMAP_I2C_STAT_XDR | OMAP_I2C_STAT_XRDY);
+		else
+			stat &= ~(OMAP_I2C_STAT_RDR | OMAP_I2C_STAT_RRDY);
+
 		if (!stat) {
 			/* my work here is done */
 			return IRQ_HANDLED;
-- 
1.7.5.4

