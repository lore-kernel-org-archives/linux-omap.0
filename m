From: imre.deak@solidboot.com
Subject: [PATCH 3/4] Input: ads7846: pluggable filtering logic
Date: Mon, 3 Jul 2006 21:36:53 +0300
Message-ID: <20060703183653.GC29921@localdomain>
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

Some LCDs like the LS041Y3 require a customized filtering
logic for reliable readings, so make the filtering function
replacable through platform specific hooks.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>

---

 drivers/input/touchscreen/ads7846.c |  124 +++++++++++++++++++++++++----------
 include/linux/spi/ads7846.h         |   10 +++
 2 files changed, 99 insertions(+), 35 deletions(-)

6bc124dcf12f9b5a10910e6f27e5dc464872dfff
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 008cf0a..2e5c5a6 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -108,6 +108,9 @@ struct ads7846 {
 	unsigned		irq_disabled:1;	/* P: lock */
 	unsigned		disabled:1;
 
+	int			(*filter)(void *data, int data_idx, int *val);
+	void			*filter_data;
+	void			(*filter_cleanup)(void *data);
 	int			(*get_pendown_state)(void);
 };
 
@@ -421,10 +424,10 @@ static void ads7846_rx(void *ads)
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
@@ -469,55 +472,84 @@ static void ads7846_rx(void *ads)
 		ads7846_sync_events(ts);
 	}
 
-
 	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD), HRTIMER_REL);
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
-	if (ts->debounce_max && (
-	    !ts->read_cnt || (abs(ts->last_read - val) > ts->debounce_tol))) {
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
@@ -722,9 +754,25 @@ static int __devinit ads7846_probe(struc
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
 	ts->pressure_max = pdata->pressure_max ? : ~0;
-	ts->debounce_max = pdata->debounce_max;
-	ts->debounce_tol = pdata->debounce_tol;
-	ts->debounce_rep = pdata->debounce_rep;
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
+		ts->debounce_max = pdata->debounce_max;
+		if (ts->debounce_max < 2)
+			ts->debounce_max = 2;
+		ts->debounce_tol = pdata->debounce_tol;
+		ts->debounce_rep = pdata->debounce_rep;
+		ts->filter = ads7846_debounce;
+		ts->filter_data = ts;
+	} else
+		ts->filter = ads7846_no_filter;
 	ts->get_pendown_state = pdata->get_pendown_state;
 
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", spi->dev.bus_id);
@@ -765,7 +813,7 @@ static int __devinit ads7846_probe(struc
 	x->len = 2;
 	spi_message_add_tail(x, m);
 
-	m->complete = ads7846_debounce;
+	m->complete = ads7846_rx_val;
 	m->context = ts;
 
 	m++;
@@ -783,7 +831,7 @@ static int __devinit ads7846_probe(struc
 	x->len = 2;
 	spi_message_add_tail(x, m);
 
-	m->complete = ads7846_debounce;
+	m->complete = ads7846_rx_val;
 	m->context = ts;
 
 	/* turn y+ off, x- on; we'll use formula #2 */
@@ -802,7 +850,7 @@ static int __devinit ads7846_probe(struc
 		x->len = 2;
 		spi_message_add_tail(x, m);
 
-		m->complete = ads7846_debounce;
+		m->complete = ads7846_rx_val;
 		m->context = ts;
 
 		m++;
@@ -819,7 +867,7 @@ static int __devinit ads7846_probe(struc
 		x->len = 2;
 		spi_message_add_tail(x, m);
 
-		m->complete = ads7846_debounce;
+		m->complete = ads7846_rx_val;
 		m->context = ts;
 	}
 
@@ -849,7 +897,7 @@ static int __devinit ads7846_probe(struc
 			spi->dev.bus_id, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		err = -EBUSY;
-		goto err_free_mem;
+		goto err_cleanup_filter;
 	}
 
 	dev_info(&spi->dev, "touchscreen + hwmon, irq %d\n", spi->irq);
@@ -895,6 +943,9 @@ static int __devinit ads7846_probe(struc
 	device_remove_file(&spi->dev, &dev_attr_in0_input);
 
 	free_irq(spi->irq, ts);
+ err_cleanup_filter:
+	if (ts->filter_cleanup)
+		ts->filter_cleanup(ts->filter_data);
  err_free_mem:
 	if (!IS_ERR(hwmon))
 		hwmon_device_unregister(hwmon);
@@ -926,6 +977,9 @@ static int __devexit ads7846_remove(stru
 	/* suspend left the IRQ disabled */
 	enable_irq(ts->spi->irq);
 
+	if (ts->filter_cleanup != NULL)
+		ts->filter_cleanup(ts->filter_data);
+
 	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index adb3daf..1663f94 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -5,6 +5,12 @@
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
@@ -21,5 +27,9 @@ struct ads7846_platform_data {
 	u16	debounce_rep;		/* additional consecutive good readings
 					 * required after the first two */
 	int	(*get_pendown_state)(void);
+	int	(*filter_init)	(struct ads7846_platform_data *pdata,
+				 void **filter_data);
+	int	(*filter)	(void *filter_data, int data_idx, int *val);
+	void	(*filter_cleanup)(void *filter_data);
 };
 
-- 
1.2.3.g90cc1-dirty
