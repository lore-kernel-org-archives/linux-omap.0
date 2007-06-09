From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 11/12] Add support for keys setting multiple bits in the scan
Date: Sat, 9 Jun 2007 20:47:27 +0200
Message-ID: <20070609184727.GK1889@varda>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch adds support for keypads with keys setting multiple bits in the scan
when they are pressed. An example of such keys is the HTC Typhoon stick for
which scanning column zero will return the following bit patterns depending on
the direction:

LEFT:  00000011  
RIGHT: 00001100
UP:    00000101
DOWN:  00001010

In this case, the key being pressed cannot be determined from a single bit.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>

---
 arch/arm/mach-omap1/board-ams-delta.c |    2 -
 arch/arm/mach-omap1/board-fsample.c   |    1 -
 arch/arm/mach-omap1/board-h2.c        |    3 +-
 arch/arm/mach-omap1/board-h3.c        |    3 +-
 arch/arm/mach-omap1/board-innovator.c |    3 +-
 arch/arm/mach-omap1/board-nokia770.c  |    1 -
 arch/arm/mach-omap1/board-osk.c       |    1 -
 arch/arm/mach-omap1/board-palmte.c    |    1 -
 arch/arm/mach-omap1/board-palmz71.c   |    1 -
 arch/arm/mach-omap1/board-perseus2.c  |    3 +-
 arch/arm/mach-omap1/board-sx1.c       |    1 -
 arch/arm/mach-omap1/board-typhoon.c   |   61 +++++++++++++++++
 arch/arm/mach-omap2/board-2430sdp.c   |    1 -
 arch/arm/mach-omap2/board-h4.c        |    3 +-
 drivers/input/keyboard/omap-keypad.c  |  117 +++++++++++++++++----------------
 include/asm-arm/arch-omap/keypad.h    |   12 +++-
 16 files changed, 134 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c73ca61..51c1778 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -109,8 +109,6 @@ static int ams_delta_keymap[] = {
 
 	KEY(0, 7, KEY_LEFTSHIFT),	/* Vol up    */
 	KEY(3, 7, KEY_LEFTCTRL),	/* Vol down  */
-
-	0
 };
 
 void ams_delta_latch1_write(u8 mask, u8 value)
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index f65baa9..ade0ebf 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -66,7 +66,6 @@ static int fsample_keymap[] = {
 	KEY(4,3,KEY_7),
 	KEY(4,4,KEY_STAR),
 	KEY(4,5,KEY_POWER),
-	0
 };
 
 static struct resource smc91x_resources[] = {
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index d2214ad..2aac5d7 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -50,7 +50,7 @@
 
 extern int omap_gpio_init(void);
 
-static int h2_keymap[] = {
+static struct kp_key h2_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
 	KEY(0, 2, KEY_3),
@@ -86,7 +86,6 @@ static int h2_keymap[] = {
 	KEY(5, 2, KEY_F15),
 	KEY(5, 3, KEY_F16),
 	KEY(5, 4, KEY_SLEEP),
-	0
 };
 
 static struct mtd_partition h2_nor_partitions[] = {
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index df77cf5..2d1cbaa 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -52,7 +52,7 @@
 
 extern int omap_gpio_init(void);
 
-static int h3_keymap[] = {
+static struct kp_key h3_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
 	KEY(0, 2, KEY_3),
@@ -88,7 +88,6 @@ static int h3_keymap[] = {
 	KEY(5, 2, KEY_F15),
 	KEY(5, 3, KEY_F16),
 	KEY(5, 4, KEY_SLEEP),
-	0
 };
 
 
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 7e63a41..1f2d0ff 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -40,7 +40,7 @@
 #include <asm/arch/mcbsp.h>
 #include <asm/arch/omap-alsa.h>
 
-static int innovator_keymap[] = {
+static struct kp_key innovator_keymap[] = {
 	KEY(0, 0, KEY_F1),
 	KEY(0, 3, KEY_DOWN),
 	KEY(1, 1, KEY_F2),
@@ -50,7 +50,6 @@ static int innovator_keymap[] = {
 	KEY(2, 2, KEY_UP),
 	KEY(3, 2, KEY_ENTER),
 	KEY(3, 3, KEY_LEFT),
-	0
 };
 
 static struct mtd_partition innovator_partitions[] = {
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index df5bda2..610bbe6 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -68,7 +68,6 @@ static int nokia770_keymap[] = {
 	KEY(3, 0, GROUP_2 | KEY_F7),
 	KEY(3, 1, GROUP_2 | KEY_F8),
 	KEY(3, 2, GROUP_2 | KEY_F6),
-	0
 };
 
 static struct resource nokia770_kp_resources[] = {
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 39bc977..100ffb6 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -264,7 +264,6 @@ static const int osk_keymap[] = {
 	KEY(2, 2, KEY_DOWN),		/* (sw2/down) */
 	KEY(3, 2, KEY_ENTER),		/* (sw2/select) */
 	KEY(3, 3, KEY_RIGHT),		/* (sw2/right) */
-	0
 };
 
 static struct omap_kp_platform_data osk_kp_data = {
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index e5e0957..587144a 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -65,7 +65,6 @@ static const int palmte_keymap[] = {
 	KEY(1, 2, KEY_UP),
 	KEY(1, 3, KEY_RIGHT),
 	KEY(1, 4, KEY_CENTER),
-	0,
 };
 
 static struct omap_kp_platform_data palmte_kp_data = {
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 6b49c71..240e3be 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -68,7 +68,6 @@ static int palmz71_keymap[] = {
 	KEY(1, 3, KEY_RIGHT),
 	KEY(1, 4, KEY_CENTER),
 	KEY(2, 0, KEY_CAMERA),
-	0,
 };
 
 static struct omap_kp_platform_data palmz71_kp_data = {
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 2dec048..62244ab 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -34,7 +34,7 @@
 #include <asm/arch/common.h>
 #include <asm/arch/board.h>
 
-static int p2_keymap[] = {
+static struct kp_key p2_keymap[] = {
 	KEY(0,0,KEY_UP),
 	KEY(0,1,KEY_RIGHT),
 	KEY(0,2,KEY_LEFT),
@@ -65,7 +65,6 @@ static int p2_keymap[] = {
 	KEY(4,3,KEY_7),
 	KEY(4,4,KEY_STAR),
 	KEY(4,5,KEY_POWER),
-	0
 };
 
 static struct resource smc91x_resources[] = {
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index f25ec6f..9c56d59 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -202,7 +202,6 @@ static int sx1_keymap[] = {
 	KEY(2, 1, GROUP_1 | KEY_LEFTSHIFT), /* shift */
 	KEY(1, 1, GROUP_1 | KEY_BACKSPACE), /* C (clear) */
 	KEY(0, 2, GROUP_1 | KEY_F7),	/* menu Qt::Key_Menu */
-	0
 };
 
 static struct resource sx1_kp_resources[] = {
diff --git a/arch/arm/mach-omap1/board-typhoon.c b/arch/arm/mach-omap1/board-typhoon.c
index 814cf3f..a469616 100644
--- a/arch/arm/mach-omap1/board-typhoon.c
+++ b/arch/arm/mach-omap1/board-typhoon.c
@@ -37,8 +37,68 @@
 
 #include <asm/arch/board.h>
 #include <asm/arch/usb.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/board-typhoon.h>
 
+/* Keypad device */
+static struct kp_key typhoon_keymap[] = {
+	MULTIKEY(0x0000000000000003ULL, KEY_LEFT),
+	MULTIKEY(0x000000000000000CULL, KEY_RIGHT),
+	MULTIKEY(0x0000000000000005ULL, KEY_UP),
+	MULTIKEY(0x000000000000000AULL, KEY_DOWN),
+	KEY(0,0,KEY_PREVIOUSSONG),
+	KEY(0,1,KEY_PLAYPAUSE),
+	KEY(0,2,KEY_NEXTSONG),
+	KEY(0,3,KEY_MEDIA),
+	KEY(1,0,KEY_1),
+	KEY(2,0,KEY_2),
+	KEY(3,0,KEY_3),
+	KEY(4,0,KEY_4),
+	KEY(1,1,KEY_5),
+	KEY(2,1,KEY_6),
+	KEY(3,1,KEY_7),
+	KEY(4,1,KEY_8),
+	KEY(1,2,KEY_9),
+	KEY(2,2,KEY_0),
+	KEY(3,2,KEY_STAR),
+	KEY(4,2,KEY_SHARP),
+	KEY(1,3,KEY_SOFT1),
+	KEY(2,3,KEY_SOFT2),
+	KEY(3,3,KEY_HOME),
+	KEY(4,3,KEY_BACK),
+	KEY(0,5,KEY_VOLUMEUP),
+	KEY(1,5,KEY_VOLUMEDOWN),
+	KEY(2,5,KEY_CAMERA),
+	KEY(3,5,KEY_PHONE),
+	KEY(4,5,KEY_MUTE),
+};
+
+static struct resource kp_resources[] = {
+	[0] = {
+		.start	= INT_730_MPUIO_KEYPAD,
+		.end	= INT_730_MPUIO_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_kp_platform_data kp_data = {
+	.rows		= 8,
+	.cols		= 8,
+	.keymap		= typhoon_keymap,
+	.keymapsize	= ARRAY_SIZE(typhoon_keymap),
+	.delay		= 20, /* XXX: find actual value */
+};
+
+static struct platform_device kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(kp_resources),
+	.resource	= kp_resources,
+};
+
 /* LCD device */
 static struct platform_device lcd_device = {
 	.name		= "lcd_typhoon",
@@ -77,6 +137,7 @@ static struct platform_device gsm_device = {
 
 /* Devices */
 static struct platform_device *devices[] __initdata = {
+	&kp_device,
 	&lcd_device,
 	&gsm_device,
 };
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 047a4e6..4be37fb 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -167,7 +167,6 @@ static int sdp2430_keymap[] = {
 	KEY(5, 2, KEY_L),
 	KEY(5, 3, KEY_S),
 	KEY(5, 4, KEY_H),
-	0
 };
 
 static struct omap_kp_platform_data sdp2430_kp_data = {
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index f476c57..8431df0 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -48,7 +48,7 @@
 static unsigned int row_gpios[6] = { 88, 89, 124, 11, 6, 96 };
 static unsigned int col_gpios[7] = { 90, 91, 100, 36, 12, 97, 98 };
 
-static int h4_keymap[] = {
+static struct kp_key h4_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
 	KEY(0, 2, KEY_A),
@@ -79,7 +79,6 @@ static int h4_keymap[] = {
 	KEY(5, 2, KEY_L),
 	KEY(5, 3, KEY_S),
 	KEY(5, 4, KEY_ENTER),
-	0
 };
 
 static struct mtd_partition h4_partitions[] = {
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 6aea1b1..8adeb69 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -9,6 +9,9 @@
  * Added support for H2 & H3 Keypad
  * Copyright (C) 2004 Texas Instruments
  *
+ * Added support for HTC Typhoon and multiple key events
+ * Copyright (C) 2005 Vivien Chappelier
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -49,7 +52,7 @@
 static void omap_kp_tasklet(unsigned long);
 static void omap_kp_timer(unsigned long);
 
-static unsigned char keypad_state[8];
+static u64 keypad_state;
 static DEFINE_MUTEX(kp_enable_mutex);
 static int kp_enable = 1;
 static int kp_cur_group = -1;
@@ -68,7 +71,8 @@ struct omap_kp {
 
 DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);
 
-static int *keymap;
+static unsigned int keymap_size;
+static struct kp_key *keymap;
 static unsigned int *row_gpios;
 static unsigned int *col_gpios;
 
@@ -131,9 +135,11 @@ static void omap_kp_timer(unsigned long data)
 	tasklet_schedule(&kp_tasklet);
 }
 
-static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
+static u64 omap_kp_scan_keypad(struct omap_kp *omap_kp)
 {
-	int col = 0;
+	u64 state = 0;
+	u64 reg;
+	int col;
 
 	/* read the keypad status */
 	if (cpu_is_omap24xx()) {
@@ -144,7 +150,8 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 		/* read the keypad status */
 		for (col = 0; col < omap_kp->cols; col++) {
 			set_col_gpio_val(omap_kp, ~(1 << col));
-			state[col] = ~(get_row_gpio_val(omap_kp)) & 0x3f;
+			state |= ((u64) ~(get_row_gpio_val(omap_kp)) & 0x3f)
+				<< (8 * col);
 		}
 		set_col_gpio_val(omap_kp, 0);
 
@@ -160,74 +167,67 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 
 			udelay(omap_kp->delay);
 
-			state[col] = ~omap_readw(OMAP_MPUIO_BASE +
-						 OMAP_MPUIO_KBR_LATCH) & 0xff;
+			reg = omap_readw(OMAP_MPUIO_BASE +
+					 OMAP_MPUIO_KBR_LATCH);
+			state |= ((u64) ~reg & 0xff) << (8 * col);
 		}
 		omap_writew(0x00, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
 		udelay(2);
 	}
-}
 
-static inline int omap_kp_find_key(int col, int row)
-{
-	int i, key;
-
-	key = KEY(col, row, 0);
-	for (i = 0; keymap[i] != 0; i++)
-		if ((keymap[i] & 0xff000000) == key)
-			return keymap[i] & 0x00ffffff;
-	return -1;
+	return(state);
 }
 
 static void omap_kp_tasklet(unsigned long data)
 {
 	struct omap_kp *omap_kp_data = (struct omap_kp *) data;
-	unsigned char new_state[8], changed, key_down = 0;
-	int col, row;
+	u64 keycode, keymask, pending;
+	int i;
+	int key, pressed;
 	int spurious = 0;
 
 	/* check for any changes */
-	omap_kp_scan_keypad(omap_kp_data, new_state);
-
-	/* check for changes and print those */
-	for (col = 0; col < omap_kp_data->cols; col++) {
-		changed = new_state[col] ^ keypad_state[col];
-		key_down |= new_state[col];
-		if (changed == 0)
-			continue;
-
-		for (row = 0; row < omap_kp_data->rows; row++) {
-			int key;
-			if (!(changed & (1 << row)))
-				continue;
+	keycode = omap_kp_scan_keypad(omap_kp_data);
+	keymask = keycode ^ keypad_state;
+
 #ifdef NEW_BOARD_LEARNING_MODE
-			printk(KERN_INFO "omap-keypad: key %d-%d %s\n", col,
-			       row, (new_state[col] & (1 << row)) ?
-			       "pressed" : "released");
+	if(keymask)
+		printk(KERN_INFO "omap-keypad: key 0x%llx %s\n",
+		       keymask, (keycode & keymask) ? "pressed" : "released");
 #else
-			key = omap_kp_find_key(col, row);
-			if (key < 0) {
-				printk(KERN_WARNING
-				      "omap-keypad: Spurious key event %d-%d\n",
-				       col, row);
-				/* We scan again after a couple of seconds */
-				spurious = 1;
-				continue;
+	/* find the corresponding key */
+	pending = 0;
+	for (i = 0; i < keymap_size; i++)
+		if (keymap[i].keycode & keymask) {
+			if((keymap[i].keycode & keymask) != keymap[i].keycode)
+				pending |= keymask & keymap[i].keycode;
+			else {
+				/* all key events received */
+				key = keymap[i].key;
+				pressed = (keycode & keymap[i].keycode)?1:0;
+				pending &= ~keymap[i].keycode;
+				keymask &= ~keymap[i].keycode;
+				if (!(kp_cur_group == (key & GROUP_MASK) ||
+				      kp_cur_group == -1))
+					continue;
+
+				kp_cur_group = key & GROUP_MASK;
+				input_report_key(omap_kp_data->input,
+						 key & ~GROUP_MASK, pressed);
 			}
-
-			if (!(kp_cur_group == (key & GROUP_MASK) ||
-			      kp_cur_group == -1))
-				continue;
-
-			kp_cur_group = key & GROUP_MASK;
-			input_report_key(omap_kp_data->input, key & ~GROUP_MASK,
-					 new_state[col] & (1 << row));
-#endif
 		}
+
+	if (keymask & ~pending) {
+		printk(KERN_WARNING "omap-keypad: Spurious key event 0x%llx\n",
+		       keymask);
+		/* We scan again after a couple of seconds */
+		spurious = 1;
+		keymask &= pending;
 	}
-	memcpy(keypad_state, new_state, sizeof(keypad_state));
+#endif
+	keypad_state = keycode ^ keymask;
 
-	if (key_down) {
+	if (keycode) {
                 int delay = HZ / 20;
 		/* some key is pressed - keep irq disabled and use timer
 		 * to poll the keypad */
@@ -343,6 +343,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	keymap = pdata->keymap;
+	keymap_size = pdata->keymapsize;
 
 	if (pdata->rep)
 		set_bit(EV_REP, input_dev->evbit);
@@ -393,9 +394,9 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 
 	/* setup input device */
 	set_bit(EV_KEY, input_dev->evbit);
-	for (i = 0; keymap[i] != 0; i++)
-		set_bit(keymap[i] & KEY_MAX, input_dev->keybit);
-	input_dev->name = "omap-keypad";
+	for (i = 0; i < keymap_size; i++)
+		set_bit(keymap[i].key & KEY_MAX, input_dev->keybit);
+ 	input_dev->name = "omap-keypad";
 	input_dev->phys = "omap-keypad/input0";
 	input_dev->dev.parent = &pdev->dev;
 
@@ -418,7 +419,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
 
 	/* scan current status and enable interrupt */
-	omap_kp_scan_keypad(omap_kp, keypad_state);
+	keypad_state = omap_kp_scan_keypad(omap_kp);
 	if (!cpu_is_omap24xx()) {
 		omap_kp->irq = platform_get_irq(pdev, 0);
 		if (omap_kp->irq >= 0) {
diff --git a/include/asm-arm/arch-omap/keypad.h b/include/asm-arm/arch-omap/keypad.h
index b7f8307..f976088 100644
--- a/include/asm-arm/arch-omap/keypad.h
+++ b/include/asm-arm/arch-omap/keypad.h
@@ -10,10 +10,15 @@
 #ifndef ASMARM_ARCH_KEYPAD_H
 #define ASMARM_ARCH_KEYPAD_H
 
+struct kp_key {
+	u64 keycode;
+	unsigned int key;
+};
+
 struct omap_kp_platform_data {
 	int rows;
 	int cols;
-	int *keymap;
+	struct kp_key *keymap;
 	unsigned int keymapsize;
 	unsigned int rep:1;
 	unsigned long delay;
@@ -23,6 +28,9 @@ struct omap_kp_platform_data {
 	unsigned int *col_gpios;
 };
 
+#define MULTIKEY(mask, val) { .keycode = mask, .key = val }
+#define KEY(col, row, val) MULTIKEY(((u64) (1 << row)) << (8 * (col)), val)
+
 /* Group (0..3) -- when multiple keys are pressed, only the
  * keys pressed in the same group are considered as pressed. This is
  * in order to workaround certain crappy HW designs that produce ghost
@@ -33,7 +41,5 @@ struct omap_kp_platform_data {
 #define GROUP_3		(3 << 16)
 #define GROUP_MASK	GROUP_3
 
-#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
-
 #endif
 
-- 
1.5.1.3
