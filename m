From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 4/4] USB: OMAP: Tahvo USB transceiver driver
Date: Thu,  7 Mar 2013 16:40:21 +0200
Message-ID: <1362667221-30659-5-git-send-email-aaro.koskinen@iki.fi>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:45779 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932408Ab3CGOkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 09:40:47 -0500
In-Reply-To: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

Add Tahvo USB transceiver driver.

Based on old code from linux-omap tree. The original driver was written
by Juha Yrj=C3=B6l=C3=A4, Tony Lindgren, and Timo Ter=C3=A4s.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/otg/Kconfig     |   16 ++
 drivers/usb/otg/Makefile    |    1 +
 drivers/usb/otg/tahvo-usb.c |  643 +++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 660 insertions(+)
 create mode 100644 drivers/usb/otg/tahvo-usb.c

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 12af870..86b5ebe 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -61,6 +61,22 @@ config USB_ULPI_VIEWPORT
 	  Provides read/write operations to the ULPI phy register set for
 	  controllers with a viewport register (e.g. Chipidea/ARC controllers=
).
=20
+config TAHVO_USB
+	tristate "Tahvo USB transceiver driver"
+	depends on MFD_RETU && ARCH_OMAP_OTG
+	select OMAP_OTG
+	select USB_OTG_UTILS
+	help
+	  Enable this to support USB transceiver on Tahvo. This is used
+	  at least on Nokia 770.
+
+config TAHVO_USB_HOST_BY_DEFAULT
+	depends on TAHVO_USB && USB_OTG
+	boolean "Device in USB host mode by default"
+	---help---
+	  Say Y here, if you want the device to enter USB host mode
+	  by default on bootup.
+
 config TWL4030_USB
 	tristate "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index 4e05c6a..31e28ef 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_USB_OTG_UTILS)	+=3D otg.o
 obj-$(CONFIG_USB_GPIO_VBUS)	+=3D gpio_vbus.o
 obj-$(CONFIG_OMAP_OTG)		+=3D omap-otg.o
 obj-$(CONFIG_ISP1301_OMAP)	+=3D isp1301_omap.o
+obj-$(CONFIG_TAHVO_USB)		+=3D tahvo-usb.o
 obj-$(CONFIG_TWL4030_USB)	+=3D twl4030-usb.o
 obj-$(CONFIG_TWL6030_USB)	+=3D twl6030-usb.o
 obj-$(CONFIG_NOP_USB_XCEIV)	+=3D nop-usb-xceiv.o
diff --git a/drivers/usb/otg/tahvo-usb.c b/drivers/usb/otg/tahvo-usb.c
new file mode 100644
index 0000000..3286457
--- /dev/null
+++ b/drivers/usb/otg/tahvo-usb.c
@@ -0,0 +1,643 @@
+/*
+ * Tahvo USB transceiver driver
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ *
+ * Parts copied from drivers/i2c/chips/isp1301_omap.c
+ * Copyright (C) 2004 Texas Instruments
+ * Copyright (C) 2004 David Brownell
+ *
+ * Original driver written by Juha Yrj=C3=B6l=C3=A4, Tony Lindgren and=
 Timo Ter=C3=A4s.
+ * Modified for Retu/Tahvo MFD by Aaro Koskinen.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of thi=
s
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/usb.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb/otg.h>
+#include <linux/mfd/retu.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/omap-otg.h>
+#include <linux/platform_device.h>
+
+#include <mach/usb.h>
+
+#define DRIVER_NAME     "tahvo-usb"
+
+#define TAHVO_REG_IDSR	0x02
+#define TAHVO_REG_USBR	0x06
+
+#define USBR_SLAVE_CONTROL	(1 << 8)
+#define USBR_VPPVIO_SW		(1 << 7)
+#define USBR_SPEED		(1 << 6)
+#define USBR_REGOUT		(1 << 5)
+#define USBR_MASTER_SW2		(1 << 4)
+#define USBR_MASTER_SW1		(1 << 3)
+#define USBR_SLAVE_SW		(1 << 2)
+#define USBR_NSUSPEND		(1 << 1)
+#define USBR_SEMODE		(1 << 0)
+
+#define TAHVO_MODE_HOST		0
+#define TAHVO_MODE_PERIPHERAL	1
+
+#ifdef CONFIG_USB_OTG
+#define TAHVO_MODE(tu)		((tu)->tahvo_mode)
+#elif IS_ENABLED(CONFIG_USB_OMAP)
+#define TAHVO_MODE(tu)		TAHVO_MODE_PERIPHERAL
+#else
+#define TAHVO_MODE(tu)		TAHVO_MODE_HOST
+#endif
+
+struct tahvo_usb {
+	struct platform_device	*pt_dev;
+	struct usb_phy		phy;
+	int			vbus_state;
+	struct mutex		serialize;
+	struct clk		*ick;
+	int			irq;
+#ifdef CONFIG_USB_OTG
+	int			tahvo_mode;
+#endif
+};
+
+/*
+ * -------------------------------------------------------------------=
--------
+ * OTG related functions
+ *
+ * These should be separated into omap-otg.c driver module, as they ar=
e used
+ * by various transceivers. These functions are needed in the UDC-only=
 case
+ * as well. These functions are copied from GPL isp1301_omap.c
+ * -------------------------------------------------------------------=
--------
+ */
+static irqreturn_t omap_otg_irq(int irq, void *arg)
+{
+	struct tahvo_usb *tu =3D arg;
+	struct usb_otg *otg =3D tu->phy.otg;
+	u16 otg_irq;
+
+	otg_irq =3D omap_readw(OTG_IRQ_SRC);
+	if (otg_irq & OPRT_CHG) {
+		omap_writew(OPRT_CHG, OTG_IRQ_SRC);
+	} else if (otg_irq & B_SRP_TMROUT) {
+		omap_writew(B_SRP_TMROUT, OTG_IRQ_SRC);
+	} else if (otg_irq & B_HNP_FAIL) {
+		omap_writew(B_HNP_FAIL, OTG_IRQ_SRC);
+	} else if (otg_irq & A_SRP_DETECT) {
+		omap_writew(A_SRP_DETECT, OTG_IRQ_SRC);
+	} else if (otg_irq & A_REQ_TMROUT) {
+		omap_writew(A_REQ_TMROUT, OTG_IRQ_SRC);
+	} else if (otg_irq & A_VBUS_ERR) {
+		omap_writew(A_VBUS_ERR, OTG_IRQ_SRC);
+	} else if (otg_irq & DRIVER_SWITCH) {
+#ifdef CONFIG_USB_OTG
+		if ((!(omap_readl(OTG_CTRL) & OTG_DRIVER_SEL)) &&
+		    otg->host && tu->phy.state =3D=3D OTG_STATE_A_HOST) {
+			/* role is host */
+			usb_bus_start_enum(otg->host, otg->host->otg_port);
+		}
+#endif
+		omap_writew(DRIVER_SWITCH, OTG_IRQ_SRC);
+	} else
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static int tahvo_otg_init(void)
+{
+	u32 l;
+
+	l =3D omap_readl(OTG_SYSCON_1);
+	l &=3D ~OTG_IDLE_EN;
+	omap_writel(l, OTG_SYSCON_1);
+	udelay(100);
+
+	/* some of these values are board-specific... */
+	l =3D omap_readl(OTG_SYSCON_2);
+	l |=3D OTG_EN
+		/* for B-device: */
+		| SRP_GPDATA		/* 9msec Bdev D+ pulse */
+		| SRP_GPDVBUS		/* discharge after VBUS pulse */
+		/* for A-device: */
+		| (0 << 20)		/* 200ms nominal A_WAIT_VRISE timer */
+		| SRP_DPW		/* detect 167+ns SRP pulses */
+		| SRP_DATA | SRP_VBUS;	/* accept both kinds of SRP pulse */
+	omap_writel(l, OTG_SYSCON_2);
+
+	omap_writew(DRIVER_SWITCH | OPRT_CHG | B_SRP_TMROUT | B_HNP_FAIL |
+		    A_VBUS_ERR | A_SRP_DETECT | A_REQ_TMROUT, OTG_IRQ_EN);
+	l =3D omap_readl(OTG_SYSCON_2);
+	l |=3D OTG_EN;
+	omap_writel(l, OTG_SYSCON_2);
+
+	return 0;
+}
+
+/*
+ * -------------------------------------------------------------------=
--------
+ * Tahvo related functions
+ *
+ * These are Nokia proprietary code, except for the OTG register setti=
ngs,
+ * which are copied from isp1301.c
+ * -------------------------------------------------------------------=
--------
+ */
+static ssize_t vbus_state_show(struct device *device,
+			       struct device_attribute *attr, char *buf)
+{
+	struct tahvo_usb *tu =3D dev_get_drvdata(device);
+	return sprintf(buf, "%d\n", tu->vbus_state);
+}
+static DEVICE_ATTR(vbus_state, 0444, vbus_state_show, NULL);
+
+static void check_vbus_state(struct tahvo_usb *tu)
+{
+	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
+	int reg, prev_state;
+
+	reg =3D retu_read(rdev, TAHVO_REG_IDSR);
+	if (reg & TAHVO_STAT_VBUS) {
+		u32 l;
+
+		switch (tu->phy.state) {
+		case OTG_STATE_B_IDLE:
+			/* Enable the gadget driver */
+			if (tu->phy.otg->gadget)
+				usb_gadget_vbus_connect(tu->phy.otg->gadget);
+			/*
+			 * Set B-session valid and not B-session ended to
+			 * indicate Vbus to be ok.
+			 */
+			l =3D omap_readl(OTG_CTRL);
+			l &=3D ~OTG_BSESSEND;
+			l |=3D OTG_BSESSVLD;
+			omap_writel(l, OTG_CTRL);
+
+			tu->phy.state =3D OTG_STATE_B_PERIPHERAL;
+			break;
+		case OTG_STATE_A_IDLE:
+			/*
+			 * Session is now valid assuming the USB hub is driving
+			 * Vbus.
+			 */
+			tu->phy.state =3D OTG_STATE_A_HOST;
+			break;
+		default:
+			break;
+		}
+		dev_info(&tu->pt_dev->dev, "USB cable connected\n");
+	} else {
+		switch (tu->phy.state) {
+		case OTG_STATE_B_PERIPHERAL:
+			if (tu->phy.otg->gadget)
+				usb_gadget_vbus_disconnect(tu->phy.otg->gadget);
+			tu->phy.state =3D OTG_STATE_B_IDLE;
+			break;
+		case OTG_STATE_A_HOST:
+			tu->phy.state =3D OTG_STATE_A_IDLE;
+			break;
+		default:
+			break;
+		}
+		dev_info(&tu->pt_dev->dev, "USB cable disconnected\n");
+	}
+
+	prev_state =3D tu->vbus_state;
+	tu->vbus_state =3D reg & TAHVO_STAT_VBUS;
+	if (prev_state !=3D tu->vbus_state)
+		sysfs_notify(&tu->pt_dev->dev.kobj, NULL, "vbus_state");
+}
+
+static void tahvo_usb_become_host(struct tahvo_usb *tu)
+{
+	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
+	u32 l;
+
+	/*
+	 * Clear system and transceiver controlled bits also mark the A-sessi=
on
+	 * is always valid.
+	 */
+	tahvo_otg_init();
+
+	l =3D omap_readl(OTG_CTRL);
+	l &=3D ~(OTG_XCEIV_OUTPUTS | OTG_CTRL_BITS);
+	l |=3D OTG_ASESSVLD;
+	omap_writel(l, OTG_CTRL);
+
+	/* Power up the transceiver in USB host mode */
+	retu_write(rdev, TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
+		   USBR_MASTER_SW2 | USBR_MASTER_SW1);
+	tu->phy.state =3D OTG_STATE_A_IDLE;
+
+	check_vbus_state(tu);
+}
+
+static void tahvo_usb_stop_host(struct tahvo_usb *tu)
+{
+	tu->phy.state =3D OTG_STATE_A_IDLE;
+}
+
+static void tahvo_usb_become_peripheral(struct tahvo_usb *tu)
+{
+	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
+	u32 l;
+
+	/*
+	 * Clear system and transceiver controlled bits and enable ID to mark
+	 * peripheral mode and BSESSEND to mark no Vbus.
+	 */
+	tahvo_otg_init();
+	l =3D omap_readl(OTG_CTRL);
+	l &=3D ~(OTG_XCEIV_OUTPUTS | OTG_CTRL_BITS | OTG_BSESSVLD);
+	l |=3D OTG_ID | OTG_BSESSEND;
+	omap_writel(l, OTG_CTRL);
+
+	/* Power up transceiver and set it in USB peripheral mode */
+	retu_write(rdev, TAHVO_REG_USBR, USBR_SLAVE_CONTROL | USBR_REGOUT |
+		   USBR_NSUSPEND | USBR_SLAVE_SW);
+	tu->phy.state =3D OTG_STATE_B_IDLE;
+
+	check_vbus_state(tu);
+}
+
+static void tahvo_usb_stop_peripheral(struct tahvo_usb *tu)
+{
+	u32 l;
+
+	l =3D omap_readl(OTG_CTRL);
+	l &=3D ~OTG_BSESSVLD;
+	l |=3D OTG_BSESSEND;
+	omap_writel(l, OTG_CTRL);
+
+	if (tu->phy.otg->gadget)
+		usb_gadget_vbus_disconnect(tu->phy.otg->gadget);
+	tu->phy.state =3D OTG_STATE_B_IDLE;
+}
+
+static void tahvo_usb_power_off(struct tahvo_usb *tu)
+{
+	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
+	u32 l;
+	int id;
+
+	/* Disable gadget controller if any */
+	if (tu->phy.otg->gadget)
+		usb_gadget_vbus_disconnect(tu->phy.otg->gadget);
+
+	/* Disable OTG and interrupts */
+	if (TAHVO_MODE(tu) =3D=3D TAHVO_MODE_PERIPHERAL)
+		id =3D OTG_ID;
+	else
+		id =3D 0;
+	l =3D omap_readl(OTG_CTRL);
+	l &=3D ~(OTG_XCEIV_OUTPUTS | OTG_CTRL_BITS | OTG_BSESSVLD);
+	l |=3D id | OTG_BSESSEND;
+	omap_writel(l, OTG_CTRL);
+	omap_writew(0, OTG_IRQ_EN);
+
+	l =3D omap_readl(OTG_SYSCON_2);
+	l &=3D ~OTG_EN;
+	omap_writel(l, OTG_SYSCON_2);
+
+	l =3D omap_readl(OTG_SYSCON_1);
+	l |=3D OTG_IDLE_EN;
+	omap_writel(l, OTG_SYSCON_1);
+
+	/* Power off transceiver */
+	retu_write(rdev, TAHVO_REG_USBR, 0);
+	tu->phy.state =3D OTG_STATE_UNDEFINED;
+}
+
+static int tahvo_usb_set_power(struct usb_phy *dev, unsigned mA)
+{
+	struct tahvo_usb *tu =3D container_of(dev, struct tahvo_usb, phy);
+
+	dev_dbg(&tu->pt_dev->dev, "%s %d mA\n", __func__, mA);
+
+	/* REVISIT: Can Tahvo charge battery from VBUS? */
+
+	return 0;
+}
+
+static int tahvo_usb_set_suspend(struct usb_phy *dev, int suspend)
+{
+	struct tahvo_usb *tu =3D container_of(dev, struct tahvo_usb, phy);
+	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
+	u16 w;
+
+	dev_dbg(&tu->pt_dev->dev, "%s\n", __func__);
+
+	w =3D retu_read(rdev, TAHVO_REG_USBR);
+	if (suspend)
+		w &=3D ~USBR_NSUSPEND;
+	else
+		w |=3D USBR_NSUSPEND;
+	retu_write(rdev, TAHVO_REG_USBR, w);
+
+	return 0;
+}
+
+static int tahvo_usb_start_srp(struct usb_otg *otg)
+{
+	struct tahvo_usb *tu =3D container_of(otg->phy, struct tahvo_usb, phy=
);
+	u32 otg_ctrl;
+
+	dev_dbg(&tu->pt_dev->dev, "%s\n", __func__);
+
+	if (!otg || tu->phy.state !=3D OTG_STATE_B_IDLE)
+		return -ENODEV;
+
+	otg_ctrl =3D omap_readl(OTG_CTRL);
+	if (!(otg_ctrl & OTG_BSESSEND))
+		return -EINVAL;
+
+	otg_ctrl |=3D OTG_B_BUSREQ;
+	otg_ctrl &=3D ~OTG_A_BUSREQ & OTG_CTRL_BITS;
+	omap_writel(otg_ctrl, OTG_CTRL);
+	tu->phy.state =3D OTG_STATE_B_SRP_INIT;
+
+	return 0;
+}
+
+static int tahvo_usb_start_hnp(struct usb_otg *otg)
+{
+	struct tahvo_usb *tu =3D container_of(otg->phy, struct tahvo_usb, phy=
);
+
+	dev_dbg(&tu->pt_dev->dev, "%s\n", __func__);
+
+	return -EINVAL;
+}
+
+static int tahvo_usb_set_host(struct usb_otg *otg, struct usb_bus *hos=
t)
+{
+	struct tahvo_usb *tu =3D container_of(otg->phy, struct tahvo_usb, phy=
);
+	u32 l;
+
+	dev_dbg(&tu->pt_dev->dev, "%s %p\n", __func__, host);
+
+	if (otg =3D=3D NULL)
+		return -ENODEV;
+
+#if defined(CONFIG_USB_OTG) || !IS_ENABLED(CONFIG_USB_OMAP)
+
+	mutex_lock(&tu->serialize);
+
+	if (host =3D=3D NULL) {
+		if (TAHVO_MODE(tu) =3D=3D TAHVO_MODE_HOST)
+			tahvo_usb_power_off(tu);
+		otg->host =3D NULL;
+		mutex_unlock(&tu->serialize);
+		return 0;
+	}
+
+	l =3D omap_readl(OTG_SYSCON_1);
+	l &=3D ~(OTG_IDLE_EN | HST_IDLE_EN | DEV_IDLE_EN);
+	omap_writel(l, OTG_SYSCON_1);
+
+	if (TAHVO_MODE(tu) =3D=3D TAHVO_MODE_HOST) {
+		otg->host =3D NULL;
+		tahvo_usb_become_host(tu);
+	}
+
+	otg->host =3D host;
+
+	mutex_unlock(&tu->serialize);
+
+	return 0;
+#else
+	/* No host mode configured, so do not allow host controlled to be set=
 */
+	return -EINVAL;
+#endif
+}
+
+static int tahvo_usb_set_peripheral(struct usb_otg *otg,
+				    struct usb_gadget *gadget)
+{
+	struct tahvo_usb *tu =3D container_of(otg->phy, struct tahvo_usb, phy=
);
+
+	dev_dbg(&tu->pt_dev->dev, "%s %p\n", __func__, gadget);
+
+	if (!otg)
+		return -ENODEV;
+
+#if defined(CONFIG_USB_OTG) || IS_ENABLED(CONFIG_USB_OMAP)
+
+	mutex_lock(&tu->serialize);
+
+	if (!gadget) {
+		if (TAHVO_MODE(tu) =3D=3D TAHVO_MODE_PERIPHERAL)
+			tahvo_usb_power_off(tu);
+		tu->phy.otg->gadget =3D NULL;
+		mutex_unlock(&tu->serialize);
+		return 0;
+	}
+
+	tu->phy.otg->gadget =3D gadget;
+	if (TAHVO_MODE(tu) =3D=3D TAHVO_MODE_PERIPHERAL)
+		tahvo_usb_become_peripheral(tu);
+
+	mutex_unlock(&tu->serialize);
+
+	return 0;
+#else
+	/* No gadget mode configured, so do not allow gadget driver to be set=
 */
+	return -EINVAL;
+#endif
+}
+
+static irqreturn_t tahvo_usb_vbus_interrupt(int irq, void *_tu)
+{
+	struct tahvo_usb *tu =3D _tu;
+
+	check_vbus_state(tu);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_USB_OTG
+static ssize_t otg_mode_show(struct device *device,
+			     struct device_attribute *attr, char *buf)
+{
+	struct tahvo_usb *tu =3D dev_get_drvdata(device);
+
+	switch (tu->tahvo_mode) {
+	case TAHVO_MODE_HOST:
+		return sprintf(buf, "host\n");
+	case TAHVO_MODE_PERIPHERAL:
+		return sprintf(buf, "peripheral\n");
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t otg_mode_store(struct device *device,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct tahvo_usb *tu =3D dev_get_drvdata(device);
+	int r;
+
+	mutex_lock(&tu->serialize);
+	if (count >=3D 4 && strncmp(buf, "host", 4) =3D=3D 0) {
+		if (tu->tahvo_mode =3D=3D TAHVO_MODE_PERIPHERAL)
+			tahvo_usb_stop_peripheral(tu);
+		tu->tahvo_mode =3D TAHVO_MODE_HOST;
+		if (tu->phy.otg->host) {
+			dev_info(device, "HOST mode: host controller present\n");
+			tahvo_usb_become_host(tu);
+		} else {
+			dev_info(device, "HOST mode: no host controller, powering off\n");
+			tahvo_usb_power_off(tu);
+		}
+		r =3D strlen(buf);
+	} else if (count >=3D 10 && strncmp(buf, "peripheral", 10) =3D=3D 0) =
{
+		if (tu->tahvo_mode =3D=3D TAHVO_MODE_HOST)
+			tahvo_usb_stop_host(tu);
+		tu->tahvo_mode =3D TAHVO_MODE_PERIPHERAL;
+		if (tu->phy.otg->gadget) {
+			dev_info(device, "PERIPHERAL mode: gadget driver present\n");
+			tahvo_usb_become_peripheral(tu);
+		} else {
+			dev_info(device, "PERIPHERAL mode: no gadget driver, powering off\n=
");
+			tahvo_usb_power_off(tu);
+		}
+		r =3D strlen(buf);
+	} else {
+		r =3D -EINVAL;
+	}
+	mutex_unlock(&tu->serialize);
+
+	return r;
+}
+
+static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
+#endif
+
+static int tahvo_usb_probe(struct platform_device *pdev)
+{
+	struct retu_dev *rdev =3D dev_get_drvdata(pdev->dev.parent);
+	struct tahvo_usb *tu;
+	int ret;
+
+	tu =3D devm_kzalloc(&pdev->dev, sizeof(*tu), GFP_KERNEL);
+	if (!tu)
+		return -ENOMEM;
+
+	tu->phy.otg =3D devm_kzalloc(&pdev->dev, sizeof(*tu->phy.otg),
+				   GFP_KERNEL);
+	if (!tu->phy.otg)
+		return -ENOMEM;
+
+	tu->pt_dev =3D pdev;
+#ifdef CONFIG_USB_OTG
+	/* Default mode */
+#ifdef CONFIG_TAHVO_USB_HOST_BY_DEFAULT
+	tu->tahvo_mode =3D TAHVO_MODE_HOST;
+#else
+	tu->tahvo_mode =3D TAHVO_MODE_PERIPHERAL;
+#endif
+#endif
+
+	mutex_init(&tu->serialize);
+
+	tu->ick =3D devm_clk_get(&pdev->dev, "usb_l4_ick");
+	if (!IS_ERR(tu->ick))
+		clk_enable(tu->ick);
+
+	/*
+	 * Set initial state, so that we generate kevents only on state chang=
es.
+	 */
+	tu->vbus_state =3D retu_read(rdev, TAHVO_REG_IDSR) & TAHVO_STAT_VBUS;
+
+	tu->irq =3D platform_get_irq(pdev, 0);
+	ret =3D request_threaded_irq(tu->irq, NULL, tahvo_usb_vbus_interrupt,=
 0,
+				   "tahvo-vbus", tu);
+	if (ret) {
+		dev_err(&pdev->dev, "could not register tahvo-vbus irq: %d\n",
+			ret);
+		goto err_disable_clk;
+	}
+
+	/* Attributes */
+	ret =3D device_create_file(&pdev->dev, &dev_attr_vbus_state);
+#ifdef CONFIG_USB_OTG
+	ret |=3D device_create_file(&pdev->dev, &dev_attr_otg_mode);
+#endif
+	if (ret)
+		dev_err(&pdev->dev, "attribute creation failed: %d\n", ret);
+
+	/* Create OTG interface */
+	tahvo_usb_power_off(tu);
+	tu->phy.state =3D OTG_STATE_UNDEFINED;
+	tu->phy.label =3D DRIVER_NAME;
+	tu->phy.set_power =3D tahvo_usb_set_power;
+	tu->phy.set_suspend =3D tahvo_usb_set_suspend;
+
+	tu->phy.otg->phy =3D &tu->phy;
+	tu->phy.otg->set_host =3D tahvo_usb_set_host;
+	tu->phy.otg->set_peripheral =3D tahvo_usb_set_peripheral;
+	tu->phy.otg->start_srp =3D tahvo_usb_start_srp;
+	tu->phy.otg->start_hnp =3D tahvo_usb_start_hnp;
+
+	ret =3D usb_add_phy(&tu->phy, USB_PHY_TYPE_USB2);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot register USB transceiver: %d\n",
+			ret);
+		goto err_free_irq;
+	}
+
+	dev_set_drvdata(&pdev->dev, tu);
+
+	omap_otg_bind(tu, omap_otg_irq);
+
+	return 0;
+
+err_free_irq:
+	free_irq(tu->irq, tu);
+err_disable_clk:
+	if (!IS_ERR(tu->ick))
+		clk_disable(tu->ick);
+
+	return ret;
+}
+
+static int tahvo_usb_remove(struct platform_device *pdev)
+{
+	struct tahvo_usb *tu =3D platform_get_drvdata(pdev);
+
+	omap_otg_unbind(tu);
+	free_irq(tu->irq, tu);
+	usb_remove_phy(&tu->phy);
+	device_remove_file(&pdev->dev, &dev_attr_vbus_state);
+#ifdef CONFIG_USB_OTG
+	device_remove_file(&pdev->dev, &dev_attr_otg_mode);
+#endif
+	if (!IS_ERR(tu->ick))
+		clk_disable(tu->ick);
+
+	return 0;
+}
+
+static struct platform_driver tahvo_usb_driver =3D {
+	.probe		=3D tahvo_usb_probe,
+	.remove		=3D tahvo_usb_remove,
+	.driver		=3D {
+		.name	=3D "tahvo-usb",
+	},
+};
+module_platform_driver(tahvo_usb_driver);
+
+MODULE_DESCRIPTION("Tahvo USB transceiver driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Juha Yrj=C3=B6l=C3=A4, Tony Lindgren, and Timo Ter=C3=A4=
s");
+MODULE_AUTHOR("Aaro Koskinen <aaro.koskinen@iki.fi>");
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
