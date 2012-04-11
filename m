From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv7 10/18] I2C: OMAP: Don't check if
 wait_for_completion_timeout() returns less than zero
Date: Wed, 11 Apr 2012 16:42:48 +0530
Message-ID: <1334142776-10583-11-git-send-email-shubhrajyoti@ti.com>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

By definition, wait_for_completion_timeout() returns an unsigned value and
therefore, it is not necessary to check if the return value is less than zero
as this is not possible.

This is based on a patch from Jon Hunter <jon-hunter@ti.com>
Changes from his patch
- Declare a long as the wait_for_completion_timeout returns long.

Original patch is
http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=ea02cece7b0000bc736e60c4188a11aaa74bc6e6

Cc : Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 959e97c..121c52e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -502,7 +502,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 			     struct i2c_msg *msg, int stop)
 {
 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
-	int r;
+	unsigned long timeout;
 	u16 w;
 
 	dev_dbg(dev->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
@@ -570,12 +570,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
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
 		omap_i2c_reset(dev);
 		omap_i2c_init(dev);
-- 
1.7.4.1
