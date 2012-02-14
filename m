From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: [PATCH v2] i2c: fix missing handling of errata I2C_OMAP3_1P153
Date: Tue, 14 Feb 2012 11:15:55 +0100
Message-ID: <4F3A345B.2060308@gmail.com>
References: <1328538811-13097-1-git-send-email-tasskjapp@gmail.com> <1329213583-20839-1-git-send-email-tasskjapp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54909 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab2BNKPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 05:15:35 -0500
In-Reply-To: <1329213583-20839-1-git-send-email-tasskjapp@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

Sorry about the bad mails. First time I use git send-email to follow up 
on a patch, and it seems I need to read up a bit more on it.

Anyway.

This patch is tested on our custom board based on Beagleboard rev C3.

 From 7c1e2c14bccb16c20dc7d93088b12ac6e6e351a3 Mon Sep 17 00:00:00 2001
From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Date: Mon, 6 Feb 2012 14:14:23 +0100
Subject: [PATCH] i2c: fix missing handling of errata I2C_OMAP3_1P153

i2c_prope set the dev->errata flag, but omap_i2c_init cleared the flag 
again. Move the errata handling to i2c_probe.

Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
---
  drivers/i2c/busses/i2c-omap.c |   10 +++++-----
  1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 801df60..d609ae2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -468,11 +468,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
  	/* Take the I2C module out of reset: */
  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);

-	dev->errata = 0;
-
-	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
-		dev->errata |= I2C_OMAP_ERRATA_I207;
-
  	/* Enable interrupts */
  	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
  			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
@@ -1058,6 +1053,11 @@ omap_i2c_probe(struct platform_device *pdev)

  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;

+	dev->errata = 0;
+
+	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
+		dev->errata |= I2C_OMAP_ERRATA_I207;
+
  	if (dev->rev <= OMAP_I2C_REV_ON_3430)
  		dev->errata |= I2C_OMAP3_1P153;

-- 
1.7.5.4


