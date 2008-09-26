From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 5/8] i2c: move twl4030-usb to platform_device
Date: Fri, 26 Sep 2008 12:40:58 +0300
Message-ID: <1222422061-3940-6-git-send-email-felipe.balbi@nokia.com>
References: <1222422061-3940-1-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-2-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-3-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-4-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-5-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:39915 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbYIZJmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 05:42:08 -0400
In-Reply-To: <1222422061-3940-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

use new style twl4030-core to register a platform_device
for twl4030-usb.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c     |    6 +
 arch/arm/mach-omap2/board-3430sdp.c     |    5 +
 arch/arm/mach-omap2/board-ldp.c         |    7 +
 arch/arm/mach-omap2/board-omap2evm.c    |    5 +
 arch/arm/mach-omap2/board-omap3beagle.c |    7 +
 arch/arm/mach-omap2/board-omap3evm.c    |    6 +-
 drivers/i2c/chips/Kconfig               |   16 --
 drivers/i2c/chips/twl4030-core.c        |   27 +++
 drivers/i2c/chips/twl4030-usb.c         |  328 ++++++++++++++-----------------
 include/linux/i2c/twl4030.h             |   10 +
 10 files changed, 217 insertions(+), 200 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 8c4c9dd..f35c252 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -344,12 +344,18 @@ static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 	{OMAP_TAG_SERIAL_CONSOLE, &sdp2430_serial_console_config},
 };
 
+
+static struct twl4030_usb_data sdp2430_usb_data = {
+	.usb_mode	= T2_MODE_ULPI,
+};
+
 static struct twl4030_platform_data sdp2430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.keypad		= &sdp2430_kp_data,
+	.usb		= &sdp2430_usb_data,
 };
 
 static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index fe1ba4e..e0c39c2 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -300,12 +300,17 @@ static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp3430_lcd_config },
 };
 
+static struct twl4030_usb_data sdp3430_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
 static struct twl4030_platform_data sdp3430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.keypad		= &sdp3430_kp_data,
+	.usb		= &sdp3430_usb_data,
 };
 
 static struct i2c_board_info __initdata sdp3430_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index c07c712..219579b 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -183,9 +183,16 @@ static struct omap_board_config_kernel ldp_config[] __initdata = {
 	{ OMAP_TAG_UART,	&ldp_uart_config },
 };
 
+static struct twl4030_usb_data ldp_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
 static struct twl4030_platform_data ldp_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.usb		= &ldp_usb_data,
 };
 
 static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap2evm.c b/arch/arm/mach-omap2/board-omap2evm.c
index d2a3743..be8348d 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -226,12 +226,17 @@ static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&omap2_evm_lcd_config },
 };
 
+static struct twl4030_usb_data omap2evm_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
 static struct twl4030_platform_data omap2evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.keypad		= &omap2evm_kp_data,
+	.usb		= &omap2evm_usb_data,
 };
 
 static struct i2c_board_info __initdata omap2evm_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index fa8f5f6..ae677b9 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -110,9 +110,16 @@ static struct omap_uart_config omap3_beagle_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct twl4030_usb_data beagle_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
 static struct twl4030_platform_data beagle_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.usb		= &beagle_usb_data,
 };
 
 static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c4a969d..158138c 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -90,6 +90,10 @@ static struct omap_uart_config omap3_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct twl4030_usb_data omap3evm_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
 static int omap3evm_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -118,13 +122,13 @@ static struct twl4030_keypad_data omap3evm_kp_data = {
 	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
-
 static struct twl4030_platform_data omap3evm_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
 	.keypad		= &omap3evm_kp_data,
+	.usb		= &omap3evm_usb_data,
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index e91be60..121aec9 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -186,22 +186,6 @@ config TWL4030_USB
 	tristate "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE
 
-choice
-	prompt "Transceiver mode"
-	depends on TWL4030_USB
-	help
-	  TWL4030 USB transceiver can operate in various
-	  mutually-exclusive modes. Select one of them.
-
-config TWL4030_USB_HS_ULPI
-	depends on TWL4030_USB
-	bool "High-speed ULPI"
-	help
-	  Say Y here if the TWL4030 is connected to high-speed USB
-	  controller through a ULPI interface.
-
-endchoice
-
 config TWL4030_PWRBUTTON
 	tristate "TWL4030 Power button Driver"
 	depends on TWL4030_CORE
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 0041d76..36a6bb7 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -57,6 +57,12 @@
 #define twl_has_keypad()	(0)
 #endif
 
+#if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODULE)
+#define twl_has_usb()		(1)
+#else
+#define twl_has_usb()		(0)
+#endif
+
 /* Primary Interrupt Handler on TWL4030 Registers */
 
 /* Register Definitions */
@@ -701,6 +707,27 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
+	if (twl_has_usb() && pdata->usb) {
+		pdev = platform_device_alloc("twl4030_usb", -1);
+		if (pdev) {
+			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM0];
+			pdev->dev.parent = &twl->client->dev;
+			device_init_wakeup(&pdev->dev, 1);
+			status = platform_device_add_data(pdev, pdata->usb,
+					sizeof(*pdata->usb));
+			if (status < 0) {
+				platform_device_put(pdev);
+				goto err;
+			}
+			status = platform_device_add(pdev);
+			if (status < 0)
+				platform_device_put(pdev);
+		} else {
+			status = -ENOMEM;
+			goto err;
+		}
+	}
+
 err:
 	pr_err("failed to add twl4030's children\n");
 	return status;
diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index 2906b82..e790c34 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -2,6 +2,8 @@
  * twl4030_usb - TWL4030 USB transceiver, talking to OMAP OTG controller
  *
  * Copyright (C) 2004-2007 Texas Instruments
+ * Copyright (C) 2008 Nokia Corporation
+ * Contact: Felipe Balbi <felipe.balbi@nokia.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -22,11 +24,11 @@
  *	- 3-pin mode support may be added in future.
  */
 
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/usb.h>
 #include <linux/usb/ch9.h>
@@ -228,14 +230,6 @@
 #define VUSB3V1_TYPE			0x78
 #define VUSB3V1_REMAP			0x79
 
-#define ID_STATUS			0x96
-#define ID_RES_FLOAT			(1 << 4) /* mini-B */
-#define ID_RES_440K			(1 << 3) /* type 2 charger */
-#define ID_RES_200K			(1 << 2) /* 5-wire carkit or
-						    type 1 charger */
-#define ID_RES_102K			(1 << 1) /* phone */
-#define ID_RES_GND			(1 << 0) /* mini-A */
-
 /* In module TWL4030_MODULE_INTBR */
 #define PMBR1				0x0D
 #define GPIO_USB_4PIN_ULPI_2430C	(3 << 0)
@@ -250,11 +244,7 @@
 #define REG_PWR_SIH_CTRL		0x07
 #define COR				(1 << 2)
 
-/* internal define on top of container_of */
-#define xceiv_to_twl(x)		container_of((x), struct twl4030_usb, otg);
-
 /* bits in OTG_CTRL */
-
 #define	OTG_XCEIV_OUTPUTS \
 	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
 #define	OTG_XCEIV_INPUTS \
@@ -268,22 +258,23 @@
 	OTG_CTRL_BITS)
 
 
-/*-------------------------------------------------------------------------*/
-
 struct twl4030_usb {
 	struct otg_transceiver	otg;
+	struct device		*dev;
+
+	/* pin configuration */
+	enum twl4030_usb_mode	usb_mode;
 	int			irq;
-	u8			usb_mode;	/* pin configuration */
-#define T2_USB_MODE_ULPI		1
-/* #define T2_USB_MODE_CEA2011_3PIN	2 */
 	u8			asleep;
 };
 
-static struct twl4030_usb *the_transceiver;
+/* internal define on top of container_of */
+#define xceiv_to_twl(x)		container_of((x), struct twl4030_usb, otg);
 
 /*-------------------------------------------------------------------------*/
 
-static int twl4030_i2c_write_u8_verify(u8 module, u8 data, u8 address)
+static int twl4030_i2c_write_u8_verify(struct twl4030_usb *twl,
+		u8 module, u8 data, u8 address)
 {
 	u8 check;
 
@@ -297,46 +288,51 @@ static int twl4030_i2c_write_u8_verify(u8 module, u8 data, u8 address)
 						(check == data))
 		return 0;
 	/* Failed again: Return error */
+
 	return -EBUSY;
 }
 
-#define twl4030_usb_write_verify(address, data)	\
-	twl4030_i2c_write_u8_verify(TWL4030_MODULE_USB, (data), (address))
+#define twl4030_usb_write_verify(twl, address, data)	\
+	twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_USB, (data), (address))
 
-static inline int twl4030_usb_write(u8 address, u8 data)
+static inline int twl4030_usb_write(struct twl4030_usb *twl,
+		u8 address, u8 data)
 {
 	int ret = 0;
+
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_USB, data, address);
 	if (ret >= 0) {
 #if 0	/* debug */
 		u8 data1;
 		if (twl4030_i2c_read_u8(TWL4030_MODULE_USB, &data1,
 					address) < 0)
-			printk(KERN_ERR "re-read failed\n");
+			dev_err(twl->dev, "re-read failed\n");
 		else
-			printk(KERN_INFO
+			dev_dbg(twl->dev,
 			       "Write %s wrote %x read %x from reg %x\n",
 			       (data1 == data) ? "succeed" : "mismatch",
 			       data, data1, address);
 #endif
 	} else {
-		printk(KERN_WARNING
+		dev_warn(twl->dev,
 			"TWL4030:USB:Write[0x%x] Error %d\n", address, ret);
 	}
+
 	return ret;
 }
 
-static inline int twl4030_usb_read(u8 address)
+static inline int twl4030_usb_read(struct twl4030_usb *twl, u8 address)
 {
 	u8 data;
 	int ret = 0;
+
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_USB, &data, address);
-	if (ret >= 0) {
+	if (ret >= 0)
 		ret = data;
-	} else {
-		printk(KERN_WARNING
+	else
+		dev_warn(twl->dev,
 			"TWL4030:USB:Read[0x%x] Error %d\n", address, ret);
-	}
+
 	return ret;
 }
 
@@ -345,14 +341,13 @@ static inline int twl4030_usb_read(u8 address)
 static inline int
 twl4030_usb_set_bits(struct twl4030_usb *twl, u8 reg, u8 bits)
 {
-	return twl4030_usb_write(reg + 1, bits);
+	return twl4030_usb_write(twl, reg + 1, bits);
 }
 
 static inline int
 twl4030_usb_clear_bits(struct twl4030_usb *twl, u8 reg, u8 bits)
 {
-	return twl4030_usb_write(reg + 2, bits);
-
+	return twl4030_usb_write(twl, reg + 2, bits);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -380,185 +375,130 @@ static void twl4030_usb_set_mode(struct twl4030_usb *twl, int mode)
 	};
 }
 
-#ifdef CONFIG_TWL4030_USB_HS_ULPI
-static void hs_usb_init(struct twl4030_usb *twl)
-{
-	twl->usb_mode = T2_USB_MODE_ULPI;
-	return;
-}
-
-#endif
-
-static void twl4030_i2c_access(int on)
+static void twl4030_i2c_access(struct twl4030_usb *twl, int on)
 {
 	unsigned long timeout;
-	int val = twl4030_usb_read(PHY_CLK_CTRL);
+	int val = twl4030_usb_read(twl, PHY_CLK_CTRL);
 
 	if (val >= 0) {
 		if (on) {
 			/* enable DPLL to access PHY registers over I2C */
 			val |= REQ_PHY_DPLL_CLK;
-			if (twl4030_usb_write_verify(PHY_CLK_CTRL,
-								(u8)val) < 0) {
-				printk(KERN_ERR "twl4030_usb: i2c write failed,"
-						" line %d\n", __LINE__);
-				return;
-			}
+			WARN_ON(twl4030_usb_write_verify(twl, PHY_CLK_CTRL,
+						(u8)val) < 0);
 
 			timeout = jiffies + HZ;
-			while (!(twl4030_usb_read(PHY_CLK_CTRL_STS) &
+			while (!(twl4030_usb_read(twl, PHY_CLK_CTRL_STS) &
 							PHY_DPLL_CLK)
 				&& time_before(jiffies, timeout))
 					udelay(10);
-			if (!(twl4030_usb_read(PHY_CLK_CTRL_STS) &
+			if (!(twl4030_usb_read(twl, PHY_CLK_CTRL_STS) &
 							PHY_DPLL_CLK))
-				printk(KERN_ERR "Timeout setting T2 HSUSB "
+				dev_err(twl->dev, "Timeout setting T2 HSUSB "
 						"PHY DPLL clock\n");
 		} else {
 			/* let ULPI control the DPLL clock */
 			val &= ~REQ_PHY_DPLL_CLK;
-			if (twl4030_usb_write_verify(PHY_CLK_CTRL,
-								(u8)val) < 0) {
-				printk(KERN_ERR "twl4030_usb: i2c write failed,"
-						" line %d\n", __LINE__);
-			}
+			WARN_ON(twl4030_usb_write_verify(twl, PHY_CLK_CTRL,
+						(u8)val) < 0);
 		}
 	}
-	return;
 }
 
-static void usb_irq_enable(int rising, int falling)
+static void usb_irq_enable(struct twl4030_usb *twl, int rising, int falling)
 {
 	u8 val;
 
 	/* edge setup */
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_EDR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c read failed,"
-				" line %d\n", __LINE__);
-		return;
-	}
+	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+				&val, REG_PWR_EDR1) < 0);
+
 	val &= ~(USB_PRES_RISING | USB_PRES_FALLING);
 	if (rising)
 		val = val | USB_PRES_RISING;
 	if (falling)
 		val = val | USB_PRES_FALLING;
-	if (twl4030_i2c_write_u8_verify(TWL4030_MODULE_INT, val,
-							REG_PWR_EDR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c write failed,"
-				" line %d\n", __LINE__);
-		return;
-	}
+	WARN_ON(twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_INT,
+				val, REG_PWR_EDR1) < 0);
 
 	/* un-mask interrupt */
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_IMR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c read failed,"
-				" line %d\n", __LINE__);
-		return;
-	}
+	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+				&val, REG_PWR_IMR1) < 0);
+
 	val &= ~USB_PRES;
-	if (twl4030_i2c_write_u8_verify(TWL4030_MODULE_INT, val,
-							REG_PWR_IMR1) < 0)
-		printk(KERN_ERR "twl4030_usb: i2c write failed,"
-				" line %d\n", __LINE__);
 
-	return;
+	WARN_ON(twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_INT,
+				val, REG_PWR_IMR1) < 0);
 }
 
-static void usb_irq_disable(void)
+static void usb_irq_disable(struct twl4030_usb *twl)
 {
 	u8 val;
 
 	/* undo edge setup */
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_EDR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c read failed,"
-				" line %d\n", __LINE__);
-		return;
-	}
+	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+				&val, REG_PWR_EDR1) < 0);
 	val &= ~(USB_PRES_RISING | USB_PRES_FALLING);
-	if (twl4030_i2c_write_u8_verify(TWL4030_MODULE_INT, val,
-							REG_PWR_EDR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c write failed,"
-				" line %d\n", __LINE__);
-		return;
-	}
+	WARN_ON(twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_INT,
+				val, REG_PWR_EDR1) < 0);
 
 	/* mask interrupt */
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_IMR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c read failed,"
-				" line %d\n", __LINE__);
-		return;
-	}
+	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+				&val, REG_PWR_IMR1) < 0);
 	val |= USB_PRES;
-	if (twl4030_i2c_write_u8_verify(TWL4030_MODULE_INT, val,
-							REG_PWR_IMR1) < 0)
-		printk(KERN_ERR "twl4030_usb: i2c write failed,"
-				" line %d\n", __LINE__);
 
-	return;
+	WARN_ON(twl4030_i2c_write_u8_verify(twl, TWL4030_MODULE_INT,
+				val, REG_PWR_IMR1) < 0);
 }
 
 static void twl4030_phy_power(struct twl4030_usb *twl, int on)
 {
 	u8 pwr;
 
-	pwr = twl4030_usb_read(PHY_PWR_CTRL);
+	pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
 	if (on) {
 		pwr &= ~PHY_PWR_PHYPWD;
-		if (twl4030_usb_write_verify(PHY_PWR_CTRL, pwr) < 0) {
-			printk(KERN_ERR "twl4030_usb: i2c write failed,"
-					" line %d\n", __LINE__);
-			return;
-		}
-		twl4030_usb_write(PHY_CLK_CTRL,
-				  twl4030_usb_read(PHY_CLK_CTRL) |
+		WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
+		twl4030_usb_write(twl, PHY_CLK_CTRL,
+				  twl4030_usb_read(twl, PHY_CLK_CTRL) |
 					(PHY_CLK_CTRL_CLOCKGATING_EN |
 						PHY_CLK_CTRL_CLK32K_EN));
 	} else  {
 		pwr |= PHY_PWR_PHYPWD;
-		if (twl4030_usb_write_verify(PHY_PWR_CTRL, pwr) < 0) {
-			printk(KERN_ERR "twl4030_usb: i2c write failed,"
-					" line %d\n", __LINE__);
-		}
+		WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
 	}
-	return;
 }
 
-static void twl4030_phy_suspend(int controller_off)
+static void twl4030_phy_suspend(struct twl4030_usb *twl, int controller_off)
 {
-	struct twl4030_usb *twl = the_transceiver;
-
 	if (controller_off)
-		usb_irq_disable();
+		usb_irq_disable(twl);
 
 	if (twl->asleep)
 		return;
 
 	if (!controller_off)
 		/* enable rising edge interrupt to detect cable attach */
-		usb_irq_enable(1, 0);
+		usb_irq_enable(twl, 1, 0);
 
 	twl4030_phy_power(twl, 0);
 	twl->asleep = 1;
-	return;
 }
 
-static void twl4030_phy_resume(void)
+static void twl4030_phy_resume(struct twl4030_usb *twl)
 {
-	struct twl4030_usb *twl = the_transceiver;
-
 	if (!twl->asleep)
 		return;
 
 	/* enable falling edge interrupt to detect cable detach */
-	usb_irq_enable(0, 1);
+	usb_irq_enable(twl, 0, 1);
 
 	twl4030_phy_power(twl, 1);
-	twl4030_i2c_access(1);
+	twl4030_i2c_access(twl, 1);
 	twl4030_usb_set_mode(twl, twl->usb_mode);
 	if (twl->usb_mode == T2_USB_MODE_ULPI)
-		twl4030_i2c_access(0);
+		twl4030_i2c_access(twl, 0);
 	twl->asleep = 0;
-	return;
 }
 
 static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
@@ -591,59 +531,57 @@ static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
 
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
-	int ret = IRQ_NONE;
+	struct twl4030_usb *twl = _twl;
 	u8 val;
 
 	/* action based on cable attach or detach */
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_EDR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c read failed,"
-				" line %d\n", __LINE__);
-		goto done;
-	}
+	WARN_ON(twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+				&val, REG_PWR_EDR1) < 0);
 
 	if (val & USB_PRES_RISING) {
-		twl4030_phy_resume();
+		twl4030_phy_resume(twl);
 		twl4030charger_usb_en(1);
 	} else {
 		twl4030charger_usb_en(0);
-		twl4030_phy_suspend(0);
+		twl4030_phy_suspend(twl, 0);
 	}
 
-	ret = IRQ_HANDLED;
-
-done:
-	return ret;
+	return IRQ_HANDLED;
 }
 
 static int twl4030_set_suspend(struct otg_transceiver *x, int suspend)
 {
+	struct twl4030_usb *twl = xceiv_to_twl(x);
+
 	if (suspend)
-		twl4030_phy_suspend(1);
+		twl4030_phy_suspend(twl, 1);
 	else
-		twl4030_phy_resume();
+		twl4030_phy_resume(twl);
 
 	return 0;
 }
 
-static int twl4030_set_peripheral(struct otg_transceiver *xceiv,
+static int twl4030_set_peripheral(struct otg_transceiver *x,
 		struct usb_gadget *gadget)
 {
+	struct twl4030_usb *twl;
 	u32 l;
-	struct twl4030_usb *twl = xceiv_to_twl(xceiv);
 
-	if (!xceiv)
+	if (!x)
 		return -ENODEV;
 
+	twl = xceiv_to_twl(x);
+
 	if (!gadget) {
 		omap_writew(0, OTG_IRQ_EN);
-		twl4030_phy_suspend(1);
+		twl4030_phy_suspend(twl, 1);
 		twl->otg.gadget = NULL;
 
 		return -ENODEV;
 	}
 
 	twl->otg.gadget = gadget;
-	twl4030_phy_resume();
+	twl4030_phy_resume(twl);
 
 	l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
 	l &= ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS);
@@ -660,23 +598,25 @@ static int twl4030_set_peripheral(struct otg_transceiver *xceiv,
 	return 0;
 }
 
-static int twl4030_set_host(struct otg_transceiver *xceiv, struct usb_bus *host)
+static int twl4030_set_host(struct otg_transceiver *x, struct usb_bus *host)
 {
-	struct twl4030_usb *twl = xceiv_to_twl(xceiv);
+	struct twl4030_usb *twl;
 
-	if (!xceiv)
+	if (!x)
 		return -ENODEV;
 
+	twl = xceiv_to_twl(x);
+
 	if (!host) {
 		omap_writew(0, OTG_IRQ_EN);
-		twl4030_phy_suspend(1);
+		twl4030_phy_suspend(twl, 1);
 		twl->otg.host = NULL;
 
 		return -ENODEV;
 	}
 
 	twl->otg.host = host;
-	twl4030_phy_resume();
+	twl4030_phy_resume(twl);
 
 	twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL,
 			TWL4030_OTG_CTRL_DMPULLDOWN
@@ -689,63 +629,65 @@ static int twl4030_set_host(struct otg_transceiver *xceiv, struct usb_bus *host)
 	return 0;
 }
 
-static int __init twl4030_usb_init(void)
+static int __init twl4030_usb_probe(struct platform_device *pdev)
 {
+	struct twl4030_usb_data *pdata = pdev->dev.platform_data;
 	struct twl4030_usb	*twl;
 	int status;
 
-	if (the_transceiver)
-		return 0;
-
 	twl = kzalloc(sizeof *twl, GFP_KERNEL);
 	if (!twl)
-		return 0;
-
-	the_transceiver = twl;
+		return -ENOMEM;
 
+	twl->dev		= &pdev->dev;
 	twl->irq		= TWL4030_PWRIRQ_USB_PRES;
 	twl->otg.set_host	= twl4030_set_host;
 	twl->otg.set_peripheral	= twl4030_set_peripheral;
 	twl->otg.set_suspend	= twl4030_set_suspend;
 
-	usb_irq_disable();
+	if (!pdata) {
+		dev_info(&pdev->dev, "platform_data not available, defaulting"
+				" to ULPI mode\n");
+		twl->usb_mode		= T2_USB_MODE_ULPI;
+	} else {
+		twl->usb_mode	= pdata->usb_mode;
+	}
+
+	usb_irq_disable(twl);
 	status = request_irq(twl->irq, twl4030_usb_irq, 0, "twl4030_usb", twl);
 	if (status < 0) {
-		printk(KERN_DEBUG "can't get IRQ %d, err %d\n",
+		dev_dbg(&pdev->dev, "can't get IRQ %d, err %d\n",
 			twl->irq, status);
 		kfree(twl);
-		return -ENODEV;
+		return status;
 	}
 
-#if defined(CONFIG_TWL4030_USB_HS_ULPI)
-	hs_usb_init(twl);
-#endif
+
 	twl4030_usb_ldo_init(twl);
 	twl4030_phy_power(twl, 1);
-	twl4030_i2c_access(1);
+	twl4030_i2c_access(twl, 1);
 	twl4030_usb_set_mode(twl, twl->usb_mode);
-	if (twl->usb_mode == T2_USB_MODE_ULPI)
-		twl4030_i2c_access(0);
 
 	twl->asleep = 0;
 
-	if (twl->usb_mode == T2_USB_MODE_ULPI)
-		twl4030_phy_suspend(1);
+	if (twl->usb_mode == T2_USB_MODE_ULPI) {
+		twl4030_i2c_access(twl, 0);
+		twl4030_phy_suspend(twl, 0);
+	}
 
 	otg_set_transceiver(&twl->otg);
-
-	printk(KERN_INFO "Initialized TWL4030 USB module\n");
+	dev_set_drvdata(&pdev->dev, twl);
+	dev_info(&pdev->dev, "Initialized TWL4030 USB module\n");
 
 	return 0;
 }
 
-
-static void __exit twl4030_usb_exit(void)
+static int __exit twl4030_usb_remove(struct platform_device *pdev)
 {
-	struct twl4030_usb *twl = the_transceiver;
+	struct twl4030_usb *twl = dev_get_drvdata(&pdev->dev);
 	int val;
 
-	usb_irq_disable();
+	usb_irq_disable(twl);
 	free_irq(twl->irq, twl);
 
 	/* set transceiver mode to power on defaults */
@@ -755,11 +697,11 @@ static void __exit twl4030_usb_exit(void)
 	 * clear dpll clock request for i2c access,
 	 * disable 32KHz
 	 */
-	val = twl4030_usb_read(PHY_CLK_CTRL);
+	val = twl4030_usb_read(twl, PHY_CLK_CTRL);
 	if (val >= 0) {
 		val |= PHY_CLK_CTRL_CLOCKGATING_EN;
 		val &= ~(PHY_CLK_CTRL_CLK32K_EN | REQ_PHY_DPLL_CLK);
-		twl4030_usb_write(PHY_CLK_CTRL, (u8)val);
+		twl4030_usb_write(twl, PHY_CLK_CTRL, (u8)val);
 	}
 
 	/* disable complete OTG block */
@@ -768,12 +710,32 @@ static void __exit twl4030_usb_exit(void)
 	twl4030_phy_power(twl, 0);
 
 	kfree(twl);
+
+	return 0;
 }
 
-subsys_initcall(twl4030_usb_init);
+static struct platform_driver twl4030_driver = {
+	.probe		= twl4030_usb_probe,
+	.remove		= __exit_p(twl4030_remove),
+	.driver		= {
+		.name	= "twl4030_usb",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init twl4030_usb_init(void)
+{
+	return platform_driver_register(&twl4030_driver);
+}
+module_init(twl4030_usb_init);
+
+static void __exit twl4030_usb_exit(void)
+{
+	platform_driver_unregister(&twl4030_driver);
+}
 module_exit(twl4030_usb_exit);
 
-MODULE_ALIAS("i2c:twl4030-usb");
-MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_ALIAS("platform:twl4030_usb");
+MODULE_AUTHOR("Texas Instruments, Inc, Nokia Corporation");
 MODULE_DESCRIPTION("TWL4030 USB transceiver driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 0ac417c..8a12ff0 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -61,9 +61,19 @@ struct twl4030_keypad_data {
 	unsigned int rep:1;
 };
 
+enum twl4030_usb_mode {
+	T2_USB_MODE_ULPI = 1,
+	T2_USB_MODE_CEA2011_3PIN = 2,
+};
+
+struct twl4030_usb_data {
+	enum twl4030_usb_mode	usb_mode;
+};
+
 struct twl4030_platform_data {
 	unsigned	irq_base, irq_end;
 	struct twl4030_keypad_data *keypad;
+	struct twl4030_usb_data *usb;
 
 	/* REVISIT more to come ... _nothing_ should be hard-wired */
 };
-- 
1.6.0.2.307.gc427

