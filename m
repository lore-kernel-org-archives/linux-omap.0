From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 02/23] i2c: omap: simplify num_bytes handling
Date: Tue, 11 Sep 2012 15:11:57 +0530
Message-ID: <1347356538-23835-3-git-send-email-shubhrajyoti@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46668 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758083Ab2IKJnQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 05:43:16 -0400
In-Reply-To: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Felipe Balbi <balbi@ti.com>

trivial patch, no functional changes

If the fifo is disabled or fifo_size is 0 the num_bytes
is set to 1. Else it is set to fifo_size or in case of a
draining interrupt the remaining bytes in the buff stat.
So the zero check is redundant and can be safely optimised.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2d9b03c..236cb38 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -812,8 +812,7 @@ complete:
 							OMAP_I2C_BUFSTAT_REG)
 							>> 8) & 0x3F;
 			}
-			while (num_bytes) {
-				num_bytes--;
+			while (num_bytes--) {
 				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
 				if (dev->buf_len) {
 					*dev->buf++ = w;
@@ -855,8 +854,7 @@ complete:
 							OMAP_I2C_BUFSTAT_REG)
 							& 0x3F;
 			}
-			while (num_bytes) {
-				num_bytes--;
+			while (num_bytes--) {
 				w = 0;
 				if (dev->buf_len) {
 					w = *dev->buf++;
-- 
1.7.5.4

