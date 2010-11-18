From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-omap: Set latency requirements only once for several messages
Date: Thu, 18 Nov 2010 12:04:20 +0200
Message-ID: <1290074660-2640-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ordinary I2C read consist of two messages. First a write operation
to tell register address and then read operation to get data.
CPU wake up latency is set and removed twice in read case.
Set latency requirement before the message processing loop
and remove the requirement after the loop to remove latency
adjustment operations between the messages.

Signed-off-by: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Acked-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

---
 drivers/i2c/busses/i2c-omap.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b33c785..3e9323e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -616,12 +616,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
 	 */
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
 	r = wait_for_completion_timeout(&dev->cmd_complete,
 					OMAP_I2C_TIMEOUT);
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
 	dev->buf_len = 0;
 	if (r < 0)
 		return r;
@@ -672,12 +668,18 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (r < 0)
 		goto out;
 
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
+
 	for (i = 0; i < num; i++) {
 		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
 		if (r != 0)
 			break;
 	}
 
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->set_mpu_wkup_lat(dev->dev, -1);
+
 	if (r == 0)
 		r = num;
 
-- 
1.6.0.4
