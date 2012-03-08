From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv2 05/13] OMAP: I2C: Fix the interrupt clearing in OMAP4
Date: Thu, 8 Mar 2012 18:47:57 +0530
Message-ID: <1331212685-6524-6-git-send-email-shubhrajyoti@ti.com>
References: <1331212685-6524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41261 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab2CHNS5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 08:18:57 -0500
In-Reply-To: <1331212685-6524-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, rnayak@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

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
Original patch can be found here:
http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=41049d62e146e0fafe2fac0a31be566b3bbc9149

 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ceb09c7..98720c9 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1172,10 +1172,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
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

