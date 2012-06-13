From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 19/22] i2c: omap: bus: add a receiver flag
Date: Wed, 13 Jun 2012 18:51:08 +0300
Message-ID: <1339602671-8431-20-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:55493 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754267Ab2FMPyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:54:08 -0400
Received: by lbom4 with SMTP id m4so2853149lbo.16
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:54:05 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

that way we can ignore TX IRQs while in receiver
mode and ignore RX IRQs while in transmitter mode.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9274fcb..5a7a223 100644
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
@@ -537,6 +538,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	init_completion(&dev->cmd_complete);
 	dev->cmd_err = 0;
+	dev->receiver = !!(msg->flags & I2C_M_RD);
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
 
@@ -898,6 +900,13 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
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

