From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 08/10] I2C: OMAP: fix missing handling of errata I2C_OMAP3_1P153
Date: Thu, 19 Apr 2012 18:58:19 +0530
Message-ID: <1334842101-20670-9-git-send-email-shubhrajyoti@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39218 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323Ab2DSN3O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 09:29:14 -0400
In-Reply-To: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Tasslehoff Kjappfot <tasskjapp@gmail.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Tasslehoff Kjappfot <tasskjapp@gmail.com>

i2c_probe set the dev->errata flag, but omap_i2c_init cleared the flag again.
Move the errata handling to i2c_probe.

Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d555dcd..9323201 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -427,11 +427,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
@@ -1023,6 +1018,11 @@ omap_i2c_probe(struct platform_device *pdev)
 
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

