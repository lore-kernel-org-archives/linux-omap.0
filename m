From: tasskjapp@gmail.com
Subject: [PATCH] i2c: fix missing handling of errata I2C_OMAP3_1P153
Date: Mon,  6 Feb 2012 15:33:31 +0100
Message-ID: <1328538811-13097-1-git-send-email-tasskjapp@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47452 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab2BFOdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 09:33:42 -0500
Received: by eaah12 with SMTP id h12so2478053eaa.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Feb 2012 06:33:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tasslehoff Kjappfot <tasskjapp@gmail.com>

From: Tasslehoff Kjappfot <tasskjapp@gmail.com>

i2c_prope set the dev->errata flag, but omap_i2c_init cleared the flag again. Move the errata handling to i2c_init.

Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 801df60..ecaa60d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -473,6 +473,10 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
 		dev->errata |= I2C_OMAP_ERRATA_I207;
 
+	if (dev->rev <= OMAP_I2C_REV_ON_3430)
+		dev->errata |= I2C_OMAP3_1P153;
+
+
 	/* Enable interrupts */
 	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
@@ -1058,9 +1062,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
-	if (dev->rev <= OMAP_I2C_REV_ON_3430)
-		dev->errata |= I2C_OMAP3_1P153;
-
 	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
 		u16 s;
 
-- 
1.7.5.4

