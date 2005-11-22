From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Convert input devices to input_allocate_device
Date: Tue, 22 Nov 2005 22:49:45 +0100
Message-ID: <43839279.5040307@de.bosch.com>
References: <438375AF.1090808@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030103090807020605090204"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <438375AF.1090808@de.bosch.com>
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
--------------030103090807020605090204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dirk Behme wrote:
> # ts_calibrate
> ts_open: No such device

Missed an input_register_device(omap_kp_dev) in omap-keypad. TS became 
event0 and so ts_calibrate can't open event1 ;) Corrected patch in the 
attachment.

But with this I get

# ts_calibrate
xres = 240, yres = 320
Took 15 samples...
Top left : X = 2893 Y = 3122
kernel BUG at include/linux/timer.h:83!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1]
Modules linked in:...

?

--------------030103090807020605090204
Content-Type: text/plain;
 name="input_allocate_device_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="input_allocate_device_v2.patch"

--- ./drivers/input/touchscreen/omap/omap_ts.c_orig	2005-11-22 20:14:23.000000000 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.c	2005-11-22 20:20:24.000000000 +0100
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
 
--- ./drivers/input/touchscreen/omap/omap_ts.h_orig	2005-11-22 19:47:37.000000000 +0100
+++ ./drivers/input/touchscreen/omap/omap_ts.h	2005-11-22 20:09:03.000000000 +0100
@@ -42,7 +42,7 @@ struct ts_device {
 };
 
 struct omap_ts_t{
-	struct input_dev inputdevice;
+	struct input_dev * inputdevice;
 	struct timer_list ts_timer;      // Timer for triggering acquisitions
 	int touched;
 	int irq;
--- ./drivers/input/keyboard/omap-keypad.c_orig	2005-11-22 20:17:15.000000000 +0100
+++ ./drivers/input/keyboard/omap-keypad.c	2005-11-22 21:58:06.575502064 +0100
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
@@ -299,11 +299,12 @@ static int __init omap_kp_init(void)
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
+	input_register_device(omap_kp_dev);
 
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
 		omap_cfg_reg(F18_1610_KBC0);
@@ -353,7 +354,7 @@ static void __exit omap_kp_exit(void)
 	del_timer_sync(&kp_timer);
 
 	/* unregister everything */
-	input_unregister_device(&omap_kp_dev);
+	input_unregister_device(omap_kp_dev);
 }
 
 module_init(omap_kp_init);

--------------030103090807020605090204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--------------030103090807020605090204--
