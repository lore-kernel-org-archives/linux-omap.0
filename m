From: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
Subject: [PATCH] I2C: Call request_irq with IRQF_DISABLED
Date: Thu,  5 Mar 2009 15:54:24 +0200
Message-ID: <1236261264-16053-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54523 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbZCENzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 08:55:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org

I have observed some Spurious IRQ's for I2C1 when all kernel hacking options
(and thus LOCKDEP) are disabled.

Applying Richard Woodruff's 'I2C bug fixes for L-O and L-Z' seems to help
but IRQF_DISABLED is needed for proper behaviour.

Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0c3ed41..18af43f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -847,7 +847,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	omap_i2c_init(dev);
 
 	isr = (dev->rev < OMAP_I2C_REV_2) ? omap_i2c_rev1_isr : omap_i2c_isr;
-	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
+	r = request_irq(dev->irq, isr, IRQF_DISABLED, pdev->name, dev);
 
 	if (r) {
 		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
-- 
1.5.6.5

