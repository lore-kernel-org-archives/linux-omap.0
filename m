From: Hema HK <hemahk@ti.com>
Subject: [PATCH 2/7 V2] usb: otg: Adding twl6030-usb transceiver driver for
Date: Fri, 10 Dec 2010 12:34:18 +0530
Message-ID: <1291964658-7076-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55069 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab0LJHEe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 02:04:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>

Adding the twl6030-usb transceiver support for OMAP4 musb driver.

OMAP4 supports 2 types of transceiver interface.

1. UTMI: The PHY is embedded within OMAP4. The transceiver functionality
is split between the twl6030 PMIC chip and OMAP4430. The VBUS, ID pin 
sensing and OTG SRP generation part is integrated in TWL6030 and UTMI PHY
functionality is embedded within the OMAP4430.

There is no direct interactions between the MUSB controller and TWL6030
chip to communicate the session-valid, session-end and ID-GND events.
It has to be done through a software by setting/resetting bits in
one of the control module register of OMAP4430 which in turn toggles
the appropriate signals to MUSB controller.

The internal transceiver has functional clocks and
powerdown bits to powerdown the PHY for power saving.

Since there is no option available for having 2 transceiver drivers
for one USB controller, internal PHY specific APIs are passed through
plaform_data function pointers to use in the twl6030-usb transceiver
driver.

2. ULPI interface is provided for off-chip transceivers.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/omap_phy_internal.c |  149 +++++++++
 arch/arm/plat-omap/include/plat/usb.h   |    5 
 drivers/usb/otg/Makefile                |    1 
 drivers/usb/otg/twl6030-usb.c           |  493 ++++++++++++++++++++++++++++++++
 4 files changed, 648 insertions(+)

Index: usb/arch/arm/mach-omap2/omap_phy_internal.c
===================================================================
--- /dev/null
+++ usb/arch/arm/mach-omap2/omap_phy_internal.c
@@ -0,0 +1,149 @@
+/*
+  * This file configures the internal USB PHY in OMAP4430. Used
+  * with TWL6030 transceiver and MUSB on OMAP4430.
+  *
+  * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License as published by
+  * the Free Software Foundation; either version 2 of the License, or
+  * (at your option) any later version.
+  *
+  * Author: Hema HK <hemahk@ti.com>
+  *
+  * This program is distributed in the hope that it will be useful,
+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  * GNU General Public License for more details.
+  *
+  * You should have received a copy of the GNU General Public License
+  * along with this program; if not, write to the Free Software
+  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+  *
+  */
+
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/usb.h>
+
+#include <plat/usb.h>
+
+/* OMAP control module register for UTMI PHY */
+#define CONTROL_DEV_CONF		0x300
+#define PHY_PD				0x1
+
+#define USBOTGHS_CONTROL		0x33c
+#define	AVALID				BIT(0)
+#define	BVALID				BIT(1)
+#define	VBUSVALID			BIT(2)
+#define	SESSEND				BIT(3)
+#define	IDDIG				BIT(4)
+
+static struct clk *phyclk, *clk48m, *clk32k;
+static void __iomem *ctrl_base;
+
+int omap4430_phy_init(struct device *dev)
+{
+	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
+	if (!ctrl_base) {
+		dev_err(dev, "control module ioremap failed\n");
+		return -ENOMEM;
+	}
+	/* Power down the phy */
+	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
+
+	if (IS_ERR(phyclk)) {
+		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
+		iounmap(ctrl_base);
+		return PTR_ERR(phyclk);
+	}
+
+	clk48m = clk_get(dev, "ocp2scp_usb_phy_phy_48m");
+	if (IS_ERR(clk48m)) {
+		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_phy_48m\n");
+		clk_put(phyclk);
+		iounmap(ctrl_base);
+		return PTR_ERR(clk48m);
+	}
+
+	clk32k = clk_get(dev, "usb_phy_cm_clk32k");
+	if (IS_ERR(clk32k)) {
+		dev_err(dev, "cannot clk_get usb_phy_cm_clk32k\n");
+		clk_put(phyclk);
+		clk_put(clk48m);
+		iounmap(ctrl_base);
+		return PTR_ERR(clk32k);
+	}
+	return 0;
+}
+
+int omap4430_phy_set_clk(struct device *dev, int on)
+{
+	static int state;
+
+	if (on && !state) {
+		/* Enable the phy clocks */
+		clk_enable(phyclk);
+		clk_enable(clk48m);
+		clk_enable(clk32k);
+		state = 1;
+	} else if (state) {
+		/* Disable the phy clocks */
+		clk_disable(phyclk);
+		clk_disable(clk48m);
+		clk_disable(clk32k);
+		state = 0;
+	}
+	return 0;
+}
+
+int omap4430_phy_power(struct device *dev, int ID, int on)
+{
+	if (on) {
+		/* enabled the clocks */
+		omap4430_phy_set_clk(dev, 1);
+		/* power on the phy */
+		if (__raw_readl(ctrl_base + CONTROL_DEV_CONF) & PHY_PD) {
+			__raw_writel(~PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+			mdelay(200);
+		}
+		if (ID)
+			/* enable VBUS valid, IDDIG groung */
+			__raw_writel(AVALID | VBUSVALID, ctrl_base +
+							USBOTGHS_CONTROL);
+		else
+			/*
+			 * Enable VBUS Valid, AValid and IDDIG
+			 * high impedence
+			 */
+			__raw_writel(IDDIG | AVALID | VBUSVALID,
+						ctrl_base + USBOTGHS_CONTROL);
+	} else {
+		/* Enable session END and IDIG to high impedence. */
+		__raw_writel(SESSEND | IDDIG, ctrl_base +
+					USBOTGHS_CONTROL);
+		/* Disable the clocks */
+		omap4430_phy_set_clk(dev, 0);
+		/* Power down the phy */
+		__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+	}
+
+	return 0;
+}
+
+int omap4430_phy_exit(struct device *dev)
+{
+	if (ctrl_base)
+		iounmap(ctrl_base);
+	if (phyclk)
+		clk_put(phyclk);
+	if (clk48m)
+		clk_put(clk48m);
+	if (clk32k)
+		clk_put(clk32k);
+
+	return 0;
+}
Index: usb/arch/arm/plat-omap/include/plat/usb.h
===================================================================
--- usb.orig/arch/arm/plat-omap/include/plat/usb.h
+++ usb/arch/arm/plat-omap/include/plat/usb.h
@@ -84,6 +84,11 @@ extern void usb_ehci_init(const struct e
 
 extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
 
+extern int omap4430_phy_power(struct device *dev, int ID, int on);
+extern int omap4430_phy_set_clk(struct device *dev, int on);
+extern int omap4430_phy_init(struct device *dev);
+extern int omap4430_phy_exit(struct device *dev);
+
 #endif
 
 
Index: usb/drivers/usb/otg/twl6030-usb.c
===================================================================
--- /dev/null
+++ usb/drivers/usb/otg/twl6030-usb.c
@@ -0,0 +1,493 @@
+/*
+ * twl6030_usb - TWL6030 USB transceiver, talking to OMAP OTG driver.
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Author: Hema HK <hemahk@ti.com>
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/usb/otg.h>
+#include <linux/i2c/twl.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+
+/* usb register definitions */
+#define USB_VENDOR_ID_LSB		0x00
+#define USB_VENDOR_ID_MSB		0x01
+#define USB_PRODUCT_ID_LSB		0x02
+#define USB_PRODUCT_ID_MSB		0x03
+#define USB_VBUS_CTRL_SET		0x04
+#define USB_VBUS_CTRL_CLR		0x05
+#define USB_ID_CTRL_SET			0x06
+#define USB_ID_CTRL_CLR			0x07
+#define USB_VBUS_INT_SRC		0x08
+#define USB_VBUS_INT_LATCH_SET		0x09
+#define USB_VBUS_INT_LATCH_CLR		0x0A
+#define USB_VBUS_INT_EN_LO_SET		0x0B
+#define USB_VBUS_INT_EN_LO_CLR		0x0C
+#define USB_VBUS_INT_EN_HI_SET		0x0D
+#define USB_VBUS_INT_EN_HI_CLR		0x0E
+#define USB_ID_INT_SRC			0x0F
+#define USB_ID_INT_LATCH_SET		0x10
+#define USB_ID_INT_LATCH_CLR		0x11
+
+#define USB_ID_INT_EN_LO_SET		0x12
+#define USB_ID_INT_EN_LO_CLR		0x13
+#define USB_ID_INT_EN_HI_SET		0x14
+#define USB_ID_INT_EN_HI_CLR		0x15
+#define USB_OTG_ADP_CTRL		0x16
+#define USB_OTG_ADP_HIGH		0x17
+#define USB_OTG_ADP_LOW			0x18
+#define USB_OTG_ADP_RISE		0x19
+#define USB_OTG_REVISION		0x1A
+
+/* to be moved to LDO */
+#define TWL6030_MISC2			0xE5
+#define TWL6030_CFG_LDO_PD2		0xF5
+#define TWL6030_BACKUP_REG		0xFA
+
+#define STS_HW_CONDITIONS		0x21
+
+/* In module TWL6030_MODULE_PM_MASTER */
+#define STS_HW_CONDITIONS		0x21
+#define STS_USB_ID			BIT(2)
+
+/* In module TWL6030_MODULE_PM_RECEIVER */
+#define VUSB_CFG_TRANS			0x71
+#define VUSB_CFG_STATE			0x72
+#define VUSB_CFG_VOLTAGE		0x73
+
+/* in module TWL6030_MODULE_MAIN_CHARGE */
+
+#define CHARGERUSB_CTRL1		0x8
+
+#define CONTROLLER_STAT1		0x03
+#define	VBUS_DET			BIT(2)
+
+struct twl6030_usb {
+	struct otg_transceiver	otg;
+	struct device		*dev;
+
+	/* for vbus reporting with irqs disabled */
+	spinlock_t		lock;
+
+	struct regulator		*usb3v3;
+
+	int			irq1;
+	int			irq2;
+	u8			linkstat;
+	u8			asleep;
+	bool			irq_enabled;
+};
+
+#define xceiv_to_twl(x)		container_of((x), struct twl6030_usb, otg);
+
+/*-------------------------------------------------------------------------*/
+
+static inline int twl6030_writeb(struct twl6030_usb *twl, u8 module,
+						u8 data, u8 address)
+{
+	int ret = 0;
+
+	ret = twl_i2c_write_u8(module, data, address);
+	if (ret < 0)
+		dev_err(twl->dev,
+			"Write[0x%x] Error %d\n", address, ret);
+	return ret;
+}
+
+static inline u8 twl6030_readb(struct twl6030_usb *twl, u8 module, u8 address)
+{
+	u8 data, ret = 0;
+
+	ret = twl_i2c_read_u8(module, &data, address);
+	if (ret >= 0)
+		ret = data;
+	else
+		dev_err(twl->dev,
+			"readb[0x%x,0x%x] Error %d\n",
+					module, address, ret);
+	return ret;
+}
+
+/*-------------------------------------------------------------------------*/
+static int twl6030_set_phy_clk(struct otg_transceiver *x, int on)
+{
+	struct twl6030_usb *twl;
+	struct device *dev;
+	struct twl4030_usb_data *pdata;
+
+	twl = xceiv_to_twl(x);
+	dev  = twl->dev;
+	pdata = dev->platform_data;
+
+	pdata->phy_set_clock(twl->dev, on);
+
+	return 0;
+}
+
+static int twl6030_phy_init(struct otg_transceiver *x)
+{
+	u8 hw_state;
+	struct twl6030_usb *twl;
+	struct device *dev;
+	struct twl4030_usb_data *pdata;
+
+	twl = xceiv_to_twl(x);
+	dev  = twl->dev;
+	pdata = dev->platform_data;
+
+	regulator_enable(twl->usb3v3);
+
+	hw_state = twl6030_readb(twl, TWL6030_MODULE_ID0, STS_HW_CONDITIONS);
+
+	if (hw_state & STS_USB_ID)
+		pdata->phy_power(twl->dev, 1, 1);
+	else
+		pdata->phy_power(twl->dev, 0, 1);
+
+	return 0;
+}
+
+static void twl6030_phy_shutdown(struct otg_transceiver *x)
+{
+	struct twl6030_usb *twl;
+	struct device *dev;
+	struct twl4030_usb_data *pdata;
+
+	twl = xceiv_to_twl(x);
+	dev  = twl->dev;
+	pdata = dev->platform_data;
+	pdata->phy_power(twl->dev, 0, 0);
+	regulator_disable(twl->usb3v3);
+}
+
+static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
+{
+
+	/* Set to OTG_REV 1.3 and turn on the ID_WAKEUP_COMP */
+	twl6030_writeb(twl, TWL6030_MODULE_ID0 , 0x1, TWL6030_BACKUP_REG);
+
+	/* Program CFG_LDO_PD2 register and set VUSB bit */
+	twl6030_writeb(twl, TWL6030_MODULE_ID0 , 0x1, TWL6030_CFG_LDO_PD2);
+
+	/* Program MISC2 register and set bit VUSB_IN_VBAT */
+	twl6030_writeb(twl, TWL6030_MODULE_ID0 , 0x10, TWL6030_MISC2);
+
+	twl->usb3v3 = regulator_get(twl->dev, "vusb");
+	if (IS_ERR(twl->usb3v3))
+		return -ENODEV;
+
+	regulator_enable(twl->usb3v3);
+
+	/* Program the VUSB_CFG_TRANS for ACTIVE state. */
+	twl6030_writeb(twl, TWL_MODULE_PM_RECEIVER, 0x3F,
+						VUSB_CFG_TRANS);
+
+	/* Program the VUSB_CFG_STATE register to ON on all groups. */
+	twl6030_writeb(twl, TWL_MODULE_PM_RECEIVER, 0xE1,
+						VUSB_CFG_STATE);
+
+	/* Program the USB_VBUS_CTRL_SET and set VBUS_ACT_COMP bit */
+	twl6030_writeb(twl, TWL_MODULE_USB, 0x4, USB_VBUS_CTRL_SET);
+
+	/*
+	 * Program the USB_ID_CTRL_SET register to enable GND drive
+	 * and the ID comparators
+	 */
+	twl6030_writeb(twl, TWL_MODULE_USB, 0x14, USB_ID_CTRL_SET);
+
+	return 0;
+}
+
+static ssize_t twl6030_usb_vbus_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct twl6030_usb *twl = dev_get_drvdata(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&twl->lock, flags);
+
+	switch (twl->linkstat) {
+	case USB_EVENT_VBUS:
+	       ret = snprintf(buf, PAGE_SIZE, "vbus\n");
+	       break;
+	case USB_EVENT_ID:
+	       ret = snprintf(buf, PAGE_SIZE, "id\n");
+	       break;
+	case USB_EVENT_NONE:
+	       ret = snprintf(buf, PAGE_SIZE, "none\n");
+	       break;
+	default:
+	       ret = snprintf(buf, PAGE_SIZE, "UNKNOWN\n");
+	}
+	spin_unlock_irqrestore(&twl->lock, flags);
+
+	return ret;
+}
+static DEVICE_ATTR(vbus, 0444, twl6030_usb_vbus_show, NULL);
+
+static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
+{
+	struct twl6030_usb *twl = _twl;
+	int status;
+	u8 vbus_state, hw_state;
+
+	hw_state = twl6030_readb(twl, TWL6030_MODULE_ID0, STS_HW_CONDITIONS);
+
+	vbus_state = twl6030_readb(twl, TWL_MODULE_MAIN_CHARGE,
+						CONTROLLER_STAT1);
+	if (!(hw_state & STS_USB_ID)) {
+		if (vbus_state & VBUS_DET) {
+			status = USB_EVENT_VBUS;
+			twl->otg.default_a = false;
+			twl->otg.state = OTG_STATE_B_IDLE;
+		} else {
+			status = USB_EVENT_NONE;
+		}
+		if (status >= 0) {
+			twl->linkstat = status;
+			blocking_notifier_call_chain(&twl->otg.notifier,
+						status, twl->otg.gadget);
+		}
+	}
+	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
+{
+	struct twl6030_usb *twl = _twl;
+	int status = USB_EVENT_NONE;
+	u8 hw_state;
+
+	hw_state = twl6030_readb(twl, TWL6030_MODULE_ID0, STS_HW_CONDITIONS);
+
+	if (hw_state & STS_USB_ID) {
+
+		twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_EN_HI_CLR, 0x1);
+		twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_EN_HI_SET,
+								0x10);
+		status = USB_EVENT_ID;
+		twl->otg.default_a = true;
+		twl->otg.state = OTG_STATE_A_IDLE;
+		blocking_notifier_call_chain(&twl->otg.notifier, status,
+							twl->otg.gadget);
+	} else  {
+		twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_EN_HI_CLR,
+								0x10);
+		twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_EN_HI_SET,
+								0x1);
+	}
+	twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_LATCH_CLR, status);
+	twl->linkstat = status;
+
+	return IRQ_HANDLED;
+}
+
+static int twl6030_set_peripheral(struct otg_transceiver *x,
+		struct usb_gadget *gadget)
+{
+	struct twl6030_usb *twl;
+
+	if (!x)
+		return -ENODEV;
+
+	twl = xceiv_to_twl(x);
+	twl->otg.gadget = gadget;
+	if (!gadget)
+		twl->otg.state = OTG_STATE_UNDEFINED;
+
+	return 0;
+}
+
+static int twl6030_enable_irq(struct otg_transceiver *x)
+{
+	struct twl6030_usb *twl = xceiv_to_twl(x);
+
+	twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_EN_HI_SET, 0x1);
+	twl6030_interrupt_unmask(0x05, REG_INT_MSK_LINE_C);
+	twl6030_interrupt_unmask(0x05, REG_INT_MSK_STS_C);
+
+	twl6030_interrupt_unmask(TWL6030_CHARGER_CTRL_INT_MASK,
+				REG_INT_MSK_LINE_C);
+	twl6030_interrupt_unmask(TWL6030_CHARGER_CTRL_INT_MASK,
+				REG_INT_MSK_STS_C);
+	twl6030_usb_irq(twl->irq2, twl);
+	twl6030_usbotg_irq(twl->irq1, twl);
+
+	return 0;
+}
+
+static int twl6030_set_vbus(struct otg_transceiver *x, bool enabled)
+{
+	struct twl6030_usb *twl = xceiv_to_twl(x);
+
+	/*
+	 * Start driving VBUS. Set OPA_MODE bit in CHARGERUSB_CTRL1
+	 * register. This enables boost mode.
+	 */
+	if (enabled)
+		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x40,
+						CHARGERUSB_CTRL1);
+	 else
+		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x00,
+						CHARGERUSB_CTRL1);
+	return 0;
+}
+
+static int twl6030_set_host(struct otg_transceiver *x, struct usb_bus *host)
+{
+	struct twl6030_usb *twl;
+
+	if (!x)
+		return -ENODEV;
+
+	twl = xceiv_to_twl(x);
+	twl->otg.host = host;
+	if (!host)
+		twl->otg.state = OTG_STATE_UNDEFINED;
+	return 0;
+}
+
+static int __devinit twl6030_usb_probe(struct platform_device *pdev)
+{
+	struct twl6030_usb	*twl;
+	int			status, err;
+	struct twl4030_usb_data *pdata;
+	struct device *dev = &pdev->dev;
+	pdata = dev->platform_data;
+
+	twl = kzalloc(sizeof *twl, GFP_KERNEL);
+	if (!twl)
+		return -ENOMEM;
+
+	twl->dev		= &pdev->dev;
+	twl->irq1		= platform_get_irq(pdev, 0);
+	twl->irq2		= platform_get_irq(pdev, 1);
+	twl->otg.dev		= twl->dev;
+	twl->otg.label		= "twl6030";
+	twl->otg.set_host	= twl6030_set_host;
+	twl->otg.set_peripheral	= twl6030_set_peripheral;
+	twl->otg.set_vbus	= twl6030_set_vbus;
+	twl->otg.init		= twl6030_phy_init;
+	twl->otg.shutdown	= twl6030_phy_shutdown;
+
+	/* init spinlock for workqueue */
+	spin_lock_init(&twl->lock);
+
+	err = twl6030_usb_ldo_init(twl);
+	if (err) {
+		dev_err(&pdev->dev, "ldo init failed\n");
+		kfree(twl);
+		return err;
+	}
+	otg_set_transceiver(&twl->otg);
+
+	platform_set_drvdata(pdev, twl);
+	if (device_create_file(&pdev->dev, &dev_attr_vbus))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
+
+	BLOCKING_INIT_NOTIFIER_HEAD(&twl->otg.notifier);
+
+	twl->irq_enabled = true;
+	status = request_threaded_irq(twl->irq1, NULL, twl6030_usbotg_irq,
+			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			"twl6030_usb", twl);
+	if (status < 0) {
+		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
+			twl->irq1, status);
+		device_remove_file(twl->dev, &dev_attr_vbus);
+		kfree(twl);
+		return status;
+	}
+
+	status = request_threaded_irq(twl->irq2, NULL, twl6030_usb_irq,
+			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			"twl6030_usb", twl);
+	if (status < 0) {
+		dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
+			twl->irq2, status);
+		free_irq(twl->irq1, twl);
+		device_remove_file(twl->dev, &dev_attr_vbus);
+		kfree(twl);
+		return status;
+	}
+
+	pdata->phy_init(dev);
+	twl6030_enable_irq(&twl->otg);
+	dev_info(&pdev->dev, "Initialized TWL6030 USB module\n");
+
+	return 0;
+}
+
+static int __exit twl6030_usb_remove(struct platform_device *pdev)
+{
+	struct twl6030_usb *twl = platform_get_drvdata(pdev);
+
+	struct twl4030_usb_data *pdata;
+	struct device *dev = &pdev->dev;
+	pdata = dev->platform_data;
+
+	twl6030_interrupt_mask(TWL6030_USBOTG_INT_MASK,
+		REG_INT_MSK_LINE_C);
+	twl6030_interrupt_mask(TWL6030_USBOTG_INT_MASK,
+			REG_INT_MSK_STS_C);
+	free_irq(twl->irq1, twl);
+	free_irq(twl->irq2, twl);
+	regulator_put(twl->usb3v3);
+	pdata->phy_exit(twl->dev);
+	device_remove_file(twl->dev, &dev_attr_vbus);
+	kfree(twl);
+
+	return 0;
+}
+
+static struct platform_driver twl6030_usb_driver = {
+	.probe		= twl6030_usb_probe,
+	.remove		= __exit_p(twl6030_usb_remove),
+	.driver		= {
+		.name	= "twl6030_usb",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init twl6030_usb_init(void)
+{
+	return platform_driver_register(&twl6030_usb_driver);
+}
+subsys_initcall(twl6030_usb_init);
+
+static void __exit twl6030_usb_exit(void)
+{
+	platform_driver_unregister(&twl6030_usb_driver);
+}
+module_exit(twl6030_usb_exit);
+
+MODULE_ALIAS("platform:twl6030_usb");
+MODULE_AUTHOR("Hema HK <hemahk@ti.com>");
+MODULE_DESCRIPTION("TWL6030 USB transceiver driver");
+MODULE_LICENSE("GPL");
Index: usb/drivers/usb/otg/Makefile
===================================================================
--- usb.orig/drivers/usb/otg/Makefile
+++ usb/drivers/usb/otg/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_USB_OTG_UTILS)	+= otg.o
 obj-$(CONFIG_USB_GPIO_VBUS)	+= gpio_vbus.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
+obj-$(CONFIG_TWL6030_USB)	+= twl6030-usb.o
 obj-$(CONFIG_USB_LANGWELL_OTG)	+= langwell_otg.o
 obj-$(CONFIG_NOP_USB_XCEIV)	+= nop-usb-xceiv.o
 obj-$(CONFIG_USB_ULPI)		+= ulpi.o
