From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v6 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
Date: Fri,  5 Sep 2014 16:36:30 +0100
Message-ID: <1409931392-22340-2-git-send-email-peter.griffin@linaro.org>
References: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-omap@vger.kernel.org

This patch adds the ST glue logic to manage the DWC3 HC
on STiH407 SoC family. It manages the powerdown signal,
and configures the internal glue logic and syscfg registers.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc3/Kconfig   |   9 ++
 drivers/usb/dwc3/Makefile  |   1 +
 drivers/usb/dwc3/dwc3-st.c | 377 +++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 387 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-st.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 785510a..5238251 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -80,6 +80,15 @@ config USB_DWC3_KEYSTONE
 	  Support of USB2/3 functionality in TI Keystone2 platforms.
 	  Say 'Y' or 'M' here if you have one such device
=20
+config USB_DWC3_ST
+	tristate "STMicroelectronics Platforms"
+	depends on ARCH_STI && OF
+	default USB_DWC3
+	help
+	  STMicroelectronics SoCs with one DesignWare Core USB3 IP
+	  inside (i.e. STiH407).
+	  Say 'Y' or 'M' if you have one such device.
+
 comment "Debugging features"
=20
 config USB_DWC3_DEBUG
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 10ac3e7..11c9f54 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -33,3 +33,4 @@ obj-$(CONFIG_USB_DWC3_OMAP)		+=3D dwc3-omap.o
 obj-$(CONFIG_USB_DWC3_EXYNOS)		+=3D dwc3-exynos.o
 obj-$(CONFIG_USB_DWC3_PCI)		+=3D dwc3-pci.o
 obj-$(CONFIG_USB_DWC3_KEYSTONE)		+=3D dwc3-keystone.o
+obj-$(CONFIG_USB_DWC3_ST)		+=3D dwc3-st.o
diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
new file mode 100644
index 0000000..c4c1717
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -0,0 +1,377 @@
+/**
+ * dwc3-st.c Support for dwc3 platform devices on ST Microelectronics =
platforms
+ *
+ * This is a small driver for the dwc3 to provide the glue logic
+ * to configure the controller. Tested on STi platforms.
+ *
+ * Copyright (C) 2014 Stmicroelectronics
+ *
+ * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
+ * Contributors: Aymen Bouattay <aymen.bouattay@st.com>
+ *               Peter Griffin <peter.griffin@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Inspired by dwc3-omap.c and dwc3-exynos.c.
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/usb/of.h>
+
+#include "core.h"
+#include "io.h"
+
+/* glue registers */
+#define CLKRST_CTRL		0x00
+#define AUX_CLK_EN		BIT(0)
+#define SW_PIPEW_RESET_N	BIT(4)
+#define EXT_CFG_RESET_N		BIT(8)
+/*
+ * 1'b0 : The host controller complies with the xHCI revision 0.96
+ * 1'b1 : The host controller complies with the xHCI revision 1.0
+ */
+#define XHCI_REVISION		BIT(12)
+
+#define USB2_VBUS_MNGMNT_SEL1	0x2C
+/*
+ * For all fields in USB2_VBUS_MNGMNT_SEL1
+ * 2=E2=80=99b00 : Override value from Reg 0x30 is selected
+ * 2=E2=80=99b01 : utmiotg_<signal_name> from usb3_top is selected
+ * 2=E2=80=99b10 : pipew_<signal_name> from PIPEW instance is selected
+ * 2=E2=80=99b11 : value is 1'b0
+ */
+#define USB2_VBUS_REG30		0x0
+#define USB2_VBUS_UTMIOTG	0x1
+#define USB2_VBUS_PIPEW		0x2
+#define USB2_VBUS_ZERO		0x3
+
+#define SEL_OVERRIDE_VBUSVALID(n)	(n << 0)
+#define SEL_OVERRIDE_POWERPRESENT(n)	(n << 4)
+#define SEL_OVERRIDE_BVALID(n)		(n << 8)
+
+/* Static DRD configuration */
+#define USB3_CONTROL_MASK		0xf77
+
+#define USB3_DEVICE_NOT_HOST		BIT(0)
+#define USB3_FORCE_VBUSVALID		BIT(1)
+#define USB3_DELAY_VBUSVALID		BIT(2)
+#define USB3_SEL_FORCE_OPMODE		BIT(4)
+#define USB3_FORCE_OPMODE(n)		(n << 5)
+#define USB3_SEL_FORCE_DPPULLDOWN2	BIT(8)
+#define USB3_FORCE_DPPULLDOWN2		BIT(9)
+#define USB3_SEL_FORCE_DMPULLDOWN2	BIT(10)
+#define USB3_FORCE_DMPULLDOWN2		BIT(11)
+
+/**
+ * struct st_dwc3 - dwc3-st driver private structure
+ * @dev:		device pointer
+ * @glue_base:		ioaddr for the glue registers
+ * @regmap:		regmap pointer for getting syscfg
+ * @syscfg_reg_off:	usb syscfg control offset
+ * @dr_mode:		drd static host/device config
+ * @rstc_pwrdn:		rest controller for powerdown signal
+ * @rstc_rst:		reset controller for softreset signal
+ */
+
+struct st_dwc3 {
+	struct device *dev;
+	void __iomem *glue_base;
+	struct regmap *regmap;
+	int syscfg_reg_off;
+	enum usb_dr_mode dr_mode;
+	struct reset_control *rstc_pwrdn;
+	struct reset_control *rstc_rst;
+};
+
+static inline u32 st_dwc3_readl(void __iomem *base, u32 offset)
+{
+	return readl_relaxed(base + offset);
+}
+
+static inline void st_dwc3_writel(void __iomem *base, u32 offset, u32 =
value)
+{
+	writel_relaxed(value, base + offset);
+}
+
+/**
+ * st_dwc3_drd_init: program the port
+ * @dwc3_data: driver private structure
+ * Description: this function is to program the port as either host or=
 device
+ * according to the static configuration passed from devicetree.
+ * OTG and dual role are not yet supported!
+ */
+static int st_dwc3_drd_init(struct st_dwc3 *dwc3_data)
+{
+	u32 val;
+	int err;
+
+	err =3D regmap_read(dwc3_data->regmap, dwc3_data->syscfg_reg_off, &va=
l);
+	if (err)
+		return err;
+
+	val &=3D USB3_CONTROL_MASK;
+
+	switch (dwc3_data->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+
+		val &=3D ~(USB3_FORCE_VBUSVALID | USB3_DELAY_VBUSVALID
+			| USB3_SEL_FORCE_OPMODE | USB3_FORCE_OPMODE(0x3)
+			| USB3_SEL_FORCE_DPPULLDOWN2 | USB3_FORCE_DPPULLDOWN2
+			| USB3_SEL_FORCE_DMPULLDOWN2 | USB3_FORCE_DMPULLDOWN2);
+
+		val |=3D USB3_DEVICE_NOT_HOST;
+
+		dev_dbg(dwc3_data->dev, "Configuring as Device\n");
+		break;
+
+	case USB_DR_MODE_HOST:
+
+		val &=3D ~(USB3_DEVICE_NOT_HOST | USB3_FORCE_VBUSVALID
+			| USB3_SEL_FORCE_OPMODE	| USB3_FORCE_OPMODE(0x3)
+			| USB3_SEL_FORCE_DPPULLDOWN2 | USB3_FORCE_DPPULLDOWN2
+			| USB3_SEL_FORCE_DMPULLDOWN2 | USB3_FORCE_DMPULLDOWN2);
+
+		/*
+		 * USB3_DELAY_VBUSVALID is ANDed with USB_C_VBUSVALID. Thus,
+		 * when set to =E2=80=980=E2=80=98, it can delay the arrival of VBUS=
VALID
+		 * information to VBUSVLDEXT2 input of the pico PHY.
+		 * We don't want to do that so we set the bit to '1'.
+		 */
+
+		val |=3D USB3_DELAY_VBUSVALID;
+
+		dev_dbg(dwc3_data->dev, "Configuring as Host\n");
+		break;
+
+	default:
+		dev_err(dwc3_data->dev, "Unsupported mode of operation %d\n",
+			dwc3_data->dr_mode);
+		return -EINVAL;
+	}
+
+	return regmap_write(dwc3_data->regmap, dwc3_data->syscfg_reg_off, val=
);
+}
+
+/**
+ * st_dwc3_init: init the controller via glue logic
+ * @dwc3_data: driver private structure
+ */
+static void st_dwc3_init(struct st_dwc3 *dwc3_data)
+{
+	u32 reg =3D st_dwc3_readl(dwc3_data->glue_base, CLKRST_CTRL);
+
+	reg |=3D AUX_CLK_EN | EXT_CFG_RESET_N | XHCI_REVISION;
+	reg &=3D ~SW_PIPEW_RESET_N;
+	st_dwc3_writel(dwc3_data->glue_base, CLKRST_CTRL, reg);
+
+	/* configure mux for vbus, powerpresent and bvalid signals */
+	reg =3D st_dwc3_readl(dwc3_data->glue_base, USB2_VBUS_MNGMNT_SEL1);
+
+	reg |=3D SEL_OVERRIDE_VBUSVALID(USB2_VBUS_UTMIOTG) |
+		SEL_OVERRIDE_POWERPRESENT(USB2_VBUS_UTMIOTG) |
+		SEL_OVERRIDE_BVALID(USB2_VBUS_UTMIOTG);
+
+	st_dwc3_writel(dwc3_data->glue_base, USB2_VBUS_MNGMNT_SEL1, reg);
+
+	reg =3D st_dwc3_readl(dwc3_data->glue_base, CLKRST_CTRL);
+	reg |=3D SW_PIPEW_RESET_N;
+	st_dwc3_writel(dwc3_data->glue_base, CLKRST_CTRL, reg);
+}
+
+static int st_dwc3_probe(struct platform_device *pdev)
+{
+	struct st_dwc3 *dwc3_data;
+	struct resource *res;
+	struct device *dev =3D &pdev->dev;
+	struct device_node *node =3D dev->of_node, *child;
+	struct regmap *regmap;
+	int ret;
+
+	dwc3_data =3D devm_kzalloc(dev, sizeof(*dwc3_data), GFP_KERNEL);
+	if (!dwc3_data)
+		return -ENOMEM;
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg-glue"=
);
+	dwc3_data->glue_base =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(dwc3_data->glue_base))
+		return PTR_ERR(dwc3_data->glue_base);
+
+	regmap =3D syscon_regmap_lookup_by_phandle(node, "st,syscfg");
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	dma_set_coherent_mask(dev, dev->coherent_dma_mask);
+	dwc3_data->dev =3D dev;
+	dwc3_data->regmap =3D regmap;
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "syscfg-re=
g");
+	if (!res) {
+		ret =3D -ENXIO;
+		goto undo_platform_dev_alloc;
+	}
+
+	dwc3_data->syscfg_reg_off =3D res->start;
+
+	dev_vdbg(&pdev->dev, "glue-logic addr 0x%p, syscfg-reg offset 0x%x\n"=
,
+		 dwc3_data->glue_base, dwc3_data->syscfg_reg_off);
+
+	dwc3_data->rstc_pwrdn =3D devm_reset_control_get(dev, "powerdown");
+	if (IS_ERR(dwc3_data->rstc_pwrdn)) {
+		dev_err(&pdev->dev, "could not get power controller\n");
+		ret =3D PTR_ERR(dwc3_data->rstc_pwrdn);
+		goto undo_platform_dev_alloc;
+	}
+
+	/* Manage PowerDown */
+	reset_control_deassert(dwc3_data->rstc_pwrdn);
+
+	dwc3_data->rstc_rst =3D devm_reset_control_get(dev, "softreset");
+	if (IS_ERR(dwc3_data->rstc_rst)) {
+		dev_err(&pdev->dev, "could not get reset controller\n");
+		ret =3D PTR_ERR(dwc3_data->rstc_pwrdn);
+		goto undo_powerdown;
+	}
+
+	/* Manage SoftReset */
+	reset_control_deassert(dwc3_data->rstc_rst);
+
+	child =3D of_get_child_by_name(node, "dwc3");
+	if (!child) {
+		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
+		ret =3D -ENODEV;
+		goto undo_softreset;
+	}
+
+	dwc3_data->dr_mode =3D of_usb_get_dr_mode(child);
+
+	/* Allocate and initialize the core */
+	ret =3D of_platform_populate(node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to add dwc3 core\n");
+		goto undo_softreset;
+	}
+
+	/*
+	 * Configure the USB port as device or host according to the static
+	 * configuration passed from DT.
+	 * DRD is the only mode currently supported so this will be enhanced
+	 * as soon as OTG is available.
+	 */
+	ret =3D st_dwc3_drd_init(dwc3_data);
+	if (ret) {
+		dev_err(dev, "drd initialisation failed\n");
+		goto undo_softreset;
+	}
+
+	/* ST glue logic init */
+	st_dwc3_init(dwc3_data);
+
+	platform_set_drvdata(pdev, dwc3_data);
+	return 0;
+
+undo_softreset:
+	reset_control_assert(dwc3_data->rstc_rst);
+undo_powerdown:
+	reset_control_assert(dwc3_data->rstc_pwrdn);
+undo_platform_dev_alloc:
+	platform_device_put(pdev);
+	return ret;
+}
+
+
+static int st_dwc3_remove_child(struct device *dev, void *c)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+
+	of_device_unregister(pdev);
+
+	return 0;
+}
+
+static int st_dwc3_remove(struct platform_device *pdev)
+{
+	struct st_dwc3 *dwc3_data =3D platform_get_drvdata(pdev);
+
+	device_for_each_child(&pdev->dev, NULL, st_dwc3_remove_child);
+
+	reset_control_assert(dwc3_data->rstc_pwrdn);
+	reset_control_assert(dwc3_data->rstc_rst);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int st_dwc3_suspend(struct device *dev)
+{
+	struct st_dwc3 *dwc3_data =3D dev_get_drvdata(dev);
+
+	reset_control_assert(dwc3_data->rstc_pwrdn);
+	reset_control_assert(dwc3_data->rstc_rst);
+
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int st_dwc3_resume(struct device *dev)
+{
+	struct st_dwc3 *dwc3_data =3D dev_get_drvdata(dev);
+	int ret;
+
+	pinctrl_pm_select_default_state(dev);
+
+	reset_control_deassert(dwc3_data->rstc_pwrdn);
+	reset_control_deassert(dwc3_data->rstc_rst);
+
+	ret =3D st_dwc3_drd_init(dwc3_data);
+	if (ret) {
+		dev_err(dev, "drd initialisation failed\n");
+		return ret;
+	}
+
+	/* ST glue logic init */
+	st_dwc3_init(dwc3_data);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(st_dwc3_dev_pm_ops, st_dwc3_suspend, st_dwc3_=
resume);
+
+static const struct of_device_id st_dwc3_match[] =3D {
+	{ .compatible =3D "st,stih407-dwc3" },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, st_dwc3_match);
+
+static struct platform_driver st_dwc3_driver =3D {
+	.probe =3D st_dwc3_probe,
+	.remove =3D st_dwc3_remove,
+	.driver =3D {
+		.name =3D "usb-st-dwc3",
+		.of_match_table =3D st_dwc3_match,
+		.pm =3D &st_dwc3_dev_pm_ops,
+	},
+};
+
+module_platform_driver(st_dwc3_driver);
+
+MODULE_AUTHOR("Giuseppe Cavallaro <peppe.cavallaro@st.com>");
+MODULE_DESCRIPTION("DesignWare USB3 STi Glue Layer");
+MODULE_LICENSE("GPL v2");
--=20
1.9.1
