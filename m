From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/12] ARM: OMAP1: Use MMC multislot structures for
	Siemens SX1 board
Date: Mon, 14 Jan 2008 16:59:02 -0800
Message-ID: <20080115005901.GH7515@atomide.com>
References: <1197957418-23913-1-git-send-email-tony@atomide.com>
	<1197957418-23913-2-git-send-email-tony@atomide.com>
	<1197957418-23913-3-git-send-email-tony@atomide.com>
	<1197957418-23913-4-git-send-email-tony@atomide.com>
	<1197957418-23913-5-git-send-email-tony@atomide.com>
	<1197957418-23913-6-git-send-email-tony@atomide.com>
	<1197957418-23913-7-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LwW0XdcUbUexiWVK"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <1197957418-23913-7-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [071217 21:58]:
> From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> 
> Use MMC multislot structures for Siemens SX1 board

Here's an updated version from Carlos with sx1_i2c_read
instead of i2c_read naming.

Tony

--LwW0XdcUbUexiWVK
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0005-ARM-OMAP1-Use-MMC-multislot-structures-for-Siemens.patch"

>From a3ca132c6db48401a6c36df7d530949fd26d5f0e Mon Sep 17 00:00:00 2001
From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Date: Thu, 29 Nov 2007 13:52:53 -0400
Subject: [PATCH] ARM: OMAP1: Use MMC multislot structures for Siemens SX1 board

Use MMC multislot structures for Siemens SX1 board

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Makefile          |    2 +-
 arch/arm/mach-omap1/board-sx1-mmc.c   |  124 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/board-sx1.c       |   17 +----
 include/asm-arm/arch-omap/board-sx1.h |    9 ++-
 4 files changed, 135 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-sx1-mmc.c

Index: linux-omap-2.6/arch/arm/mach-omap1/Makefile
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap1/Makefile	2008-01-14 15:57:13.000000000 -0800
+++ linux-omap-2.6/arch/arm/mach-omap1/Makefile	2008-01-14 15:57:14.000000000 -0800
@@ -26,7 +26,7 @@ obj-$(CONFIG_MACH_OMAP_PALMZ71)		+= boar
 obj-$(CONFIG_MACH_OMAP_PALMTT)		+= board-palmtt.o
 obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
-obj-$(CONFIG_MACH_SX1)			+= board-sx1.o
+obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
 
 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 # Innovator-1510 FPGA
Index: linux-omap-2.6/arch/arm/mach-omap1/board-sx1-mmc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap1/board-sx1-mmc.c	2008-01-14 15:57:55.000000000 -0800
@@ -0,0 +1,124 @@
+/*
+ * linux/arch/arm/mach-omap1/board-sx1-mmc.c
+ *
+ * Copyright (C) 2007 Instituto Nokia de Tecnologia - INdT
+ * Author: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
+ *
+ * This code is based on linux/arch/arm/mach-omap1/board-h2-mmc.c, which is:
+ * Copyright (C) 2007 Instituto Nokia de Tecnologia - INdT
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/mmc.h>
+#include <asm/arch/gpio.h>
+
+#ifdef CONFIG_MMC_OMAP
+static int slot_cover_open;
+static struct device *mmc_device;
+
+static int sx1_mmc_set_power(struct device *dev, int slot, int power_on,
+				int vdd)
+{
+	int err;
+	u8 dat = 0;
+
+#ifdef CONFIG_MMC_DEBUG
+	dev_dbg(dev, "Set slot %d power: %s (vdd %d)\n", slot + 1,
+		power_on ? "on" : "off", vdd);
+#endif
+
+	if (slot != 0) {
+		dev_err(dev, "No such slot %d\n", slot + 1);
+		return -ENODEV;
+	}
+
+	err = sx1_i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
+	if (err < 0)
+		return err;
+
+	if (power_on)
+		dat |= SOFIA_MMC_POWER;
+	else
+		dat &= ~SOFIA_MMC_POWER;
+
+	return sx1_i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
+}
+
+static int sx1_mmc_set_bus_mode(struct device *dev, int slot, int bus_mode)
+{
+#ifdef CONFIG_MMC_DEBUG
+	dev_dbg(dev, "Set slot %d bus_mode %s\n", slot + 1,
+		bus_mode == MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pull");
+#endif
+	if (slot != 0) {
+		dev_err(dev, "No such slot %d\n", slot + 1);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int sx1_mmc_get_cover_state(struct device *dev, int slot)
+{
+	BUG_ON(slot != 0);
+
+	return slot_cover_open;
+}
+
+void sx1_mmc_slot_cover_handler(void *arg, int state)
+{
+	if (mmc_device == NULL)
+		return;
+
+	slot_cover_open = state;
+	omap_mmc_notify_cover_event(mmc_device, 0, state);
+}
+
+static int sx1_mmc_late_init(struct device *dev)
+{
+	int ret = 0;
+
+	mmc_device = dev;
+
+	return ret;
+}
+
+static void sx1_mmc_cleanup(struct device *dev)
+{
+}
+
+static struct omap_mmc_platform_data sx1_mmc_data = {
+	.nr_slots                       = 1,
+	.switch_slot                    = NULL,
+	.init                           = sx1_mmc_late_init,
+	.cleanup                        = sx1_mmc_cleanup,
+	.slots[0]       = {
+		.set_power              = sx1_mmc_set_power,
+		.set_bus_mode           = sx1_mmc_set_bus_mode,
+		.get_ro                 = NULL,
+		.get_cover_state        = sx1_mmc_get_cover_state,
+		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
+					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.name                   = "mmcblk",
+	},
+};
+
+void __init sx1_mmc_init(void)
+{
+	omap_set_mmc_info(1, &sx1_mmc_data);
+}
+
+#else
+
+void __init sx1_mmc_init(void)
+{
+}
+
+void sx1_mmc_slot_cover_handler(void *arg, int state)
+{
+}
+#endif
Index: linux-omap-2.6/arch/arm/mach-omap1/board-sx1.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap1/board-sx1.c	2008-01-11 13:54:53.000000000 -0800
+++ linux-omap-2.6/arch/arm/mach-omap1/board-sx1.c	2008-01-14 15:57:55.000000000 -0800
@@ -44,7 +44,7 @@
 #include <asm/arch/keypad.h>
 
 /* Write to I2C device */
-int i2c_write_byte(u8 devaddr, u8 regoffset, u8 value)
+int sx1_i2c_write_byte(u8 devaddr, u8 regoffset, u8 value)
 {
 	struct i2c_adapter *adap;
 	int err;
@@ -67,7 +67,7 @@ int i2c_write_byte(u8 devaddr, u8 regoff
 }
 
 /* Read from I2C device */
-int i2c_read_byte(u8 devaddr, u8 regoffset, u8 * value)
+int sx1_i2c_read_byte(u8 devaddr, u8 regoffset, u8 *value)
 {
 	struct i2c_adapter *adap;
 	int err;
@@ -101,66 +101,55 @@ int sx1_setkeylight(u8 keylight)
 {
 	if (keylight > SOFIA_MAX_LIGHT_VAL)
 		keylight = SOFIA_MAX_LIGHT_VAL;
-	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_KEYLIGHT_REG, keylight);
+	return sx1_i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_KEYLIGHT_REG, keylight);
 }
 /* get current keylight intensity */
 int sx1_getkeylight(u8 * keylight)
 {
-	return i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_KEYLIGHT_REG, keylight);
+	return sx1_i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_KEYLIGHT_REG, keylight);
 }
 /* set LCD backlight intensity */
 int sx1_setbacklight(u8 backlight)
 {
 	if (backlight > SOFIA_MAX_LIGHT_VAL)
 		backlight = SOFIA_MAX_LIGHT_VAL;
-	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_BACKLIGHT_REG, backlight);
+	return sx1_i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_BACKLIGHT_REG,
+				  backlight);
 }
 /* get current LCD backlight intensity */
 int sx1_getbacklight (u8 * backlight)
 {
-	return i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_BACKLIGHT_REG, backlight);
+	return sx1_i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_BACKLIGHT_REG,
+				 backlight);
 }
 /* set LCD backlight power on/off */
 int sx1_setmmipower(u8 onoff)
 {
 	int err;
 	u8 dat = 0;
-	err = i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
+	err = sx1_i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
 	if (err < 0)
 		return err;
 	if (onoff)
 		dat |= SOFIA_MMILIGHT_POWER;
 	else
 		dat &= ~SOFIA_MMILIGHT_POWER;
-	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
-}
-/* set MMC power on/off */
-int sx1_setmmcpower(u8 onoff)
-{
-	int err;
-	u8 dat = 0;
-	err = i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
-	if (err < 0)
-		return err;
-	if (onoff)
-		dat |= SOFIA_MMC_POWER;
-	else
-		dat &= ~SOFIA_MMC_POWER;
-	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
+	return sx1_i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
 }
+
 /* set USB power on/off */
 int sx1_setusbpower(u8 onoff)
 {
 	int err;
 	u8 dat = 0;
-	err = i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
+	err = sx1_i2c_read_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, &dat);
 	if (err < 0)
 		return err;
 	if (onoff)
 		dat |= SOFIA_USB_POWER;
 	else
 		dat &= ~SOFIA_USB_POWER;
-	return i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
+	return sx1_i2c_write_byte(SOFIA_I2C_ADDR, SOFIA_POWER1_REG, dat);
 }
 
 EXPORT_SYMBOL(sx1_setkeylight);
@@ -168,7 +157,6 @@ EXPORT_SYMBOL(sx1_getkeylight);
 EXPORT_SYMBOL(sx1_setbacklight);
 EXPORT_SYMBOL(sx1_getbacklight);
 EXPORT_SYMBOL(sx1_setmmipower);
-EXPORT_SYMBOL(sx1_setmmcpower);
 EXPORT_SYMBOL(sx1_setusbpower);
 
 /*----------- Keypad -------------------------*/
@@ -454,6 +442,7 @@ static void __init omap_sx1_init(void)
 	omap_board_config = sx1_config;
 	omap_board_config_size = ARRAY_SIZE(sx1_config);
 	omap_serial_init();
+	sx1_mmc_init();
 
 	/* turn on USB power */
 	/* sx1_setusbpower(1); cant do it here because i2c is not ready */
Index: linux-omap-2.6/include/asm-arm/arch-omap/board-sx1.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/board-sx1.h	2008-01-11 13:54:54.000000000 -0800
+++ linux-omap-2.6/include/asm-arm/arch-omap/board-sx1.h	2008-01-14 15:57:55.000000000 -0800
@@ -41,6 +41,12 @@ int sx1_getkeylight(u8 *keylight);
 
 int sx1_setmmipower(u8 onoff);
 int sx1_setusbpower(u8 onoff);
-int sx1_setmmcpower(u8 onoff);
+int sx1_i2c_read_byte(u8 devaddr, u8 regoffset, u8 *value);
+int sx1_i2c_write_byte(u8 devaddr, u8 regoffset, u8 value);
+
+/* MMC prototypes */
+
+extern void sx1_mmc_init(void);
+extern void sx1_mmc_slot_cover_handler(void *arg, int state);
 
 #endif /* __ASM_ARCH_SX1_I2C_CHIPS_H */

--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--LwW0XdcUbUexiWVK--
