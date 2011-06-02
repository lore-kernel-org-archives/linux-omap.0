From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v4 02/18] I2C: OMAP2+: Name registers in I2C IP V2 only accordingly
Date: Wed,  1 Jun 2011 17:19:28 -0700
Message-ID: <1306973984-15165-3-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:52305 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758654Ab1FBATs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 20:19:48 -0400
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
Cc: Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Andy Green <andy@warmcat.com>

The OMAP I2C driver dynamically chooses between two register sets of
differing sizes depending on the cpu type it finds itself on.

It has been observed that the existing code references non-existing
registers on OMAP3530, because while it correctly chose the smaller
register layout based on cpu type, the code uses the probed register
ID to decide if to execute code referencing an extra register, and
both register layout devices on OMAP3530 and OMAP4430 report the same
probed ID of 0x40.

This patch changes the extended register names only found on IP V2
of the I2C peripheral unit accordingly to help show up errors in usage.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 58a58c7..6a6b222 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -72,11 +72,12 @@ enum {
 	OMAP_I2C_SCLH_REG,
 	OMAP_I2C_SYSTEST_REG,
 	OMAP_I2C_BUFSTAT_REG,
-	OMAP_I2C_REVNB_LO,
-	OMAP_I2C_REVNB_HI,
-	OMAP_I2C_IRQSTATUS_RAW,
-	OMAP_I2C_IRQENABLE_SET,
-	OMAP_I2C_IRQENABLE_CLR,
+	/* only on OMAP4430 */
+	OMAP_I2C_IP_V2_REVNB_LO,
+	OMAP_I2C_IP_V2_REVNB_HI,
+	OMAP_I2C_IP_V2_IRQSTATUS_RAW,
+	OMAP_I2C_IP_V2_IRQENABLE_SET,
+	OMAP_I2C_IP_V2_IRQENABLE_CLR,
 };
 
 /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
@@ -244,11 +245,11 @@ const static u8 omap4_reg_map[] = {
 	[OMAP_I2C_SCLH_REG] = 0xb8,
 	[OMAP_I2C_SYSTEST_REG] = 0xbC,
 	[OMAP_I2C_BUFSTAT_REG] = 0xc0,
-	[OMAP_I2C_REVNB_LO] = 0x00,
-	[OMAP_I2C_REVNB_HI] = 0x04,
-	[OMAP_I2C_IRQSTATUS_RAW] = 0x24,
-	[OMAP_I2C_IRQENABLE_SET] = 0x2c,
-	[OMAP_I2C_IRQENABLE_CLR] = 0x30,
+	[OMAP_I2C_IP_V2_REVNB_LO] = 0x00,
+	[OMAP_I2C_IP_V2_REVNB_HI] = 0x04,
+	[OMAP_I2C_IP_V2_IRQSTATUS_RAW] = 0x24,
+	[OMAP_I2C_IP_V2_IRQENABLE_SET] = 0x2c,
+	[OMAP_I2C_IP_V2_IRQENABLE_CLR] = 0x30,
 };
 
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -309,7 +310,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	if (dev->rev >= OMAP_I2C_REV_ON_4430)
-		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
+		omap_i2c_write_reg(dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 
-- 
1.7.4

