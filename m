From: imre.deak@solidboot.com
Subject: Re: [PATCH 1/4] Input: ads7846: detect pen up from IRQ state
Date: Wed, 5 Jul 2006 19:18:32 +0300
Message-ID: <20060705161832.GA32247@localdomain>
References: <20060703182931.GA29921@localdomain> <44AA84CC.5020808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <44AA84CC.5020808@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 04, 2006 at 05:10:04PM +0200, Dirk Behme wrote:
> Hi Imre,
> 
> imre.deak@solidboot.com wrote:
> >We can't depend on the pressure value to determine when the pen was
> >lifted, so use the IRQ line state instead.
> 
> Today, Tony pushed the "input: ads7846: can't disable 
> filtering"
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-June/007358.html
> 
> fix from beginning of June.

Uh, I forgot about that and noticed Tony's email about it too late.

> 
> Yesterday, you posted a new patchset "[PATCH 1/1-4] Input: 
> ads7846:". As I understand it, this recent patch set is the 
> clean version of ads7846 and is a replacement for the old 
> workaround now pushed by Tony? Or is it an add on?

The first patch of the set includes that fix. Now that it's pushed I'm
posting an updated version of that first patch. The rest should apply ok.

Thanks,
Imre

[PATCH 1/4] Input: ads7846: detect pen up from IRQ state

We can't depend on the pressure value to determine when the pen was
lifted, so use the IRQ line state instead.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>

---

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4ec7875..94c36b1 100644
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
-
-	spin_lock_irqsave(&ts->lock, flags);
 
-	ts->pendown = (Rt != 0);
 	mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
-
-	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
 static void ads7846_debounce(void *ads)
@@ -520,14 +530,20 @@ static void ads7846_timer(unsigned long 
 
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
