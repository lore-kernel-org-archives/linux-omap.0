From: Felipe Balbi <balbi@ti.com>
Subject: [rft/rfc/patch 10/22] i2c: omap: switch I2C REV2 to threaded IRQ
Date: Wed, 13 Jun 2012 18:50:59 +0300
Message-ID: <1339602671-8431-11-git-send-email-balbi@ti.com>
References: <1339602671-8431-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38889 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754159Ab2FMPxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:53:43 -0400
Received: by lagy4 with SMTP id y4so600666lag.29
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:53:41 -0700 (PDT)
In-Reply-To: <1339602671-8431-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

that way all our IRQ handling will happen in
thread.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a9c1fa6..6e0b406 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -865,7 +865,23 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *dev, u8 num_bytes,
 }
 
 static irqreturn_t
-omap_i2c_isr(int this_irq, void *dev_id)
+omap_i2c_isr(int irq, void *_dev)
+{
+	struct omap_i2c_dev	*dev = _dev;
+	u16			stat;
+	u16			bits;
+
+	stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+	bits = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
+
+	if (stat & bits)
+		return IRQ_WAKE_THREAD;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t
+omap_i2c_threaded_isr(int this_irq, void *dev_id)
 {
 	struct omap_i2c_dev *dev = dev_id;
 	u16 bits;
@@ -1055,7 +1071,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
-	irq_handler_t isr;
 	int r;
 
 	/* NOTE: driver uses the static register mapping */
@@ -1155,9 +1170,12 @@ omap_i2c_probe(struct platform_device *pdev)
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 
-	isr = (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
-								   omap_i2c_isr;
-	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
+	if (dev->rev < OMAP_I2C_OMAP1_REV_2)
+		r = request_irq(dev->irq, omap_i2c_omap1_isr, 0,
+				pdev->name, dev);
+	else
+		r = request_threaded_irq(dev->irq, omap_i2c_isr,
+				omap_i2c_threaded_isr, 0, pdev->name, dev);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
-- 
1.7.10.4

