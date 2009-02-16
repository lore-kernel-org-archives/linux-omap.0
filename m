From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 2/2] OMAP: tsc2005: Change state machine to be more stable.
Date: Mon, 16 Feb 2009 15:49:31 +0200
Message-ID: <4602dff1637b96a23837d3552838b20e9a92ceb1.1234789985.git.ext-phil.2.carmody@nokia.com>
References: <>
 <1234792171-4095-1-git-send-email-ext-phil.2.carmody@nokia.com>
 <cad4802ce1266717a82d5bb73118713de1fdfd15.1234789985.git.ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46229 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391AbZBPNwo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 08:52:44 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1GDqVnE027010
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 15:52:42 +0200
In-Reply-To: <cad4802ce1266717a82d5bb73118713de1fdfd15.1234789985.git.ext-phil.2.carmody@nokia.com>
In-Reply-To: <cad4802ce1266717a82d5bb73118713de1fdfd15.1234789985.git.ext-phil.2.carmody@nokia.com>
References: <cad4802ce1266717a82d5bb73118713de1fdfd15.1234789985.git.ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext-phil.2.carmody@nokia.com

Firstly, changed the IRQ mode to PENDAV, which acts as a heartbeat
to keep at least part of the IRQ/SPI sequence active while the pen
is down. Secondly, implemented an IRQ counting scheme so that the
SPI can lag far behind the IRQs. This requires ignoring pen-up
timeouts until you know there are no SPI requests pending. For
additional stability, lengthen the pen-up timeout, and decrease
the rate of the interrupts (increase batch delay).

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/input/touchscreen/tsc2005.c |   56 ++++++++++++++++++++++------------
 1 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index e3e63a5..104ead2 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -145,7 +145,7 @@
 #define TSC2005_CFR1_BATCHDELAY_40MS	(0x0006)
 #define TSC2005_CFR1_BATCHDELAY_100MS	(0x0007)
 
-#define TSC2005_CFR1_INITVALUE	(TSC2005_CFR1_BATCHDELAY_2MS)
+#define TSC2005_CFR1_INITVALUE	(TSC2005_CFR1_BATCHDELAY_4MS)
 
 #define TSC2005_CFR2_MAVE_TEMP	(0x0001)
 #define TSC2005_CFR2_MAVE_AUX	(0x0002)
@@ -160,11 +160,12 @@
 #define TSC2005_CFR2_MEDIUM_7	(0x2000)
 #define TSC2005_CFR2_MEDIUM_15	(0x3000)
 
+#define TSC2005_CFR2_IRQ_MASK   (0xC000)
 #define TSC2005_CFR2_IRQ_DAV	(0x4000)
 #define TSC2005_CFR2_IRQ_PEN	(0x8000)
 #define TSC2005_CFR2_IRQ_PENDAV	(0x0000)
 
-#define TSC2005_CFR2_INITVALUE	(TSC2005_CFR2_IRQ_DAV   |	\
+#define TSC2005_CFR2_INITVALUE	(TSC2005_CFR2_IRQ_PENDAV |	\
 				 TSC2005_CFR2_MAVE_X    |	\
 				 TSC2005_CFR2_MAVE_Y    |	\
 				 TSC2005_CFR2_MAVE_Z    |	\
@@ -174,7 +175,7 @@
 #define MAX_12BIT					((1 << 12) - 1)
 #define TS_SAMPLES					4
 #define TS_RECT_SIZE					8
-#define TSC2005_TS_PENUP_TIME				20
+#define TSC2005_TS_PENUP_TIME				40
 
 static const u32 tsc2005_read_reg[] = {
 	(TSC2005_REG | TSC2005_REG_X | TSC2005_REG_READ) << 16,
@@ -218,7 +219,7 @@ struct tsc2005 {
 	u8			pen_down;
 	u8			disabled;
 	u8			disable_depth;
-	u8			spi_active;
+	u8			spi_pending;
 };
 
 static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
@@ -327,8 +328,8 @@ static void tsc2005_ts_rx(void *arg)
 	ts->avg_z1 = 0;
 	ts->avg_z2 = 0;
 
-		pressure = x * (z2 - z1) / z1;
-		pressure = pressure * ts->x_plate_ohm / 4096;
+	pressure = x * (z2 - z1) / z1;
+	pressure = pressure * ts->x_plate_ohm / 4096;
 
 	pressure_limit = ts->sample_sent? ts->p_max: ts->touch_pressure;
 	if (pressure > pressure_limit)
@@ -352,7 +353,19 @@ static void tsc2005_ts_rx(void *arg)
 		ts->p = pressure;
 	}
 out:
-	ts->spi_active = 0;
+	if (ts->spi_pending > 1) {
+		/* One or more interrupts (sometimes several dozens)
+		 * occured while waiting for the SPI read - get
+		 * another read going.
+		 */
+		ts->spi_pending = 1;
+		if (spi_async(ts->spi, &ts->read_msg)) {
+			dev_err(&ts->spi->dev, "ts: spi_async() failed");
+			ts->spi_pending = 0;
+		}
+	} else
+		ts->spi_pending = 0;
+
 	spin_unlock_irqrestore(&ts->lock, flags);
 
 	/* kick pen up timer - to make sure it expires again(!) */
@@ -364,8 +377,7 @@ out:
 static void tsc2005_ts_penup_timer_handler(unsigned long data)
 {
 	struct tsc2005 *ts = (struct tsc2005 *)data;
-
-	if (ts->sample_sent) {
+	if (!ts->spi_pending && ts->sample_sent) {
 		tsc2005_ts_update_pen_state(ts, 0, 0, 0);
 		ts->sample_sent = 0;
 	}
@@ -373,20 +385,21 @@ static void tsc2005_ts_penup_timer_handler(unsigned long data)
 
 /*
  * This interrupt is called when pen is down and coordinates are
- * available. That is indicated by a falling edge on DAV line.
+ * available. That is indicated by a either:
+ * a) a rising edge on PINTDAV or (PENDAV mode)
+ * b) a falling edge on DAV line (DAV mode)
+ * depending on the setting of the IRQ bits in the CFR2 setting above.
  */
 static irqreturn_t tsc2005_ts_irq_handler(int irq, void *dev_id)
 {
 	struct tsc2005 *ts = dev_id;
-	int r;
-
-	if (ts->spi_active)
-		return IRQ_HANDLED;
 
-	ts->spi_active = 1;
-	r = spi_async(ts->spi, &ts->read_msg);
-	if (r)
-		dev_err(&ts->spi->dev, "ts: spi_async() failed");
+	if (!ts->spi_pending) {
+		if (spi_async(ts->spi, &ts->read_msg))
+			dev_err(&ts->spi->dev, "ts: spi_async() failed");
+	}
+	/* By shifting in 1s we can never wrap */
+	ts->spi_pending = (ts->spi_pending<<1)+1;
 
 	/* kick pen up timer */
 	mod_timer(&ts->penup_timer,
@@ -561,8 +574,11 @@ static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
 	tsc2005_start_scan(ts);
 
 	r = request_irq(ts->spi->irq, tsc2005_ts_irq_handler,
-			IRQF_TRIGGER_FALLING | IRQF_DISABLED |
-			IRQF_SAMPLE_RANDOM, "tsc2005", ts);
+			(((TSC2005_CFR2_INITVALUE & TSC2005_CFR2_IRQ_MASK) ==
+			  TSC2005_CFR2_IRQ_PENDAV)
+			 ? IRQF_TRIGGER_RISING
+			 : IRQF_TRIGGER_FALLING) |
+			IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "tsc2005", ts);
 	if (r < 0) {
 		dev_err(&ts->spi->dev, "unable to get DAV IRQ");
 		goto err2;
-- 
1.5.4.3

