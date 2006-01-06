From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] Convert touchscreen to input_allocate_device
Date: Fri, 06 Jan 2006 20:37:16 +0100
Message-ID: <43BEC6EC.6060204@de.bosch.com>
References: <43B10E92.4060203@de.bosch.com> <20051230222808.GJ4415@atomide.com>
	<20060103191356.GR6034@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060008050005070706040901"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060103191356.GR6034@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008050005070706040901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren wrote:
> Dirk, I've only pushed Todd's timer fix below like you suggested. Can you please
> update your patch?

ARM: OMAP: Convert touchscreen to input_allocate_device() to remove:

input: device omap_ts is statically allocated, will not register
Please convert to input_allocate_device() or contact dtor_core@ameritech.net

Signed-off-by: Dirk Behme <dirk.behme_at_de.bosch.com>




--------------060008050005070706040901
Content-Type: text/plain;
 name="touchscreen_input_allocate_device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="touchscreen_input_allocate_device.patch"

--- ./drivers/input/touchscreen/omap/omap_ts.c_orig	2006-01-06 16:43:40.000000000 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.c	2006-01-06 18:48:39.754015208 +0100
@@ -65,10 +65,10 @@ static int omap_ts_read(void)
 
 	ts_omap.dev->read(data);
 
-	input_report_abs(&(ts_omap.inputdevice), ABS_X, data[0]);
-	input_report_abs(&(ts_omap.inputdevice), ABS_Y, data[1]);
-	input_report_abs(&(ts_omap.inputdevice), ABS_PRESSURE, data[2]);
-	input_sync(&(ts_omap.inputdevice));
+	input_report_abs(ts_omap.inputdevice, ABS_X, data[0]);
+	input_report_abs(ts_omap.inputdevice, ABS_Y, data[1]);
+	input_report_abs(ts_omap.inputdevice, ABS_PRESSURE, data[2]);
+	input_sync(ts_omap.inputdevice);
 
 	DEBUG_TS("omap_ts_read: read x=%d,y=%d,p=%d\n", data[0], data[1],
 		 data[2]);
@@ -85,7 +85,7 @@ static void omap_ts_timer(unsigned long 
 	if (!ts_omap.dev->penup()) {
 		if (!ts_omap.touched) {
 			DEBUG_TS("omap_ts_timer: pen down\n");
-			input_report_key(&(ts_omap.inputdevice), BTN_TOUCH, 1);
+			input_report_key(ts_omap.inputdevice, BTN_TOUCH, 1);
 		}
 		ts_omap.touched = 1;
 		omap_ts_read();
@@ -95,12 +95,12 @@ static void omap_ts_timer(unsigned long 
 		if (ts_omap.touched) {
 			DEBUG_TS("omap_ts_timer: pen up\n");
 			ts_omap.touched = 0;
-			input_report_abs(&(ts_omap.inputdevice), ABS_X, 0);
-			input_report_abs(&(ts_omap.inputdevice), ABS_Y, 0);
-			input_report_abs(&(ts_omap.inputdevice), ABS_PRESSURE,
+			input_report_abs(ts_omap.inputdevice, ABS_X, 0);
+			input_report_abs(ts_omap.inputdevice, ABS_Y, 0);
+			input_report_abs(ts_omap.inputdevice, ABS_PRESSURE,
 					 0);
-			input_sync(&(ts_omap.inputdevice));
-			input_report_key(&(ts_omap.inputdevice), BTN_TOUCH, 0);
+			input_sync(ts_omap.inputdevice);
+			input_report_key(ts_omap.inputdevice, BTN_TOUCH, 0);
 		}
 		if (!ts_omap.irq_enabled) {
 			ts_omap.irq_enabled = 1;
@@ -167,14 +167,14 @@ static int __init omap_ts_probe(struct p
 		return -EINVAL;
 	}
 
-	init_input_dev(&(ts_omap.inputdevice));
-	ts_omap.inputdevice.name = OMAP_TS_NAME;
-	ts_omap.inputdevice.dev = &pdev->dev;
-	ts_omap.inputdevice.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	ts_omap.inputdevice.keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
-	ts_omap.inputdevice.absbit[0] =
+	ts_omap.inputdevice = input_allocate_device();
+	ts_omap.inputdevice->name = OMAP_TS_NAME;
+	ts_omap.inputdevice->dev = &pdev->dev;
+	ts_omap.inputdevice->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	ts_omap.inputdevice->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
+	ts_omap.inputdevice->absbit[0] =
 	    BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
-	input_register_device(&(ts_omap.inputdevice));
+	input_register_device(ts_omap.inputdevice);
 
 	ts_omap.dev->enable();
 
@@ -186,7 +186,7 @@ static int __init omap_ts_probe(struct p
 static int omap_ts_remove(struct platform_device *pdev)
 {
 	ts_omap.dev->disable();
-	input_unregister_device(&ts_omap.inputdevice);
+	input_unregister_device(ts_omap.inputdevice);
 	if (ts_omap.irq != -1)
 		free_irq(ts_omap.irq, &ts_omap);
 
--- ./drivers/input/touchscreen/omap/omap_ts.h_orig	2006-01-06 16:43:40.000000000 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.h	2006-01-06 18:48:39.756014904 +0100
@@ -42,7 +42,7 @@ struct ts_device {
 };
 
 struct omap_ts_t{
-	struct input_dev inputdevice;
+	struct input_dev * inputdevice;
 	struct timer_list ts_timer;      // Timer for triggering acquisitions
 	int touched;
 	int irq;


--------------060008050005070706040901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060008050005070706040901--
