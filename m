From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH v2] OMAP: I2C: Fix the interrupt clearing in OMAP4
Date: Mon, 21 Nov 2011 12:46:42 +0530
Message-ID: <1321859802-5386-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab1KUHQ5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Nov 2011 02:16:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, khilman@ti.com, ben-linux@fluff.org, Shubhrajyoti D <shubhrajyoti@ti.com>

For OMAP4 Interrupt enable register is a legacy register.
To clear the interrupts we were writing 0 to it. However on OMAP4
we were writing 1 to  IRQENABLE_CLR which clears only the arbitration
lost interrupt. The patch intends to fix the same by writing 1
to all the bits.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2dfb631..bf4376f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -167,6 +167,10 @@ enum {
 #define SYSC_IDLEMODE_SMART		0x2
 #define SYSC_CLOCKACTIVITY_FCLK		0x2
 
+
+/* Mask to clear all the interrupts */
+#define OMAP_I2C_IRQENABLE_CLR_ALL	0x6FFF
+
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
 #define I2C_OMAP3_1P153			(1 << 1)
@@ -308,8 +312,17 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	pdata = pdev->dev.platform_data;
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
+
+	/*
+	 * The Interrupt enable register is a legacy register for OMAP4.
+	 * However to clear all the interrupts we could write 0 to Interrupt
+	 * enable reg  or  should write 1 to all the bits of the
+	 * I2C_IRQENABLE_CLR register.
+	 */
+
 	if (dev->rev >= OMAP_I2C_REV_ON_4430)
-		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
+		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR,
+					OMAP_I2C_IRQENABLE_CLR_ALL);
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 
-- 
1.7.1

