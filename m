From: Claudio Foellmi <claudio.foellmi@ergon.ch>
Subject: [PATCH] i2c-omap: Trigger bus recovery in lockup case
Date: Thu, 14 Sep 2017 17:39:09 +0200
Message-ID: <1505403549-12992-1-git-send-email-claudio.foellmi@ergon.ch>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

A very conservative check for bus activity (to prevent interference
in multimaster setups) prevented the bus recovery methods from being
triggered in the case that SDA or SCL was stuck low.
This defeats the purpose of the recovery mechanism, which was introduced
for exactly this situation (a slave device keeping SDA pulled down).

Note that bus lockups can persist across reboots. The only other options
are to reset or power cycle the offending slave device, and many i2c
slaves do not even have a reset pin.

If we see that one of the lines is low for the entire timeout duration,
we can actually be sure that there is no other master driving the bus.
It is therefore save for us to attempt a bus recovery.

Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
---
Caveat: It turns out I don't have the hardware to fully test the
recovery mechanism. My faulty i2c slave device actually pulls down SCL,
not SDA (so the recovery will not succeed in my case).
But by directly connecting SDA to ground, I could at least make sure
the recovery function gets called after applying this patch.

 drivers/i2c/busses/i2c-omap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1ebb5e9..4b25fd1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -563,8 +563,13 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
 		}
 
 		if (time_after(jiffies, timeout)) {
+			/*
+			 * SDA or SCL were low for the entire timeout without
+			 * any activity detected. Most likely, a slave is
+			 * locking up the bus with no master driving the clock.
+			 */
 			dev_warn(omap->dev, "timeout waiting for bus ready\n");
-			return -ETIMEDOUT;
+			return i2c_recover_bus(&omap->adapter);
 		}
 
 		msleep(1);
-- 
2.7.4
