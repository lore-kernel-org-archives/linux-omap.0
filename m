From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Mon, 19 Mar 2012 12:18:31 +0530
Message-ID: <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43657 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757799Ab2CSGtZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 02:49:25 -0400
In-Reply-To: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com, Keshava Munegowda <Keshava_mgowda@ti.com>

From: Keshava Munegowda <Keshava_mgowda@ti.com>

The platform driver for the TLL component of the OMAP USB host controller
is implemented. Depending on the TLL hardware revision , the TLL channels
are configured. The USB HS core driver uses this driver through exported
APIs from the TLL platform driver.
usb_tll_enable and usb_tll_disble are the exported APIs of the USB TLL
platform driver.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Reviewed-by: Partha Basak <parthab@india.ti.com>
---
 arch/arm/plat-omap/include/plat/usb.h |    8 +
 drivers/mfd/Kconfig                   |    2 +-
 drivers/mfd/Makefile                  |    2 +-
 drivers/mfd/omap-usb-tll.c            |  463 +++++++++++++++++++++++++++++++++
 4 files changed, 473 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mfd/omap-usb-tll.c

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index dc864b5..eb1e47d 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -61,6 +61,10 @@ struct usbhs_omap_platform_data {
 	struct ehci_hcd_omap_platform_data	*ehci_data;
 	struct ohci_hcd_omap_platform_data	*ohci_data;
 };
+
+struct usbtll_omap_platform_data {
+	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
+};
 /*-------------------------------------------------------------------------*/
 
 #define OMAP1_OTG_BASE			0xfffb0400
@@ -105,6 +109,10 @@ extern int omap4430_phy_set_clk(struct device *dev, int on);
 extern int omap4430_phy_init(struct device *dev);
 extern int omap4430_phy_exit(struct device *dev);
 extern int omap4430_phy_suspend(struct device *dev, int suspend);
+
+extern int omap_tll_enable(void);
+extern int omap_tll_disable(void);
+
 #endif
 
 extern void am35x_musb_reset(void);
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f147395..5f75ad4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -772,7 +772,7 @@ config MFD_WL1273_CORE
 	  audio codec.
 
 config MFD_OMAP_USB_HOST
-	bool "Support OMAP USBHS core driver"
+	bool "Support OMAP USBHS core and TLL driver"
 	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
 	default y
 	help
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b953bab..4b3a8e0 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -105,7 +105,7 @@ obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
 obj-$(CONFIG_MFD_VX855)		+= vx855.o
 obj-$(CONFIG_MFD_WL1273_CORE)	+= wl1273-core.o
 obj-$(CONFIG_MFD_CS5535)	+= cs5535-mfd.o
-obj-$(CONFIG_MFD_OMAP_USB_HOST)	+= omap-usb-host.o
+obj-$(CONFIG_MFD_OMAP_USB_HOST)	+= omap-usb-host.o omap-usb-tll.o
 obj-$(CONFIG_MFD_PM8921_CORE) 	+= pm8921-core.o
 obj-$(CONFIG_MFD_PM8XXX_IRQ) 	+= pm8xxx-irq.o
 obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
new file mode 100644
index 0000000..3da468a
--- /dev/null
+++ b/drivers/mfd/omap-usb-tll.c
@@ -0,0 +1,463 @@
+/**
+ * omap-usb-tll.c - The USB TLL driver for OMAP EHCI & OHCI
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
+ * Author: Keshava Munegowda <keshava_mgowda@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <plat/usb.h>
+#include <linux/pm_runtime.h>
+
+#define USBTLL_DRIVER_NAME	"usbhs_tll"
+
+/* TLL Register Set */
+#define	OMAP_USBTLL_REVISION				(0x00)
+#define	OMAP_USBTLL_SYSCONFIG				(0x10)
+#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY			(1 << 8)
+#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE			(1 << 3)
+#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP			(1 << 2)
+#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET			(1 << 1)
+#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE			(1 << 0)
+
+#define	OMAP_USBTLL_SYSSTATUS				(0x14)
+#define	OMAP_USBTLL_SYSSTATUS_RESETDONE			(1 << 0)
+
+#define	OMAP_USBTLL_IRQSTATUS				(0x18)
+#define	OMAP_USBTLL_IRQENABLE				(0x1C)
+
+#define	OMAP_TLL_SHARED_CONF				(0x30)
+#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN		(1 << 6)
+#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN		(1 << 5)
+#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION		(1 << 2)
+#define	OMAP_TLL_SHARED_CONF_FCLK_REQ			(1 << 1)
+#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON			(1 << 0)
+
+#define	OMAP_TLL_CHANNEL_CONF(num)			(0x040 + 0x004 * num)
+#define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT		24
+#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
+#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
+#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
+#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
+#define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS		(1 << 1)
+#define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
+
+#define OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0		0x0
+#define OMAP_TLL_FSLSMODE_6PIN_PHY_DP_DM		0x1
+#define OMAP_TLL_FSLSMODE_3PIN_PHY			0x2
+#define OMAP_TLL_FSLSMODE_4PIN_PHY			0x3
+#define OMAP_TLL_FSLSMODE_6PIN_TLL_DAT_SE0		0x4
+#define OMAP_TLL_FSLSMODE_6PIN_TLL_DP_DM		0x5
+#define OMAP_TLL_FSLSMODE_3PIN_TLL			0x6
+#define OMAP_TLL_FSLSMODE_4PIN_TLL			0x7
+#define OMAP_TLL_FSLSMODE_2PIN_TLL_DAT_SE0		0xA
+#define OMAP_TLL_FSLSMODE_2PIN_DAT_DP_DM		0xB
+
+#define	OMAP_TLL_ULPI_FUNCTION_CTRL(num)		(0x804 + 0x100 * num)
+#define	OMAP_TLL_ULPI_INTERFACE_CTRL(num)		(0x807 + 0x100 * num)
+#define	OMAP_TLL_ULPI_OTG_CTRL(num)			(0x80A + 0x100 * num)
+#define	OMAP_TLL_ULPI_INT_EN_RISE(num)			(0x80D + 0x100 * num)
+#define	OMAP_TLL_ULPI_INT_EN_FALL(num)			(0x810 + 0x100 * num)
+#define	OMAP_TLL_ULPI_INT_STATUS(num)			(0x813 + 0x100 * num)
+#define	OMAP_TLL_ULPI_INT_LATCH(num)			(0x814 + 0x100 * num)
+#define	OMAP_TLL_ULPI_DEBUG(num)			(0x815 + 0x100 * num)
+#define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)		(0x816 + 0x100 * num)
+
+#define OMAP_REV2_TLL_CHANNEL_COUNT			2
+#define OMAP_TLL_CHANNEL_COUNT				3
+#define OMAP_TLL_CHANNEL_1_EN_MASK			(1 << 0)
+#define OMAP_TLL_CHANNEL_2_EN_MASK			(1 << 1)
+#define OMAP_TLL_CHANNEL_3_EN_MASK			(1 << 2)
+
+/* Values of USBTLL_REVISION - Note: these are not given in the TRM */
+#define OMAP_USBTLL_REV1		0x00000015	/* OMAP3 */
+#define OMAP_USBTLL_REV2		0x00000004	/* OMAP4 */
+
+#define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
+
+struct usbtll_omap {
+	struct clk				*usbtll_p1_fck;
+	struct clk				*usbtll_p2_fck;
+	struct usbtll_omap_platform_data	platdata;
+	spinlock_t				lock;
+};
+
+/*-------------------------------------------------------------------------*/
+
+const char usbtll_driver_name[] = USBTLL_DRIVER_NAME;
+struct platform_device	*tll_pdev;
+
+/*-------------------------------------------------------------------------*/
+
+static inline void usbtll_write(void __iomem *base, u32 reg, u32 val)
+{
+	__raw_writel(val, base + reg);
+}
+
+static inline u32 usbtll_read(void __iomem *base, u32 reg)
+{
+	return __raw_readl(base + reg);
+}
+
+static inline void usbtll_writeb(void __iomem *base, u8 reg, u8 val)
+{
+	__raw_writeb(val, base + reg);
+}
+
+static inline u8 usbtll_readb(void __iomem *base, u8 reg)
+{
+	return __raw_readb(base + reg);
+}
+
+/*-------------------------------------------------------------------------*/
+
+static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
+{
+	switch (pmode) {
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+/*
+ * convert the port-mode enum to a value we can use in the FSLSMODE
+ * field of USBTLL_CHANNEL_CONF
+ */
+static unsigned ohci_omap3_fslsmode(enum usbhs_omap_port_mode mode)
+{
+	switch (mode) {
+	case OMAP_USBHS_PORT_MODE_UNUSED:
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
+		return OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0;
+
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
+		return OMAP_TLL_FSLSMODE_6PIN_PHY_DP_DM;
+
+	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
+		return OMAP_TLL_FSLSMODE_3PIN_PHY;
+
+	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
+		return OMAP_TLL_FSLSMODE_4PIN_PHY;
+
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
+		return OMAP_TLL_FSLSMODE_6PIN_TLL_DAT_SE0;
+
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
+		return OMAP_TLL_FSLSMODE_6PIN_TLL_DP_DM;
+
+	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
+		return OMAP_TLL_FSLSMODE_3PIN_TLL;
+
+	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
+		return OMAP_TLL_FSLSMODE_4PIN_TLL;
+
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
+		return OMAP_TLL_FSLSMODE_2PIN_TLL_DAT_SE0;
+
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
+		return OMAP_TLL_FSLSMODE_2PIN_DAT_DP_DM;
+	default:
+		pr_warning("Invalid port mode, using default\n");
+		return OMAP_TLL_FSLSMODE_6PIN_PHY_DAT_SE0;
+	}
+}
+
+/**
+ * usbtll_omap_probe - initialize TI-based HCDs
+ *
+ * Allocates basic resources for this USB host controller.
+ */
+static int __devinit usbtll_omap_probe(struct platform_device *pdev)
+{
+	struct device				*dev =  &pdev->dev;
+	struct usbtll_omap_platform_data	*pdata = dev->platform_data;
+	void __iomem				*base;
+	struct resource				*res;
+	struct usbtll_omap			*tll;
+	unsigned				reg;
+	unsigned long				flags;
+	int					ret = 0;
+	int					i, ver, count;
+
+	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
+
+	tll = kzalloc(sizeof(struct usbtll_omap), GFP_KERNEL);
+	if (!tll) {
+		dev_err(dev, "Memory allocation failed\n");
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	spin_lock_init(&tll->lock);
+
+	for (i = 0; i < OMAP3_HS_USB_PORTS; i++)
+		tll->platdata.port_mode[i] = pdata->port_mode[i];
+
+	tll->usbtll_p1_fck = clk_get(dev, "usb_tll_hs_usb_ch0_clk");
+	if (IS_ERR(tll->usbtll_p1_fck)) {
+		ret = PTR_ERR(tll->usbtll_p1_fck);
+		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
+		goto err_tll;
+	}
+
+	tll->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
+	if (IS_ERR(tll->usbtll_p2_fck)) {
+		ret = PTR_ERR(tll->usbtll_p2_fck);
+		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
+		goto err_usbtll_p1_fck;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "usb tll get resource failed\n");
+		ret = -ENODEV;
+		goto err_usbtll_p2_fck;
+	}
+
+	base = ioremap(res->start, resource_size(res));
+	if (!base) {
+		dev_err(dev, "TLL ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_usbtll_p2_fck;
+	}
+
+	platform_set_drvdata(pdev, tll);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	spin_lock_irqsave(&tll->lock, flags);
+
+	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
+	if (ver == OMAP_USBTLL_REV1)
+		count = OMAP_TLL_CHANNEL_COUNT;
+	else if (ver == OMAP_USBTLL_REV2)
+		count = OMAP_REV2_TLL_CHANNEL_COUNT;
+	else {
+		dev_err(dev, "TLL version failed\n");
+		ret = -ENODEV;
+		goto err_ioremap;
+	}
+
+	if (is_ehci_tll_mode(pdata->port_mode[0]) ||
+		is_ehci_tll_mode(pdata->port_mode[1]) ||
+		is_ehci_tll_mode(pdata->port_mode[2]) ||
+		(is_ohci_port(pdata->port_mode[0])) ||
+		(is_ohci_port(pdata->port_mode[1])) ||
+		(is_ohci_port(pdata->port_mode[2]))) {
+
+		/* Program Common TLL register */
+		reg = usbtll_read(base, OMAP_TLL_SHARED_CONF);
+		reg |= (OMAP_TLL_SHARED_CONF_FCLK_IS_ON
+			| OMAP_TLL_SHARED_CONF_USB_DIVRATION);
+		reg &= ~OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN;
+		reg &= ~OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN;
+
+		usbtll_write(base, OMAP_TLL_SHARED_CONF, reg);
+
+		/* Enable channels now */
+		for (i = 0; i < count; i++) {
+			reg = usbtll_read(base,	OMAP_TLL_CHANNEL_CONF(i));
+
+			if (is_ohci_port(pdata->port_mode[i])) {
+				reg |= ohci_omap3_fslsmode(pdata->port_mode[i])
+				<< OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT;
+				reg |= OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS;
+			} else
+			if (pdata->port_mode[i] == OMAP_EHCI_PORT_MODE_TLL) {
+
+				/*
+				 * Disable AutoIdle, BitStuffing
+				 * and use SDR Mode
+				 */
+				reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
+					| OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
+					| OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
+			} else
+				continue;
+
+			reg |= OMAP_TLL_CHANNEL_CONF_CHANEN;
+			usbtll_write(base, OMAP_TLL_CHANNEL_CONF(i), reg);
+
+			usbtll_writeb(base,
+				OMAP_TLL_ULPI_SCRATCH_REGISTER(i), 0xbe);
+		}
+	}
+
+err_ioremap:
+	spin_unlock_irqrestore(&tll->lock, flags);
+	iounmap(base);
+	pm_runtime_put_sync(dev);
+	tll_pdev = pdev;
+	if (!ret)
+		goto end;
+	pm_runtime_disable(dev);
+
+err_usbtll_p2_fck:
+	clk_put(tll->usbtll_p2_fck);
+
+err_usbtll_p1_fck:
+	clk_put(tll->usbtll_p1_fck);
+
+err_tll:
+	kfree(tll);
+
+end:
+	return ret;
+}
+
+/**
+ * usbtll_omap_remove - shutdown processing for UHH & TLL HCDs
+ * @pdev: USB Host Controller being removed
+ *
+ * Reverses the effect of usbtll_omap_probe().
+ */
+static int __devexit usbtll_omap_remove(struct platform_device *pdev)
+{
+	struct usbtll_omap *tll = platform_get_drvdata(pdev);
+
+	clk_put(tll->usbtll_p2_fck);
+	clk_put(tll->usbtll_p1_fck);
+	pm_runtime_disable(&pdev->dev);
+	kfree(tll);
+	return 0;
+}
+
+static int usbtll_runtime_resume(struct device *dev)
+{
+	struct usbtll_omap			*tll = dev_get_drvdata(dev);
+	struct usbtll_omap_platform_data	*pdata = &tll->platdata;
+	unsigned long				flags;
+
+	dev_dbg(dev, "usbtll_runtime_resume\n");
+
+	if (!pdata) {
+		dev_dbg(dev, "missing platform_data\n");
+		return  -ENODEV;
+	}
+
+	spin_lock_irqsave(&tll->lock, flags);
+
+	if (is_ehci_tll_mode(pdata->port_mode[0]))
+		clk_enable(tll->usbtll_p1_fck);
+
+	if (is_ehci_tll_mode(pdata->port_mode[1]))
+		clk_enable(tll->usbtll_p2_fck);
+
+	spin_unlock_irqrestore(&tll->lock, flags);
+
+	return 0;
+}
+
+static int usbtll_runtime_suspend(struct device *dev)
+{
+	struct usbtll_omap			*tll = dev_get_drvdata(dev);
+	struct usbtll_omap_platform_data	*pdata = &tll->platdata;
+	unsigned long				flags;
+
+	dev_dbg(dev, "usbtll_runtime_suspend\n");
+
+	if (!pdata) {
+		dev_dbg(dev, "missing platform_data\n");
+		return  -ENODEV;
+	}
+
+	spin_lock_irqsave(&tll->lock, flags);
+
+	if (is_ehci_tll_mode(pdata->port_mode[0]))
+		clk_disable(tll->usbtll_p1_fck);
+
+	if (is_ehci_tll_mode(pdata->port_mode[1]))
+		clk_disable(tll->usbtll_p2_fck);
+
+	spin_unlock_irqrestore(&tll->lock, flags);
+
+	return 0;
+}
+
+static const struct dev_pm_ops usbtllomap_dev_pm_ops = {
+	.runtime_suspend	= usbtll_runtime_suspend,
+	.runtime_resume		= usbtll_runtime_resume,
+};
+
+static struct platform_driver usbtll_omap_driver = {
+	.driver = {
+		.name		= (char *)usbtll_driver_name,
+		.owner		= THIS_MODULE,
+		.pm		= &usbtllomap_dev_pm_ops,
+	},
+	.remove		= __exit_p(usbtll_omap_remove),
+};
+
+int omap_tll_enable(void)
+{
+	if (!tll_pdev) {
+		dev_dbg(&tll_pdev->dev, "missing platform_data\n");
+		return  -ENODEV;
+	}
+	return pm_runtime_get_sync(&tll_pdev->dev);
+}
+EXPORT_SYMBOL_GPL(omap_tll_enable);
+
+int omap_tll_disable(void)
+{
+	if (!tll_pdev) {
+		dev_dbg(&tll_pdev->dev, "missing platform_data\n");
+		return  -ENODEV;
+	}
+	return pm_runtime_put_sync(&tll_pdev->dev);
+}
+EXPORT_SYMBOL_GPL(omap_tll_disable);
+
+MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
+MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
+
+static int __init omap_usbtll_drvinit(void)
+{
+	return platform_driver_probe(&usbtll_omap_driver, usbtll_omap_probe);
+}
+
+/*
+ * init before usbhs core driver;
+ * The usbtll driver should be initialized before
+ * the usbhs core driver probe function is called.
+ */
+fs_initcall(omap_usbtll_drvinit);
+
+static void __exit omap_usbtll_drvexit(void)
+{
+	platform_driver_unregister(&usbtll_omap_driver);
+}
+module_exit(omap_usbtll_drvexit);
-- 
1.6.0.4

