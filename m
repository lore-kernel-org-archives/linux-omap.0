From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 13/33] Add omap touchscreen driver
Date: Sat, 30 Aug 2008 20:16:13 +0300
Message-ID: <1220116593-862-14-git-send-email-me@felipebalbi.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
 <1220116593-862-2-git-send-email-me@felipebalbi.com>
 <1220116593-862-3-git-send-email-me@felipebalbi.com>
 <1220116593-862-4-git-send-email-me@felipebalbi.com>
 <1220116593-862-5-git-send-email-me@felipebalbi.com>
 <1220116593-862-6-git-send-email-me@felipebalbi.com>
 <1220116593-862-7-git-send-email-me@felipebalbi.com>
 <1220116593-862-8-git-send-email-me@felipebalbi.com>
 <1220116593-862-9-git-send-email-me@felipebalbi.com>
 <1220116593-862-10-git-send-email-me@felipebalbi.com>
 <1220116593-862-11-git-send-email-me@felipebalbi.com>
 <1220116593-862-12-git-send-email-me@felipebalbi.com>
 <1220116593-862-13-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36446 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbYH3RUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:20:52 -0400
In-Reply-To: <1220116593-862-13-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/touchscreen/Makefile       |    1 +
 drivers/input/touchscreen/omap/Makefile  |   10 +
 drivers/input/touchscreen/omap/omap_ts.c |  267 ++++++++++++++++++++++++++++++
 drivers/input/touchscreen/omap/omap_ts.h |   57 +++++++
 drivers/input/touchscreen/omap/ts_hx.c   |  184 ++++++++++++++++++++
 5 files changed, 519 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/omap/Makefile
 create mode 100644 drivers/input/touchscreen/omap/omap_ts.c
 create mode 100644 drivers/input/touchscreen/omap/omap_ts.h
 create mode 100644 drivers/input/touchscreen/omap/ts_hx.c

diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 0342389..e0bc8fb 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
+obj-$(CONFIG_TOUCHSCREEN_OMAP)	+= omap/
 obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+= wm97xx-ts.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9705)	+= wm9705.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712)	+= wm9712.o
diff --git a/drivers/input/touchscreen/omap/Makefile b/drivers/input/touchscreen/omap/Makefile
new file mode 100644
index 0000000..af6344e
--- /dev/null
+++ b/drivers/input/touchscreen/omap/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for the OMAP touchscreen input driver
+#
+
+obj-$(CONFIG_TOUCHSCREEN_OMAP) += omapts.o
+
+objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_H2) += ts_hx.o
+objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_H3) += ts_hx.o
+
+omapts-objs := omap_ts.o $(objs-yy)
diff --git a/drivers/input/touchscreen/omap/omap_ts.c b/drivers/input/touchscreen/omap/omap_ts.c
new file mode 100644
index 0000000..ee85755
--- /dev/null
+++ b/drivers/input/touchscreen/omap/omap_ts.c
@@ -0,0 +1,267 @@
+/*
+ * input/touchscreen/omap/omap_ts.c
+ *
+ * touchscreen input device driver for various TI OMAP boards
+ * Copyright (c) 2002 MontaVista Software Inc.
+ * Copyright (c) 2004 Texas Instruments, Inc.
+ * Cleanup and modularization 2004 by Dirk Behme <dirk.behme@de.bosch.com>
+ *
+ * Assembled using driver code copyright the companies above.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * History:
+ * 12/12/2004    Srinath Modified and intergrated code for H2 and H3
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+#include <linux/interrupt.h>
+#include <linux/suspend.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-types.h>
+
+//#define DEBUG
+
+#include "omap_ts.h"
+
+#define OMAP_TS_NAME	"omap_ts"
+
+static struct ts_device *__initdata ts_devs[] = {
+#if defined(CONFIG_MACH_OMAP_H2) || defined(CONFIG_MACH_OMAP_H3)
+	&hx_ts,
+#endif
+};
+
+static struct omap_ts_t ts_omap;
+
+static int omap_ts_read(void)
+{
+	u16 data[4] = { 0, 0, 0, 0 };
+
+	ts_omap.dev->read(data);
+
+	input_report_abs(ts_omap.inputdevice, ABS_X, data[0]);
+	input_report_abs(ts_omap.inputdevice, ABS_Y, data[1]);
+	input_report_abs(ts_omap.inputdevice, ABS_PRESSURE, data[2]);
+	input_sync(ts_omap.inputdevice);
+
+	DEBUG_TS("omap_ts_read: read x=%d,y=%d,p=%d\n", data[0], data[1],
+		 data[2]);
+
+	return 0;
+}
+
+static void omap_ts_timer(unsigned long data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts_omap.lock, flags);
+
+	if (!ts_omap.dev->penup()) {
+		if (!ts_omap.touched) {
+			DEBUG_TS("omap_ts_timer: pen down\n");
+			input_report_key(ts_omap.inputdevice, BTN_TOUCH, 1);
+		}
+		ts_omap.touched = 1;
+		omap_ts_read();
+		ts_omap.ts_timer.expires = jiffies + HZ / 100;
+		add_timer(&(ts_omap.ts_timer));
+	} else {
+		if (ts_omap.touched) {
+			DEBUG_TS("omap_ts_timer: pen up\n");
+			ts_omap.touched = 0;
+			input_report_abs(ts_omap.inputdevice, ABS_X, 0);
+			input_report_abs(ts_omap.inputdevice, ABS_Y, 0);
+			input_report_abs(ts_omap.inputdevice, ABS_PRESSURE,
+					 0);
+			input_sync(ts_omap.inputdevice);
+			input_report_key(ts_omap.inputdevice, BTN_TOUCH, 0);
+		}
+		if (!ts_omap.irq_enabled) {
+			ts_omap.irq_enabled = 1;
+			enable_irq(ts_omap.irq);
+		}
+	}
+
+	spin_unlock_irqrestore(&ts_omap.lock, flags);
+}
+
+static irqreturn_t omap_ts_handler(int irq, void *dev_id)
+{
+	spin_lock(&ts_omap.lock);
+
+	if (ts_omap.irq_enabled) {
+		ts_omap.irq_enabled = 0;
+		disable_irq(irq);
+	}
+	// restart acquire
+	mod_timer(&ts_omap.ts_timer, jiffies + HZ / 100);
+
+	spin_unlock(&ts_omap.lock);
+
+	return IRQ_HANDLED;
+}
+
+static int __init omap_ts_probe(struct platform_device *pdev)
+{
+	int i;
+	int status = -ENODEV;
+
+	memset(&ts_omap, 0, sizeof(ts_omap));
+
+	ts_omap.inputdevice = input_allocate_device();
+	if (!ts_omap.inputdevice) {
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&ts_omap.lock);
+
+	for (i = 0; i < ARRAY_SIZE(ts_devs); i++) {
+		if (!ts_devs[i] || !ts_devs[i]->probe)
+			continue;
+		status = ts_devs[i]->probe(&ts_omap);
+		if (status == 0) {
+			ts_omap.dev = ts_devs[i];
+			break;
+		}
+	}
+
+	if (status != 0) {
+	    	input_free_device(ts_omap.inputdevice);
+		return status;
+	}
+
+	// Init acquisition timer function
+	init_timer(&ts_omap.ts_timer);
+	ts_omap.ts_timer.function = omap_ts_timer;
+
+	/* request irq */
+	if (ts_omap.irq != -1) {
+		if (request_irq(ts_omap.irq, omap_ts_handler,
+				IRQF_SAMPLE_RANDOM | ts_omap.irq_type,
+				OMAP_TS_NAME, &ts_omap)) {
+			printk(KERN_ERR
+	  "omap_ts.c: Could not allocate touchscreen IRQ!\n");
+			ts_omap.irq = -1;
+			ts_omap.dev->remove();
+			input_free_device(ts_omap.inputdevice);
+			return -EINVAL;
+		}
+		ts_omap.irq_enabled = 1;
+	} else {
+		printk(KERN_ERR "omap_ts.c: No touchscreen IRQ assigned!\n");
+		ts_omap.dev->remove();
+		input_free_device(ts_omap.inputdevice);
+		return -EINVAL;
+	}
+
+	ts_omap.inputdevice->name = OMAP_TS_NAME;
+	ts_omap.inputdevice->dev = &pdev->dev;
+	ts_omap.inputdevice->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	ts_omap.inputdevice->keybit[BIT_WORD(BTN_TOUCH)] |= BIT(BTN_TOUCH);
+	ts_omap.inputdevice->absbit[0] =
+	    BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	input_register_device(ts_omap.inputdevice);
+
+	ts_omap.dev->enable();
+
+	printk("OMAP touchscreen driver initialized\n");
+
+	return 0;
+}
+
+static int omap_ts_remove(struct platform_device *pdev)
+{
+	ts_omap.dev->disable();
+	input_unregister_device(ts_omap.inputdevice);
+	if (ts_omap.irq != -1)
+		free_irq(ts_omap.irq, &ts_omap);
+
+	ts_omap.dev->remove();
+
+	return 0;
+}
+
+static int omap_ts_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	ts_omap.dev->disable();
+	return 0;
+}
+
+static int omap_ts_resume(struct platform_device *pdev)
+{
+	ts_omap.dev->enable();
+	return 0;
+}
+
+static void omap_ts_device_release(struct device *dev)
+{
+	/* Nothing */
+}
+static struct platform_driver omap_ts_driver = {
+	.probe 		= omap_ts_probe,
+	.remove 	= omap_ts_remove,
+	.suspend 	= omap_ts_suspend,
+	.resume 	= omap_ts_resume,
+	.driver = {
+		.name	= OMAP_TS_NAME,
+	},
+};
+
+static struct platform_device omap_ts_device = {
+	.name 		= OMAP_TS_NAME,
+	.id 		= -1,
+	.dev = {
+		.release 	= omap_ts_device_release,
+	},
+};
+
+static int __init omap_ts_init(void)
+{
+	int ret;
+
+	if (machine_is_omap_osk() || machine_is_omap_innovator())
+		return -ENODEV;
+
+	ret = platform_device_register(&omap_ts_device);
+	if (ret != 0)
+		return -ENODEV;
+
+	ret = platform_driver_register(&omap_ts_driver);
+	if (ret != 0) {
+		platform_device_unregister(&omap_ts_device);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit omap_ts_exit(void)
+{
+	platform_driver_unregister(&omap_ts_driver);
+	platform_device_unregister(&omap_ts_device);
+}
+
+module_init(omap_ts_init);
+module_exit(omap_ts_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/omap/omap_ts.h b/drivers/input/touchscreen/omap/omap_ts.h
new file mode 100644
index 0000000..bef8e17
--- /dev/null
+++ b/drivers/input/touchscreen/omap/omap_ts.h
@@ -0,0 +1,57 @@
+/*
+ * omap_ts.h - header file for OMAP touchscreen support
+ * 
+ * Copyright (c) 2002 MontaVista Software Inc.
+ * Copyright (c) 2004 Texas Instruments, Inc.
+ *
+ * Assembled using driver code copyright the companies above.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __OMAP_TS_H
+#define __OMAP_TS_H
+
+#ifdef DEBUG
+#define DEBUG_TS(fmt...)   printk(fmt)
+#else
+#define DEBUG_TS(fmt...)   do { } while (0)
+#endif
+
+struct omap_ts_t;
+
+struct ts_device {
+        int  (*probe)   (struct omap_ts_t *);
+        void (*read)    (u16 *);
+        void (*enable)  (void);
+        void (*disable) (void);
+        void (*remove)  (void);
+        int  (*penup)  (void);
+};
+
+struct omap_ts_t{
+	struct input_dev * inputdevice;
+	struct timer_list ts_timer;      // Timer for triggering acquisitions
+	int touched;
+	int irq;
+	int irq_type;
+	int irq_enabled;
+	struct ts_device *dev;
+	spinlock_t lock;
+};
+
+extern struct ts_device hx_ts;
+
+#endif /* __OMAP_TS_H */
diff --git a/drivers/input/touchscreen/omap/ts_hx.c b/drivers/input/touchscreen/omap/ts_hx.c
new file mode 100644
index 0000000..9f82f5a
--- /dev/null
+++ b/drivers/input/touchscreen/omap/ts_hx.c
@@ -0,0 +1,184 @@
+/*
+ * input/touchscreen/omap/ts_hx.c
+ * touchscreen support for OMAP H3 and H2  boards
+ *
+ * Copyright (c) 2002 MontaVista Software Inc.
+ * Copyright (c) 2004 Texas Instruments, Inc.
+ *
+ * Assembled using driver code copyright the companies above.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * History:
+ * 9/12/2004  	Srinath Modified and integrated  H2 and H3 code
+ *
+ */
+
+#include <linux/input.h>
+#include <linux/device.h>
+#include <asm/mach-types.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/hardware.h>
+#include <asm/hardware/tsc2101.h>
+
+#include "../drivers/ssi/omap-tsc2101.h"
+#include "omap_ts.h"
+
+#define	H2_GPIO_NUM		4
+#define	H3_GPIO_NUM		48
+
+#define OMAP_TSC2101_XRES		       500
+#define TOUCHSCREEN_DATA_REGISTERS_PAGE	 0x0
+#define TOUCHSCREEN_CONTROL_REGISTERS_PAGE      0x1
+#define OMAP_TSC2101_READ_MAX		   0x4
+#define TSC2101_GETSTATUS(ret)		  (((ret) >> 11) & 0x1)
+#define TSC2101_MASKVAL			 0xFFF
+#define TSC2101_PRESSUREVAL(x)		  ((x) << 12)
+
+static int hx_ts_penup(void);
+static int hx_ts_probe(struct omap_ts_t *ts);
+static void hx_ts_read(u16 * data);
+static void hx_ts_enable(void);
+static void hx_ts_disable(void);
+#ifdef	MODULE
+static void hx_ts_remove(void);
+#endif
+
+struct ts_device hx_ts = {
+	.probe 		= hx_ts_probe,
+	.read 		= hx_ts_read,
+	.enable 	= hx_ts_enable,
+	.disable 	= hx_ts_disable,
+	.remove 	= __exit_p(hx_ts_remove),
+	.penup 		= hx_ts_penup,
+};
+
+static int hx_ts_penup(void)
+{
+	int ret = 0;
+	/* Read the status register */
+	ret = omap_tsc2101_read(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+				TSC2101_TS_STATUS);
+	/* Check for availability of data in status register */
+	ret = TSC2101_GETSTATUS(ret);
+	return !ret;
+
+}
+
+static int __init hx_ts_probe(struct omap_ts_t *ts)
+{
+	unsigned	gpio;
+
+	if (machine_is_omap_h2()) {
+		gpio = H2_GPIO_NUM;
+		omap_cfg_reg(P20_1610_GPIO4);
+	} else if (machine_is_omap_h3()) {
+		gpio = H3_GPIO_NUM;
+		omap_cfg_reg(W19_1610_GPIO48);
+	} else
+		return -ENODEV;
+
+	ts->irq = OMAP_GPIO_IRQ(gpio);
+	if (omap_request_gpio(gpio) != 0) {
+		printk(KERN_ERR "hX_ts_init.c: Could not reserve GPIO!\n");
+		return -EINVAL;
+	};
+
+	omap_set_gpio_direction(gpio, 1);
+	ts->irq_type = IRQF_TRIGGER_FALLING;
+	return 0;
+}
+
+static void hx_ts_read(u16 * values)
+{
+	s32 t, p = 0;
+	int i;
+
+	/* Read X, Y, Z1 and Z2 */
+	omap_tsc2101_reads(TOUCHSCREEN_DATA_REGISTERS_PAGE, TSC2101_TS_X,
+			   values, OMAP_TSC2101_READ_MAX);
+
+	for (i = 0; i < OMAP_TSC2101_READ_MAX; i++)
+		values[i] &= TSC2101_MASKVAL;
+
+	/* Calculate Pressure */
+	if (values[TSC2101_TS_Z1] != 0) {
+		t = ((OMAP_TSC2101_XRES * values[TSC2101_TS_X]) *
+		     (values[TSC2101_TS_Z2] - values[TSC2101_TS_Z1]));
+		p = t / (u32) (TSC2101_PRESSUREVAL(values[TSC2101_TS_Z1]));
+		if (p < 0)
+			p = 0;
+	}
+
+	values[TSC2101_TS_Z1] = p;
+}
+
+static void hx_ts_enable(void)
+{
+	int ret = omap_tsc2101_enable();
+	if (ret) {
+		printk(KERN_ERR "FAILED TO INITIALIZE TSC CODEC\n");
+		return;
+	}
+
+	/* PINTDAV is data available only */
+	omap_tsc2101_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			   TSC2101_TS_STATUS, TSC2101_DATA_AVAILABLE);
+	/* disable buffer mode */
+	omap_tsc2101_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			   TSC2101_TS_BUFFER_CTRL, TSC2101_BUFFERMODE_DISABLE);
+	/* use internal reference, 100 usec power-up delay,
+	 *	  * power down between conversions, 1.25V internal reference */
+	omap_tsc2101_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			   TSC2101_TS_REF_CTRL, TSC2101_REF_POWERUP);
+	/* enable touch detection, 84usec precharge time, 32 usec sense time */
+	omap_tsc2101_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			   TSC2101_TS_CONFIG_CTRL, TSC2101_ENABLE_TOUCHDETECT);
+	/* 3 msec conversion delays  */
+	omap_tsc2101_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			   TSC2101_TS_PROG_DELAY, TSC2101_PRG_DELAY);
+	/*
+	 * TSC2101-controlled conversions
+	 * 12-bit samples
+	 * continuous X,Y,Z1,Z2 scan mode
+	 * average (mean) 4 samples per coordinate
+	 * 1 MHz internal conversion clock
+	 * 500 usec panel voltage stabilization delay
+	 */
+	omap_tsc2101_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			   TSC2101_TS_ADC_CTRL, TSC2101_ADC_CONTROL);
+
+	return;
+
+}
+
+static void hx_ts_disable(void)
+{
+	/* stop conversions and power down */
+	omap_tsc2101_write(TOUCHSCREEN_CONTROL_REGISTERS_PAGE,
+			   TSC2101_TS_ADC_CTRL, TSC2101_ADC_POWERDOWN);
+	omap_tsc2101_disable();
+}
+
+#ifdef	MODULE
+static void __exit hx_ts_remove(void)
+{
+	if (machine_is_omap_h2())
+		omap_free_gpio(H2_GPIO_NUM);
+	else if (machine_is_omap_h3())
+		omap_free_gpio(H3_GPIO_NUM);
+}
+#endif
-- 
1.6.0.1.141.g445ca

