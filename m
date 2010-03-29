From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][PATCH v2 4/5] input: serio: add support for Amstrad Delta serial keyboard port
Date: Mon, 29 Mar 2010 16:30:41 +0200
Message-ID: <201003291630.43694.jkrzyszt@tis.icnet.pl>
References: <201003291619.25878.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:45267 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696Ab0C2ObD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Mar 2010 10:31:03 -0400
In-Reply-To: <201003291619.25878.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, e3-hacking@earth.li

The patch introduces a serio driver that supports a keyboard serial port found
on the Amstrad Delta videophone board.

After initializing the hardware, the driver reads its input data from a buffer
filled in by the board FIQ (Fast Interrupt Request) handler.

Standard AT keyboard driver (atkbd) will be used on top of the serio layer for 
handling the E3 keyboard (called mailboard) connected to the port. Since the 
device generated scancodes differ from what the atkbd expects, a custom key 
code to scan code table must be loaded from userspace for the keyboard to be 
useable.

Compiles and works on to of patch 3/5:
	omap1: Amstrad Delta: use FIQ for processing GPIO interrupts

Created and tested against linux-2.6.34-rc2.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
v2 changes:
- use correct variable name for return value in ams_delta_kbd_init(),
- remove scan code to key code mapping,
- refreshed against linux-2.6.34-rc2.

 drivers/input/serio/Kconfig              |    9 +
 drivers/input/serio/Makefile             |    1
 drivers/input/serio/ams_delta_keyboard.c |  171 +++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)

diff -uprN git.orig/drivers/input/serio/Kconfig git/drivers/input/serio/Kconfig
--- git.orig/drivers/input/serio/Kconfig	2010-03-25 15:55:42.000000000 +0100
+++ git/drivers/input/serio/Kconfig	2010-03-28 23:42:09.000000000 +0200
@@ -209,4 +209,13 @@ config SERIO_ALTERA_PS2
 	  To compile this driver as a module, choose M here: the
 	  module will be called altera_ps2.
 
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
--- git.orig/drivers/input/serio/Makefile	2010-03-25 15:55:42.000000000 +0100
+++ git/drivers/input/serio/Makefile	2010-03-28 23:42:09.000000000 +0200
@@ -21,5 +21,6 @@ obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
 obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
 obj-$(CONFIG_SERIO_LIBPS2)	+= libps2.o
 obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
+obj-$(CONFIG_SERIO_AMS_DELTA)	+= ams_delta_keyboard.o
 obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+= xilinx_ps2.o
 obj-$(CONFIG_SERIO_ALTERA_PS2)	+= altera_ps2.o
diff -uprN git.orig/drivers/input/serio/ams_delta_keyboard.c git/drivers/input/serio/ams_delta_keyboard.c
--- git.orig/drivers/input/serio/ams_delta_keyboard.c	1970-01-01 01:00:00.000000000 +0100
+++ git/drivers/input/serio/ams_delta_keyboard.c	2010-03-28 23:42:09.000000000 +0200
@@ -0,0 +1,171 @@
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
+		u8 scancode;
+
+		data = circ_buff[fiq_buffer[FIQ_BACK_OFFSET]] ;
+		fiq_buffer[FIQ_BACK_OFFSET]++;
+		fiq_buffer[FIQ_CHAR_CNT]--;
+		if (fiq_buffer[FIQ_BACK_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
+			fiq_buffer[FIQ_BACK_OFFSET] = 0;
+
+		if (check_data(data)) {
+			scancode = (u8) (data >> 1) & 0xFF;
+			serio_interrupt(ams_delta_kbd_port, scancode, 0);
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
+	return err;
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
