From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v4 4/5(7)] input: serio: add support for Amstrad Delta serial keyboard port
Date: Wed, 28 Apr 2010 03:10:50 +0200
Message-ID: <201004280310.52678.jkrzyszt@tis.icnet.pl>
References: <201004280252.58420.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:41377 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab0D1BOP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 21:14:15 -0400
In-Reply-To: <201004280252.58420.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, e3-hacking@earth.li

The patch introduces a serio driver that supports a keyboard serial port found
on the Amstrad Delta videophone board.

After initializing the hardware, the driver reads its input data from a buffer
filled in by the board FIQ (Fast Interrupt Request) handler.

Standard AT keyboard driver (atkbd) will be used on top of the serio layer for 
handling the E3 keyboard (called mailboard) connected to the port. Since the 
device generated scancodes differ from what the atkbd expects, a custom key 
code to scan code table must be loaded from userspace for the keyboard to be 
useable.

Compiles and works on top of PATCH v4 3/5(7), "OMAP1: Amstrad Delta: use FIQ 
for processing GPIO interrupts".

Created and tested against linux-omap master, 
commit 104a77440f05430f29f9d3f4ecb88c1536819585 dated 2010-04-27.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
v2 changes:
- use correct variable name for return value in ams_delta_kbd_init(),
- remove scan code to key code mapping,
- refreshed against linux-2.6.34-rc2.
v3 changes:
- cleanups suggested by Dmitry,
- force using of handle_simple_irq() to avoid GPIO register manipulation, 
  already handled at FIQ level,
- modify Kconfig for automatic AT keyboard and FIQ handler selection,
- misc cleanups.
v4 changes:
- drop automatic KEYBOARD_ATKBD selection and place the config back inside 
  the "if SERIO"..."endif" block,
- drop extra parenthesis.

 drivers/input/serio/Kconfig           |   16 +++
 drivers/input/serio/Makefile          |    1
 drivers/input/serio/ams_delta_serio.c |  177 ++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)

diff -uprN git.orig/drivers/input/serio/Kconfig git/drivers/input/serio/Kconfig
--- git.orig/drivers/input/serio/Kconfig	2010-04-27 21:41:00.000000000 +0200
+++ git/drivers/input/serio/Kconfig	2010-04-27 22:38:48.000000000 +0200
@@ -209,4 +209,20 @@ config SERIO_ALTERA_PS2
 	  To compile this driver as a module, choose M here: the
 	  module will be called altera_ps2.
 
+config SERIO_AMS_DELTA
+	tristate "Amstrad Delta (E3) mailboard support"
+	depends on MACH_AMS_DELTA
+	default y
+	select AMS_DELTA_FIQ
+	---help---
+	  Say Y here if you have an E3 and want to use its mailboard,
+	  or any standard AT keyboard connected to the mailboard port.
+
+	  When used for the E3 mailboard, a non-standard key table
+	  must be loaded from userspace, possibly using udev extras
+	  provided keymap helper utility.
+
+	  To compile this driver as a module, choose M here;
+	  the module will be called ams_delta_serio.
+
 endif
diff -uprN git.orig/drivers/input/serio/Makefile git/drivers/input/serio/Makefile
--- git.orig/drivers/input/serio/Makefile	2010-04-27 21:41:00.000000000 +0200
+++ git/drivers/input/serio/Makefile	2010-04-27 22:38:48.000000000 +0200
@@ -21,5 +21,6 @@ obj-$(CONFIG_SERIO_PCIPS2)	+= pcips2.o
 obj-$(CONFIG_SERIO_MACEPS2)	+= maceps2.o
 obj-$(CONFIG_SERIO_LIBPS2)	+= libps2.o
 obj-$(CONFIG_SERIO_RAW)		+= serio_raw.o
+obj-$(CONFIG_SERIO_AMS_DELTA)	+= ams_delta_serio.o
 obj-$(CONFIG_SERIO_XILINX_XPS_PS2)	+= xilinx_ps2.o
 obj-$(CONFIG_SERIO_ALTERA_PS2)	+= altera_ps2.o
diff -uprN git.orig/drivers/input/serio/ams_delta_serio.c git/drivers/input/serio/ams_delta_serio.c
--- git.orig/drivers/input/serio/ams_delta_serio.c	1970-01-01 01:00:00.000000000 +0100
+++ git/drivers/input/serio/ams_delta_serio.c	2010-04-27 22:38:48.000000000 +0200
@@ -0,0 +1,177 @@
+/*
+ *  Amstrad E3 (Delta) keyboard port driver
+ *
+ *  Copyright (c) 2006 Matt Callow
+ *  Copyright (c) 2010 Janusz Krzysztofik
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Thanks to Cliff Lawson for his help
+ *
+ * The Amstrad Delta keyboard (aka mailboard) uses normal PC-AT style serial
+ * transmission.  The keyboard port is formed of two GPIO lines, for clock
+ * and data.  Due to strict timing requirements of the interface,
+ * the serial data stream is read and processed by a FIQ handler.
+ * The resulting words are fetched by this driver from a circular buffer.
+ *
+ * Standard AT keyboard driver (atkbd) is used for handling the keyboard data.
+ * However, when used with the E3 mailboard that producecs non-standard
+ * scancodes, a custom key table must be prepared and loaded from userspace.
+ */
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/serio.h>
+#include <linux/slab.h>
+
+#include <asm/mach-types.h>
+#include <plat/board-ams-delta.h>
+
+#include <mach/ams-delta-fiq.h>
+
+MODULE_AUTHOR("Matt Callow");
+MODULE_DESCRIPTION("AMS Delta (E3) keyboard port driver");
+MODULE_LICENSE("GPL");
+
+static struct serio *ams_delta_serio;
+
+static int check_data(int data)
+{
+	int i, parity = 0;
+
+	/* check valid stop bit */
+	if (!(data & 0x400)) {
+		dev_warn(&ams_delta_serio->dev,
+				"invalid stop bit, data=0x%X\n",
+				data);
+		return SERIO_FRAME;
+	}
+	/* calculate the parity */
+	for (i = 1; i < 10; i++) {
+		if (data & (1 << i))
+			parity++;
+	}
+	/* it should be odd */
+	if (!(parity & 0x01)) {
+		dev_warn(&ams_delta_serio->dev,
+				"paritiy check failed, data=0x%X parity=0x%X\n",
+				data, parity);
+		return SERIO_PARITY;
+	}
+	return 0;
+}
+
+static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
+{
+	int *circ_buff = &fiq_buffer[FIQ_CIRC_BUFF];
+	int data, dfl;
+	u8 scancode;
+
+	fiq_buffer[FIQ_IRQ_PEND] = 0;
+
+	/*
+	 * Read data from the circular buffer, check it
+	 * and then pass it on the serio
+	 */
+	while (fiq_buffer[FIQ_KEYS_CNT] > 0) {
+
+		data = circ_buff[fiq_buffer[FIQ_HEAD_OFFSET]++];
+		fiq_buffer[FIQ_KEYS_CNT]--;
+		if (fiq_buffer[FIQ_HEAD_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
+			fiq_buffer[FIQ_HEAD_OFFSET] = 0;
+
+		dfl = check_data(data);
+		scancode = (u8) (data >> 1) & 0xFF;
+		serio_interrupt(ams_delta_serio, scancode, dfl);
+	}
+	return IRQ_HANDLED;
+}
+
+static int ams_delta_serio_open(struct serio *serio)
+{
+	/* enable keyboard */
+	ams_delta_latch2_write(AMD_DELTA_LATCH2_KEYBRD_PWR,
+			AMD_DELTA_LATCH2_KEYBRD_PWR);
+
+	return 0;
+}
+
+static void ams_delta_serio_close(struct serio *serio)
+{
+	/* disable keyboard */
+	ams_delta_latch2_write(AMD_DELTA_LATCH2_KEYBRD_PWR, 0);
+}
+
+static int __init ams_delta_serio_init(void)
+{
+	int err;
+
+	if (!machine_is_ams_delta())
+		return -ENODEV;
+
+	ams_delta_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!ams_delta_serio)
+		return -ENOMEM;
+
+	ams_delta_serio->id.type = SERIO_8042;
+	ams_delta_serio->open = ams_delta_serio_open;
+	ams_delta_serio->close = ams_delta_serio_close;
+	strlcpy(ams_delta_serio->name, "AMS DELTA keyboard adapter",
+			sizeof(ams_delta_serio->name));
+	strlcpy(ams_delta_serio->phys, "GPIO/serio0",
+			sizeof(ams_delta_serio->phys));
+
+	err = gpio_request(AMS_DELTA_GPIO_PIN_KEYBRD_DATA, "serio-data");
+	if (err) {
+		pr_err("ams_delta_serio: Couldn't request gpio pin for data\n");
+		goto serio;
+	}
+	gpio_direction_input(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
+
+	err = gpio_request(AMS_DELTA_GPIO_PIN_KEYBRD_CLK, "serio-clock");
+	if (err) {
+		pr_err("ams_delta_serio: couldn't request gpio pin for clock\n");
+		goto gpio_data;
+	}
+	gpio_direction_input(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
+
+	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
+			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
+			"ams-delta-serio", 0);
+	if (err < 0) {
+		pr_err("ams_delta_serio: couldn't request gpio interrupt %d\n",
+				gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
+		goto gpio_clk;
+	}
+	/*
+	 * Since GPIO register handling for keyboard clock pin is performed
+	 * at FIQ level, switch back from edge to simple interrupt handler
+	 * to avoid bad interaction.
+	 */
+	set_irq_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
+			handle_simple_irq);
+
+	serio_register_port(ams_delta_serio);
+	dev_info(&ams_delta_serio->dev, "%s\n", ams_delta_serio->name);
+
+	return 0;
+gpio_clk:
+	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
+gpio_data:
+	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
+serio:
+	kfree(ams_delta_serio);
+	return err;
+}
+module_init(ams_delta_serio_init);
+
+static void __exit ams_delta_serio_exit(void)
+{
+	serio_unregister_port(ams_delta_serio);
+	free_irq(OMAP_GPIO_IRQ(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
+	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
+	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
+	kfree(ams_delta_serio);
+}
+module_exit(ams_delta_serio_exit);
