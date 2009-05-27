From: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] I2C: OMAP3: Better noise suppression for fast/standard modes
Date: Wed, 27 May 2009 17:54:46 +0300
Message-ID: <1243436086-3623-2-git-send-email-aaro.koskinen@nokia.com>
References: <>
 <1243436086-3623-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1243436086-3623-1-git-send-email-aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use longer noise filter period for fast and standard mode. Based on an
earlier patch by Eero Nurkkala.

Signed-off-by: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5d9880c..8c76cea 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -333,8 +333,18 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 
-		/* HSI2C controller internal clk rate should be 19.2 Mhz */
-		internal_clk = 19200;
+		/*
+		 * HSI2C controller internal clk rate should be 19.2 Mhz for
+		 * HS and for all modes on 2430. On 34xx we can use lower rate
+		 * to get longer filter period for better noise suppression.
+		 * The filter is iclk (fclk for HS) period.
+		 */
+		if (dev->speed > 400 || cpu_is_omap_2430())
+			internal_clk = 19200;
+		else if (dev->speed > 100)
+			internal_clk = 9600;
+		else
+			internal_clk = 4000;
 		fclk_rate = clk_get_rate(dev->fclk) / 1000;
 
 		/* Compute prescaler divisor */
-- 
1.5.4.3
