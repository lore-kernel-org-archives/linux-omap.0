From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH v3] OMAP: I2C: Fix the interrupt clearing in OMAP4
Date: Tue, 22 Nov 2011 11:31:56 +0530
Message-ID: <1321941716-4505-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56748 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab1KVGCR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 01:02:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, khilman@ti.com, ben-linux@fluff.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

However on OMAP4 we were writing 1 to  IRQENABLE_CLR which clears only
the arbitration lost interrupt. The patch intends to fix the same by writing 
0 to the IE register.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2dfb631..4220949 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -308,10 +308,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	pdata = pdev->dev.platform_data;
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	if (dev->rev >= OMAP_I2C_REV_ON_4430)
-		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
-	else
-		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
+
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 
 	if (dev->rev < OMAP_I2C_REV_2) {
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
-- 
1.7.1

