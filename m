From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v4 4/4] USB: OMAP1: Tahvo USB transceiver driver
Date: Fri,  6 Dec 2013 16:13:07 +0200
Message-ID: <1386339187-28466-5-git-send-email-aaro.koskinen@iki.fi>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:43310 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267Ab3LFOQi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 09:16:38 -0500
In-Reply-To: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Add Tahvo USB transceiver driver.

Based on old code from linux-omap tree. The original driver was written
by Juha Yrj=C3=B6l=C3=A4, Tony Lindgren, and Timo Ter=C3=A4s.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 Documentation/ABI/testing/sysfs-platform-tahvo-usb |  16 +
 drivers/usb/phy/Kconfig                            |  15 +
 drivers/usb/phy/Makefile                           |   1 +
 drivers/usb/phy/phy-tahvo.c                        | 461 +++++++++++++=
++++++++
 4 files changed, 493 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-tahvo-usb
 create mode 100644 drivers/usb/phy/phy-tahvo.c

diff --git a/Documentation/ABI/testing/sysfs-platform-tahvo-usb b/Docum=
entation/ABI/testing/sysfs-platform-tahvo-usb
new file mode 100644
index 000000000000..f6e20ce4b538
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-tahvo-usb
@@ -0,0 +1,16 @@
+What:		/sys/bus/platform/devices/tahvo-usb/otg_mode
+Date:		December 2013
+Contact:	Aaro Koskinen <aaro.koskinen@iki.fi>
+Description:
+		Set or read the current OTG mode. Valid values are "host" and
+		"peripheral".
+
+		Reading: returns the current mode.
+
+What:		/sys/bus/platform/devices/tahvo-usb/vbus
+Date:		December 2013
+Contact:	Aaro Koskinen <aaro.koskinen@iki.fi>
+Description:
+		Read the current VBUS state.
+
+		Reading: returns "on" or "off".
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 95d0acc117cc..e0d11c227dd7 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -164,6 +164,21 @@ config OMAP_OTG
 	  This driver can also be built as a module. If so, the module
 	  will be called omap-otg.
=20
+config TAHVO_USB
+	tristate "Tahvo USB transceiver driver"
+	depends on MFD_RETU && EXTCON
+	select USB_PHY
+	help
+	  Enable this to support USB transceiver on Tahvo. This is used
+	  at least on Nokia 770.
+
+config TAHVO_USB_HOST_BY_DEFAULT
+	depends on TAHVO_USB
+	boolean "Device in USB host mode by default"
+	help
+	  Say Y here, if you want the device to enter USB host mode
+	  by default on bootup.
+
 config USB_ISP1301
 	tristate "NXP ISP1301 USB transceiver support"
 	depends on USB || USB_GADGET
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index ca5bcad49da2..5359489891de 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_FSL_USB2_OTG)		+=3D phy-fsl-usb2.o
 obj-$(CONFIG_ISP1301_OMAP)		+=3D phy-isp1301-omap.o
 obj-$(CONFIG_MV_U3D_PHY)		+=3D phy-mv-u3d-usb.o
 obj-$(CONFIG_NOP_USB_XCEIV)		+=3D phy-generic.o
+obj-$(CONFIG_TAHVO_USB)			+=3D phy-tahvo.o
 obj-$(CONFIG_OMAP_CONTROL_USB)		+=3D phy-omap-control.o
 obj-$(CONFIG_AM335X_CONTROL_USB)	+=3D phy-am335x-control.o
 obj-$(CONFIG_AM335X_PHY_USB)		+=3D phy-am335x.o
diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
new file mode 100644
index 000000000000..7cf1766e1106
--- /dev/null
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -0,0 +1,461 @@
+/*
+ * Tahvo USB transceiver driver
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ *
+ * Parts copied from isp1301_omap.c.
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
+#include <linux/extcon.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb/otg.h>
+#include <linux/mfd/retu.h>
+#include <linux/usb/gadget.h>
+#include <linux/platform_device.h>
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
+struct tahvo_usb {
+	struct platform_device	*pt_dev;
+	struct usb_phy		phy;
+	int			vbus_state;
+	struct mutex		serialize;
+	struct clk		*ick;
+	int			irq;
+	int			tahvo_mode;
+	struct extcon_dev	extcon;
+};
+
+static const char *tahvo_cable[] =3D {
+	"USB-HOST",
+	"USB",
+	NULL,
+};
+
+static ssize_t vbus_state_show(struct device *device,
+			       struct device_attribute *attr, char *buf)
+{
+	struct tahvo_usb *tu =3D dev_get_drvdata(device);
+	return sprintf(buf, "%s\n", tu->vbus_state ? "on" : "off");
+}
+static DEVICE_ATTR(vbus, 0444, vbus_state_show, NULL);
+
+static void check_vbus_state(struct tahvo_usb *tu)
+{
+	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
+	int reg, prev_state;
+
+	reg =3D retu_read(rdev, TAHVO_REG_IDSR);
+	if (reg & TAHVO_STAT_VBUS) {
+		switch (tu->phy.state) {
+		case OTG_STATE_B_IDLE:
+			/* Enable the gadget driver */
+			if (tu->phy.otg->gadget)
+				usb_gadget_vbus_connect(tu->phy.otg->gadget);
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
+	if (prev_state !=3D tu->vbus_state) {
+		extcon_set_cable_state(&tu->extcon, "USB", tu->vbus_state);
+		sysfs_notify(&tu->pt_dev->dev.kobj, NULL, "vbus_state");
+	}
+}
+
+static void tahvo_usb_become_host(struct tahvo_usb *tu)
+{
+	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
+
+	extcon_set_cable_state(&tu->extcon, "USB-HOST", true);
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
+
+	extcon_set_cable_state(&tu->extcon, "USB-HOST", false);
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
+	if (tu->phy.otg->gadget)
+		usb_gadget_vbus_disconnect(tu->phy.otg->gadget);
+	tu->phy.state =3D OTG_STATE_B_IDLE;
+}
+
+static void tahvo_usb_power_off(struct tahvo_usb *tu)
+{
+	struct retu_dev *rdev =3D dev_get_drvdata(tu->pt_dev->dev.parent);
+
+	/* Disable gadget controller if any */
+	if (tu->phy.otg->gadget)
+		usb_gadget_vbus_disconnect(tu->phy.otg->gadget);
+
+	/* Power off transceiver */
+	retu_write(rdev, TAHVO_REG_USBR, 0);
+	tu->phy.state =3D OTG_STATE_UNDEFINED;
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
+static int tahvo_usb_set_host(struct usb_otg *otg, struct usb_bus *hos=
t)
+{
+	struct tahvo_usb *tu =3D container_of(otg->phy, struct tahvo_usb, phy=
);
+
+	dev_dbg(&tu->pt_dev->dev, "%s %p\n", __func__, host);
+
+	if (otg =3D=3D NULL)
+		return -ENODEV;
+
+	mutex_lock(&tu->serialize);
+
+	if (host =3D=3D NULL) {
+		if (tu->tahvo_mode =3D=3D TAHVO_MODE_HOST)
+			tahvo_usb_power_off(tu);
+		otg->host =3D NULL;
+		mutex_unlock(&tu->serialize);
+		return 0;
+	}
+
+	if (tu->tahvo_mode =3D=3D TAHVO_MODE_HOST) {
+		otg->host =3D NULL;
+		tahvo_usb_become_host(tu);
+	}
+
+	otg->host =3D host;
+
+	mutex_unlock(&tu->serialize);
+
+	return 0;
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
+	mutex_lock(&tu->serialize);
+
+	if (!gadget) {
+		if (tu->tahvo_mode =3D=3D TAHVO_MODE_PERIPHERAL)
+			tahvo_usb_power_off(tu);
+		tu->phy.otg->gadget =3D NULL;
+		mutex_unlock(&tu->serialize);
+		return 0;
+	}
+
+	tu->phy.otg->gadget =3D gadget;
+	if (tu->tahvo_mode =3D=3D TAHVO_MODE_PERIPHERAL)
+		tahvo_usb_become_peripheral(tu);
+
+	mutex_unlock(&tu->serialize);
+
+	return 0;
+}
+
+static irqreturn_t tahvo_usb_vbus_interrupt(int irq, void *_tu)
+{
+	struct tahvo_usb *tu =3D _tu;
+
+	mutex_lock(&tu->serialize);
+	check_vbus_state(tu);
+	mutex_unlock(&tu->serialize);
+
+	return IRQ_HANDLED;
+}
+
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
+static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
+
+static struct attribute *tahvo_attributes[] =3D {
+	&dev_attr_vbus.attr,
+	&dev_attr_otg_mode.attr,
+	NULL
+};
+
+static struct attribute_group tahvo_attr_group =3D {
+	.attrs =3D tahvo_attributes,
+};
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
+
+	/* Default mode */
+#ifdef CONFIG_TAHVO_USB_HOST_BY_DEFAULT
+	tu->tahvo_mode =3D TAHVO_MODE_HOST;
+#else
+	tu->tahvo_mode =3D TAHVO_MODE_PERIPHERAL;
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
+	tu->extcon.name =3D DRIVER_NAME;
+	tu->extcon.supported_cable =3D tahvo_cable;
+	ret =3D extcon_dev_register(&tu->extcon, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "could not register extcon device: %d\n",
+			ret);
+		goto err_disable_clk;
+	}
+
+	/* Set the initial cable state. */
+	extcon_set_cable_state(&tu->extcon, "USB-HOST",
+			       tu->tahvo_mode =3D=3D TAHVO_MODE_HOST);
+	extcon_set_cable_state(&tu->extcon, "USB", tu->vbus_state);
+
+	/* Create OTG interface */
+	tahvo_usb_power_off(tu);
+	tu->phy.dev =3D &pdev->dev;
+	tu->phy.state =3D OTG_STATE_UNDEFINED;
+	tu->phy.label =3D DRIVER_NAME;
+	tu->phy.set_suspend =3D tahvo_usb_set_suspend;
+
+	tu->phy.otg->phy =3D &tu->phy;
+	tu->phy.otg->set_host =3D tahvo_usb_set_host;
+	tu->phy.otg->set_peripheral =3D tahvo_usb_set_peripheral;
+
+	ret =3D usb_add_phy(&tu->phy, USB_PHY_TYPE_USB2);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot register USB transceiver: %d\n",
+			ret);
+		goto err_extcon_unreg;
+	}
+
+	dev_set_drvdata(&pdev->dev, tu);
+
+	tu->irq =3D platform_get_irq(pdev, 0);
+	ret =3D request_threaded_irq(tu->irq, NULL, tahvo_usb_vbus_interrupt,=
 0,
+				   "tahvo-vbus", tu);
+	if (ret) {
+		dev_err(&pdev->dev, "could not register tahvo-vbus irq: %d\n",
+			ret);
+		goto err_remove_phy;
+	}
+
+	/* Attributes */
+	ret =3D sysfs_create_group(&pdev->dev.kobj, &tahvo_attr_group);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot create sysfs group: %d\n", ret);
+		goto err_free_irq;
+	}
+
+	return 0;
+
+err_free_irq:
+	free_irq(tu->irq, tu);
+err_remove_phy:
+	usb_remove_phy(&tu->phy);
+err_extcon_unreg:
+	extcon_dev_unregister(&tu->extcon);
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
+	sysfs_remove_group(&pdev->dev.kobj, &tahvo_attr_group);
+	free_irq(tu->irq, tu);
+	usb_remove_phy(&tu->phy);
+	extcon_dev_unregister(&tu->extcon);
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
+		.owner	=3D THIS_MODULE,
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
1.8.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
