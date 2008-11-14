From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] i2c: i2c-omap: Fix standard and fast mode prescalers
Date: Fri, 14 Nov 2008 10:41:57 +0200
Message-ID: <12266521173159-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49419 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbYKNIng (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 03:43:36 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAE8hJw5013276
	for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 10:43:33 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

The prescalers for 100 kHz and 400 kHz mode
are wrong. The internal clock is the fclock
divided by the prescaler. The PSC is an 8 bit
field in omap3430. Moreover, the scll and
sclh values should be adjusted properly.
Having the correct prescaler is important in
the process of getting a finite i2c clock. In
addition, the prescaler is used in the process
of activating the correct noise filter and thus,
lets more error resilient i2c communications.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e708ebd..a42003a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -288,7 +288,17 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 
 		/* HSI2C controller internal clk rate should be 19.2 Mhz */
-		internal_clk = 19200;
+		if (cpu_is_omap34xx()) {
+			if (dev->speed > 400)
+				internal_clk = 19200;
+			else if (dev->speed > 100)
+				internal_clk = 9600;
+			else
+				internal_clk = 4000;
+		} else {
+			internal_clk = 19200;
+		}
+
 		fclk_rate = clk_get_rate(dev->fclk) / 1000;
 
 		/* Compute prescaler divisor */
@@ -306,8 +316,13 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			hssclh = fclk_rate / (dev->speed * 2) - 6;
 		} else {
 			/* To handle F/S modes */
-			fsscll = internal_clk / (dev->speed * 2) - 6;
-			fssclh = internal_clk / (dev->speed * 2) - 6;
+			if (cpu_is_omap34xx()) {
+				fsscll = internal_clk / (dev->speed * 2) - 7;
+				fssclh = internal_clk / (dev->speed * 2) - 5;
+			} else {
+				fsscll = internal_clk / (dev->speed * 2) - 6;
+				fssclh = internal_clk / (dev->speed * 2) - 6;
+			}
 		}
 		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
 		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
-- 
1.6.0

