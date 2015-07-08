From: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: core: only use set_scl for bus recovery after calling prepare_recovery
Date: Wed,  8 Jul 2015 16:35:06 +0200
Message-ID: <1436366106-11779-1-git-send-email-jlu@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Using set_scl may be ineffective before calling the driver specific
prepare_recovery callback, which might change into a test mode. So
instead of setting SCL in i2c_generic_scl_recovery, move it to
i2c_generic_recovery (after the optional prepare_recovery).

Signed-off-by: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 069a41f116dd..be992b3e0be8 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -567,6 +567,9 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
 	if (bri->prepare_recovery)
 		bri->prepare_recovery(adap);
 
+	bri->set_scl(adap, val);
+	ndelay(RECOVERY_NDELAY);
+
 	/*
 	 * By this time SCL is high, as we need to give 9 falling-rising edges
 	 */
@@ -597,7 +600,6 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
 
 int i2c_generic_scl_recovery(struct i2c_adapter *adap)
 {
-	adap->bus_recovery_info->set_scl(adap, 1);
 	return i2c_generic_recovery(adap);
 }
 EXPORT_SYMBOL_GPL(i2c_generic_scl_recovery);
-- 
2.1.4
