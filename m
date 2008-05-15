From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] Chip message format is either 8-bit cmd or 8-bit cmd + 16-bit data.
Date: Thu, 15 May 2008 18:44:27 +0300
Message-ID: <1210866268-19254-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37629 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYEOPp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 11:45:27 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4FFin4w009107
	for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 10:45:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>

Fix the touchscreen input device name.

No need in msg.spi = ts->spi assignments. It is done in
spi_async called from spi_sync.

No need in driver bus assignment. It is done in spi_driver_register.


Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/input/touchscreen/tsc2005.c |   36 ++++++++++++++++------------------
 1 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 035d209..fa01799 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -54,7 +54,13 @@
  *     during the last 20ms which means the pen has been lifted.
  */
 
-#define TSC2005_HZ	(14000000)
+#define TSC2005_VDD_LOWER_27
+
+#ifdef TSC2005_VDD_LOWER_27
+#define TSC2005_HZ     (10000000)
+#else
+#define TSC2005_HZ     (25000000)
+#endif
 
 #define TSC2005_CMD	(0x80)
 #define TSC2005_REG	(0x00)
@@ -226,13 +232,12 @@ static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
 	struct spi_message msg;
 	struct spi_transfer xfer = { 0 };
 
-	spi_message_init(&msg);
-	msg.spi = ts->spi;
 	xfer.tx_buf = &data;
 	xfer.rx_buf = NULL;
-	xfer.len = 2;
+	xfer.len = 1;
 	xfer.bits_per_word = 8;
 
+	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
 	spi_sync(ts->spi, &msg);
 }
@@ -244,16 +249,15 @@ static void tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
 	struct spi_transfer xfer = { 0 };
 
 	tx = (TSC2005_REG | reg | TSC2005_REG_PND0 |
-	       TSC2005_REG_WRITE) << (2 * 8);
+	       TSC2005_REG_WRITE) << 16;
 	tx |= value;
 
-	spi_message_init(&msg);
-	msg.spi = ts->spi;
 	xfer.tx_buf = &tx;
 	xfer.rx_buf = NULL;
 	xfer.len = 4;
-	xfer.bits_per_word = 3 * 8;
+	xfer.bits_per_word = 24;
 
+	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
 	spi_sync(ts->spi, &msg);
 }
@@ -271,10 +275,10 @@ static void tsc2005_ts_update_pen_state(struct tsc2005 *ts,
 		}
 	} else {
 		input_report_abs(ts->idev, ABS_PRESSURE, 0);
-		if (ts->pen_down)
+		if (ts->pen_down) {
 			input_report_key(ts->idev, BTN_TOUCH, 0);
-
-		ts->pen_down = 0;
+			ts->pen_down = 0;
+		}
 	}
 
 	input_sync(ts->idev);
@@ -377,7 +381,7 @@ static void tsc2005_ts_penup_timer_handler(unsigned long data)
 
 /*
  * This interrupt is called when pen is down and coordinates are
- * available. That is indicated by a falling edge on DEV line.
+ * available. That is indicated by a falling edge on DAV line.
  */
 static irqreturn_t tsc2005_ts_irq_handler(int irq, void *dev_id)
 {
@@ -406,7 +410,6 @@ static void tsc2005_ts_setup_spi_xfer(struct tsc2005 *ts)
 	int i;
 
 	spi_message_init(m);
-	m->spi = ts->spi;
 
 	for (i = 0; i < NUM_READ_REGS; i++, x++) {
 		x->tx_buf = &tsc2005_read_reg[i];
@@ -565,11 +568,7 @@ static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
 		goto err2;
 	}
 
-	/*
-	 * TODO: should be "TSC2005 touchscreen", but X has hardcoded these
-	 * strings and doesn't accept TSC2005 yet...
-	 */
-	idev->name = "TSC2301 touchscreen";
+	idev->name = "TSC2005 touchscreen";
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input-ts",
 		 ts->spi->dev.bus_id);
 	idev->phys = ts->phys;
@@ -709,7 +708,6 @@ static int tsc2005_resume(struct spi_device *spi)
 static struct spi_driver tsc2005_driver = {
 	.driver = {
 		.name = "tsc2005",
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 	},
 #ifdef CONFIG_PM
-- 
1.5.3.7

