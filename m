From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 1/2] I2C: OMAP2/3: Fix scll/sclh calculations
Date: Wed, 27 May 2009 17:54:45 +0300
Message-ID: <1243436086-3623-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24896 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760442AbZE0Oyv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 10:54:51 -0400
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

Fix scll/sclh calculations for HS and fast modes. Currently the driver
uses equal (roughly) low/high times which will result in too short
low time.

OMAP3430 TRM gives the following equations:

	F/S: tLow  = (scll + 7) * internal_clk
	     tHigh = (sclh + 5) * internal_clk
	HS:  tLow  = (scll + 7) * fclk
	     tHigh = (sclh + 5) * fclk

Furthermore, the I2C specification sets the following minimum values
for HS tLow/tHigh for capacitive bus loads 100 pF (maximum speed 3400)
and 400 pF (maximum speed 1700):

	speed	tLow		tHigh
	3400	160 ns		60 ns
	1700	320 ns		120 ns

and for F/S:

	speed	tLow		tHigh
	400	1300 ns		600 ns
	100	4700 ns		4000 ns

By using duty cycles 33/66 (HS, F) and 50/50 (S) we stay above these
minimum values.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9919c08..5d9880c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -343,17 +343,28 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
 		/* If configured for High Speed */
 		if (dev->speed > 400) {
+			unsigned long scl;
+
 			/* For first phase of HS mode */
-			fsscll = internal_clk / (400 * 2) - 6;
-			fssclh = internal_clk / (400 * 2) - 6;
+			scl = internal_clk / 400;
+			fsscll = scl - (scl / 3) - 7;
+			fssclh = (scl / 3) - 5;
 
 			/* For second phase of HS mode */
-			hsscll = fclk_rate / (dev->speed * 2) - 6;
-			hssclh = fclk_rate / (dev->speed * 2) - 6;
+			scl = fclk_rate / dev->speed;
+			hsscll = scl - (scl / 3) - 7;
+			hssclh = (scl / 3) - 5;
+		} else if (dev->speed > 100) {
+			unsigned long scl;
+
+			/* Fast mode */
+			scl = internal_clk / dev->speed;
+			fsscll = scl - (scl / 3) - 7;
+			fssclh = (scl / 3) - 5;
 		} else {
-			/* To handle F/S modes */
-			fsscll = internal_clk / (dev->speed * 2) - 6;
-			fssclh = internal_clk / (dev->speed * 2) - 6;
+			/* Standard mode */
+			fsscll = internal_clk / (dev->speed * 2) - 7;
+			fssclh = internal_clk / (dev->speed * 2) - 5;
 		}
 		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
 		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
-- 
1.5.4.3

