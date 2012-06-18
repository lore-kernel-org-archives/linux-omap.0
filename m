From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 10/13] I2C: OMAP: simplify num_bytes handling
Date: Mon, 18 Jun 2012 20:00:25 +0530
Message-ID: <1340029828-20751-11-git-send-email-shubhrajyoti@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340029828-20751-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

trivial patch, no functional changes

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Reviewed-by : Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e24eb1f..080193a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -844,8 +844,7 @@ complete:
 							OMAP_I2C_BUFSTAT_REG)
 							>> 8) & 0x3F;
 			}
-			while (num_bytes) {
-				num_bytes--;
+			while (num_bytes--) {
 				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
 				if (dev->buf_len) {
 					*dev->buf++ = w;
@@ -887,8 +886,7 @@ complete:
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
