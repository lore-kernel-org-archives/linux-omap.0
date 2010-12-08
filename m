From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/7] usb: otg: Adding twl6030-usb transceiver driver for
Date: Wed, 8 Dec 2010 11:50:53 +0200
Message-ID: <20101208095053.GF2891@legolas.emea.dhcp.ti.com>
References: <1291824075-7060-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45356 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753892Ab0LHJvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 04:51:00 -0500
Content-Disposition: inline
In-Reply-To: <1291824075-7060-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>

On Wed, Dec 08, 2010 at 09:31:15PM +0530, Hema HK wrote:
>Adding the twl6030-usb transceiver support for OMAP4 musb driver.
>
>OMAP4 supports 2 types of transceiver interface.
>
>1. UTMI: The PHY is embedded within OMAP4. The transceiver functionality
>is split between the twl6030 PMIC chip and OMAP4430. The VBUS, ID pin
>sensing and OTG SRP generation part is integrated in TWL6030 and UTMI PHY
>functionality is embedded within the OMAP4430.
>
>There is no direct interactions between the MUSB controller and TWL6030
>chip to communicate the session-valid, session-end and ID-GND events.
>It has to be done through a software by setting/resetting bits in
>one of the control module register of OMAP4430 which in turn toggles
>the appropriate signals to MUSB controller.
>
>The internal transceiver has functional clocks and
>powerdown bits to powerdown the PHY for power saving.
>
>Since there is no option available for having 2 transceiver drivers
>for one USB controller, internal PHY specific APIs are passed through
>plaform_data function pointers to use in the twl6030-usb transceiver
>driver.
>
>2. ULPI interface is provided for off-chip transceivers.
>
>Signed-off-by: Hema HK <hemahk@ti.com>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: David Brownell <dbrownell@users.sourceforge.net>
>---
> arch/arm/mach-omap2/omap_phy_internal.c |  133 ++++++++
> arch/arm/plat-omap/include/plat/usb.h   |    4
> drivers/usb/otg/Makefile                |    1
> drivers/usb/otg/twl6030-usb.c           |  514 ++++++++++++++++++++++++++++++++
> 4 files changed, 652 insertions(+)
>
>Index: linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
>===================================================================
>--- /dev/null
>+++ linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
>@@ -0,0 +1,148 @@
>+/*
>+  * This file configures the internal USB PHY in OMAP4430. Used
>+  * with TWL6030 transceiver and MUSB on OMAP4430.
>+  *
>+  * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com
>+  * This program is free software; you can redistribute it and/or modify
>+  * it under the terms of the GNU General Public License as published by
>+  * the Free Software Foundation; either version 2 of the License, or
>+  * (at your option) any later version.
>+  *
>+  *Author: Hema HK <hemahk@ti.com>
     ^^ you need a space after *

>+  * This program is distributed in the hope that it will be useful,
>+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+  * GNU General Public License for more details.
>+  *
>+  * You should have received a copy of the GNU General Public License
>+  * along with this program; if not, write to the Free Software
>+  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>+  *
>+  */
>+
>+#include <linux/types.h>
>+#include <linux/errno.h>
>+#include <linux/delay.h>
>+#include <linux/clk.h>
>+#include <linux/io.h>
>+#include <linux/err.h>
>+#include <linux/usb.h>
>+
>+#include <plat/usb.h>
>+
>+/* OMAP control module register for UTMI PHY */
>+#define CONTROL_DEV_CONF		0x300
>+#define PHY_PD				0x1
>+
>+#define USBOTGHS_CONTROL		0x33c
>+#define	AVALID				BIT(0)
>+#define	BVALID				BIT(1)
>+#define	VBUSVALID			BIT(2)
>+#define	SESSEND				BIT(3)
>+#define	IDDIG				BIT(4)
>+
>+static struct clk *phyclk, *clk48m, *clk32k;
>+static void __iomem *ctrl_base;
>+
>+int omap4430_phy_init(struct device *dev)
>+{
>+	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>+	if (!ctrl_base) {
>+		dev_err(dev, "control module ioremap failed\n");
>+		return -ENOMEM;
>+	}
>+	/* Power down the phy */
>+	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>+	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
>+
>+	if (IS_ERR(phyclk)) {
>+		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
>+		iounmap(ctrl_base);
>+		return PTR_ERR(phyclk);
>+	}
>+
>+	clk48m = clk_get(dev, "ocp2scp_usb_phy_phy_48m");
>+	if (IS_ERR(clk48m)) {
>+		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_phy_48m\n");
>+		clk_put(phyclk);
>+		iounmap(ctrl_base);
>+		return PTR_ERR(clk48m);
>+	}
>+
>+	clk32k = clk_get(dev, "usb_phy_cm_clk32k");
>+	if (IS_ERR(clk32k)) {
>+		dev_err(dev, "cannot clk_get usb_phy_cm_clk32k\n");
>+		clk_put(phyclk);
>+		clk_put(clk48m);
>+		iounmap(ctrl_base);
>+		return PTR_ERR(clk32k);
>+	}
>+	return 0;
>+}
>+
>+int omap4430_phy_set_clk(struct device *dev, int on)
>+{
>+	static int state;
>+
>+	if (on && !state) {
>+		/* Enable the phy clocks */
>+		clk_enable(phyclk);
>+		clk_enable(clk48m);
>+		clk_enable(clk32k);
>+		state = 1;
>+	} else if (state) {
>+		/* Disable the phy clocks */
>+		clk_disable(phyclk);
>+		clk_disable(clk48m);
>+		clk_disable(clk32k);
>+		state = 0;
>+	}
>+	return 0;
>+}
>+
>+int omap4430_phy_power(struct device *dev, int ID, int on)
>+{
>+	if (on) {
>+		/* enabled the clocks */
>+		omap4430_phy_set_clk(dev, 1);
>+		/* power on the phy */
>+		if (__raw_readl(ctrl_base + CONTROL_DEV_CONF) & PHY_PD) {
>+			__raw_writel(~PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>+			mdelay(200);
>+		}
>+		if (ID)
>+			/* enable VBUS valid, IDDIG groung */
>+			__raw_writel(AVALID | VBUSVALID, ctrl_base +
>+							USBOTGHS_CONTROL);
>+		else
>+			/*
>+			 * Enable VBUS Valid, AValid and IDDIG
>+			 * high impedence
>+			 */
>+			__raw_writel(IDDIG | AVALID | VBUSVALID,
>+						ctrl_base + USBOTGHS_CONTROL);
>+	} else {
>+		/* Enable session END and IDIG to high impedence. */
>+		__raw_writel(SESSEND | IDDIG, ctrl_base +
>+					USBOTGHS_CONTROL);
>+		/* Disable the clocks */
>+		omap4430_phy_set_clk(dev, 0);
>+		/* Power down the phy */
>+		__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>+	}
>+
>+	return 0;
>+}
>+
>+int omap4430_phy_exit(struct device *dev)
>+{
>+	if (ctrl_base)
>+		iounmap(ctrl_base);
>+	if (phyclk)
>+		clk_put(phyclk);
>+	if (clk48m)
>+		clk_put(clk48m);
>+	if (clk32k)
>+		clk_put(clk32k);
>+
>+	return 0;
>+}
>+
>+

two blank lines at the end of file. I like to use one, but people say it
should be none :-p

Anyway, can this be converted into a platform driver ? Then you could
power it on/off with pm_runtime ?!? You wouldn't need to export
functions either.

It could be that's not possible, but doesn't hurt asking.

>Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
>===================================================================
>--- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
>+++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
>@@ -79,6 +79,12 @@ extern void usb_ehci_init(const struct e
>
> extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
>
>+extern int omap4430_phy_power(struct device *dev, int ID, int on);
>+extern int omap4430_phy_set_clk(struct device *dev, int on);
>+extern int omap4430_phy_init(struct device *dev);
>+extern int omap4430_phy_exit(struct device *dev);
>+
>+

one blank line only.

>Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
>===================================================================
>--- /dev/null
>+++ linux-2.6/drivers/usb/otg/twl6030-usb.c
>@@ -0,0 +1,520 @@
>+/*
>+ * twl6030_usb - TWL6030 USB transceiver, talking to OMAP OTG driver.
>+ *
>+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License as published by
>+ * the Free Software Foundation; either version 2 of the License, or
>+ * (at your option) any later version.
>+ *
>+ *Author: Hema HK <hemahk@ti.com>
    ^^ space

>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>+ *
>+ *
>+ */
>+
>+#include <linux/module.h>
>+#include <linux/init.h>
>+#include <linux/interrupt.h>
>+#include <linux/platform_device.h>
>+#include <linux/io.h>
>+#include <linux/usb/otg.h>
>+#include <linux/i2c/twl.h>
>+#include <linux/regulator/consumer.h>
>+#include <linux/err.h>
>+#include <linux/notifier.h>
>+#include <linux/slab.h>
>+
>+/* usb register definitions */
>+#define USB_VENDOR_ID_LSB		0x00
>+#define USB_VENDOR_ID_MSB		0x01
>+#define USB_PRODUCT_ID_LSB		0x02
>+#define USB_PRODUCT_ID_MSB		0x03
>+#define USB_VBUS_CTRL_SET		0x04
>+#define USB_VBUS_CTRL_CLR		0x05
>+#define USB_ID_CTRL_SET			0x06
>+#define USB_ID_CTRL_CLR			0x07
>+#define USB_VBUS_INT_SRC		0x08
>+#define USB_VBUS_INT_LATCH_SET		0x09
>+#define USB_VBUS_INT_LATCH_CLR		0x0A
>+#define USB_VBUS_INT_EN_LO_SET		0x0B
>+#define USB_VBUS_INT_EN_LO_CLR		0x0C
>+#define USB_VBUS_INT_EN_HI_SET		0x0D
>+#define USB_VBUS_INT_EN_HI_CLR		0x0E
>+#define USB_ID_INT_SRC			0x0F
>+#define USB_ID_INT_LATCH_SET		0x10
>+#define USB_ID_INT_LATCH_CLR		0x11
>+
>+
>+#define USB_ID_INT_EN_LO_SET		0x12
>+#define USB_ID_INT_EN_LO_CLR		0x13
>+#define USB_ID_INT_EN_HI_SET		0x14
>+#define USB_ID_INT_EN_HI_CLR		0x15

I wonder why HW people didn't follow ULPI spec here. What a mess...

>+#define USB_OTG_ADP_CTRL		0x16
>+#define USB_OTG_ADP_HIGH		0x17
>+#define USB_OTG_ADP_LOW			0x18
>+#define USB_OTG_ADP_RISE		0x19
>+#define USB_OTG_REVISION		0x1A

... then these would only be a set of extended registers.

>+/* to be moved to LDO */
>+#define MISC2				0xE5
>+#define CFG_LDO_PD2			0xF5

prepend with USB_

>+#define USB_BACKUP_REG			0xFA
>+
>+#define STS_HW_CONDITIONS		0x21
>+
>+/* In module TWL6030_MODULE_PM_MASTER */
>+#define PROTECT_KEY			0x0E

defined in <linux/i2c/twl.h>

>+#define STS_HW_CONDITIONS		0x21
>+#define STS_USB_ID			BIT(2)
>+
>+/* In module TWL6030_MODULE_PM_RECEIVER */
>+#define VUSB_DEDICATED1			0x7D
>+#define VUSB_DEDICATED2			0x7E
>+#define VUSB1V5_DEV_GRP			0x71
>+#define VUSB1V5_TYPE			0x72
>+#define VUSB1V5_REMAP			0x73
>+#define VUSB1V8_DEV_GRP			0x74
>+#define VUSB1V8_TYPE			0x75
>+#define VUSB1V8_REMAP			0x76
>+#define VUSB3V1_DEV_GRP			0x77
>+#define VUSB3V1_TYPE			0x78
>+#define VUSB3V1_REMAP			0x79
>+
>+/* In module TWL6030_MODULE_PM_RECEIVER */
>+#define VUSB_CFG_TRANS			0x71
>+#define VUSB_CFG_STATE			0x72
>+#define VUSB_CFG_VOLTAGE		0x73
>+
>+/* in module TWL6030_MODULE_MAIN_CHARGE */
>+
>+#define CHARGERUSB_CTRL1		0x8
>+
>+#define CONTROLLER_STAT1		0x03
>+#define	VBUS_DET			BIT(2)
>+
>+
>+/* OMAP control module register for UTMI PHY */
>+#define ONTROL_DEV_CONF			0x300

did you mean CONTROL ??

>+#define PHY_PD				0x1
>+
>+#define USBOTGHS_CONTROL		0x33c
>+#define	AVALID				BIT(0)
>+#define	BVALID				BIT(1)
>+#define	VBUSVALID			BIT(2)
>+#define	SESSEND				BIT(3)
>+#define	IDDIG				BIT(4)

these are likely to give namespace colision at some point, append with
USB_ or better change USB_ to TWL6030_USB_

>+static int __devinit twl6030_usb_probe(struct platform_device *pdev)
>+{
>+	struct twl6030_usb	*twl;
>+	int			status, err;
>+	struct twl4030_usb_data *pdata;
>+	struct device *dev = &pdev->dev;
>+	pdata = dev->platform_data;
>+
>+	twl = kzalloc(sizeof *twl, GFP_KERNEL);
>+	if (!twl)
>+		return -ENOMEM;
>+
>+	twl->dev		= &pdev->dev;
>+	twl->irq1		= platform_get_irq(pdev, 0);
>+	twl->irq2		= platform_get_irq(pdev, 1);
>+	twl->otg.dev		= twl->dev;
>+	twl->otg.label		= "twl6030";
>+	twl->otg.set_host	= twl6030_set_host;
>+	twl->otg.set_peripheral	= twl6030_set_peripheral;
>+	twl->asleep		= 1;

better to read this from HW and avoid problems if bootloaders wakes this
one up.

-- 
balbi
