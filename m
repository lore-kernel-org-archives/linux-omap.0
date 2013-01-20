From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] i2c: omap: errata i462: fix incorrect ack for arbitration lost interrupt
Date: Sun, 20 Jan 2013 02:32:58 +0200
Message-ID: <1358641978-9316-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:34419 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab3ATAdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Jan 2013 19:33:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: w.sang@pengutronix.de, ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, balbi@ti.com
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

The errata handling function acks wrong interrupt in case of "Arbitration
lost". Fix it.

Discovered during code review, the real impact of the bug is unknown.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 20d41bf..832f16e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -803,7 +803,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *dev)
 			if (stat & OMAP_I2C_STAT_AL) {
 				dev_err(dev->dev, "Arbitration lost\n");
 				dev->cmd_err |= OMAP_I2C_STAT_AL;
-				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+				omap_i2c_ack_stat(dev, OMAP_I2C_STAT_AL);
 			}
 
 			return -EIO;
-- 
1.7.10.4

