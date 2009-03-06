From: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
Subject: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Fri,  6 Mar 2009 15:34:54 +0200
Message-ID: <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17078 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207AbZCFNgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 08:36:41 -0500
In-Reply-To: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

I have observed some Spurious IRQ's for I2C1 when all kernel hacking options
(and thus LOCKDEP) are disabled.

Applying Richard Woodruff's 'I2C bug fixes for L-O and L-Z' seems to help
but IRQF_DISABLED is needed for proper behaviour.

Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
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

