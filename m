From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/3] i2c: twl4030-usb: move to platform_device
Date: Tue,  2 Sep 2008 15:31:51 +0300
Message-ID: <1220358712-25737-2-git-send-email-felipe.balbi@nokia.com>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47252 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbYIBMce (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 08:32:34 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m82CW9Zr002970
	for <linux-omap@vger.kernel.org>; Tue, 2 Sep 2008 15:32:30 +0300
In-Reply-To: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

This patch moves twl4030-usb to platform_device. Later patches
will come adding proper notifications for twl usb irq events
via sysfs. The files will be placed under
/sys/devices/platform/twl4030-usb/

Also get rid of transceiver mode Kconfig selection, that will be
done by passing the desired mode via platform_data.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c  |   19 ++
 drivers/i2c/chips/Kconfig       |   16 --
 drivers/i2c/chips/twl4030-usb.c |  550 +++++++++++----------------------------
 include/linux/i2c/twl4030-usb.h |  257 ++++++++++++++++++
 4 files changed, 422 insertions(+), 420 deletions(-)
 create mode 100644 include/linux/i2c/twl4030-usb.h

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 3f90a93..afb377d 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -146,9 +146,28 @@ static struct platform_device musb_device = {
 };
 #endif
 
+#if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODULE)
+static struct twl4030_usb_platform_data twl4030_usb_plat = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
+static struct platform_device twl4030_usb_device = {
+	.name		= "twl4030-usb",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &twl4030_usb_plat,
+	},
+};
+#endif
 
 void __init usb_musb_init(void)
 {
+#if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODULE)
+	if (platform_device_register(&twl4030_usb_device) < 0) {
+		printk(KERN_ERR "Unable to register TWL4030 USB device\n");
+		return;
+	}
+#endif
 #ifdef CONFIG_USB_MUSB_SOC
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
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
diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index 2906b82..0d62e65 100644
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
@@ -22,268 +24,37 @@
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
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl4030-usb.h>
 #include <mach/usb.h>
 
-/* Register defines */
-
-#define VENDOR_ID_LO			0x00
-#define VENDOR_ID_HI			0x01
-#define PRODUCT_ID_LO			0x02
-#define PRODUCT_ID_HI			0x03
-
-#define FUNC_CTRL			0x04
-#define FUNC_CTRL_SET			0x05
-#define FUNC_CTRL_CLR			0x06
-#define FUNC_CTRL_SUSPENDM		(1 << 6)
-#define FUNC_CTRL_RESET			(1 << 5)
-#define FUNC_CTRL_OPMODE_MASK		(3 << 3) /* bits 3 and 4 */
-#define FUNC_CTRL_OPMODE_NORMAL		(0 << 3)
-#define FUNC_CTRL_OPMODE_NONDRIVING	(1 << 3)
-#define FUNC_CTRL_OPMODE_DISABLE_BIT_NRZI	(2 << 3)
-#define FUNC_CTRL_TERMSELECT		(1 << 2)
-#define FUNC_CTRL_XCVRSELECT_MASK	(3 << 0) /* bits 0 and 1 */
-#define FUNC_CTRL_XCVRSELECT_HS		(0 << 0)
-#define FUNC_CTRL_XCVRSELECT_FS		(1 << 0)
-#define FUNC_CTRL_XCVRSELECT_LS		(2 << 0)
-#define FUNC_CTRL_XCVRSELECT_FS4LS	(3 << 0)
-
-#define IFC_CTRL			0x07
-#define IFC_CTRL_SET			0x08
-#define IFC_CTRL_CLR			0x09
-#define IFC_CTRL_INTERFACE_PROTECT_DISABLE	(1 << 7)
-#define IFC_CTRL_AUTORESUME		(1 << 4)
-#define IFC_CTRL_CLOCKSUSPENDM		(1 << 3)
-#define IFC_CTRL_CARKITMODE		(1 << 2)
-#define IFC_CTRL_FSLSSERIALMODE_3PIN	(1 << 1)
-
-#define TWL4030_OTG_CTRL		0x0A
-#define TWL4030_OTG_CTRL_SET		0x0B
-#define TWL4030_OTG_CTRL_CLR		0x0C
-#define TWL4030_OTG_CTRL_DRVVBUS	(1 << 5)
-#define TWL4030_OTG_CTRL_CHRGVBUS	(1 << 4)
-#define TWL4030_OTG_CTRL_DISCHRGVBUS	(1 << 3)
-#define TWL4030_OTG_CTRL_DMPULLDOWN	(1 << 2)
-#define TWL4030_OTG_CTRL_DPPULLDOWN	(1 << 1)
-#define TWL4030_OTG_CTRL_IDPULLUP	(1 << 0)
-
-#define USB_INT_EN_RISE			0x0D
-#define USB_INT_EN_RISE_SET		0x0E
-#define USB_INT_EN_RISE_CLR		0x0F
-#define USB_INT_EN_FALL			0x10
-#define USB_INT_EN_FALL_SET		0x11
-#define USB_INT_EN_FALL_CLR		0x12
-#define USB_INT_STS			0x13
-#define USB_INT_LATCH			0x14
-#define USB_INT_IDGND			(1 << 4)
-#define USB_INT_SESSEND			(1 << 3)
-#define USB_INT_SESSVALID		(1 << 2)
-#define USB_INT_VBUSVALID		(1 << 1)
-#define USB_INT_HOSTDISCONNECT		(1 << 0)
-
-#define CARKIT_CTRL			0x19
-#define CARKIT_CTRL_SET			0x1A
-#define CARKIT_CTRL_CLR			0x1B
-#define CARKIT_CTRL_MICEN		(1 << 6)
-#define CARKIT_CTRL_SPKRIGHTEN		(1 << 5)
-#define CARKIT_CTRL_SPKLEFTEN		(1 << 4)
-#define CARKIT_CTRL_RXDEN		(1 << 3)
-#define CARKIT_CTRL_TXDEN		(1 << 2)
-#define CARKIT_CTRL_IDGNDDRV		(1 << 1)
-#define CARKIT_CTRL_CARKITPWR		(1 << 0)
-#define CARKIT_PLS_CTRL			0x22
-#define CARKIT_PLS_CTRL_SET		0x23
-#define CARKIT_PLS_CTRL_CLR		0x24
-#define CARKIT_PLS_CTRL_SPKRRIGHT_BIASEN	(1 << 3)
-#define CARKIT_PLS_CTRL_SPKRLEFT_BIASEN	(1 << 2)
-#define CARKIT_PLS_CTRL_RXPLSEN		(1 << 1)
-#define CARKIT_PLS_CTRL_TXPLSEN		(1 << 0)
-
-#define MCPC_CTRL			0x30
-#define MCPC_CTRL_SET			0x31
-#define MCPC_CTRL_CLR			0x32
-#define MCPC_CTRL_RTSOL			(1 << 7)
-#define MCPC_CTRL_EXTSWR		(1 << 6)
-#define MCPC_CTRL_EXTSWC		(1 << 5)
-#define MCPC_CTRL_VOICESW		(1 << 4)
-#define MCPC_CTRL_OUT64K		(1 << 3)
-#define MCPC_CTRL_RTSCTSSW		(1 << 2)
-#define MCPC_CTRL_HS_UART		(1 << 0)
-
-#define MCPC_IO_CTRL			0x33
-#define MCPC_IO_CTRL_SET		0x34
-#define MCPC_IO_CTRL_CLR		0x35
-#define MCPC_IO_CTRL_MICBIASEN		(1 << 5)
-#define MCPC_IO_CTRL_CTS_NPU		(1 << 4)
-#define MCPC_IO_CTRL_RXD_PU		(1 << 3)
-#define MCPC_IO_CTRL_TXDTYP		(1 << 2)
-#define MCPC_IO_CTRL_CTSTYP		(1 << 1)
-#define MCPC_IO_CTRL_RTSTYP		(1 << 0)
-
-#define MCPC_CTRL2			0x36
-#define MCPC_CTRL2_SET			0x37
-#define MCPC_CTRL2_CLR			0x38
-#define MCPC_CTRL2_MCPC_CK_EN		(1 << 0)
-
-#define OTHER_FUNC_CTRL			0x80
-#define OTHER_FUNC_CTRL_SET		0x81
-#define OTHER_FUNC_CTRL_CLR		0x82
-#define OTHER_FUNC_CTRL_BDIS_ACON_EN	(1 << 4)
-#define OTHER_FUNC_CTRL_FIVEWIRE_MODE	(1 << 2)
-
-#define OTHER_IFC_CTRL			0x83
-#define OTHER_IFC_CTRL_SET		0x84
-#define OTHER_IFC_CTRL_CLR		0x85
-#define OTHER_IFC_CTRL_OE_INT_EN	(1 << 6)
-#define OTHER_IFC_CTRL_CEA2011_MODE	(1 << 5)
-#define OTHER_IFC_CTRL_FSLSSERIALMODE_4PIN	(1 << 4)
-#define OTHER_IFC_CTRL_HIZ_ULPI_60MHZ_OUT	(1 << 3)
-#define OTHER_IFC_CTRL_HIZ_ULPI		(1 << 2)
-#define OTHER_IFC_CTRL_ALT_INT_REROUTE	(1 << 0)
-
-#define OTHER_INT_EN_RISE		0x86
-#define OTHER_INT_EN_RISE_SET		0x87
-#define OTHER_INT_EN_RISE_CLR		0x88
-#define OTHER_INT_EN_FALL		0x89
-#define OTHER_INT_EN_FALL_SET		0x8A
-#define OTHER_INT_EN_FALL_CLR		0x8B
-#define OTHER_INT_STS			0x8C
-#define OTHER_INT_LATCH			0x8D
-#define OTHER_INT_VB_SESS_VLD		(1 << 7)
-#define OTHER_INT_DM_HI			(1 << 6) /* not valid for "latch" reg */
-#define OTHER_INT_DP_HI			(1 << 5) /* not valid for "latch" reg */
-#define OTHER_INT_BDIS_ACON		(1 << 3) /* not valid for "fall" regs */
-#define OTHER_INT_MANU			(1 << 1)
-#define OTHER_INT_ABNORMAL_STRESS	(1 << 0)
-
-#define ID_STATUS			0x96
-#define ID_RES_FLOAT			(1 << 4)
-#define ID_RES_440K			(1 << 3)
-#define ID_RES_200K			(1 << 2)
-#define ID_RES_102K			(1 << 1)
-#define ID_RES_GND			(1 << 0)
-
-#define POWER_CTRL			0xAC
-#define POWER_CTRL_SET			0xAD
-#define POWER_CTRL_CLR			0xAE
-#define POWER_CTRL_OTG_ENAB		(1 << 5)
-
-#define OTHER_IFC_CTRL2			0xAF
-#define OTHER_IFC_CTRL2_SET		0xB0
-#define OTHER_IFC_CTRL2_CLR		0xB1
-#define OTHER_IFC_CTRL2_ULPI_STP_LOW	(1 << 4)
-#define OTHER_IFC_CTRL2_ULPI_TXEN_POL	(1 << 3)
-#define OTHER_IFC_CTRL2_ULPI_4PIN_2430	(1 << 2)
-#define OTHER_IFC_CTRL2_USB_INT_OUTSEL_MASK	(3 << 0) /* bits 0 and 1 */
-#define OTHER_IFC_CTRL2_USB_INT_OUTSEL_INT1N	(0 << 0)
-#define OTHER_IFC_CTRL2_USB_INT_OUTSEL_INT2N	(1 << 0)
-
-#define REG_CTRL_EN			0xB2
-#define REG_CTRL_EN_SET			0xB3
-#define REG_CTRL_EN_CLR			0xB4
-#define REG_CTRL_ERROR			0xB5
-#define ULPI_I2C_CONFLICT_INTEN		(1 << 0)
-
-#define OTHER_FUNC_CTRL2		0xB8
-#define OTHER_FUNC_CTRL2_SET		0xB9
-#define OTHER_FUNC_CTRL2_CLR		0xBA
-#define OTHER_FUNC_CTRL2_VBAT_TIMER_EN	(1 << 0)
-
-/* following registers do not have separate _clr and _set registers */
-#define VBUS_DEBOUNCE			0xC0
-#define ID_DEBOUNCE			0xC1
-#define VBAT_TIMER			0xD3
-#define PHY_PWR_CTRL			0xFD
-#define PHY_PWR_PHYPWD			(1 << 0)
-#define PHY_CLK_CTRL			0xFE
-#define PHY_CLK_CTRL_CLOCKGATING_EN	(1 << 2)
-#define PHY_CLK_CTRL_CLK32K_EN		(1 << 1)
-#define REQ_PHY_DPLL_CLK		(1 << 0)
-#define PHY_CLK_CTRL_STS		0xFF
-#define PHY_DPLL_CLK			(1 << 0)
-
-/* In module TWL4030_MODULE_PM_MASTER */
-#define PROTECT_KEY			0x0E
-
-/* In module TWL4030_MODULE_PM_RECEIVER */
-#define VUSB_DEDICATED1			0x7D
-#define VUSB_DEDICATED2			0x7E
-#define VUSB1V5_DEV_GRP			0x71
-#define VUSB1V5_TYPE			0x72
-#define VUSB1V5_REMAP			0x73
-#define VUSB1V8_DEV_GRP			0x74
-#define VUSB1V8_TYPE			0x75
-#define VUSB1V8_REMAP			0x76
-#define VUSB3V1_DEV_GRP			0x77
-#define VUSB3V1_TYPE			0x78
-#define VUSB3V1_REMAP			0x79
-
-#define ID_STATUS			0x96
-#define ID_RES_FLOAT			(1 << 4) /* mini-B */
-#define ID_RES_440K			(1 << 3) /* type 2 charger */
-#define ID_RES_200K			(1 << 2) /* 5-wire carkit or
-						    type 1 charger */
-#define ID_RES_102K			(1 << 1) /* phone */
-#define ID_RES_GND			(1 << 0) /* mini-A */
-
-/* In module TWL4030_MODULE_INTBR */
-#define PMBR1				0x0D
-#define GPIO_USB_4PIN_ULPI_2430C	(3 << 0)
-
-/* In module TWL4030_MODULE_INT */
-#define REG_PWR_ISR1			0x00
-#define REG_PWR_IMR1			0x01
-#define USB_PRES			(1 << 2)
-#define REG_PWR_EDR1			0x05
-#define USB_PRES_FALLING		(1 << 4)
-#define USB_PRES_RISING			(1 << 5)
-#define REG_PWR_SIH_CTRL		0x07
-#define COR				(1 << 2)
-
-/* internal define on top of container_of */
-#define xceiv_to_twl(x)		container_of((x), struct twl4030_usb, otg);
-
-/* bits in OTG_CTRL */
-
-#define	OTG_XCEIV_OUTPUTS \
-	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
-#define	OTG_XCEIV_INPUTS \
-	(OTG_PULLDOWN|OTG_PULLUP|OTG_DRV_VBUS|OTG_PD_VBUS|OTG_PU_VBUS|OTG_PU_ID)
-#define	OTG_CTRL_BITS \
-	(OTG_A_BUSREQ|OTG_A_SETB_HNPEN|OTG_B_BUSREQ|OTG_B_HNPEN|OTG_BUSDROP)
-	/* and OTG_PULLUP is sometimes written */
-
-#define	OTG_CTRL_MASK	(OTG_DRIVER_SEL| \
-	OTG_XCEIV_OUTPUTS|OTG_XCEIV_INPUTS| \
-	OTG_CTRL_BITS)
-
-
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
 
@@ -297,46 +68,51 @@ static int twl4030_i2c_write_u8_verify(u8 module, u8 data, u8 address)
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
 
@@ -345,14 +121,13 @@ static inline int twl4030_usb_read(u8 address)
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
@@ -380,185 +155,130 @@ static void twl4030_usb_set_mode(struct twl4030_usb *twl, int mode)
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
@@ -591,59 +311,57 @@ static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
 
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
@@ -660,23 +378,25 @@ static int twl4030_set_peripheral(struct otg_transceiver *xceiv,
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
@@ -689,63 +409,65 @@ static int twl4030_set_host(struct otg_transceiver *xceiv, struct usb_bus *host)
 	return 0;
 }
 
-static int __init twl4030_usb_init(void)
+static int __init twl4030_usb_probe(struct platform_device *pdev)
 {
+	struct twl4030_usb_platform_data *pdata = pdev->dev.platform_data;
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
@@ -755,11 +477,11 @@ static void __exit twl4030_usb_exit(void)
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
@@ -768,12 +490,32 @@ static void __exit twl4030_usb_exit(void)
 	twl4030_phy_power(twl, 0);
 
 	kfree(twl);
+
+	return 0;
+}
+
+static struct platform_driver twl4030_driver = {
+	.probe		= twl4030_usb_probe,
+	.remove		= __exit_p(twl4030_remove),
+	.driver		= {
+		.name	= "twl4030-usb",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init twl4030_usb_init(void)
+{
+	return platform_driver_register(&twl4030_driver);
 }
+module_init(twl4030_usb_init);
 
-subsys_initcall(twl4030_usb_init);
+static void __exit twl4030_usb_exit(void)
+{
+	platform_driver_unregister(&twl4030_driver);
+}
 module_exit(twl4030_usb_exit);
 
-MODULE_ALIAS("i2c:twl4030-usb");
-MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_ALIAS("platform:twl4030-usb");
+MODULE_AUTHOR("Texas Instruments, Inc, Nokia Corporation");
 MODULE_DESCRIPTION("TWL4030 USB transceiver driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/twl4030-usb.h b/include/linux/i2c/twl4030-usb.h
new file mode 100644
index 0000000..9cd2e50
--- /dev/null
+++ b/include/linux/i2c/twl4030-usb.h
@@ -0,0 +1,257 @@
+/*
+ * twl4030-usb.h - header for TWL4030 USB Transceiver
+ *
+ * Copyright (C) 2004-2007 Texas Instruments
+ * Copyright (C) 2008 Nokia Corporation
+ * Contact: Felipe Balbi <felipe.balbi@nokia.com>
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#ifndef __TWL4030_USB_H_
+#define __TWL4030_USB_H_
+
+/* Register defines */
+
+#define VENDOR_ID_LO			0x00
+#define VENDOR_ID_HI			0x01
+#define PRODUCT_ID_LO			0x02
+#define PRODUCT_ID_HI			0x03
+
+#define FUNC_CTRL			0x04
+#define FUNC_CTRL_SET			0x05
+#define FUNC_CTRL_CLR			0x06
+#define FUNC_CTRL_SUSPENDM		(1 << 6)
+#define FUNC_CTRL_RESET			(1 << 5)
+#define FUNC_CTRL_OPMODE_MASK		(3 << 3) /* bits 3 and 4 */
+#define FUNC_CTRL_OPMODE_NORMAL		(0 << 3)
+#define FUNC_CTRL_OPMODE_NONDRIVING	(1 << 3)
+#define FUNC_CTRL_OPMODE_DISABLE_BIT_NRZI	(2 << 3)
+#define FUNC_CTRL_TERMSELECT		(1 << 2)
+#define FUNC_CTRL_XCVRSELECT_MASK	(3 << 0) /* bits 0 and 1 */
+#define FUNC_CTRL_XCVRSELECT_HS		(0 << 0)
+#define FUNC_CTRL_XCVRSELECT_FS		(1 << 0)
+#define FUNC_CTRL_XCVRSELECT_LS		(2 << 0)
+#define FUNC_CTRL_XCVRSELECT_FS4LS	(3 << 0)
+
+#define IFC_CTRL			0x07
+#define IFC_CTRL_SET			0x08
+#define IFC_CTRL_CLR			0x09
+#define IFC_CTRL_INTERFACE_PROTECT_DISABLE	(1 << 7)
+#define IFC_CTRL_AUTORESUME		(1 << 4)
+#define IFC_CTRL_CLOCKSUSPENDM		(1 << 3)
+#define IFC_CTRL_CARKITMODE		(1 << 2)
+#define IFC_CTRL_FSLSSERIALMODE_3PIN	(1 << 1)
+
+#define TWL4030_OTG_CTRL		0x0A
+#define TWL4030_OTG_CTRL_SET		0x0B
+#define TWL4030_OTG_CTRL_CLR		0x0C
+#define TWL4030_OTG_CTRL_DRVVBUS	(1 << 5)
+#define TWL4030_OTG_CTRL_CHRGVBUS	(1 << 4)
+#define TWL4030_OTG_CTRL_DISCHRGVBUS	(1 << 3)
+#define TWL4030_OTG_CTRL_DMPULLDOWN	(1 << 2)
+#define TWL4030_OTG_CTRL_DPPULLDOWN	(1 << 1)
+#define TWL4030_OTG_CTRL_IDPULLUP	(1 << 0)
+
+#define USB_INT_EN_RISE			0x0D
+#define USB_INT_EN_RISE_SET		0x0E
+#define USB_INT_EN_RISE_CLR		0x0F
+#define USB_INT_EN_FALL			0x10
+#define USB_INT_EN_FALL_SET		0x11
+#define USB_INT_EN_FALL_CLR		0x12
+#define USB_INT_STS			0x13
+#define USB_INT_LATCH			0x14
+#define USB_INT_IDGND			(1 << 4)
+#define USB_INT_SESSEND			(1 << 3)
+#define USB_INT_SESSVALID		(1 << 2)
+#define USB_INT_VBUSVALID		(1 << 1)
+#define USB_INT_HOSTDISCONNECT		(1 << 0)
+
+#define CARKIT_CTRL			0x19
+#define CARKIT_CTRL_SET			0x1A
+#define CARKIT_CTRL_CLR			0x1B
+#define CARKIT_CTRL_MICEN		(1 << 6)
+#define CARKIT_CTRL_SPKRIGHTEN		(1 << 5)
+#define CARKIT_CTRL_SPKLEFTEN		(1 << 4)
+#define CARKIT_CTRL_RXDEN		(1 << 3)
+#define CARKIT_CTRL_TXDEN		(1 << 2)
+#define CARKIT_CTRL_IDGNDDRV		(1 << 1)
+#define CARKIT_CTRL_CARKITPWR		(1 << 0)
+#define CARKIT_PLS_CTRL			0x22
+#define CARKIT_PLS_CTRL_SET		0x23
+#define CARKIT_PLS_CTRL_CLR		0x24
+#define CARKIT_PLS_CTRL_SPKRRIGHT_BIASEN	(1 << 3)
+#define CARKIT_PLS_CTRL_SPKRLEFT_BIASEN	(1 << 2)
+#define CARKIT_PLS_CTRL_RXPLSEN		(1 << 1)
+#define CARKIT_PLS_CTRL_TXPLSEN		(1 << 0)
+
+#define MCPC_CTRL			0x30
+#define MCPC_CTRL_SET			0x31
+#define MCPC_CTRL_CLR			0x32
+#define MCPC_CTRL_RTSOL			(1 << 7)
+#define MCPC_CTRL_EXTSWR		(1 << 6)
+#define MCPC_CTRL_EXTSWC		(1 << 5)
+#define MCPC_CTRL_VOICESW		(1 << 4)
+#define MCPC_CTRL_OUT64K		(1 << 3)
+#define MCPC_CTRL_RTSCTSSW		(1 << 2)
+#define MCPC_CTRL_HS_UART		(1 << 0)
+
+#define MCPC_IO_CTRL			0x33
+#define MCPC_IO_CTRL_SET		0x34
+#define MCPC_IO_CTRL_CLR		0x35
+#define MCPC_IO_CTRL_MICBIASEN		(1 << 5)
+#define MCPC_IO_CTRL_CTS_NPU		(1 << 4)
+#define MCPC_IO_CTRL_RXD_PU		(1 << 3)
+#define MCPC_IO_CTRL_TXDTYP		(1 << 2)
+#define MCPC_IO_CTRL_CTSTYP		(1 << 1)
+#define MCPC_IO_CTRL_RTSTYP		(1 << 0)
+
+#define MCPC_CTRL2			0x36
+#define MCPC_CTRL2_SET			0x37
+#define MCPC_CTRL2_CLR			0x38
+#define MCPC_CTRL2_MCPC_CK_EN		(1 << 0)
+
+#define OTHER_FUNC_CTRL			0x80
+#define OTHER_FUNC_CTRL_SET		0x81
+#define OTHER_FUNC_CTRL_CLR		0x82
+#define OTHER_FUNC_CTRL_BDIS_ACON_EN	(1 << 4)
+#define OTHER_FUNC_CTRL_FIVEWIRE_MODE	(1 << 2)
+
+#define OTHER_IFC_CTRL			0x83
+#define OTHER_IFC_CTRL_SET		0x84
+#define OTHER_IFC_CTRL_CLR		0x85
+#define OTHER_IFC_CTRL_OE_INT_EN	(1 << 6)
+#define OTHER_IFC_CTRL_CEA2011_MODE	(1 << 5)
+#define OTHER_IFC_CTRL_FSLSSERIALMODE_4PIN	(1 << 4)
+#define OTHER_IFC_CTRL_HIZ_ULPI_60MHZ_OUT	(1 << 3)
+#define OTHER_IFC_CTRL_HIZ_ULPI		(1 << 2)
+#define OTHER_IFC_CTRL_ALT_INT_REROUTE	(1 << 0)
+
+#define OTHER_INT_EN_RISE		0x86
+#define OTHER_INT_EN_RISE_SET		0x87
+#define OTHER_INT_EN_RISE_CLR		0x88
+#define OTHER_INT_EN_FALL		0x89
+#define OTHER_INT_EN_FALL_SET		0x8A
+#define OTHER_INT_EN_FALL_CLR		0x8B
+#define OTHER_INT_STS			0x8C
+#define OTHER_INT_LATCH			0x8D
+#define OTHER_INT_VB_SESS_VLD		(1 << 7)
+#define OTHER_INT_DM_HI			(1 << 6) /* not valid for "latch" reg */
+#define OTHER_INT_DP_HI			(1 << 5) /* not valid for "latch" reg */
+#define OTHER_INT_BDIS_ACON		(1 << 3) /* not valid for "fall" regs */
+#define OTHER_INT_MANU			(1 << 1)
+#define OTHER_INT_ABNORMAL_STRESS	(1 << 0)
+
+#define ID_STATUS			0x96
+#define ID_RES_FLOAT			(1 << 4)
+#define ID_RES_440K			(1 << 3)
+#define ID_RES_200K			(1 << 2)
+#define ID_RES_102K			(1 << 1)
+#define ID_RES_GND			(1 << 0)
+
+#define POWER_CTRL			0xAC
+#define POWER_CTRL_SET			0xAD
+#define POWER_CTRL_CLR			0xAE
+#define POWER_CTRL_OTG_ENAB		(1 << 5)
+
+#define OTHER_IFC_CTRL2			0xAF
+#define OTHER_IFC_CTRL2_SET		0xB0
+#define OTHER_IFC_CTRL2_CLR		0xB1
+#define OTHER_IFC_CTRL2_ULPI_STP_LOW	(1 << 4)
+#define OTHER_IFC_CTRL2_ULPI_TXEN_POL	(1 << 3)
+#define OTHER_IFC_CTRL2_ULPI_4PIN_2430	(1 << 2)
+#define OTHER_IFC_CTRL2_USB_INT_OUTSEL_MASK	(3 << 0) /* bits 0 and 1 */
+#define OTHER_IFC_CTRL2_USB_INT_OUTSEL_INT1N	(0 << 0)
+#define OTHER_IFC_CTRL2_USB_INT_OUTSEL_INT2N	(1 << 0)
+
+#define REG_CTRL_EN			0xB2
+#define REG_CTRL_EN_SET			0xB3
+#define REG_CTRL_EN_CLR			0xB4
+#define REG_CTRL_ERROR			0xB5
+#define ULPI_I2C_CONFLICT_INTEN		(1 << 0)
+
+#define OTHER_FUNC_CTRL2		0xB8
+#define OTHER_FUNC_CTRL2_SET		0xB9
+#define OTHER_FUNC_CTRL2_CLR		0xBA
+#define OTHER_FUNC_CTRL2_VBAT_TIMER_EN	(1 << 0)
+
+/* following registers do not have separate _clr and _set registers */
+#define VBUS_DEBOUNCE			0xC0
+#define ID_DEBOUNCE			0xC1
+#define VBAT_TIMER			0xD3
+#define PHY_PWR_CTRL			0xFD
+#define PHY_PWR_PHYPWD			(1 << 0)
+#define PHY_CLK_CTRL			0xFE
+#define PHY_CLK_CTRL_CLOCKGATING_EN	(1 << 2)
+#define PHY_CLK_CTRL_CLK32K_EN		(1 << 1)
+#define REQ_PHY_DPLL_CLK		(1 << 0)
+#define PHY_CLK_CTRL_STS		0xFF
+#define PHY_DPLL_CLK			(1 << 0)
+
+/* In module TWL4030_MODULE_PM_MASTER */
+#define PROTECT_KEY			0x0E
+
+/* In module TWL4030_MODULE_PM_RECEIVER */
+#define VUSB_DEDICATED1			0x7D
+#define VUSB_DEDICATED2			0x7E
+#define VUSB1V5_DEV_GRP			0x71
+#define VUSB1V5_TYPE			0x72
+#define VUSB1V5_REMAP			0x73
+#define VUSB1V8_DEV_GRP			0x74
+#define VUSB1V8_TYPE			0x75
+#define VUSB1V8_REMAP			0x76
+#define VUSB3V1_DEV_GRP			0x77
+#define VUSB3V1_TYPE			0x78
+#define VUSB3V1_REMAP			0x79
+
+/* In module TWL4030_MODULE_INTBR */
+#define PMBR1				0x0D
+#define GPIO_USB_4PIN_ULPI_2430C	(3 << 0)
+
+/* In module TWL4030_MODULE_INT */
+#define REG_PWR_ISR1			0x00
+#define REG_PWR_IMR1			0x01
+#define USB_PRES			(1 << 2)
+#define REG_PWR_EDR1			0x05
+#define USB_PRES_FALLING		(1 << 4)
+#define USB_PRES_RISING			(1 << 5)
+#define REG_PWR_SIH_CTRL		0x07
+#define COR				(1 << 2)
+
+/* bits in OTG_CTRL */
+#define	OTG_XCEIV_OUTPUTS \
+	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
+#define	OTG_XCEIV_INPUTS \
+	(OTG_PULLDOWN|OTG_PULLUP|OTG_DRV_VBUS|OTG_PD_VBUS|OTG_PU_VBUS|OTG_PU_ID)
+#define	OTG_CTRL_BITS \
+	(OTG_A_BUSREQ|OTG_A_SETB_HNPEN|OTG_B_BUSREQ|OTG_B_HNPEN|OTG_BUSDROP)
+	/* and OTG_PULLUP is sometimes written */
+
+#define	OTG_CTRL_MASK	(OTG_DRIVER_SEL| \
+	OTG_XCEIV_OUTPUTS|OTG_XCEIV_INPUTS| \
+	OTG_CTRL_BITS)
+
+enum twl4030_usb_mode {
+	T2_USB_MODE_ULPI = 1,
+	T2_USB_MODE_CEA2011_3PIN = 2,
+};
+
+struct twl4030_usb_platform_data {
+	enum twl4030_usb_mode	usb_mode;
+};
+
+#endif /* End of __TWL4030_USB_H */
+
-- 
1.6.0.1.126.ga118

