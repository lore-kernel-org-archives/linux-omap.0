From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv3] power: supply: cpcap-charger: Add minimal CPCAP PMIC battery charger
Date: Sun, 26 Mar 2017 20:25:13 -0700
Message-ID: <20170327032513.22890-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The custom CPCAP PMIC used on Motorola phones such as Droid 4 has a
USB battery charger. It can optionally also have a companion chip that
is used for wireless charging.

The charger on CPCAP also can feed VBUS for the USB host mode. This
can be handled by the existing kernel phy_companion interface.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

Changes since v2:

- Update binding based on comments by Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

- Drop "motorola,cpcap-charger" compatible for now as this seems specific
  to the motorola-mapphone

- Update Kconfig for "depends on IIO" and "default MFD_CPCAP"

Changes since v1:

- Fix scaling of IIO values as pointed out by Sebastian Reichel
  <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

- Use iio_read_channel_processed() instead of iio_read_channel_scaled()
  as changed in the v2 of the ADC driver

- Add GPL v2 license header

---
 .../bindings/power/supply/cpcap-charger.txt        |  38 ++
 drivers/power/supply/Kconfig                       |   8 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/cpcap-charger.c               | 681 +++++++++++++++++++++
 4 files changed, 728 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
 create mode 100644 drivers/power/supply/cpcap-charger.c

diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt b/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
@@ -0,0 +1,38 @@
+Motorola CPCAP PMIC battery charger binding
+
+Required properties:
+- compatible: Shall be "motorola,cpcap-charger" or
+	      "motorola,mapphone-cpcap-charger"
+- interrupts: Interrupt specifier for each name in interrupt-names
+- interrupt-names: Should contain the following entries:
+		   "chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
+		   "rvrs_mode", "chrgcurr1", "vbusvld", "battdetb"
+- io-channels: IIO ADC channel specifier for each name in io-channel-names
+- io-channel-names: Should contain the following entries:
+		    "battdetb", "battp", "vbus", "chg_isense", "batti"
+
+Optional properties:
+- mode-gpios: Optionally CPCAP charger can have a companion wireless
+	      charge controller that is controlled with two GPIOs
+	      that are active low.
+
+Example:
+
+cpcap_charger: charger {
+	compatible = "motorola,mapphone-cpcap-charger";
+	interrupts-extended = <
+		&cpcap 13 0 &cpcap 12 0 &cpcap 29 0 &cpcap 28 0
+		&cpcap 22 0 &cpcap 20 0 &cpcap 19 0 &cpcap 54 0
+	>;
+	interrupt-names =
+		"chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
+		"rvrs_mode", "chrgcurr1", "vbusvld", "battdetb";
+	mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW
+		      &gpio3 23 GPIO_ACTIVE_LOW>;
+	io-channels = <&cpcap_adc 0 &cpcap_adc 1
+		       &cpcap_adc 2 &cpcap_adc 5
+		       &cpcap_adc 6>;
+	io-channel-names = "battdetb", "battp",
+			   "vbus", "chg_isense",
+			   "batti";
+};
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -317,6 +317,14 @@ config BATTERY_RX51
 	  Say Y here to enable support for battery information on Nokia
 	  RX-51, also known as N900 tablet.
 
+config CHARGER_CPCAP
+	tristate "CPCAP PMIC Charger Driver"
+	depends on MFD_CPCAP && IIO
+	default MFD_CPCAP
+	help
+	  Say Y to enable support for CPCAP PMIC charger driver for Motorola
+	  mobile devices such as Droid 4.
+
 config CHARGER_ISP1704
 	tristate "ISP1704 USB Charger Detection"
 	depends on USB_PHY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
 obj-$(CONFIG_BATTERY_JZ4740)	+= jz4740-battery.o
 obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
 obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o abx500_chargalg.o pm2301_charger.o
+obj-$(CONFIG_CHARGER_CPCAP)	+= cpcap-charger.o
 obj-$(CONFIG_CHARGER_ISP1704)	+= isp1704_charger.o
 obj-$(CONFIG_CHARGER_MAX8903)	+= max8903_charger.o
 obj-$(CONFIG_CHARGER_TWL4030)	+= twl4030_charger.o
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
new file mode 100644
--- /dev/null
+++ b/drivers/power/supply/cpcap-charger.c
@@ -0,0 +1,681 @@
+/*
+ * Motorola CPCAP PMIC battery charger driver
+ *
+ * Copyright (C) 2017 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
+ *
+ * Rewritten for Linux power framework with some parts based on
+ * on earlier driver found in the Motorola Linux kernel:
+ *
+ * Copyright (C) 2009-2010 Motorola, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/atomic.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/usb/phy_companion.h>
+#include <linux/phy/omap_usb.h>
+#include <linux/usb/otg.h>
+#include <linux/iio/consumer.h>
+#include <linux/mfd/motorola-cpcap.h>
+
+/* CPCAP_REG_CRM register bits */
+#define CPCAP_REG_CRM_UNUSED_641_15	BIT(15)	/* 641 = register number */
+#define CPCAP_REG_CRM_UNUSED_641_14	BIT(14)	/* 641 = register number */
+#define CPCAP_REG_CRM_CHRG_LED_EN	BIT(13)
+#define CPCAP_REG_CRM_RVRSMODE		BIT(12)
+#define CPCAP_REG_CRM_ICHRG_TR1		BIT(11)
+#define CPCAP_REG_CRM_ICHRG_TR0		BIT(10)
+#define CPCAP_REG_CRM_FET_OVRD		BIT(9)
+#define CPCAP_REG_CRM_FET_CTRL		BIT(8)
+#define CPCAP_REG_CRM_VCHRG3		BIT(7)
+#define CPCAP_REG_CRM_VCHRG2		BIT(6)
+#define CPCAP_REG_CRM_VCHRG1		BIT(5)
+#define CPCAP_REG_CRM_VCHRG0		BIT(4)
+#define CPCAP_REG_CRM_ICHRG3		BIT(3)
+#define CPCAP_REG_CRM_ICHRG2		BIT(2)
+#define CPCAP_REG_CRM_ICHRG1		BIT(1)
+#define CPCAP_REG_CRM_ICHRG0		BIT(0)
+
+/* CPCAP_REG_CRM trickle charge voltages */
+#define CPCAP_REG_CRM_TR(val)		(((val) & 0x3) << 10)
+#define CPCAP_REG_CRM_TR_0A00		CPCAP_REG_CRM_TR(0x0)
+#define CPCAP_REG_CRM_TR_0A24		CPCAP_REG_CRM_TR(0x1)
+#define CPCAP_REG_CRM_TR_0A48		CPCAP_REG_CRM_TR(0x2)
+#define CPCAP_REG_CRM_TR_0A72		CPCAP_REG_CRM_TR(0x4)
+
+/* CPCAP_REG_CRM charge voltages */
+#define CPCAP_REG_CRM_VCHRG(val)	(((val) & 0xf) << 4)
+#define CPCAP_REG_CRM_VCHRG_3V80	CPCAP_REG_CRM_VCHRG(0x0)
+#define CPCAP_REG_CRM_VCHRG_4V10	CPCAP_REG_CRM_VCHRG(0x1)
+#define CPCAP_REG_CRM_VCHRG_4V15	CPCAP_REG_CRM_VCHRG(0x2)
+#define CPCAP_REG_CRM_VCHRG_4V20	CPCAP_REG_CRM_VCHRG(0x3)
+#define CPCAP_REG_CRM_VCHRG_4V22	CPCAP_REG_CRM_VCHRG(0x4)
+#define CPCAP_REG_CRM_VCHRG_4V24	CPCAP_REG_CRM_VCHRG(0x5)
+#define CPCAP_REG_CRM_VCHRG_4V26	CPCAP_REG_CRM_VCHRG(0x6)
+#define CPCAP_REG_CRM_VCHRG_4V28	CPCAP_REG_CRM_VCHRG(0x7)
+#define CPCAP_REG_CRM_VCHRG_4V30	CPCAP_REG_CRM_VCHRG(0x8)
+#define CPCAP_REG_CRM_VCHRG_4V32	CPCAP_REG_CRM_VCHRG(0x9)
+#define CPCAP_REG_CRM_VCHRG_4V34	CPCAP_REG_CRM_VCHRG(0xa)
+#define CPCAP_REG_CRM_VCHRG_4V36	CPCAP_REG_CRM_VCHRG(0xb)
+#define CPCAP_REG_CRM_VCHRG_4V38	CPCAP_REG_CRM_VCHRG(0xc)
+#define CPCAP_REG_CRM_VCHRG_4V40	CPCAP_REG_CRM_VCHRG(0xd)
+#define CPCAP_REG_CRM_VCHRG_4V42	CPCAP_REG_CRM_VCHRG(0xe)
+#define CPCAP_REG_CRM_VCHRG_4V44	CPCAP_REG_CRM_VCHRG(0xf)
+
+/* CPCAP_REG_CRM charge currents */
+#define CPCAP_REG_CRM_ICHRG(val)	(((val) & 0xf) << 0)
+#define CPCAP_REG_CRM_ICHRG_0A000	CPCAP_REG_CRM_ICHRG(0x0)
+#define CPCAP_REG_CRM_ICHRG_0A070	CPCAP_REG_CRM_ICHRG(0x1)
+#define CPCAP_REG_CRM_ICHRG_0A176	CPCAP_REG_CRM_ICHRG(0x2)
+#define CPCAP_REG_CRM_ICHRG_0A264	CPCAP_REG_CRM_ICHRG(0x3)
+#define CPCAP_REG_CRM_ICHRG_0A352	CPCAP_REG_CRM_ICHRG(0x4)
+#define CPCAP_REG_CRM_ICHRG_0A440	CPCAP_REG_CRM_ICHRG(0x5)
+#define CPCAP_REG_CRM_ICHRG_0A528	CPCAP_REG_CRM_ICHRG(0x6)
+#define CPCAP_REG_CRM_ICHRG_0A616	CPCAP_REG_CRM_ICHRG(0x7)
+#define CPCAP_REG_CRM_ICHRG_0A704	CPCAP_REG_CRM_ICHRG(0x8)
+#define CPCAP_REG_CRM_ICHRG_0A792	CPCAP_REG_CRM_ICHRG(0x9)
+#define CPCAP_REG_CRM_ICHRG_0A880	CPCAP_REG_CRM_ICHRG(0xa)
+#define CPCAP_REG_CRM_ICHRG_0A968	CPCAP_REG_CRM_ICHRG(0xb)
+#define CPCAP_REG_CRM_ICHRG_1A056	CPCAP_REG_CRM_ICHRG(0xc)
+#define CPCAP_REG_CRM_ICHRG_1A144	CPCAP_REG_CRM_ICHRG(0xd)
+#define CPCAP_REG_CRM_ICHRG_1A584	CPCAP_REG_CRM_ICHRG(0xe)
+#define CPCAP_REG_CRM_ICHRG_NO_LIMIT	CPCAP_REG_CRM_ICHRG(0xf)
+
+enum {
+	CPCAP_CHARGER_IIO_BATTDET,
+	CPCAP_CHARGER_IIO_VOLTAGE,
+	CPCAP_CHARGER_IIO_VBUS,
+	CPCAP_CHARGER_IIO_CHRG_CURRENT,
+	CPCAP_CHARGER_IIO_BATT_CURRENT,
+	CPCAP_CHARGER_IIO_NR,
+};
+
+struct cpcap_charger_ddata {
+	struct device *dev;
+	struct regmap *reg;
+	struct list_head irq_list;
+	struct delayed_work detect_work;
+	struct delayed_work vbus_work;
+	struct gpio_desc *gpio[2];		/* gpio_reven0 & 1 */
+
+	struct iio_channel *channels[CPCAP_CHARGER_IIO_NR];
+
+	struct power_supply *usb;
+
+	struct phy_companion comparator;	/* For USB VBUS */
+	bool vbus_enabled;
+	atomic_t active;
+
+	int status;
+};
+
+struct cpcap_interrupt_desc {
+	int irq;
+	struct list_head node;
+	const char *name;
+};
+
+struct cpcap_charger_ints_state {
+	bool chrg_det;
+	bool rvrs_chrg;
+	bool vbusov;
+
+	bool chrg_se1b;
+	bool rvrs_mode;
+	bool chrgcurr1;
+	bool vbusvld;
+
+	bool battdetb;
+};
+
+static enum power_supply_property cpcap_charger_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+static bool cpcap_charger_battery_found(struct cpcap_charger_ddata *ddata)
+{
+	struct iio_channel *channel;
+	int error, value;
+
+	channel = ddata->channels[CPCAP_CHARGER_IIO_BATTDET];
+	error = iio_read_channel_raw(channel, &value);
+	if (error < 0) {
+		dev_warn(ddata->dev, "%s failed: %i\n", __func__, error);
+
+		return false;
+	}
+
+	return value == 1;
+}
+
+static int cpcap_charger_get_charge_voltage(struct cpcap_charger_ddata *ddata)
+{
+	struct iio_channel *channel;
+	int error, value = 0;
+
+	channel = ddata->channels[CPCAP_CHARGER_IIO_VOLTAGE];
+	error = iio_read_channel_processed(channel, &value);
+	if (error < 0) {
+		dev_warn(ddata->dev, "%s failed: %i\n", __func__, error);
+
+		return 0;
+	}
+
+	return value;
+}
+
+static int cpcap_charger_get_charge_current(struct cpcap_charger_ddata *ddata)
+{
+	struct iio_channel *channel;
+	int error, value = 0;
+
+	channel = ddata->channels[CPCAP_CHARGER_IIO_CHRG_CURRENT];
+	error = iio_read_channel_processed(channel, &value);
+	if (error < 0) {
+		dev_warn(ddata->dev, "%s failed: %i\n", __func__, error);
+
+		return 0;
+	}
+
+	return value;
+}
+
+static int cpcap_charger_get_property(struct power_supply *psy,
+				      enum power_supply_property psp,
+				      union power_supply_propval *val)
+{
+	struct cpcap_charger_ddata *ddata = dev_get_drvdata(psy->dev.parent);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = ddata->status;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (ddata->status == POWER_SUPPLY_STATUS_CHARGING)
+			val->intval = cpcap_charger_get_charge_voltage(ddata) *
+				1000;
+		else
+			val->intval = 0;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (ddata->status == POWER_SUPPLY_STATUS_CHARGING)
+			val->intval = cpcap_charger_get_charge_current(ddata) *
+				1000;
+		else
+			val->intval = 0;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ddata->status == POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void cpcap_charger_set_cable_path(struct cpcap_charger_ddata *ddata,
+					 bool enabled)
+{
+	if (!ddata->gpio[0])
+		return;
+
+	gpiod_set_value(ddata->gpio[0], enabled);
+}
+
+static void cpcap_charger_set_inductive_path(struct cpcap_charger_ddata *ddata,
+					     bool enabled)
+{
+	if (!ddata->gpio[1])
+		return;
+
+	gpiod_set_value(ddata->gpio[1], enabled);
+}
+
+static int cpcap_charger_set_state(struct cpcap_charger_ddata *ddata,
+				   int max_voltage, int charge_current,
+				   int trickle_current)
+{
+	bool enable;
+	int error;
+
+	enable = max_voltage && (charge_current || trickle_current);
+	dev_dbg(ddata->dev, "%s enable: %i\n", __func__, enable);
+
+	if (!enable) {
+		error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM,
+					   0x3fff,
+					   CPCAP_REG_CRM_FET_OVRD |
+					   CPCAP_REG_CRM_FET_CTRL);
+		if (error) {
+			ddata->status = POWER_SUPPLY_STATUS_UNKNOWN;
+			goto out_err;
+		}
+
+		ddata->status = POWER_SUPPLY_STATUS_DISCHARGING;
+
+		return 0;
+	}
+
+	error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM, 0x3fff,
+				   CPCAP_REG_CRM_CHRG_LED_EN |
+				   trickle_current |
+				   CPCAP_REG_CRM_FET_OVRD |
+				   CPCAP_REG_CRM_FET_CTRL |
+				   max_voltage |
+				   charge_current);
+	if (error) {
+		ddata->status = POWER_SUPPLY_STATUS_UNKNOWN;
+		goto out_err;
+	}
+
+	ddata->status = POWER_SUPPLY_STATUS_CHARGING;
+
+	return 0;
+
+out_err:
+	dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
+
+	return error;
+}
+
+static bool cpcap_charger_vbus_valid(struct cpcap_charger_ddata *ddata)
+{
+	int error, value = 0;
+	struct iio_channel *channel =
+		ddata->channels[CPCAP_CHARGER_IIO_VBUS];
+
+	error = iio_read_channel_processed(channel, &value);
+	if (error >= 0)
+		return value > 3900 ? true : false;
+
+	dev_err(ddata->dev, "error reading VBUS: %i\n", error);
+
+	return false;
+}
+
+/* VBUS control functions for the USB PHY companion */
+
+static void cpcap_charger_vbus_work(struct work_struct *work)
+{
+	struct cpcap_charger_ddata *ddata;
+	bool vbus = false;
+	int error;
+
+	ddata = container_of(work, struct cpcap_charger_ddata,
+			     vbus_work.work);
+
+	if (ddata->vbus_enabled) {
+		vbus = cpcap_charger_vbus_valid(ddata);
+		if (vbus) {
+			dev_info(ddata->dev, "VBUS already provided\n");
+
+			return;
+		}
+
+		cpcap_charger_set_cable_path(ddata, false);
+		cpcap_charger_set_inductive_path(ddata, false);
+
+		error = cpcap_charger_set_state(ddata, 0, 0, 0);
+		if (error)
+			goto out_err;
+
+		error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM,
+					   CPCAP_REG_CRM_RVRSMODE,
+					   CPCAP_REG_CRM_RVRSMODE);
+		if (error)
+			goto out_err;
+	} else {
+		error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM,
+					   CPCAP_REG_CRM_RVRSMODE, 0);
+		if (error)
+			goto out_err;
+
+		cpcap_charger_set_cable_path(ddata, true);
+		cpcap_charger_set_inductive_path(ddata, true);
+	}
+
+	return;
+
+out_err:
+	dev_err(ddata->dev, "%s could not %s vbus: %i\n", __func__,
+		ddata->vbus_enabled ? "enable" : "disable", error);
+}
+
+static int cpcap_charger_set_vbus(struct phy_companion *comparator,
+				  bool enabled)
+{
+	struct cpcap_charger_ddata *ddata =
+		container_of(comparator, struct cpcap_charger_ddata,
+			     comparator);
+
+	ddata->vbus_enabled = enabled;
+	schedule_delayed_work(&ddata->vbus_work, 0);
+
+	return 0;
+}
+
+/* Charger interrupt handling functions */
+
+static int cpcap_charger_get_ints_state(struct cpcap_charger_ddata *ddata,
+					struct cpcap_charger_ints_state *s)
+{
+	int val, error;
+
+	error = regmap_read(ddata->reg, CPCAP_REG_INTS1, &val);
+	if (error)
+		return error;
+
+	s->chrg_det = val & BIT(13);
+	s->rvrs_chrg = val & BIT(12);
+	s->vbusov = val & BIT(11);
+
+	error = regmap_read(ddata->reg, CPCAP_REG_INTS2, &val);
+	if (error)
+		return error;
+
+	s->chrg_se1b = val & BIT(13);
+	s->rvrs_mode = val & BIT(6);
+	s->chrgcurr1 = val & BIT(4);
+	s->vbusvld = val & BIT(3);
+
+	error = regmap_read(ddata->reg, CPCAP_REG_INTS4, &val);
+	if (error)
+		return error;
+
+	s->battdetb = val & BIT(6);
+
+	return 0;
+}
+
+static void cpcap_usb_detect(struct work_struct *work)
+{
+	struct cpcap_charger_ddata *ddata;
+	struct cpcap_charger_ints_state s;
+	int error;
+
+	ddata = container_of(work, struct cpcap_charger_ddata,
+			     detect_work.work);
+
+	error = cpcap_charger_get_ints_state(ddata, &s);
+	if (error)
+		return;
+
+	if (cpcap_charger_vbus_valid(ddata) && s.chrgcurr1) {
+		int max_current;
+
+		if (cpcap_charger_battery_found(ddata))
+			max_current = CPCAP_REG_CRM_ICHRG_1A584;
+		else
+			max_current = CPCAP_REG_CRM_ICHRG_0A528;
+
+		error = cpcap_charger_set_state(ddata,
+						CPCAP_REG_CRM_VCHRG_4V20,
+						max_current,
+						CPCAP_REG_CRM_TR_0A72);
+		if (error)
+			goto out_err;
+	} else {
+		error = cpcap_charger_set_state(ddata, 0, 0, 0);
+		if (error)
+			goto out_err;
+	}
+
+	return;
+
+out_err:
+	dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
+}
+
+static irqreturn_t cpcap_charger_irq_thread(int irq, void *data)
+{
+	struct cpcap_charger_ddata *ddata = data;
+
+	if (!atomic_read(&ddata->active))
+		return IRQ_NONE;
+
+	schedule_delayed_work(&ddata->detect_work, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int cpcap_usb_init_irq(struct platform_device *pdev,
+			      struct cpcap_charger_ddata *ddata,
+			      const char *name)
+{
+	struct cpcap_interrupt_desc *d;
+	int irq, error;
+
+	irq = platform_get_irq_byname(pdev, name);
+	if (!irq)
+		return -ENODEV;
+
+	error = devm_request_threaded_irq(ddata->dev, irq, NULL,
+					  cpcap_charger_irq_thread,
+					  IRQF_SHARED,
+					  name, ddata);
+	if (error) {
+		dev_err(ddata->dev, "could not get irq %s: %i\n",
+			name, error);
+
+		return error;
+	}
+
+	d = devm_kzalloc(ddata->dev, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	d->name = name;
+	d->irq = irq;
+	list_add(&d->node, &ddata->irq_list);
+
+	return 0;
+}
+
+static const char * const cpcap_charger_irqs[] = {
+	/* REG_INT_0 */
+	"chrg_det", "rvrs_chrg",
+
+	/* REG_INT1 */
+	"chrg_se1b", "se0conn", "rvrs_mode", "chrgcurr1", "vbusvld",
+
+	/* REG_INT_3 */
+	"battdetb",
+};
+
+static int cpcap_usb_init_interrupts(struct platform_device *pdev,
+				     struct cpcap_charger_ddata *ddata)
+{
+	int i, error;
+
+	for (i = 0; i < ARRAY_SIZE(cpcap_charger_irqs); i++) {
+		error = cpcap_usb_init_irq(pdev, ddata, cpcap_charger_irqs[i]);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
+static void cpcap_charger_init_optional_gpios(struct cpcap_charger_ddata *ddata)
+{
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		ddata->gpio[i] = devm_gpiod_get_index(ddata->dev, "mode",
+						      i, GPIOD_OUT_HIGH);
+		if (IS_ERR(ddata->gpio[i])) {
+			dev_info(ddata->dev, "no mode change GPIO%i: %li\n",
+				 i, PTR_ERR(ddata->gpio[i]));
+				 ddata->gpio[i] = NULL;
+		}
+	}
+}
+
+static int cpcap_charger_init_iio(struct cpcap_charger_ddata *ddata)
+{
+	const char * const names[CPCAP_CHARGER_IIO_NR] = {
+		"battdetb", "battp", "vbus", "chg_isense", "batti",
+	};
+	int error, i;
+
+	for (i = 0; i < CPCAP_CHARGER_IIO_NR; i++) {
+		ddata->channels[i] = devm_iio_channel_get(ddata->dev,
+							  names[i]);
+		if (IS_ERR(ddata->channels[i])) {
+			error = PTR_ERR(ddata->channels[i]);
+			goto out_err;
+		}
+
+		if (!ddata->channels[i]->indio_dev) {
+			error = -ENXIO;
+			goto out_err;
+		}
+	}
+
+	return 0;
+
+out_err:
+	dev_err(ddata->dev, "could not initialize VBUS or ID IIO: %i\n",
+		error);
+
+	return error;
+}
+
+static const struct power_supply_desc cpcap_charger_usb_desc = {
+	.name		= "cpcap_usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.properties	= cpcap_charger_props,
+	.num_properties	= ARRAY_SIZE(cpcap_charger_props),
+	.get_property	= cpcap_charger_get_property,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id cpcap_charger_id_table[] = {
+	{
+		.compatible = "motorola,mapphone-cpcap-charger",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cpcap_charger_id_table);
+#endif
+
+static int cpcap_charger_probe(struct platform_device *pdev)
+{
+	struct cpcap_charger_ddata *ddata;
+	const struct of_device_id *of_id;
+	int error;
+
+	of_id = of_match_device(of_match_ptr(cpcap_charger_id_table),
+				&pdev->dev);
+	if (!of_id)
+		return -EINVAL;
+
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->dev = &pdev->dev;
+
+	ddata->reg = dev_get_regmap(ddata->dev->parent, NULL);
+	if (!ddata->reg)
+		return -ENODEV;
+
+	INIT_LIST_HEAD(&ddata->irq_list);
+	INIT_DELAYED_WORK(&ddata->detect_work, cpcap_usb_detect);
+	INIT_DELAYED_WORK(&ddata->vbus_work, cpcap_charger_vbus_work);
+	platform_set_drvdata(pdev, ddata);
+
+	error = cpcap_charger_init_iio(ddata);
+	if (error)
+		return error;
+
+	atomic_set(&ddata->active, 1);
+
+	ddata->usb = devm_power_supply_register(ddata->dev,
+						&cpcap_charger_usb_desc,
+						NULL);
+	if (IS_ERR(ddata->usb)) {
+		error = PTR_ERR(ddata->usb);
+		dev_err(ddata->dev, "failed to register USB charger: %i\n",
+			error);
+
+		return error;
+	}
+
+	error = cpcap_usb_init_interrupts(pdev, ddata);
+	if (error)
+		return error;
+
+	ddata->comparator.set_vbus = cpcap_charger_set_vbus;
+	error = omap_usb2_set_comparator(&ddata->comparator);
+	if (error == -ENODEV) {
+		dev_info(ddata->dev, "charger needs phy, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
+
+	cpcap_charger_init_optional_gpios(ddata);
+
+	schedule_delayed_work(&ddata->detect_work, 0);
+
+	return 0;
+}
+
+static int cpcap_charger_remove(struct platform_device *pdev)
+{
+	struct cpcap_charger_ddata *ddata = platform_get_drvdata(pdev);
+	int error;
+
+	atomic_set(&ddata->active, 0);
+	error = omap_usb2_set_comparator(NULL);
+	if (error)
+		dev_warn(ddata->dev, "could not clear USB comparator: %i\n",
+			 error);
+
+	error = cpcap_charger_set_state(ddata, 0, 0, 0);
+	if (error)
+		dev_warn(ddata->dev, "could not clear charger: %i\n",
+			 error);
+	cancel_delayed_work_sync(&ddata->vbus_work);
+	cancel_delayed_work_sync(&ddata->detect_work);
+
+	return 0;
+}
+
+static struct platform_driver cpcap_charger_driver = {
+	.probe = cpcap_charger_probe,
+	.driver	= {
+		.name	= "cpcap-charger",
+		.of_match_table = of_match_ptr(cpcap_charger_id_table),
+	},
+	.remove	= cpcap_charger_remove,
+};
+module_platform_driver(cpcap_charger_driver);
+
+MODULE_AUTHOR("Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>");
+MODULE_DESCRIPTION("CPCAP Battery Charger Interface driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cpcap-charger");
-- 
2.12.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
