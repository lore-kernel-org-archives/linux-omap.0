From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] Fix for the touchscreen driver
Date: Sun, 04 Mar 2007 21:24:45 +0100
Message-ID: <85mz2sdaeq.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--=-=-=


This patch is reintroducing the changes lost in the touchscreen
driver.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=ts.patch

---
 drivers/input/touchscreen/ads7846.c |  542 	334 +	208 -	0 !
 include/linux/spi/ads7846.h         |   12 	12 +	0 -	0 !
 2 files changed, 346 insertions(+), 208 deletions(-)

Index: linux-omap-2.6/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-omap-2.6.orig/drivers/input/touchscreen/ads7846.c	2007-03-03 21:05:29.000000000 +0100
+++ linux-omap-2.6/drivers/input/touchscreen/ads7846.c	2007-03-03 21:05:33.000000000 +0100
@@ -17,8 +17,9 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-#include <linux/device.h>
+#include <linux/hwmon.h>
 #include <linux/init.h>
+#include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
@@ -54,7 +55,8 @@
  * files.
  */
 
-#define	TS_POLL_PERIOD	msecs_to_jiffies(10)
+#define TS_POLL_DELAY	(1 * 1000000)	/* ns delay before the first sample */
+#define	TS_POLL_PERIOD	(5 * 1000000)	/* ns delay between samples */
 
 /* this driver doesn't aim at the peak continuous sample rate */
 #define	SAMPLE_BITS	(8 /*cmd*/ + 16 /*sample*/ + 2 /* before, after */)
@@ -76,7 +78,7 @@ struct ads7846 {
 	char			phys[32];
 
 	struct spi_device	*spi;
-	struct attribute_group	*attr_group;
+	struct class_device	*hwmon;
 	u16			model;
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
@@ -99,13 +101,16 @@ struct ads7846 {
 	u16			debounce_rep;
 
 	spinlock_t		lock;
-	struct timer_list	timer;		/* P: lock */
+	struct hrtimer		timer;
 	unsigned		pendown:1;	/* P: lock */
 	unsigned		pending:1;	/* P: lock */
 // FIXME remove "irq_disabled"
 	unsigned		irq_disabled:1;	/* P: lock */
 	unsigned		disabled:1;
 
+	int			(*filter)(void *data, int data_idx, int *val);
+	void			*filter_data;
+	void			(*filter_cleanup)(void *data);
 	int			(*get_pendown_state)(void);
 };
 
@@ -142,15 +147,16 @@ struct ads7846 {
 #define	MAX_12BIT	((1<<12)-1)
 
 /* leave ADC powered up (disables penirq) between differential samples */
-#define	READ_12BIT_DFR(x) (ADS_START | ADS_A2A1A0_d_ ## x \
-	| ADS_12_BIT | ADS_DFR)
+#define	READ_12BIT_DFR(x, adc, vref) (ADS_START | ADS_A2A1A0_d_ ## x \
+	| ADS_12_BIT | ADS_DFR | \
+	(adc ? ADS_PD10_ADC_ON : 0) | (vref ? ADS_PD10_REF_ON : 0))
+
+#define	READ_Y(vref)	(READ_12BIT_DFR(y,  1, vref))
+#define	READ_Z1(vref)	(READ_12BIT_DFR(z1, 1, vref))
+#define	READ_Z2(vref)	(READ_12BIT_DFR(z2, 1, vref))
 
-#define	READ_Y	(READ_12BIT_DFR(y)  | ADS_PD10_ADC_ON)
-#define	READ_Z1	(READ_12BIT_DFR(z1) | ADS_PD10_ADC_ON)
-#define	READ_Z2	(READ_12BIT_DFR(z2) | ADS_PD10_ADC_ON)
-
-#define	READ_X	(READ_12BIT_DFR(x)  | ADS_PD10_ADC_ON)
-#define	PWRDOWN	(READ_12BIT_DFR(y)  | ADS_PD10_PDOWN)	/* LAST */
+#define	READ_X(vref)	(READ_12BIT_DFR(x,  1, vref))
+#define	PWRDOWN		(READ_12BIT_DFR(y,  0, 0))	/* LAST */
 
 /* single-ended samples need to first power up reference voltage;
  * we leave both ADC and VREF powered
@@ -158,14 +164,19 @@ struct ads7846 {
 #define	READ_12BIT_SER(x) (ADS_START | ADS_A2A1A0_ ## x \
 	| ADS_12_BIT | ADS_SER)
 
-#define	REF_ON	(READ_12BIT_DFR(x) | ADS_PD10_ALL_ON)
-#define	REF_OFF	(READ_12BIT_DFR(y) | ADS_PD10_PDOWN)
+#define	REF_ON	(READ_12BIT_DFR(x, 1, 1))
+#define	REF_OFF	(READ_12BIT_DFR(y, 0, 0))
 
 /*--------------------------------------------------------------------------*/
 
 /*
  * Non-touchscreen sensors only use single-ended conversions.
+ * The range is GND..vREF. The ads7843 and ads7835 must use external vREF;
+ * ads7846 lets that pin be unconnected, to use internal vREF.
+ *
+ * FIXME make external vREF_mV be a module option, and use that as needed...
  */
+static const unsigned vREF_mV = 2500;
 
 struct ser_req {
 	u8			ref_on;
@@ -193,50 +204,55 @@ static int ads7846_read12_ser(struct dev
 	struct ser_req		*req = kzalloc(sizeof *req, GFP_KERNEL);
 	int			status;
 	int			sample;
-	int			i;
+	int			use_internal;
 
 	if (!req)
 		return -ENOMEM;
 
 	spi_message_init(&req->msg);
 
-	/* activate reference, so it has time to settle; */
-	req->ref_on = REF_ON;
-	req->xfer[0].tx_buf = &req->ref_on;
-	req->xfer[0].len = 1;
-	req->xfer[1].rx_buf = &req->scratch;
-	req->xfer[1].len = 2;
-
-	/*
-	 * for external VREF, 0 usec (and assume it's always on);
-	 * for 1uF, use 800 usec;
-	 * no cap, 100 usec.
-	 */
-	req->xfer[1].delay_usecs = ts->vref_delay_usecs;
+	/* FIXME boards with ads7846 might use external vref instead ... */
+	use_internal = (ts->model == 7846);
+
+	/* maybe turn on internal vREF, and let it settle */
+	if (use_internal) {
+		req->ref_on = REF_ON;
+		req->xfer[0].tx_buf = &req->ref_on;
+		req->xfer[0].len = 1;
+		spi_message_add_tail(&req->xfer[0], &req->msg);
+
+		req->xfer[1].rx_buf = &req->scratch;
+		req->xfer[1].len = 2;
+
+		/* for 1uF, settle for 800 usec; no cap, 100 usec.  */
+		req->xfer[1].delay_usecs = ts->vref_delay_usecs;
+		spi_message_add_tail(&req->xfer[1], &req->msg);
+	}
 
 	/* take sample */
 	req->command = (u8) command;
 	req->xfer[2].tx_buf = &req->command;
 	req->xfer[2].len = 1;
+	spi_message_add_tail(&req->xfer[2], &req->msg);
+
 	req->xfer[3].rx_buf = &req->sample;
 	req->xfer[3].len = 2;
+	spi_message_add_tail(&req->xfer[3], &req->msg);
 
 	/* REVISIT:  take a few more samples, and compare ... */
 
-	/* turn off reference */
-	req->ref_off = REF_OFF;
-	req->xfer[4].tx_buf = &req->ref_off;
-	req->xfer[4].len = 1;
-	req->xfer[5].rx_buf = &req->scratch;
-	req->xfer[5].len = 2;
-
-	CS_CHANGE(req->xfer[5]);
-
-	/* group all the transfers together, so we can't interfere with
-	 * reading touchscreen state; disable penirq while sampling
-	 */
-	for (i = 0; i < 6; i++)
-		spi_message_add_tail(&req->xfer[i], &req->msg);
+	/* maybe off internal vREF */
+	if (use_internal) {
+		req->ref_off = REF_OFF;
+		req->xfer[4].tx_buf = &req->ref_off;
+		req->xfer[4].len = 1;
+		spi_message_add_tail(&req->xfer[4], &req->msg);
+
+		req->xfer[5].rx_buf = &req->scratch;
+		req->xfer[5].len = 2;
+		CS_CHANGE(req->xfer[5]);
+		spi_message_add_tail(&req->xfer[5], &req->msg);
+	}
 
 	ts->irq_disabled = 1;
 	disable_irq(spi->irq);
@@ -256,21 +272,60 @@ static int ads7846_read12_ser(struct dev
 	return status ? status : sample;
 }
 
-#define SHOW(name) static ssize_t \
+#define SHOW(name,var,adjust) static ssize_t \
 name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
+	struct ads7846 *ts = dev_get_drvdata(dev); \
 	ssize_t v = ads7846_read12_ser(dev, \
-			READ_12BIT_SER(name) | ADS_PD10_ALL_ON); \
+			READ_12BIT_SER(var) | ADS_PD10_ALL_ON); \
 	if (v < 0) \
 		return v; \
-	return sprintf(buf, "%u\n", (unsigned) v); \
+	return sprintf(buf, "%u\n", adjust(ts, v)); \
 } \
 static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
 
-SHOW(temp0)
-SHOW(temp1)
-SHOW(vaux)
-SHOW(vbatt)
+
+/* Sysfs conventions report temperatures in millidegrees Celcius.
+ * We could use the low-accuracy two-sample scheme, but can't do the high
+ * accuracy scheme without calibration data.  For now we won't try either;
+ * userspace sees raw sensor values, and must scale appropriately.
+ */
+static inline unsigned null_adjust(struct ads7846 *ts, ssize_t v)
+{
+	return v;
+}
+
+SHOW(temp0, temp0, null_adjust)		// temp1_input
+SHOW(temp1, temp1, null_adjust)		// temp2_input
+
+
+/* sysfs conventions report voltages in millivolts.  We can convert voltages
+ * if we know vREF.  userspace may need to scale vAUX to match the board's
+ * external resistors; we assume that vBATT only uses the internal ones.
+ */
+static inline unsigned vaux_adjust(struct ads7846 *ts, ssize_t v)
+{
+	unsigned retval = v;
+
+	/* external resistors may scale vAUX into 0..vREF */
+	retval *= vREF_mV;
+	retval = retval >> 12;
+	return retval;
+}
+
+static inline unsigned vbatt_adjust(struct ads7846 *ts, ssize_t v)
+{
+	unsigned retval = vaux_adjust(ts, v);
+
+	/* ads7846 has a resistor ladder to scale this signal down */
+	if (ts->model == 7846)
+		retval *= 4;
+	return retval;
+}
+
+SHOW(in0_input, vaux, vaux_adjust)
+SHOW(in1_input, vbatt, vbatt_adjust)
+
 
 static int is_pen_down(struct device *dev)
 {
@@ -318,49 +373,40 @@ static ssize_t ads7846_disable_store(str
 
 static DEVICE_ATTR(disable, 0664, ads7846_disable_show, ads7846_disable_store);
 
-static struct attribute *ads7846_attributes[] = {
-	&dev_attr_temp0.attr,
-	&dev_attr_temp1.attr,
-	&dev_attr_vbatt.attr,
-	&dev_attr_vaux.attr,
-	&dev_attr_pen_down.attr,
-	&dev_attr_disable.attr,
-	NULL,
-};
+/*--------------------------------------------------------------------------*/
 
-static struct attribute_group ads7846_attr_group = {
-	.attrs = ads7846_attributes,
-};
+static void ads7846_report_pen_state(struct ads7846 *ts, int down)
+{
+	struct input_dev	*input_dev = ts->input;
 
-/*
- * ads7843/7845 don't have temperature sensors, and
- * use the other sensors a bit differently too
- */
+	input_report_key(input_dev, BTN_TOUCH, down);
+	if (!down)
+		input_report_abs(input_dev, ABS_PRESSURE, 0);
+#ifdef VERBOSE
+	pr_debug("%s: %s\n", ts->spi->dev.bus_id, down ? "DOWN" : "UP");
+#endif
+}
 
-static struct attribute *ads7843_attributes[] = {
-	&dev_attr_vbatt.attr,
-	&dev_attr_vaux.attr,
-	&dev_attr_pen_down.attr,
-	&dev_attr_disable.attr,
-	NULL,
-};
+static void ads7846_report_pen_position(struct ads7846 *ts, int x, int y,
+					int pressure)
+{
+	struct input_dev	*input_dev = ts->input;
 
-static struct attribute_group ads7843_attr_group = {
-	.attrs = ads7843_attributes,
-};
+	input_report_abs(input_dev, ABS_X, x);
+	input_report_abs(input_dev, ABS_Y, y);
+	input_report_abs(input_dev, ABS_PRESSURE, pressure);
 
-static struct attribute *ads7845_attributes[] = {
-	&dev_attr_vaux.attr,
-	&dev_attr_pen_down.attr,
-	&dev_attr_disable.attr,
-	NULL,
-};
+#ifdef VERBOSE
+	pr_debug("%s: %d/%d/%d\n", ts->spi->dev.bus_id, x, y, pressure);
+#endif
+}
 
-static struct attribute_group ads7845_attr_group = {
-	.attrs = ads7845_attributes,
-};
+static void ads7846_sync_events(struct ads7846 *ts)
+{
+	struct input_dev	*input_dev = ts->input;
 
-/*--------------------------------------------------------------------------*/
+	input_sync(input_dev);
+}
 
 /*
  * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
@@ -373,25 +419,22 @@ static struct attribute_group ads7845_at
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
 	 */
-	x = (be16_to_cpu(ts->tc.x) >> 3) & 0x0fff;
-	y = (be16_to_cpu(ts->tc.y) >> 3) & 0x0fff;
-	z1 = (be16_to_cpu(ts->tc.z1) >> 3) & 0x0fff;
-	z2 = (be16_to_cpu(ts->tc.z2) >> 3) & 0x0fff;
+	x = ts->tc.x;
+	y = ts->tc.y;
+	z1 = ts->tc.z1;
+	z2 = ts->tc.z2;
 
 	/* range filtering */
 	if (x == MAX_12BIT)
 		x = 0;
 
-	if (likely(x && z1 && !device_suspended(&ts->spi->dev))) {
+	if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
 		Rt -= z1;
@@ -406,97 +449,108 @@ static void ads7846_rx(void *ads)
 	* the maximum. Don't report it to user space, repeat at least
 	* once more the measurement */
 	if (ts->tc.ignore || Rt > ts->pressure_max) {
-		mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
+#ifdef VERBOSE
+		pr_debug("%s: ignored %d pressure %d\n",
+			ts->spi->dev.bus_id, ts->tc.ignore, Rt);
+#endif
+		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
+			      HRTIMER_MODE_REL);
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
-
-	ts->pendown = (Rt != 0);
-	mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
-
-	spin_unlock_irqrestore(&ts->lock, flags);
+	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD), HRTIMER_MODE_REL);
 }
 
-static void ads7846_debounce(void *ads)
+static int ads7846_debounce(void *ads, int data_idx, int *val)
 {
 	struct ads7846		*ts = ads;
-	struct spi_message	*m;
-	struct spi_transfer	*t;
-	int			val;
-	int			status;
 
-	m = &ts->msg[ts->msg_idx];
-	t = list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
-	val = (be16_to_cpu(*(__be16 *)t->rx_buf) >> 3) & 0x0fff;
-	if (!ts->read_cnt || (abs(ts->last_read - val) > ts->debounce_tol)) {
+	if (!ts->read_cnt || (abs(ts->last_read - *val) > ts->debounce_tol)) {
+		/* Start over collecting consistent readings. */
+		ts->read_rep = 0;
 		/* Repeat it, if this was the first read or the read
 		 * wasn't consistent enough. */
 		if (ts->read_cnt < ts->debounce_max) {
-			ts->last_read = val;
+			ts->last_read = *val;
 			ts->read_cnt++;
+			return ADS7846_FILTER_REPEAT;
 		} else {
 			/* Maximum number of debouncing reached and still
 			 * not enough number of consistent readings. Abort
 			 * the whole sample, repeat it in the next sampling
 			 * period.
 			 */
-			ts->tc.ignore = 1;
 			ts->read_cnt = 0;
-			/* Last message will contain ads7846_rx() as the
-			 * completion function.
-			 */
-			m = ts->last_msg;
+			return ADS7846_FILTER_IGNORE;
 		}
-		/* Start over collecting consistent readings. */
-		ts->read_rep = 0;
 	} else {
 		if (++ts->read_rep > ts->debounce_rep) {
 			/* Got a good reading for this coordinate,
 			 * go for the next one. */
-			ts->tc.ignore = 0;
-			ts->msg_idx++;
 			ts->read_cnt = 0;
 			ts->read_rep = 0;
-			m++;
-		} else
+			return ADS7846_FILTER_OK;
+		} else {
 			/* Read more values that are consistent. */
 			ts->read_cnt++;
+			return ADS7846_FILTER_REPEAT;
+		}
+	}
+}
+
+static int ads7846_no_filter(void *ads, int data_idx, int *val)
+{
+	return ADS7846_FILTER_OK;
+}
+
+static void ads7846_rx_val(void *ads)
+{
+	struct ads7846 *ts = ads;
+	struct spi_message *m;
+	struct spi_transfer *t;
+	u16 *rx_val;
+	int val;
+	int action;
+	int status;
+
+	m = &ts->msg[ts->msg_idx];
+	t = list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
+	rx_val = (u16 *)t->rx_buf;
+	val = be16_to_cpu(*rx_val) >> 3;
+
+	action = ts->filter(ts->filter_data, ts->msg_idx, &val);
+	switch (action) {
+	case ADS7846_FILTER_REPEAT:
+		break;
+	case ADS7846_FILTER_IGNORE:
+		ts->tc.ignore = 1;
+		/* Last message will contain ads7846_rx() as the
+		 * completion function.
+		 */
+		m = ts->last_msg;
+		break;
+	case ADS7846_FILTER_OK:
+		*rx_val = val;
+		ts->tc.ignore = 0;
+		m = &ts->msg[++ts->msg_idx];
+		break;
+	default:
+		BUG();
 	}
 	status = spi_async(ts->spi, m);
 	if (status)
@@ -504,21 +558,27 @@ static void ads7846_debounce(void *ads)
 				status);
 }
 
-static void ads7846_timer(unsigned long handle)
+static enum hrtimer_restart ads7846_timer(struct hrtimer *handle)
 {
-	struct ads7846	*ts = (void *)handle;
+	struct ads7846	*ts = container_of(handle, struct ads7846, timer);
 	int		status = 0;
 
 	spin_lock_irq(&ts->lock);
 
-	if (unlikely(ts->msg_idx && !ts->pendown)) {
-		/* measurement cycle ended */
+	if (unlikely(!ts->get_pendown_state() ||
+		     device_suspended(&ts->spi->dev))) {
+		if (ts->pendown) {
+			ads7846_report_pen_state(ts, 0);
+			ads7846_sync_events(ts);
+			ts->pendown = 0;
+		}
+
+		/* measurment cycle ended */
 		if (!device_suspended(&ts->spi->dev)) {
 			ts->irq_disabled = 0;
 			enable_irq(ts->spi->irq);
 		}
 		ts->pending = 0;
-		ts->msg_idx = 0;
 	} else {
 		/* pen is still down, continue with the measurement */
 		ts->msg_idx = 0;
@@ -528,6 +588,7 @@ static void ads7846_timer(unsigned long 
 	}
 
 	spin_unlock_irq(&ts->lock);
+	return HRTIMER_NORESTART;
 }
 
 static irqreturn_t ads7846_irq(int irq, void *handle)
@@ -538,15 +599,17 @@ static irqreturn_t ads7846_irq(int irq, 
 	spin_lock_irqsave(&ts->lock, flags);
 	if (likely(ts->get_pendown_state())) {
 		if (!ts->irq_disabled) {
-			/* The ARM do_simple_IRQ() dispatcher doesn't act
-			 * like the other dispatchers:  it will report IRQs
-			 * even after they've been disabled.  We work around
-			 * that here.  (The "generic irq" framework may help...)
+			/* REVISIT irq logic for many ARM chips has cloned a
+			 * bug wherein disabling an irq in its handler won't
+			 * work;(it's disabled lazily, and too late to work.
+			 * until all their irq logic is fixed, we must shadow
+			 * that state here.
 			 */
 			ts->irq_disabled = 1;
 			disable_irq(ts->spi->irq);
 			ts->pending = 1;
-			mod_timer(&ts->timer, jiffies);
+			hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
+					HRTIMER_MODE_REL);
 		}
 	}
 	spin_unlock_irqrestore(&ts->lock, flags);
@@ -629,9 +692,11 @@ static int __devinit ads7846_probe(struc
 {
 	struct ads7846			*ts;
 	struct input_dev		*input_dev;
+	struct class_device		*hwmon = ERR_PTR(-ENOMEM);
 	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_message		*m;
 	struct spi_transfer		*x;
+	int				vref;
 	int				err;
 
 	if (!spi->irq) {
@@ -651,36 +716,38 @@ static int __devinit ads7846_probe(struc
 		return -EINVAL;
 	}
 
-	/* REVISIT when the irq can be triggered active-low, or if for some
-	 * reason the touchscreen isn't hooked up, we don't need to access
-	 * the pendown state.
-	 */
 	if (pdata->get_pendown_state == NULL) {
 		dev_dbg(&spi->dev, "no get_pendown_state function?\n");
 		return -EINVAL;
 	}
 
-	/* We'd set TX wordsize 8 bits and RX wordsize to 13 bits ... except
-	 * that even if the hardware can do that, the SPI controller driver
-	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
+	/* We'd set the wordsize to 12 bits ... except that some controllers
+	 * will then treat the 8 bit command words as 12 bits (and drop the
+	 * four MSBs of the 12 bit result).  Result: inputs must be shifted
+	 * to discard the four garbage LSBs.  (Also, not all controllers can
+	 * support 12 bit words.)
 	 */
-	spi->bits_per_word = 8;
 
 	ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL);
 	input_dev = input_allocate_device();
-	if (!ts || !input_dev) {
+	hwmon = hwmon_device_register(&spi->dev);
+	if (!ts || !input_dev || IS_ERR(hwmon)) {
 		err = -ENOMEM;
 		goto err_free_mem;
 	}
 
 	dev_set_drvdata(&spi->dev, ts);
 	spi->dev.power.power_state = PMSG_ON;
+	spi->mode = SPI_MODE_1;
+	err = spi_setup(spi);
+	if (err < 0)
+		goto err_free_mem;
 
 	ts->spi = spi;
 	ts->input = input_dev;
+	ts->hwmon = hwmon;
 
-	init_timer(&ts->timer);
-	ts->timer.data = (unsigned long) ts;
+	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ts->timer.function = ads7846_timer;
 
 	spin_lock_init(&ts->lock);
@@ -689,14 +756,25 @@ static int __devinit ads7846_probe(struc
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
 	ts->pressure_max = pdata->pressure_max ? : ~0;
-	if (pdata->debounce_max) {
+
+	if (pdata->filter != NULL) {
+		if (pdata->filter_init != NULL) {
+			err = pdata->filter_init(pdata, &ts->filter_data);
+			if (err < 0)
+				goto err_free_mem;
+		}
+		ts->filter = pdata->filter;
+		ts->filter_cleanup = pdata->filter_cleanup;
+	} else if (pdata->debounce_max) {
 		ts->debounce_max = pdata->debounce_max;
+		if (ts->debounce_max < 2)
+			ts->debounce_max = 2;
 		ts->debounce_tol = pdata->debounce_tol;
 		ts->debounce_rep = pdata->debounce_rep;
-		if (ts->debounce_rep > ts->debounce_max + 1)
-			ts->debounce_rep = ts->debounce_max - 1;
+		ts->filter = ads7846_debounce;
+		ts->filter_data = ts;
 	} else
-		ts->debounce_tol = ~0;
+		ts->filter = ads7846_no_filter;
 	ts->get_pendown_state = pdata->get_pendown_state;
 
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", spi->dev.bus_id);
@@ -718,6 +796,8 @@ static int __devinit ads7846_probe(struc
 	input_set_abs_params(input_dev, ABS_PRESSURE,
 			pdata->pressure_min, pdata->pressure_max, 0, 0);
 
+	vref = pdata->keep_vref_on;
+
 	/* set up the transfers to read touchscreen state; this assumes we
 	 * use formula #2 for pressure, not #3.
 	 */
@@ -727,7 +807,7 @@ static int __devinit ads7846_probe(struc
 	spi_message_init(m);
 
 	/* y- still on; turn on only y+ (and ADC) */
-	ts->read_y = READ_Y;
+	ts->read_y = READ_Y(vref);
 	x->tx_buf = &ts->read_y;
 	x->len = 1;
 	spi_message_add_tail(x, m);
@@ -737,7 +817,7 @@ static int __devinit ads7846_probe(struc
 	x->len = 2;
 	spi_message_add_tail(x, m);
 
-	m->complete = ads7846_debounce;
+	m->complete = ads7846_rx_val;
 	m->context = ts;
 
 	m++;
@@ -745,7 +825,7 @@ static int __devinit ads7846_probe(struc
 
 	/* turn y- off, x+ on, then leave in lowpower */
 	x++;
-	ts->read_x = READ_X;
+	ts->read_x = READ_X(vref);
 	x->tx_buf = &ts->read_x;
 	x->len = 1;
 	spi_message_add_tail(x, m);
@@ -755,7 +835,7 @@ static int __devinit ads7846_probe(struc
 	x->len = 2;
 	spi_message_add_tail(x, m);
 
-	m->complete = ads7846_debounce;
+	m->complete = ads7846_rx_val;
 	m->context = ts;
 
 	/* turn y+ off, x- on; we'll use formula #2 */
@@ -764,7 +844,7 @@ static int __devinit ads7846_probe(struc
 		spi_message_init(m);
 
 		x++;
-		ts->read_z1 = READ_Z1;
+		ts->read_z1 = READ_Z1(vref);
 		x->tx_buf = &ts->read_z1;
 		x->len = 1;
 		spi_message_add_tail(x, m);
@@ -774,14 +854,14 @@ static int __devinit ads7846_probe(struc
 		x->len = 2;
 		spi_message_add_tail(x, m);
 
-		m->complete = ads7846_debounce;
+		m->complete = ads7846_rx_val;
 		m->context = ts;
 
 		m++;
 		spi_message_init(m);
 
 		x++;
-		ts->read_z2 = READ_Z2;
+		ts->read_z2 = READ_Z2(vref);
 		x->tx_buf = &ts->read_z2;
 		x->len = 1;
 		spi_message_add_tail(x, m);
@@ -791,7 +871,7 @@ static int __devinit ads7846_probe(struc
 		x->len = 2;
 		spi_message_add_tail(x, m);
 
-		m->complete = ads7846_debounce;
+		m->complete = ads7846_rx_val;
 		m->context = ts;
 	}
 
@@ -816,47 +896,81 @@ static int __devinit ads7846_probe(struc
 
 	ts->last_msg = m;
 
-	if (request_irq(spi->irq, ads7846_irq, IRQF_TRIGGER_FALLING,
-			spi->dev.driver->name, ts)) {
+	if (request_irq(spi->irq, ads7846_irq,
+			IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_FALLING,
+			spi->dev.bus_id, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		err = -EBUSY;
-		goto err_free_mem;
+		goto err_cleanup_filter;
 	}
 
-	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
+	dev_info(&spi->dev, "touchscreen + hwmon, irq %d\n", spi->irq);
 
-	/* take a first sample, leaving nPENIRQ active; avoid
+	/* take a first sample, leaving nPENIRQ active and vREF off; avoid
 	 * the touchscreen, in case it's not connected.
 	 */
 	(void) ads7846_read12_ser(&spi->dev,
 			  READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
 
-	switch (ts->model) {
-	case 7846:
-		ts->attr_group = &ads7846_attr_group;
-		break;
-	case 7845:
-		ts->attr_group = &ads7845_attr_group;
-		break;
-	default:
-		ts->attr_group = &ads7843_attr_group;
-		break;
+	/* ads7843/7845 don't have temperature sensors, and
+	 * use the other ADC lines a bit differently too
+	 */
+	if (ts->model == 7846) {
+		err = device_create_file(&spi->dev, &dev_attr_temp0);
+		if (err)
+			goto err_remove_attr7;
+		err = device_create_file(&spi->dev, &dev_attr_temp1);
+		if (err)
+			goto err_remove_attr6;
 	}
-	err = sysfs_create_group(&spi->dev.kobj, ts->attr_group);
+	/* in1 == vBAT (7846), or a non-scaled ADC input */
+	if (ts->model != 7845) {
+		err = device_create_file(&spi->dev, &dev_attr_in1_input);
+		if (err)
+			goto err_remove_attr5;
+	}
+	/* in0 == a non-scaled ADC input */
+	err = device_create_file(&spi->dev, &dev_attr_in0_input);
 	if (err)
-		goto err_free_irq;
+		goto err_remove_attr4;
+
+	/* non-hwmon device attributes */
+	err = device_create_file(&spi->dev, &dev_attr_pen_down);
+	if (err)
+		goto err_remove_attr3;
+	err = device_create_file(&spi->dev, &dev_attr_disable);
+	if (err)
+		goto err_remove_attr2;
 
 	err = input_register_device(input_dev);
 	if (err)
-		goto err_remove_attr_group;
+		goto err_remove_attr1;
 
 	return 0;
 
- err_remove_attr_group:
-	sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
- err_free_irq:
+ err_remove_attr1:
+	device_remove_file(&spi->dev, &dev_attr_disable);
+ err_remove_attr2:
+	device_remove_file(&spi->dev, &dev_attr_pen_down);
+ err_remove_attr3:
+	device_remove_file(&spi->dev, &dev_attr_in0_input);
+ err_remove_attr4:
+	if (ts->model != 7845)
+		device_remove_file(&spi->dev, &dev_attr_in1_input);
+ err_remove_attr5:
+	if (ts->model == 7846) {
+		device_remove_file(&spi->dev, &dev_attr_temp1);
+ err_remove_attr6:
+		device_remove_file(&spi->dev, &dev_attr_temp0);
+	}
+ err_remove_attr7:
 	free_irq(spi->irq, ts);
+ err_cleanup_filter:
+	if (ts->filter_cleanup)
+		ts->filter_cleanup(ts->filter_data);
  err_free_mem:
+	if (!IS_ERR(hwmon))
+		hwmon_device_unregister(hwmon);
 	input_free_device(input_dev);
 	kfree(ts);
 	return err;
@@ -866,16 +980,28 @@ static int __devexit ads7846_remove(stru
 {
 	struct ads7846		*ts = dev_get_drvdata(&spi->dev);
 
+	hwmon_device_unregister(ts->hwmon);
 	input_unregister_device(ts->input);
 
 	ads7846_suspend(spi, PMSG_SUSPEND);
 
-	sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
+	device_remove_file(&spi->dev, &dev_attr_disable);
+	device_remove_file(&spi->dev, &dev_attr_pen_down);
+	if (ts->model == 7846) {
+		device_remove_file(&spi->dev, &dev_attr_temp1);
+		device_remove_file(&spi->dev, &dev_attr_temp0);
+	}
+	if (ts->model != 7845)
+		device_remove_file(&spi->dev, &dev_attr_in1_input);
+	device_remove_file(&spi->dev, &dev_attr_in0_input);
 
 	free_irq(ts->spi->irq, ts);
 	/* suspend left the IRQ disabled */
 	enable_irq(ts->spi->irq);
 
+	if (ts->filter_cleanup != NULL)
+		ts->filter_cleanup(ts->filter_data);
+
 	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
@@ -923,7 +1049,7 @@ static int __init ads7846_init(void)
 
 	return spi_register_driver(&ads7846_driver);
 }
-module_init(ads7846_init);
+device_initcall(ads7846_init);
 
 static void __exit ads7846_exit(void)
 {
Index: linux-omap-2.6/include/linux/spi/ads7846.h
===================================================================
--- linux-omap-2.6.orig/include/linux/spi/ads7846.h	2007-03-03 21:05:29.000000000 +0100
+++ linux-omap-2.6/include/linux/spi/ads7846.h	2007-03-03 21:05:33.000000000 +0100
@@ -5,9 +5,17 @@
  *
  * It's OK if the min/max values are zero.
  */
+enum ads7846_filter {
+	ADS7846_FILTER_OK,
+	ADS7846_FILTER_REPEAT,
+	ADS7846_FILTER_IGNORE,
+};
+
 struct ads7846_platform_data {
 	u16	model;			/* 7843, 7845, 7846. */
 	u16	vref_delay_usecs;	/* 0 for external vref; etc */
+	int	keep_vref_on : 1;	/* set to keep vref on for differential
+					 * measurements as well */
 	u16	x_plate_ohms;
 	u16	y_plate_ohms;
 
@@ -21,5 +29,9 @@ struct ads7846_platform_data {
 	u16	debounce_rep;		/* additional consecutive good readings
 					 * required after the first two */
 	int	(*get_pendown_state)(void);
+	int	(*filter_init)	(struct ads7846_platform_data *pdata,
+				 void **filter_data);
+	int	(*filter)	(void *filter_data, int data_idx, int *val);
+	void	(*filter_cleanup)(void *filter_data);
 };
 

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
