From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv4 05/18] OMAP: I2C: Fix the interrupt clearing in OMAP4
Date: Tue, 3 Apr 2012 17:08:14 +0530
Message-ID: <1333453107-7697-6-git-send-email-shubhrajyoti@ti.com>
References: <1333453107-7697-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52590 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab2DCLjP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Apr 2012 07:39:15 -0400
In-Reply-To: <1333453107-7697-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

On OMAP4 we were writing 1 to IRQENABLE_CLR which cleared only
the arbitration lost interrupt. The patch intends to fix the same by writing 0
to the IE register clearing all interrupts.

This is based on the work done by Vikram Pandita <vikram.pandita@ti.com>.

The  changes from the original patch ...
-  Does not use the IRQENABLE_CLR register to clear as it is not mentioned
  to be legacy register IRQENABLE_CLR helps in  atomically
  setting/clearing specific interrupts, instead use the OMAP_I2C_IE_REG as we are
  clearing all interrupts.

Cc: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 45389db..2769f67 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1179,10 +1179,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 		_dev->dev_lost_count = _dev->get_context_loss_count(dev);
 
 	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
-	if (_dev->dtrev == OMAP_I2C_IP_VERSION_2)
-		omap_i2c_write_reg(_dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
-	else
-		omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
+
+	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
 
 	if (_dev->rev < OMAP_I2C_OMAP1_REV_2) {
 		iv = omap_i2c_read_reg(_dev, OMAP_I2C_IV_REG); /* Read clears */
-- 
1.7.1

