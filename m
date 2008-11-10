From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Mon, 10 Nov 2008 12:46:58 +0200
Message-ID: <12263140183960-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64729 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbYKJKsY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 05:48:24 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAAAm70s023971
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 12:48:22 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>


Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9ae3ad3..92653ce 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -304,7 +304,13 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 
 		/* HSI2C controller internal clk rate should be 19.2 Mhz */
-		internal_clk = 19200;
+		if (dev->speed > 400)
+			internal_clk = 19200;
+		else if (dev->speed > 100)
+			internal_clk = 9600;
+		else
+			internal_clk = 4000;
+
 		fclk_rate = clk_get_rate(dev->fclk) / 1000;
 
 		/* Compute prescaler divisor */
@@ -322,8 +328,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			hssclh = fclk_rate / (dev->speed * 2) - 6;
 		} else {
 			/* To handle F/S modes */
-			fsscll = internal_clk / (dev->speed * 2) - 6;
-			fssclh = internal_clk / (dev->speed * 2) - 6;
+			fsscll = internal_clk / (dev->speed * 2) - 7;
+			fssclh = internal_clk / (dev->speed * 2) - 5;
 		}
 		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
 		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
-- 
1.5.2

