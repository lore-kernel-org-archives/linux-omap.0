From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 03/24] i2c: omap: decrease indentation level on data handling
Date: Thu, 16 Aug 2012 19:33:34 +0530
Message-ID: <1345125835-15524-4-git-send-email-shubhrajyoti@ti.com>
References: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36375 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932671Ab2HPOFA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 10:05:00 -0400
In-Reply-To: <1345125835-15524-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

The patch intends to decrease the indentation level on the
data handling
by using the fact that else of if (dev->buf_len) is same as
if (!dev->buf_len)

if (dev->buf_len) {
	aaa;
} else {
	bbb;
	break;
}

to

if (!dev->buf_len) {
        bbb;
        break;
}
aaa;

Hence no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   63 ++++++++++++++++++++---------------------
 1 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9b003a3..81ef0a7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -813,22 +813,7 @@ complete:
 							>> 8) & 0x3F;
 			}
 			while (num_bytes--) {
-				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
-				if (dev->buf_len) {
-					*dev->buf++ = w;
-					dev->buf_len--;
-					/*
-					 * Data reg in 2430, omap3 and
-					 * omap4 is 8 bit wide
-					 */
-					if (dev->flags &
-						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
-						if (dev->buf_len) {
-							*dev->buf++ = w >> 8;
-							dev->buf_len--;
-						}
-					}
-				} else {
+				if (!dev->buf_len) {
 					if (stat & OMAP_I2C_STAT_RRDY)
 						dev_err(dev->dev,
 							"RRDY IRQ while no data"
@@ -839,6 +824,21 @@ complete:
 								" requested\n");
 					break;
 				}
+
+				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
+				*dev->buf++ = w;
+				dev->buf_len--;
+				/*
+				 * Data reg in 2430, omap3 and
+				 * omap4 is 8 bit wide
+				 */
+				if (dev->flags &
+						OMAP_I2C_FLAG_16BIT_DATA_REG) {
+					if (dev->buf_len) {
+						*dev->buf++ = w >> 8;
+						dev->buf_len--;
+					}
+				}
 			}
 			omap_i2c_ack_stat(dev,
 				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
@@ -855,22 +855,7 @@ complete:
 							& 0x3F;
 			}
 			while (num_bytes--) {
-				w = 0;
-				if (dev->buf_len) {
-					w = *dev->buf++;
-					dev->buf_len--;
-					/*
-					 * Data reg in 2430, omap3 and
-					 * omap4 is 8 bit wide
-					 */
-					if (dev->flags &
-						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
-						if (dev->buf_len) {
-							w |= *dev->buf++ << 8;
-							dev->buf_len--;
-						}
-					}
-				} else {
+				if (!dev->buf_len) {
 					if (stat & OMAP_I2C_STAT_XRDY)
 						dev_err(dev->dev,
 							"XRDY IRQ while no "
@@ -882,6 +867,20 @@ complete:
 					break;
 				}
 
+				w = *dev->buf++;
+				dev->buf_len--;
+				/*
+				 * Data reg in 2430, omap3 and
+				 * omap4 is 8 bit wide
+				 */
+				if (dev->flags &
+						OMAP_I2C_FLAG_16BIT_DATA_REG) {
+					if (dev->buf_len) {
+						w |= *dev->buf++ << 8;
+						dev->buf_len--;
+					}
+				}
+
 				if ((dev->errata & I2C_OMAP_ERRATA_I462) &&
 				    errata_omap3_i462(dev, &stat, &err))
 					goto complete;
-- 
1.7.5.4

