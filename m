From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv10 09/11] I2C: OMAP: Do not set the XUDF(Transmit underflow) if the underflow is not reached
Date: Tue, 29 May 2012 16:26:21 +0530
Message-ID: <1338288983-15026-10-git-send-email-shubhrajyoti@ti.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338288983-15026-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently in the 1.153 errata handling, while waiting for transmitter
underflow, if NACK is got the XUDF(Transmit underflow) flag is also set.
Fix this by setting the XUDF(Transmit underflow) flag after wait for the
condition is over.

Cc: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Acked-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
-v10 Change the punctuation and reword.
-v9 XUDF is expanded to transmit underflow

 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6129cb8..cd6feea 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -730,7 +730,6 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
-			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
 
@@ -743,6 +742,7 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 		return 0;
 	}
 
+	*err |= OMAP_I2C_STAT_XUDF;
 	return 0;
 }
 
-- 
1.7.5.4
