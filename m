From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 17/22] i2c: omap: drop Access Ready IRQ
Date: Wed, 13 Jun 2012 18:51:06 +0300
Message-ID: <1339602671-8431-18-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:50138 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754248Ab2FMPyC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:54:02 -0400
Received: by lbgc1 with SMTP id c1so1226310lbg.15
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:54:00 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

documentation is very unclear about how that
works and testing shows that driver works without
it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b9c9407..20f854d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -474,9 +474,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		dev->errata |= I2C_OMAP_ERRATA_I207;
 
 	/* Enable interrupts */
-	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
-			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
-			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
+	dev->iestate = OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+		OMAP_I2C_IE_NACK | OMAP_I2C_IE_AL  | ((dev->fifo_size) ?
 				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) : 0);
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 	if (dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
@@ -923,23 +922,6 @@ omap_i2c_threaded_isr(int this_irq, void *dev_id)
 			return IRQ_HANDLED;
 		}
 
-		if (stat & OMAP_I2C_STAT_ARDY)
-			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ARDY);
-
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
-			omap_i2c_complete_cmd(dev, err);
-			return IRQ_HANDLED;
-		}
-
 		if (stat & OMAP_I2C_STAT_RDR) {
 			u8 num_bytes = 1;
 
-- 
1.7.10.4

