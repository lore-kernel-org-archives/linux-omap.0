From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Convert input devices to input_allocate_device
Date: Tue, 22 Nov 2005 20:46:55 +0100
Message-ID: <438375AF.1090808@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000007090109000509050405"
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

This is a multi-part message in MIME format.
--------------000007090109000509050405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

while loading omapts and omap-keypad drivers as modules in
2.6.15-rc1-omap1 I get:

input: device omap-keypad is statically allocated, will not register
Please convert to input_allocate_device() or contact dtor_core@ameritech.net

input: device omap_ts is statically allocated, will not register
Please convert to input_allocate_device() or contact dtor_core@ameritech.net

Converting them to input_allocate_device() (patch in the attachment)
results in clean loading:

OMAP Keypad Driver
MUX: initialized N14_1610_UWIRE_CS0
MUX: initialized P15_1610_UWIRE_CS3
MUX: initialized P20_1610_GPIO4
input: omap_ts as /class/input/input0
OMAP touchscreen driver initialized

But then ts_calibrate doesn't want to open touchscreen driver:

# ts_calibrate
ts_open: No such device

My standard TS configuration (worked quite good with the old
configuration) is:

./profile:4:export TSLIB_TSDEVICE='/dev/input/event1'
./ts.conf:2:module_raw input

Any ideas?

Thanks

Dirk











--------------000007090109000509050405
Content-Type: text/plain;
 name="input_allocate_device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="input_allocate_device.patch"

--- ./drivers/input/touchscreen/omap/omap_ts.c_orig	2005-11-22 20:14:23.258389432 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.c	2005-11-22 20:20:24.437481864 +0100
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
@@ -168,14 +168,14 @@ static int __init omap_ts_probe(struct d
 		return -EINVAL;
 	}
 
-	init_input_dev(&(ts_omap.inputdevice));
-	ts_omap.inputdevice.name = OMAP_TS_NAME;
-	ts_omap.inputdevice.dev = dev;
-	ts_omap.inputdevice.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	ts_omap.inputdevice.keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
-	ts_omap.inputdevice.absbit[0] =
+	ts_omap.inputdevice = input_allocate_device();
+	ts_omap.inputdevice->name = OMAP_TS_NAME;
+	ts_omap.inputdevice->dev = dev;
+	ts_omap.inputdevice->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	ts_omap.inputdevice->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
+	ts_omap.inputdevice->absbit[0] =
 	    BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
-	input_register_device(&(ts_omap.inputdevice));
+	input_register_device(ts_omap.inputdevice);
 
 	ts_omap.dev->enable();
 
@@ -187,7 +187,7 @@ static int __init omap_ts_probe(struct d
 static int __exit omap_ts_remove(struct device *dev)
 {
 	ts_omap.dev->disable();
-	input_unregister_device(&ts_omap.inputdevice);
+	input_unregister_device(ts_omap.inputdevice);
 	if (ts_omap.irq != -1)
 		free_irq(ts_omap.irq, &ts_omap);
 
--- ./drivers/input/touchscreen/omap/omap_ts.h_orig	2005-11-22 19:47:37.137556912 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.h	2005-11-22 20:09:03.938933368 +0100
@@ -42,7 +42,7 @@ struct ts_device {
 };
 
 struct omap_ts_t{
-	struct input_dev inputdevice;
+	struct input_dev * inputdevice;
 	struct timer_list ts_timer;      // Timer for triggering acquisitions
 	int touched;
 	int irq;
--- ./drivers/input/keyboard/omap-keypad.c_orig	2005-11-22 20:17:15.222246952 +0100
+++ ./drivers/input/keyboard/omap-keypad.c	2005-11-22 20:20:56.918543992 +0100
@@ -44,7 +44,7 @@
 static void omap_kp_tasklet(unsigned long);
 static void omap_kp_timer(unsigned long);
 
-static struct input_dev omap_kp_dev;
+static struct input_dev * omap_kp_dev;
 static unsigned char keypad_state[8];
 static unsigned int keypad_irq = INT_KEYBOARD;
 
@@ -246,7 +246,7 @@ static void omap_kp_tasklet(unsigned lon
 				continue;
 			}
 
-			input_report_key(&omap_kp_dev, key,
+			input_report_key(omap_kp_dev, key,
 					 new_state[col] & (1 << row));
 #endif
 		}
@@ -277,7 +277,7 @@ static int __init omap_kp_init(void)
 
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
 		keymap = h2_keymap;
-		set_bit(EV_REP, omap_kp_dev.evbit);
+		set_bit(EV_REP, omap_kp_dev->evbit);
 	} else if (machine_is_omap_innovator()) {
 		keymap = innovator_keymap;
 	} else if (machine_is_omap_osk()) {
@@ -299,11 +299,11 @@ static int __init omap_kp_init(void)
 		return -EINVAL;
 
 	/* setup input device */
-	set_bit(EV_KEY, omap_kp_dev.evbit);
+	omap_kp_dev = input_allocate_device();
+	set_bit(EV_KEY, omap_kp_dev->evbit);
 	for (i = 0; keymap[i] != 0; i++)
-		set_bit(keymap[i] & 0x00ffffff, omap_kp_dev.keybit);
-	omap_kp_dev.name = "omap-keypad";
-	input_register_device(&omap_kp_dev);
+		set_bit(keymap[i] & 0x00ffffff, omap_kp_dev->keybit);
+	omap_kp_dev->name = "omap-keypad";
 
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
 		omap_cfg_reg(F18_1610_KBC0);
@@ -353,7 +353,7 @@ static void __exit omap_kp_exit(void)
 	del_timer_sync(&kp_timer);
 
 	/* unregister everything */
-	input_unregister_device(&omap_kp_dev);
+	input_unregister_device(omap_kp_dev);
 }
 
 module_init(omap_kp_init);



--------------000007090109000509050405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--------------000007090109000509050405--
