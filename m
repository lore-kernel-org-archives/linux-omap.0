From: imre.deak@solidboot.com
Subject: [PATCH 1/4] Input: ads7846: detect pen up from IRQ state
Date: Mon, 3 Jul 2006 21:29:31 +0300
Message-ID: <20060703182931.GA29921@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: david-b@pacbell.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

We can't depend on the pressure value to determine when the pen was
lifted, so use the IRQ line state instead.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>

---

 drivers/input/touchscreen/ads7846.c |  112 +++++++++++++++++++----------------
 1 files changed, 62 insertions(+), 50 deletions(-)

dfeac813257ad4941ac35a82f1996d3cd468a07e
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4369845..94c36b1 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -370,6 +370,39 @@ static DEVICE_ATTR(disable, 0664, ads784
 
 /*--------------------------------------------------------------------------*/
 
+static void ads7846_report_pen_state(struct ads7846 *ts, int down)
+{
+	struct input_dev	*input_dev = ts->input;
+
+	input_report_key(input_dev, BTN_TOUCH, down);
+	if (!down)
+		input_report_abs(input_dev, ABS_PRESSURE, 0);
+#ifdef VERBOSE
+	pr_debug("%s: %s\n", ts->spi->dev.bus_id, down ? "DOWN" : "UP");
+#endif
+}
+
+static void ads7846_report_pen_position(struct ads7846 *ts, int x, int y,
+					int pressure)
+{
+	struct input_dev	*input_dev = ts->input;
+
+	input_report_abs(input_dev, ABS_X, x);
+	input_report_abs(input_dev, ABS_Y, y);
+	input_report_abs(input_dev, ABS_PRESSURE, pressure);
+
+#ifdef VERBOSE
+	pr_debug("%s: %d/%d/%d\n", ts->spi->dev.bus_id, x, y, pressure);
+#endif
+}
+
+static void ads7846_sync_events(struct ads7846 *ts)
+{
+	struct input_dev	*input_dev = ts->input;
+
+	input_sync(input_dev);
+}
+
 /*
  * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
  * to retrieve touchscreen status.
@@ -381,11 +414,8 @@ static DEVICE_ATTR(disable, 0664, ads784
 static void ads7846_rx(void *ads)
 {
 	struct ads7846		*ts = ads;
-	struct input_dev	*input_dev = ts->input;
 	unsigned		Rt;
-	unsigned		sync = 0;
 	u16			x, y, z1, z2;
-	unsigned long		flags;
 
 	/* adjust:  on-wire is a must-ignore bit, a BE12 value, then padding;
 	 * built from two 8 bit values written msb-first.
@@ -399,7 +429,7 @@ static void ads7846_rx(void *ads)
 	if (x == MAX_12BIT)
 		x = 0;
 
-	if (likely(x && z1 && !device_suspended(&ts->spi->dev))) {
+	if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
 		Rt -= z1;
@@ -414,51 +444,31 @@ static void ads7846_rx(void *ads)
 	* the maximum. Don't report it to user space, repeat at least
 	* once more the measurement */
 	if (ts->tc.ignore || Rt > ts->pressure_max) {
+#ifdef VERBOSE
+		pr_debug("%s: ignored %d pressure %d\n",
+			ts->spi->dev.bus_id, ts->tc.ignore, Rt);
+#endif
 		mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
 		return;
 	}
 
-	/* NOTE:  "pendown" is inferred from pressure; we don't rely on
-	 * being able to check nPENIRQ status, or "friendly" trigger modes
-	 * (both-edges is much better than just-falling or low-level).
-	 *
-	 * REVISIT:  some boards may require reading nPENIRQ; it's
-	 * needed on 7843.  and 7845 reads pressure differently...
-	 *
-	 * REVISIT:  the touchscreen might not be connected; this code
-	 * won't notice that, even if nPENIRQ never fires ...
+	/* NOTE: We can't rely on the pressure to determine the pen down
+	 * state. The pressure value can fluctuate for quite a while
+	 * after lifting the pen and in some cases may not even settle at
+	 * the expected value. The only safe way to check for the pen up
+	 * condition is in the timer by reading the pen IRQ state.
 	 */
-	if (!ts->pendown && Rt != 0) {
-		input_report_key(input_dev, BTN_TOUCH, 1);
-		sync = 1;
-	} else if (ts->pendown && Rt == 0) {
-		input_report_key(input_dev, BTN_TOUCH, 0);
-		sync = 1;
-	}
-
 	if (Rt) {
-		input_report_abs(input_dev, ABS_X, x);
-		input_report_abs(input_dev, ABS_Y, y);
-		sync = 1;
-	}
-
-	if (sync) {
-		input_report_abs(input_dev, ABS_PRESSURE, Rt);
-		input_sync(input_dev);
+		if (!ts->pendown) {
+			ads7846_report_pen_state(ts, 1);
+			ts->pendown = 1;
+		}
+		ads7846_report_pen_position(ts, x, y, Rt);
+		ads7846_sync_events(ts);
 	}
 
-#ifdef	VERBOSE
-	if (Rt || ts->pendown)
-		pr_debug("%s: %d/%d/%d%s\n", ts->spi->dev.bus_id,
-			x, y, Rt, Rt ? "" : " UP");
-#endif
 
-	spin_lock_irqsave(&ts->lock, flags);
-
-	ts->pendown = (Rt != 0);
 	mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
-
-	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
 static void ads7846_debounce(void *ads)
@@ -472,7 +482,8 @@ static void ads7846_debounce(void *ads)
 	m = &ts->msg[ts->msg_idx];
 	t = list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
 	val = (be16_to_cpu(*(__be16 *)t->rx_buf) >> 3) & 0x0fff;
-	if (!ts->read_cnt || (abs(ts->last_read - val) > ts->debounce_tol)) {
+	if (ts->debounce_max && (
+	    !ts->read_cnt || (abs(ts->last_read - val) > ts->debounce_tol))) {
 		/* Repeat it, if this was the first read or the read
 		 * wasn't consistent enough. */
 		if (ts->read_cnt < ts->debounce_max) {
@@ -519,14 +530,20 @@ static void ads7846_timer(unsigned long 
 
 	spin_lock_irq(&ts->lock);
 
-	if (unlikely(ts->msg_idx && !ts->pendown)) {
+	if (unlikely(!ts->get_pendown_state() ||
+		     device_suspended(&ts->spi->dev))) {
+		if (ts->pendown) {
+			ads7846_report_pen_state(ts, 0);
+			ads7846_sync_events(ts);
+			ts->pendown = 0;
+		}
+
 		/* measurment cycle ended */
 		if (!device_suspended(&ts->spi->dev)) {
 			ts->irq_disabled = 0;
 			enable_irq(ts->spi->irq);
 		}
 		ts->pending = 0;
-		ts->msg_idx = 0;
 	} else {
 		/* pen is still down, continue with the measurement */
 		ts->msg_idx = 0;
@@ -702,14 +719,9 @@ static int __devinit ads7846_probe(struc
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
 	ts->pressure_max = pdata->pressure_max ? : ~0;
-	if (pdata->debounce_max) {
-		ts->debounce_max = pdata->debounce_max;
-		ts->debounce_tol = pdata->debounce_tol;
-		ts->debounce_rep = pdata->debounce_rep;
-		if (ts->debounce_rep > ts->debounce_max + 1)
-			ts->debounce_rep = ts->debounce_max - 1;
-	} else
-		ts->debounce_tol = ~0;
+	ts->debounce_max = pdata->debounce_max;
+	ts->debounce_tol = pdata->debounce_tol;
+	ts->debounce_rep = pdata->debounce_rep;
 	ts->get_pendown_state = pdata->get_pendown_state;
 
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", spi->dev.bus_id);
-- 
1.2.3.g90cc1-dirty
