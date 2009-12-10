From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][PATCH 4/5] input: serio: add support for Amstrad Delta serial keyboard port
Date: Thu, 10 Dec 2009 21:07:50 +0100
Message-ID: <200912102107.52375.jkrzyszt@tis.icnet.pl>
References: <200912102058.43892.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:40217 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbZLJUHj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Dec 2009 15:07:39 -0500
In-Reply-To: <200912102058.43892.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

The patch introduces a serio driver that supports a keyboard serial port found
on the Amstrad Delta videophone board.

After initializing the hardware, the driver reads its input data from a buffer
filled in by the board FIQ (Fast Interrupt Request) handler.

Compiles and works on to of patch 3/5: omap1: Amstrad Delta: use FIQ for
processing MPU GPIO interrupts

Created and tested against linux-omap for-next,
commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c dated 2009-12-02.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---

 drivers/input/serio/Kconfig              |    9 +
 drivers/input/serio/Makefile             |    1
 drivers/input/serio/ams_delta_keyboard.c |  240 +++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)

diff -uprN git.orig/drivers/input/serio/Kconfig git/drivers/input/serio/Kconfig
--- git.orig/drivers/input/serio/Kconfig	2009-12-02 15:51:50.000000000 +0100
+++ git/drivers/input/serio/Kconfig	2009-12-10 14:21:05.000000000 +0100
@@ -201,4 +201,13 @@ config SERIO_XILINX_XPS_PS2
 	  To compile this driver as a module, choose M here: the
 	  module will be called xilinx_ps2.
 
+config SERIO_AMS_DELTA
+	tristate "Amstrad Delta (E3) keyboard support"
+	depends on MACH_AMS_DELTA && AMS_DELTA_FIQ
+	---help---
+	  Say Y here if has an E3 and want to use the separate keyboard
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ams_delta_keyboard
+
 endif
diff -uprN git.orig/drivers/input/serio/Makefile git/drivers/input/serio/Makefile
--- git.orig/drivers/input/serio/Makefile	2009-12-02 15:51:50.000000000 +0100
+++ git/drivers/input/serio/Makefile	2009-12-10 14:21:05.000000000 +0100
@@ -21,4 +21,5 @@ obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
 obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
 obj-$(CONFIG_SERIO_LIBPS2)	+= libps2.o
 obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
+obj-$(CONFIG_SERIO_AMS_DELTA)	+= ams_delta_keyboard.o
 obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+= xilinx_ps2.o
diff -uprN git.orig/drivers/input/serio/ams_delta_keyboard.c git/drivers/input/serio/ams_delta_keyboard.c
--- git.orig/drivers/input/serio/ams_delta_keyboard.c	1970-01-01 01:00:00.000000000 +0100
+++ git/drivers/input/serio/ams_delta_keyboard.c	2009-12-10 14:50:47.000000000 +0100
@@ -0,0 +1,240 @@
+/*
+ *  Amstrad E3 (delta) keyboard driver
+ *
+ *  Copyright (c) 2006 Matt Callow
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Thanks to Cliff Lawson for his help
+ *
+ * The Amstrad Delta keyboard (or mailboard) is connected to GPIO 0 (clock)
+ * and GPIO 1 (data). It uses normal PC-AT style serial transmission,
+ * but the data and clock lines are inverted on the E3 mainboard,
+ * and the scancodes produced are non-standard
+ *
+ * Due to the strict timing requirements of the interface,
+ * the serial data stream is read using a FIQ handler, and then
+ * the resulting byte stream passed to this driver via a circular buffer.
+ */
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+#include <asm/fiq.h>
+#include <plat/board-ams-delta.h>
+#include <mach/ams-delta-fiq.h>
+
+MODULE_AUTHOR("Matt Callow");
+MODULE_DESCRIPTION("AMS Delta (E3) Keyboard driver");
+MODULE_LICENSE("GPL");
+
+#define MAX_SCANCODE 0x84
+
+/*
+ * This table converts the amstrad mailboard scancodes to normal PC-AT scancodes
+ * The diagram below shows the amstrad keyboard, with the raw scancodes
+ *
+ *   (70) (7A) (46) (7C) (77)   Amstrad     (72) (69) (1A) (2A) (1C) (15)
+ * [  71][1:74][2:73][3:6B][4:22][5:1B][6:1D][7:1E][8:79][9:7D][0:75][  6C]
+ *  [Q:21][W:23][E:24][R:26][T:52][Y:5D][U:0D][I:0E][O:32][P:34]  |return|
+ *   [A:31][S:33][D:35][F:36][G:29][H:5B][J:03][K:76][L:3A][@:3B]  |   2C|
+ *  [  3C][Z:3D][X:4E][C:54][V:0B][B:05][N:41][M:42][.:43][  3E][  55]
+ *  [  83][  06][  49][           4B         ][,:44][  16][  2E][  09]
+ *
+ * These scancodes are then translated to AT scancodes using the following table
+ * The amstrad keyboard does not produce any extended scancodes, but we need to
+ * translate some amstrad scancodes to a AT extended scancode, hence the 16bit
+ * value for the translated scancode
+ *
+ * Translations for the non-obvious keys are:
+ * Store      -> Tab
+ * Setup      -> Caps Lock
+ * Service    -> Backslash
+ * Games      -> Left Alt
+ * Internet   -> Right Alt
+ * Home       -> Home
+ * Office     -> Page Up
+ * Mobile     -> Page Down
+ * Mobile Msg -> Insert
+ * Email      -> Delete
+ * Fax        -> End
+ * Stop       -> Esc
+ * Symbol     -> Left Ctrl
+ * Calc       -> Right Ctrl
+ * Address    -> Scroll Lock
+ */
+
+static unsigned short trans_table[MAX_SCANCODE] = {
+	0,      0,      0, 0x003B,      0, 0x0032, 0x007E,      0,  /* 00..07 */
+	0, 0xE074,      0, 0x002A,      0, 0x003C, 0x0043,      0,  /* 08..0F */
+	0,      0,      0,      0,      0, 0xE069, 0xE06B,      0,  /* 10..17 */
+	0,      0, 0xE07A, 0x002E, 0xE071, 0x0036, 0x003D,      0,  /* 18..1F */
+	0, 0x0015, 0x0025, 0x001D, 0x0024,      0, 0x002D,      0,  /* 20..27 */
+	0, 0x0034, 0xE070,      0, 0x005A,      0, 0xE072,      0,  /* 28..2F */
+	0, 0x001C, 0x0044, 0x001B, 0x004D, 0x0023, 0x002B,      0,  /* 30..37 */
+	0,      0, 0x004B, 0x0052, 0x0012, 0x001A, 0xE075,      0,  /* 38..3F */
+	0, 0x0031, 0x003A, 0x0049, 0x0041,      0, 0x0061,      0,  /* 40..47 */
+	0, 0x0014,      0, 0x0029,      0,      0, 0x0022,      0,  /* 48..4F */
+	0,      0, 0x002C,      0, 0x0021, 0x0059,      0,      0,  /* 50..57 */
+	0,      0,      0, 0x0033,      0, 0x0035,      0,      0,  /* 58..5F */
+	0,      0,      0,      0,      0,      0,      0,      0,  /* 60..67 */
+	0, 0xE07D,      0, 0x0026, 0x0066,      0,      0,      0,  /* 68..6F */
+   0x000D, 0x0076, 0xE06C, 0x001E, 0x0016, 0x0045, 0x0042, 0xE011,  /* 70..77 */
+	0, 0x003E, 0x0058,      0, 0x0011, 0x0046,      0,      0,  /* 78..7F */
+	0,      0,      0, 0xE014                                   /* 80..83 */
+};
+
+static struct serio *ams_delta_kbd_port;
+
+static int check_data(int data)
+{
+	int i;
+	int parity = 0;
+
+	/* check valid stop bit */
+	if (!(data & 0x400)) {
+		printk(KERN_WARNING
+				"Invalid stop bit in AMS keyboard"
+				" data=0x%X\r\n", data);
+		return 0;
+	}
+	/* calculate the parity */
+	for (i = 1; i < 10; i++) {
+		if (data & (1 << i))
+			parity++;
+	}
+	/* it should be odd */
+	if (!(parity & 0x01)) {
+		printk(KERN_WARNING
+				"Paritiy check failed in AMS keyboard "
+				" data=0x%X parity 0x%X\r\n", data, parity);
+	}
+	return 1;
+}
+
+static irqreturn_t ams_delta_kbd_interrupt(int irq, void *dev_id,
+		struct pt_regs *regs)
+{
+	int *circ_buff = &fiq_buffer[FIQ_CIRC_BUFF];
+	/*
+	 * Read data from the CIRC buffer, check it, translate the scancode
+	 * and then pass it on the serio
+	 */
+	fiq_buffer[FIQ_IRQ_PEND] = 0;
+
+	while (fiq_buffer[FIQ_CHAR_CNT] > 0) {
+		int data;
+		u8 original_scancode;
+		unsigned short translated_scancode;
+
+		data = circ_buff[fiq_buffer[FIQ_BACK_OFFSET]] ;
+		fiq_buffer[FIQ_BACK_OFFSET]++;
+		fiq_buffer[FIQ_CHAR_CNT]--;
+		if (fiq_buffer[FIQ_BACK_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
+			fiq_buffer[FIQ_BACK_OFFSET] = 0;
+
+		if (check_data(data)) {
+			original_scancode = (u8) (data >> 1) & 0xFF;
+			if (original_scancode < MAX_SCANCODE) {
+				translated_scancode =
+						trans_table[original_scancode];
+				if ((translated_scancode & 0xff00) != 0) {
+					serio_interrupt(ams_delta_kbd_port,
+						translated_scancode >> 8, 0);
+				}
+				if ((translated_scancode & 0xff) != 0) {
+					serio_interrupt(ams_delta_kbd_port,
+						translated_scancode & 0xff, 0);
+				}
+			} else {
+				serio_interrupt(ams_delta_kbd_port,
+						original_scancode, 0);
+			}
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static struct serio * __init ams_delta_kbd_allocate_serio(void)
+{
+	struct serio *serio;
+
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		memset(serio, 0, sizeof(struct serio));
+		serio->id.type = SERIO_8042;
+		strlcpy(serio->name, "AMS DELTA keyboard adapter",
+				sizeof(serio->name));
+		snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", "GPIO");
+	}
+
+	return serio;
+}
+
+static int __init ams_delta_kbd_init(void)
+{
+	int err;
+
+	ams_delta_kbd_port = ams_delta_kbd_allocate_serio();
+	if (!ams_delta_kbd_port) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	if (gpio_request(AMS_DELTA_GPIO_PIN_KEYBRD_DATA, "kbd-data")) {
+		printk(KERN_ERR "Couldn't request gpio pin for keyboard data");
+		err = -EINVAL;
+		goto serio;
+	}
+	gpio_direction_input(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
+
+	if (gpio_request(AMS_DELTA_GPIO_PIN_KEYBRD_CLK, "kbd-clock")) {
+		printk(KERN_ERR "Couldn't request gpio pin for keyboard clock");
+		err = -EINVAL;
+		goto gpio_data;
+	}
+	gpio_direction_input(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
+
+	if (request_irq(OMAP_GPIO_IRQ(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
+		    ams_delta_kbd_interrupt, 0, "ams-delta-keyboard", 0) < 0) {
+		printk(KERN_ERR "Couldn't request gpio interrupt %d",
+				OMAP_GPIO_IRQ(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
+		err = -EINVAL;
+		goto gpio_clk;
+	}
+	set_irq_type(OMAP_GPIO_IRQ(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
+			IRQ_TYPE_EDGE_RISING);
+
+	/* enable keyboard */
+	ams_delta_latch2_write(AMD_DELTA_LATCH2_KEYBRD_PWR,
+			AMD_DELTA_LATCH2_KEYBRD_PWR);
+
+	serio_register_port(ams_delta_kbd_port);
+	printk(KERN_INFO "serio: AMS DELTA keyboard adapter\n");
+
+	return 0;
+gpio_clk:
+	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
+gpio_data:
+	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
+serio:
+	kfree(ams_delta_kbd_port);
+err:
+	return retval;
+}
+module_init(ams_delta_kbd_init);
+
+static void __exit ams_delta_kbd_exit(void)
+{
+	serio_unregister_port(ams_delta_kbd_port);
+	/* disable keyboard */
+	ams_delta_latch2_write(AMD_DELTA_LATCH2_KEYBRD_PWR, 0);
+	free_irq(OMAP_GPIO_IRQ(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
+	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
+	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
+	kfree(ams_delta_kbd_port);
+}
+module_exit(ams_delta_kbd_exit);
