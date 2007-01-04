From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: Re: innovator_ps2 broken
Date: Thu, 04 Jan 2007 15:20:28 -0400
Message-ID: <1167938428.19325.5.camel@balbi>
References: <459D34C9.8060405@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <459D34C9.8060405@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Dirk Behme <dirk.behme@googlemail.com>, Ilias Biris <ilias.biris@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello all, 
>    CC [M]  drivers/input/keyboard/innovator_ps2.o
> drivers/input/keyboard/innovator_ps2.c: In function 
> 'innovator_kbd_init':
> drivers/input/keyboard/innovator_ps2.c:1225: warning: 
> implicit declaration of function 'init_input_dev'
> WARNING: "init_input_dev" 
> [drivers/input/keyboard/innovator_ps2.ko] undefined!

This patch makes this module compile again.

== CUT HERE ==

Make drivers/input/keyboard/innovator_ps2.c work again.

init_input_dev() is not used anymore, use input_allocate_dev() instead.

Signed-off-by Felipe Balbi <felipe.lima@indt.org.br>
---
 
Index: linux-omap-2.6-dev/drivers/input/keyboard/innovator_ps2.c
===================================================================
--- linux-omap-2.6-dev.orig/drivers/input/keyboard/innovator_ps2.c
+++ linux-omap-2.6-dev/drivers/input/keyboard/innovator_ps2.c
@@ -338,3 +338,3 @@ static struct innovator_hid_dev *hid;
 struct innovator_hid_dev {
-	struct input_dev mouse, keyboard;
+	struct input_dev *mouse, *keyboard;
 	int open;
@@ -923,2 +923,4 @@ process_pointing_report(struct innovator
 	int x, y, btn;
+	hid->keyboard = input_allocate_device();
+	hid->mouse = input_allocate_device();
 
@@ -939,10 +941,10 @@ process_pointing_report(struct innovator
 
-		input_report_key(&hid->mouse,
+		input_report_key(hid->mouse,
 				 BTN_LEFT, buffer[1] & (1<<0));
-		input_report_key(&hid->mouse,
+		input_report_key(hid->mouse,
 				 BTN_RIGHT, buffer[1] & (1<<1));
-		input_report_key(&hid->mouse,
+		input_report_key(hid->mouse,
 				 BTN_MIDDLE, buffer[1] & (1<<2));
-		input_report_rel(&hid->mouse, REL_X, x);
-		input_report_rel(&hid->mouse, REL_Y, y);
+		input_report_rel(hid->mouse, REL_X, x);
+		input_report_rel(hid->mouse, REL_Y, y);
 	} else {
@@ -958,5 +960,5 @@ process_pointing_report(struct innovator
 
-		input_report_key(&hid->mouse, BTN_LEFT, btn);
-		input_report_abs(&hid->mouse, ABS_X, x);
-		input_report_abs(&hid->mouse, ABS_Y, y);
+		input_report_key(hid->mouse, BTN_LEFT, btn);
+		input_report_abs(hid->mouse, ABS_X, x);
+		input_report_abs(hid->mouse, ABS_Y, y);
 		prev_x = x;
@@ -965,3 +967,3 @@ process_pointing_report(struct innovator
 	}
-	input_sync(&hid->mouse);
+	input_sync(hid->mouse);
 	dbg("HID X: %d Y: %d Functions: %x\n", x, y, buffer[1]);
@@ -1015,11 +1017,11 @@ handle_print_scr(int up)
 	if (up) {
-		input_report_key(&hid->keyboard, 0xe0, 1);
-		input_report_key(&hid->keyboard, 0xb7, 1);
-		input_report_key(&hid->keyboard, 0xe0, 1);
-		input_report_key(&hid->keyboard, 0xaa, 1);
+		input_report_key(hid->keyboard, 0xe0, 1);
+		input_report_key(hid->keyboard, 0xb7, 1);
+		input_report_key(hid->keyboard, 0xe0, 1);
+		input_report_key(hid->keyboard, 0xaa, 1);
 	} else {
-		input_report_key(&hid->keyboard, 0xe0, 0);
-		input_report_key(&hid->keyboard, 0x2a, 0);
-		input_report_key(&hid->keyboard, 0xe0, 0);
-		input_report_key(&hid->keyboard, 0x37, 0);
+		input_report_key(hid->keyboard, 0xe0, 0);
+		input_report_key(hid->keyboard, 0x2a, 0);
+		input_report_key(hid->keyboard, 0xe0, 0);
+		input_report_key(hid->keyboard, 0x37, 0);
 	}
@@ -1030,8 +1032,8 @@ handle_pause(void)
 {
-	input_report_key(&hid->keyboard, 0xe1, 0);
-	input_report_key(&hid->keyboard, 0x1d, 0);
-	input_report_key(&hid->keyboard, 0x45, 0);
-	input_report_key(&hid->keyboard, 0xe1, 0);
-	input_report_key(&hid->keyboard, 0x9d, 0);
-	input_report_key(&hid->keyboard, 0xc5, 0);
+	input_report_key(hid->keyboard, 0xe1, 0);
+	input_report_key(hid->keyboard, 0x1d, 0);
+	input_report_key(hid->keyboard, 0x45, 0);
+	input_report_key(hid->keyboard, 0xe1, 0);
+	input_report_key(hid->keyboard, 0x9d, 0);
+	input_report_key(hid->keyboard, 0xc5, 0);
 }
@@ -1044,2 +1046,4 @@ process_keyboard_report(struct innovator
 	int is_e0 = 0;
+	hid->keyboard = input_allocate_device();
+	hid->mouse = input_allocate_device();
 
@@ -1067,6 +1071,6 @@ process_keyboard_report(struct innovator
 	if (is_e0) {
-		input_report_key(&hid->keyboard, 0xe0, !up);
+		input_report_key(hid->keyboard, 0xe0, !up);
 	}
-	input_report_key(&hid->keyboard, usar2scancode[ch], !up);
-	input_sync(&hid->keyboard);
+	input_report_key(hid->keyboard, usar2scancode[ch], !up);
+	input_sync(hid->keyboard);
 }
@@ -1210,33 +1214,34 @@ innovator_kbd_init(void)
 	memset(hid, 0, sizeof(struct innovator_hid_dev));
-	hid->mouse.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	hid->mouse.keybit[LONG(BTN_MOUSE)] =
+	hid->mouse = input_allocate_device();
+	hid->mouse->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	hid->mouse->keybit[LONG(BTN_MOUSE)] =
 	    BIT(BTN_LEFT) | BIT(BTN_RIGHT) |
 	    BIT(BTN_MIDDLE) | BIT(BTN_TOUCH);
-	hid->mouse.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	hid->mouse.private = hid;
-	hid->mouse.open = innovator_hid_open;
-	hid->mouse.close = innovator_hid_close;
-	hid->mouse.name = "innovator_mouse";
-	hid->mouse.id.bustype = 0;
-	hid->mouse.id.vendor = 0;
-	hid->mouse.id.product = 0;
-	hid->mouse.id.version = 0;
-	hid->keyboard.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
-        init_input_dev(&hid->keyboard);
-        hid->keyboard.keycodesize = sizeof(unsigned char);
-        hid->keyboard.keycodemax = ARRAY_SIZE(usar2scancode);
+	hid->mouse->relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	hid->mouse->private = hid;
+	hid->mouse->open = innovator_hid_open;
+	hid->mouse->close = innovator_hid_close;
+	hid->mouse->name = "innovator_mouse";
+	hid->mouse->id.bustype = 0;
+	hid->mouse->id.vendor = 0;
+	hid->mouse->id.product = 0;
+	hid->mouse->id.version = 0;
+       hid->keyboard = input_allocate_device();
+	hid->keyboard->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+       hid->keyboard->keycodesize = sizeof(unsigned char);
+       hid->keyboard->keycodemax = ARRAY_SIZE(usar2scancode);
 	for(i = 0; i < 128; i++)
-		set_bit(usar2scancode[i], hid->keyboard.keybit); 
-	hid->keyboard.private = hid;
-	hid->keyboard.open = innovator_hid_open;
-	hid->keyboard.close = innovator_hid_close;
-	hid->keyboard.name = "innovator_keyboard";
-	hid->keyboard.id.bustype = 0;
-	hid->keyboard.id.vendor = 0;
-	hid->keyboard.id.product = 0;
-	hid->keyboard.id.version = 0;
-	input_register_device(&hid->mouse);
-	input_register_device(&hid->keyboard);
-	innovator_hid_open(&hid->mouse);
-	innovator_hid_open(&hid->keyboard);
+		set_bit(usar2scancode[i], hid->keyboard->keybit);
+	hid->keyboard->private = hid;
+	hid->keyboard->open = innovator_hid_open;
+	hid->keyboard->close = innovator_hid_close;
+	hid->keyboard->name = "innovator_keyboard";
+	hid->keyboard->id.bustype = 0;
+	hid->keyboard->id.vendor = 0;
+	hid->keyboard->id.product = 0;
+	hid->keyboard->id.version = 0;
+	input_register_device(hid->mouse);
+	input_register_device(hid->keyboard);
+	innovator_hid_open(hid->mouse);
+	innovator_hid_open(hid->keyboard);
 
@@ -1259,4 +1264,4 @@ innovator_kbd_exit(void)
 {
-	input_unregister_device(&hid->mouse);
-	input_unregister_device(&hid->keyboard);
+	input_unregister_device(hid->mouse);
+	input_unregister_device(hid->keyboard);
 	free_irq(OMAP1510_INT_FPGA_ATN, hid);



-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 8127 0839
