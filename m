From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 10/10] I2C: OMAP: Don't check if wait_for_completion_timeout() returns less than zero
Date: Fri, 10 Feb 2012 19:30:05 +0530
Message-ID: <1328882405-15284-11-git-send-email-shubhrajyoti@ti.com>
References: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60964 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759243Ab2BJOA5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 09:00:57 -0500
In-Reply-To: <1328882405-15284-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khali@linux-fr.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Ben Dooks <ben-linux@fluff.org>, Kevin Hilman <khilman@ti.com>

By definition, wait_for_completion_timeout() returns an unsigned value and
therefore, it is not necessary to check if the return value is less than zero
as this is not possible.

This is based on a patch from Jon Hunter <jon-hunter@ti.com>
Changes from his patch
- Declare a long as the wait_for_completion_timeout returns long.

Cc : Jon Hunter <jon-hunter@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Original patch is
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=ea02cece7b0000bc736e60c4188a11aaa74bc6e6
 drivers/i2c/busses/i2c-omap.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4c5d98f..435d6a7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -501,7 +501,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 			     struct i2c_msg *msg, int stop)
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
-	int r;
+	unsigned long timeout;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
@@ -569,12 +569,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
 	 */
-	r = wait_for_completion_timeout(&dev->cmd_complete,
-					OMAP_I2C_TIMEOUT);
+	timeout = wait_for_completion_timeout(&dev->cmd_complete,
+						OMAP_I2C_TIMEOUT);
 	dev->buf_len = 0;
-	if (r < 0)
-		return r;
-	if (r == 0) {
+	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		omap_i2c_init(dev);
 		omap_i2c_reset(dev);
-- 
1.7.1

