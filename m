From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [PATCH] keypad: platform_data and 24xx support -exp
Date: Sat, 14 Jan 2006 04:04:17 +0200
Message-ID: <43C85C21.6030202@cc.jyu.fi>
References: <20051210130228.91620.qmail@web32905.mail.mud.yahoo.com>
	<20060114003728.GJ5499@atomide.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020901030409040009090507"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060114003728.GJ5499@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020901030409040009090507
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Has anybody needed a joypad driver for the omap-boards? 
I have made changes to keypad driver so that it will support h6300 joypad ok, but I think my approach is a little bit hackish.
The iPAQ h6300 joypad has 5 sensors that are located in following diagonal locations

	UL - Up/Left
	DL - Down/Left
	DR - Down/Right
	UR - Up/Right
	CT - Center

If I press the key-pad for example to North, the joypad will generate 3 keydown events. (CT, UL and UR)
Same logic applies to all 4 main directions both when the key is pressed down or released.
Therefore I have put the driver to listen the real sensor events, but instead of sending them to userspace
I will calculate a "virtual" key event (up, right, down or left) and send that to the userspace.

I am not yet proposing this patch to be applied to omap kernel, but would anyway like to hear
some suggestions how to handle this kind of situation.

Mika

>I like this patch, takes care of the keypad mapping problems nicely.
>Can you please refresh it?
>
>Tony
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>  
>


--------------020901030409040009090507
Content-Type: text/x-patch;
 name="h6300_omap_keypad.patch"
Content-Disposition: inline;
 filename="h6300_omap_keypad.patch"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by reloaded.ext.ti.com id k0E1vH4K009825

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboar=
d/omap-keypad.c
index 7e851e2..157ef8d 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -5,10 +5,11 @@
  *
  * Copyright (C) 2003 Nokia Corporation
  * Written by Timo Ter=C3=A4s <ext-timo.teras@nokia.com>
+ * iPAQ h6300 key and joypad support added by Mika Laitio. (2005)
  *
  * Added support for H2 & H3 Keypad
  * Copyright (C) 2004 Texas Instruments
- *
+ *=20
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -41,13 +42,16 @@
 #include <asm/arch/mux.h>
=20
 #undef NEW_BOARD_LEARNING_MODE
+//#define NEW_BOARD_LEARNING_MODE 1
=20
 static void omap_kp_tasklet(unsigned long);
-static void omap_kp_timer(unsigned long);
+static void omap_=C2=A7kp_timer(unsigned long);
=20
 static unsigned char keypad_state[8];
 static unsigned int keypad_irq =3D INT_KEYBOARD;
=20
+static int prevJoypadKeycodePressEmulated;
+
 struct omap_kp {
 	struct input_dev *input;
 	struct timer_list timer;
@@ -169,6 +173,47 @@ static int p2_keymap[] =3D {
 	0
 };
=20
+#define _h6300_KEY_CALENDAR	67 	// xmodmap 75 aka F9
+#define _H6300_KEY_TELEPHONE	68 	// xmodmap 76 aka F10
+#define _H6300_KEY_HOMEPAGE	87 	// xmodmap 87 aka Num_Lock
+#define _H6300_KEY_MAIL		88 	// xmodmap 88 aka Scroll_Lock
+
+/*
+ * Following 5 keypad events are not really sent to userspace.=20
+ * Instead if the good combination of them is sent, then that is send.
+ * (up, right, down, left, enter)
+ */
+#define	_H6300_JOYPAD_UP_RIGHT		1	// 00001
+#define _H6300_JOYPAD_DOWN_RIGHT	2	// 00010
+#define _h6300_JOYPAD_DOWN_LEFT		4	// 00100
+#define _h6300_JOYPAD_UP_LEFT		8	// 01000
+#define _H6300_JOYPAD_KEY_OK		16	// 10000
+
+static int h6300_keymap[] =3D {
+	KEY(2, 0, _h6300_KEY_CALENDAR),		// address button in the bottom left=09
+	KEY(2, 3, _H6300_KEY_TELEPHONE),	// start call button in the bottom
+	KEY(3, 1, _H6300_KEY_HOMEPAGE),		// stop call button in the bottom
+	KEY(3, 4, _H6300_KEY_MAIL),		// messaging button in the bottom right
+
+	KEY(0, 0, KEY_VOLUMEUP),	// volume up button in the right side
+	KEY(0, 1, KEY_VOLUMEDOWN),	// volume down button in the right side
+	KEY(3, 2, KEY_RECORD),		// record button in the left side
+=09
+	KEY(1, 0, _h6300_JOYPAD_UP_LEFT),=09
+	KEY(1, 1, _h6300_JOYPAD_DOWN_LEFT),=09
+	KEY(1, 2, _H6300_JOYPAD_KEY_OK),	=09
+	KEY(1, 3, _H6300_JOYPAD_DOWN_RIGHT),
+	KEY(1, 4, _H6300_JOYPAD_UP_RIGHT),=09
+=09
+	KEY(5, 0, KEY_RIGHT),
+	KEY(5, 1, KEY_DOWN),
+	KEY(5, 2, KEY_LEFT),	=09
+	KEY(5, 3, KEY_UP),
+	KEY(5, 4, KEY_ENTER),
+
+	0
+};
+
 static int *keymap;
=20
 static irqreturn_t omap_kp_interrupt(int irq, void *dev_id,
@@ -195,7 +240,8 @@ static void omap_kp_scan_keypad(unsigned
 	for (col =3D 0; col < 8; col++) {
 		omap_writew(~(1 << col) & 0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
=20
-		if (machine_is_omap_osk() || machine_is_omap_h2() || machine_is_omap_h=
3()) {
+		if (machine_is_omap_osk() || machine_is_omap_h2() || machine_is_omap_h=
3()  || machine_is_h6300()) {
+			// makes keyboard act a little bit slower
 			udelay(9);
 		} else {
 			udelay(4);
@@ -218,17 +264,26 @@ static inline int omap_kp_find_key(int c
 	return -1;
 }
=20
+int is_key_down(unsigned char new_state[],
+		int col,
+		int row)
+{
+	return (new_state[col] & (1 << row)) ? 1 : 0;
+}
+
 static void omap_kp_tasklet(unsigned long data)
 {
 	struct omap_kp *omap_kp_data =3D (struct omap_kp *) data;
 	unsigned char new_state[8], changed, key_down =3D 0;
 	int col, row;
 	int spurious =3D 0;
+	int report_key, report_col, report_row, joypad_checked;	// h6300-joypad=
 specific variables
=20
 	/* check for any changes */
 	omap_kp_scan_keypad(new_state);
=20
 	/* check for changes and print those */
+	joypad_checked	=3D 0;
 	for (col =3D 0; col < 8; col++) {
 		changed =3D new_state[col] ^ keypad_state[col];
 		key_down |=3D new_state[col];
@@ -250,9 +305,173 @@ static void omap_kp_tasklet(unsigned lon
 				spurious =3D 1;
 				continue;
 			}
-
-			input_report_key(omap_kp_data->input, key,
-					 new_state[col] & (1 << row));
+ 			if (machine_is_h6300() &&=20
+ 			   ((col =3D=3D 1) || (col =3D=3D 5)))
+ 			{
+ 				if (col =3D=3D 5)
+ 				{
+ 					continue;
+ 				}
+ 				if ((joypad_checked =3D=3D 0) &&
+ 				    ((key =3D=3D _H6300_JOYPAD_KEY_OK) ||
+ 				     (key =3D=3D _h6300_JOYPAD_UP_LEFT) ||
+ 	    			     (key =3D=3D _H6300_JOYPAD_UP_RIGHT) ||
+ 				     (key =3D=3D _H6300_JOYPAD_DOWN_RIGHT) ||
+ 				     (key =3D=3D _h6300_JOYPAD_DOWN_LEFT)))
+ 				{
+ 					if (is_key_down(new_state, col, row))
+ 					{
+ 						/*
+ 						 * only enter pressed
+ 						 * 1 0 0 _H6300_JOYPAD_KEY_OK 0 0
+ 						 * --> 100100 =3D=3D 36
+ 						 */
+ 						 if (new_state[1] =3D=3D 36)
+ 						 {
+ 						 	joypad_checked	=3D 1;
+ 							prevJoypadKeycodePressEmulated	=3D KEY_ENTER;
+ 							new_state[5]	=3D 48;	//110000
+ 							report_key	=3D prevJoypadKeycodePressEmulated;
+ 							report_col	=3D 5;
+ 							report_row	=3D 4;
+ 							input_report_key(omap_kp_data->input,
+ 									report_key,
+ 							 		new_state[report_col] & (1 << report_row));
+ 						 }					=09
+ 						/*
+ 						 * enter, up_left and up_right sensors pressed.
+ 						 * 1 _H6300_JOYPAD_UP_RIGHT 0 _H6300_JOYPAD_KEY_OK 0 _h6300_JOYPA=
D_UP_LEFT
+ 						 * --> 110101 =3D=3D 53
+ 						 * OR
+ 						 * 1 KEY_UP_RIGHT 0 0 0 _h6300_JOYPAD_UP_LEFT
+ 						 * --> 110001 =3D=3D 42
+ 						 * --> move to up
+ 						 */
+ 						else if ((new_state[1] =3D=3D 53) ||
+ 						         (new_state[1] =3D=3D 49))
+ 						{
+ 							joypad_checked	=3D 1;
+ 							prevJoypadKeycodePressEmulated	=3D KEY_UP;
+ 							new_state[5]	=3D 40;	//101000
+ 							report_key	=3D prevJoypadKeycodePressEmulated;
+ 							report_col	=3D 5;
+ 							report_row	=3D 3;
+ 							input_report_key(omap_kp_data->input,
+ 									report_key,
+ 							 		new_state[report_col] & (1 << report_row));
+ 						}
+ 						/*
+ 						 * enter, down_left and down_right sensors pressed
+ 						 * --> 101110 =3D=3D 46
+ 						 * OR
+ 						 * down_left and down_right
+ 						 * -->101010 =3D=3D 42
+ 						 * --> move to down
+ 						 */
+ 						else if ((new_state[1] =3D=3D 46) ||
+ 							 (new_state[1] =3D=3D 42))
+ 						{
+ 							joypad_checked	=3D 1;
+ 							prevJoypadKeycodePressEmulated	=3D KEY_DOWN;
+ 							new_state[5]	=3D 34;	//100010
+ 							report_key	=3D prevJoypadKeycodePressEmulated;
+ 							report_col	=3D 5;
+ 							report_row	=3D 1;
+ 							input_report_key(omap_kp_data->input,
+ 									report_key,
+ 							 		new_state[report_col] & (1 << report_row));
+ 						}											=09
+ 						/*
+ 						 * enter, up_right and down_right sensors pressed
+ 						 * --> 111100 =3D=3D 60
+ 						 * or
+ 						 * down_right and up_right
+ 						 * --> 111000 =3D=3D 56
+ 						 * --> move to right
+ 						 */
+ 						else if ((new_state[1] =3D=3D 60) ||
+ 							 (new_state[1] =3D=3D 56))
+ 						{
+ 							joypad_checked	=3D 1;
+ 							prevJoypadKeycodePressEmulated	=3D KEY_RIGHT;
+ 							new_state[5]	=3D 33;	//100001
+ 							report_key	=3D prevJoypadKeycodePressEmulated;
+ 							report_col	=3D 5;
+ 							report_row	=3D 0;
+ 							input_report_key(omap_kp_data->input,
+ 									report_key,
+ 							 		new_state[report_col] & (1 << report_row));
+ 						}
+ 						/*
+ 						 * enter, up_left and down_left sensors pressed
+ 						 * --> 100111 =3D=3D 39
+ 						 * or up_left and down_left
+ 						 * --> 100011 =3D=3D 35
+ 						 * --> move to left
+ 						 */
+ 						else if ((new_state[1] =3D=3D 39) ||
+ 							 (new_state[1] =3D=3D 35))
+ 						{
+ 							joypad_checked	=3D 1;
+ 							prevJoypadKeycodePressEmulated	=3D KEY_LEFT;
+ 							new_state[5]	=3D 36;	//100100
+ 							report_key	=3D prevJoypadKeycodePressEmulated;
+ 							report_col	=3D 5;
+ 							report_row	=3D 2;
+ 							input_report_key(omap_kp_data->input,
+ 									report_key,
+ 							 		new_state[report_col] & (1 << report_row));
+ 						}
+ 						else
+ 						{
+ 							//printk("missed new_state =3D %d\n", new_state[1]);
+ 						}
+ 					}
+ 					else
+ 					{
+ 						if (prevJoypadKeycodePressEmulated !=3D 0)
+ 						{
+ 							// report key up event
+ 							joypad_checked	=3D 1;
+ 							new_state[5]	=3D 32;	//100000
+ 							report_key	=3D prevJoypadKeycodePressEmulated;
+ 							report_col	=3D 5;
+ 							switch(prevJoypadKeycodePressEmulated)
+ 							{
+ 								case KEY_RIGHT:
+									report_row	=3D 0;
+ 									break;
+ 								case KEY_DOWN:
+ 									report_row	=3D 1;
+ 									break;
+ 								case KEY_LEFT:
+ 									report_row	=3D 2;
+ 									break;
+ 								case KEY_UP:
+ 									report_row	=3D 3;
+ 									break;
+ 								case KEY_ENTER:
+ 									report_row	=3D 4;
+ 									break;
+ 								default:
+ 									printk(KERN_WARNING "Unknown iPAQ h6300 column 1 key =3D %d re=
leased. This should newer happen!\n",
+ 										key);
+ 									report_row	=3D 0;
+ 							}
+ 							input_report_key(omap_kp_data->input,
+ 									report_key,
+ 							 		new_state[report_col] & (1 << report_row));
+ 							prevJoypadKeycodePressEmulated	=3D 0;
+ 						}
+ 					}
+ 				}
+ 			}
+ 			else
+ 			{
+ 				input_report_key(omap_kp_data->input, // &omap_kp_dev,=20
+ 						key,
+ 						new_state[col] & (1 << row));
+ 			}
 #endif
 		}
 	}
@@ -321,9 +540,15 @@ static int __init omap_kp_probe(struct p
 	} else if (machine_is_omap_perseus2()) {
 		keymap =3D p2_keymap;
 		keypad_irq =3D INT_730_MPUIO_KEYPAD;
+	} else if (machine_is_h6300()) {
+		keymap =3D h6300_keymap;
+		// set keyboard to send repeated key events if key is hold down
+		set_bit(EV_REP, =C2=A7.evbit);
 	} else {
+		printk("omap_keypad.c, keyMap =3D test_keymap\n");
 		keymap =3D test_keymap;
 	}
+	prevJoypadKeycodePressEmulated		=3D 0;
=20
 	init_timer(&omap_kp->timer);
 	omap_kp->timer.function =3D omap_kp_timer;

--------------020901030409040009090507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--------------020901030409040009090507--
