From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 13:29:11 -0500
Message-ID: <1434565751-14944-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56641 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418AbbFQScQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 14:32:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wsa@the-dreams.de
Cc: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

With this patch we try to be as close to 50%
duty cycle as possible. The reason for this
is that some devices present an erratic behavior
with certain duty cycles.

One such example is TPS65218 PMIC which fails
to change voltages when running @ 400kHz and
duty cycle is lower than 34%.

The idea of the patch is simple:

calculate desired scl_period from requested scl
and use 50% for tLow and 50% for tHigh.

tLow is calculated with a DIV_ROUND_UP() to make
sure it's slightly higher than tHigh and to make
sure that we end up within I2C specifications.

Kudos to Nishanth Menon and Dave Gerlach for helping
debugging the TPS65218 problem found on AM437x SK.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 88 ++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0e894193accf..194bece83c1d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
@@ -39,6 +40,8 @@
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
 
+#define NSECS_PER_SEC			1000000000
+
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
 
@@ -359,6 +362,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
 	unsigned long internal_clk = 0;
+	unsigned long internal_clk_period = 0;
+	unsigned long scl_period = 0;
 	struct clk *fclk;
 
 	if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
@@ -395,58 +400,79 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	}
 
 	if (!(dev->flags & OMAP_I2C_FLAG_SIMPLE_CLOCK)) {
-
 		/*
 		 * HSI2C controller internal clk rate should be 19.2 Mhz for
-		 * HS and for all modes on 2430. On 34xx we can use lower rate
-		 * to get longer filter period for better noise suppression.
-		 * The filter is iclk (fclk for HS) period.
+		 * HS and for all modes on 2430. For all other devices and
+		 * speeds we will use a 12MHz internal clock.
 		 */
-		if (dev->speed > 400 ||
-			       dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK)
-			internal_clk = 19200;
-		else if (dev->speed > 100)
-			internal_clk = 9600;
-		else
-			internal_clk = 4000;
+		if (dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK ||
+				dev->speed > 400) {
+			internal_clk = 1920000;
+			internal_clk_period = NSECS_PER_SEC /
+				internal_clk; /* ns */
+		} else {
+			internal_clk = 12000000;
+			internal_clk_period = NSECS_PER_SEC /
+				internal_clk; /* ns */
+		}
+
 		fclk = clk_get(dev->dev, "fck");
-		fclk_rate = clk_get_rate(fclk) / 1000;
+		fclk_rate = clk_get_rate(fclk);
 		clk_put(fclk);
 
 		/* Compute prescaler divisor */
 		psc = fclk_rate / internal_clk;
 		psc = psc - 1;
 
+		/*
+		 * Here's the tricky part, we want to make sure our duty cycle
+		 * is as close to 50% as possible. In order to achieve that, we
+		 * will first figure out what's the period on chosen scl is,
+		 * then divide that by two and calculate SCLL and SCLH based on
+		 * that.
+		 *
+		 * SCLL and SCLH equations are as folows:
+		 *
+		 * SCLL = (tLow / iclk_period) - 7;
+		 * SCLH = (tHigh / iclk_period) - 5;
+		 *
+		 * Where iclk_period is period of Internal Clock.
+		 *
+		 * tLow and tHigh will be basically half of scl_period where
+		 * possible as long as we can match I2C spec's minimum limits
+		 * for them.
+		 */
+		scl_period = NSECS_PER_SEC / (dev->speed * 1000);
+
 		/* If configured for High Speed */
 		if (dev->speed > 400) {
-			unsigned long scl;
+			unsigned long fs_period;
+
+			/*
+			 * first phase of HS mode is up to
+			 * 400kHz so we will use that.
+			 */
+			fs_period = NSECS_PER_SEC / 400000;
 
 			/* For first phase of HS mode */
-			scl = internal_clk / 400;
-			fsscll = scl - (scl / 3) - 7;
-			fssclh = (scl / 3) - 5;
+			fsscll = DIV_ROUND_UP(fs_period >> 1,
+					internal_clk_period) - 7;
+			fssclh = (fs_period >> 1) / internal_clk_period - 5;
 
 			/* For second phase of HS mode */
-			scl = fclk_rate / dev->speed;
-			hsscll = scl - (scl / 3) - 7;
-			hssclh = (scl / 3) - 5;
-		} else if (dev->speed > 100) {
-			unsigned long scl;
-
-			/* Fast mode */
-			scl = internal_clk / dev->speed;
-			fsscll = scl - (scl / 3) - 7;
-			fssclh = (scl / 3) - 5;
-		} else {
-			/* Standard mode */
-			fsscll = internal_clk / (dev->speed * 2) - 7;
-			fssclh = internal_clk / (dev->speed * 2) - 5;
+			hsscll = DIV_ROUND_UP(scl_period >> 1,
+					internal_clk_period) - 7;
+			hssclh = (scl_period >> 1) / internal_clk_period - 5;
+		} else  {
+			fsscll = DIV_ROUND_UP(scl_period >> 1,
+					internal_clk_period) - 7;
+			fssclh = (scl_period >> 1) / internal_clk_period - 5;
 		}
 		scll = (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
 		sclh = (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
 	} else {
 		/* Program desired operating rate */
-		fclk_rate /= (psc + 1) * 1000;
+		fclk_rate /= (psc + 1);
 		if (psc > 2)
 			psc = 2;
 		scll = fclk_rate / (dev->speed * 2) - 7 + psc;
-- 
2.4.3

