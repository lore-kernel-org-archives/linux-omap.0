From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3/4] OMAP3 and 4 i2c mark extended reg enums as extended only
Date: Thu, 03 Mar 2011 13:50:37 +0000
Message-ID: <20110303135037.30648.90406.stgit@otae.warmcat.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51839 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab1CCNuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 08:50:40 -0500
Received: by wwb22 with SMTP id 22so1364688wwb.1
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 05:50:39 -0800 (PST)
In-Reply-To: <20110303134744.30648.91218.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Andy Green <andy.green@linaro.org>

The OMAP I2C driver dynamically chooses between two register sets of
differing sizes depending on the cpu type it finds itself on.

It has been observed that the existing code references non-existing
registers on OMAP3530, because while it correctly chose the smaller
register layout based on cpu type, the code uses the probed register
ID to decide if to execute code referencing an extra register, and
both register layout devices on OMAP3530 and OMAP4430 report the same
probed ID of 0x40.

This patch changes the extended register name to make it clearer
they only exist in OMAP4 context

Cc: patches@linaro.org
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 drivers/i2c/busses/i2c-omap.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d6500ec..e09c62d 100644
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
+	OMAP_I2C_OMAP4430_REVNB_LO,
+	OMAP_I2C_OMAP4430_REVNB_HI,
+	OMAP_I2C_OMAP4430_IRQSTATUS_RAW,
+	OMAP_I2C_OMAP4430_IRQENABLE_SET,
+	OMAP_I2C_OMAP4430_IRQENABLE_CLR,
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
+	[OMAP_I2C_OMAP4430_REVNB_LO] = 0x00,
+	[OMAP_I2C_OMAP4430_REVNB_HI] = 0x04,
+	[OMAP_I2C_OMAP4430_IRQSTATUS_RAW] = 0x24,
+	[OMAP_I2C_OMAP4430_IRQENABLE_SET] = 0x2c,
+	[OMAP_I2C_OMAP4430_IRQENABLE_CLR] = 0x30,
 };
 
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -309,7 +310,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
 	if (dev->rev >= OMAP_I2C_REV_ON_4430)
-		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
+		omap_i2c_write_reg(dev, OMAP_I2C_OMAP4430_IRQENABLE_CLR, 1);
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 

