From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 2/3] power_supply: Add support for tps65217-charger.
Date: Tue,  8 Sep 2015 10:09:38 +0200
Message-ID: <1441699779-22189-3-git-send-email-enric.balletbo@collabora.com>
References: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, tony@atomide.com, sameo@linux.intel.com, lee.jones@linaro.org, sjoerd.simons@collabora.co.uk, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

This patch adds support for the tps65217 charger driver. This driver is
responsible for controlling the charger aspect of the tps65217 mfd.
Currently, this mainly consists of turning on and off the charger, but
some other features of the charger can be supported through this driver=
=2E

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/power/Kconfig            |   7 +
 drivers/power/Makefile           |   1 +
 drivers/power/tps65217_charger.c | 269 +++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 drivers/power/tps65217_charger.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index f8758d6..57fdc80 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -434,6 +434,13 @@ config CHARGER_TPS65090
 	 Say Y here to enable support for battery charging with TPS65090
 	 PMIC chips.
=20
+config CHARGER_TPS65217
+	tristate "TPS65217 battery charger driver"
+	depends on MFD_TPS65217
+	help
+	 Say Y here to enable support for battery charging with TPS65217
+	 PMIC chips.
+
 config BATTERY_GAUGE_LTC2941
 	tristate "LTC2941/LTC2943 Battery Gauge Driver"
 	depends on I2C
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 5752ce8..c1409b3 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
 obj-$(CONFIG_POWER_AVS)		+=3D avs/
 obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
 obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
+obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
 obj-$(CONFIG_POWER_RESET)	+=3D reset/
 obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
 obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
diff --git a/drivers/power/tps65217_charger.c b/drivers/power/tps65217_=
charger.c
new file mode 100644
index 0000000..0b6a30d
--- /dev/null
+++ b/drivers/power/tps65217_charger.c
@@ -0,0 +1,269 @@
+/*
+ * Battery charger driver for TI's tps65217
+ *
+ * Copyright (c) 2015, Collabora Ltd.
+
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+
+ * This program is distributed in the hope it will be useful, but WITH=
OUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
+ * more details.
+
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
+ */
+
+/*
+ * Battery charger driver for TI's tps65217
+ */
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/power_supply.h>
+
+#include <linux/mfd/core.h>
+#include <linux/mfd/tps65217.h>
+
+#define POLL_INTERVAL		(HZ * 2)
+
+struct tps65217_charger {
+	struct tps65217 *tps;
+	struct device *dev;
+	struct power_supply *ac;
+
+	int	ac_online;
+	int	prev_ac_online;
+
+	struct task_struct	*poll_task;
+};
+
+static enum power_supply_property tps65217_ac_props[] =3D {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static int tps65217_config_charger(struct tps65217_charger *charger)
+{
+	int ret;
+
+	dev_dbg(charger->dev, "%s\n", __func__);
+
+	/*
+	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
+	 *
+	 * The device can be configured to support a 100k NTC (B =3D 3960) by
+	 * setting the the NTC_TYPE bit in register CHGCONFIG1 to 1. However =
it
+	 * is not recommended to do so. In sleep mode, the charger continues
+	 * charging the battery, but all register values are reset to default
+	 * values. Therefore, the charger would get the wrong temperature
+	 * information. If 100k NTC setting is required, please contact the
+	 * factory.
+	 *
+	 * ATTENTION, conflicting information, from p. 46
+	 *
+	 * NTC TYPE (for battery temperature measurement)
+	 *   0 =E2=80=93 100k (curve 1, B =3D 3960)
+	 *   1 =E2=80=93 10k  (curve 2, B =3D 3480) (default on reset)
+	 *
+	 */
+	ret =3D tps65217_clear_bits(charger->tps, TPS65217_REG_CHGCONFIG1,
+			TPS65217_CHGCONFIG1_NTC_TYPE,
+			TPS65217_PROTECT_NONE);
+	if (ret) {
+		dev_err(charger->dev,
+			"failed to set 100k NTC setting: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tps65217_enable_charging(struct tps65217_charger *charger)
+{
+	int ret;
+
+	/* charger already enabled */
+	if (charger->ac_online)
+		return 0;
+
+	dev_dbg(charger->dev, "%s: enable charging\n", __func__);
+	ret =3D tps65217_set_bits(charger->tps, TPS65217_REG_CHGCONFIG1,
+			TPS65217_CHGCONFIG1_CHG_EN,
+			TPS65217_CHGCONFIG1_CHG_EN,
+			TPS65217_PROTECT_NONE);
+	if (ret) {
+		dev_err(charger->dev,
+			"%s: Error in writing CHG_EN in reg 0x%x: %d\n",
+			__func__, TPS65217_REG_CHGCONFIG1, ret);
+		return ret;
+	}
+
+	charger->ac_online =3D 1;
+
+	return 0;
+}
+
+static int tps65217_ac_get_property(struct power_supply *psy,
+			enum power_supply_property psp,
+			union power_supply_propval *val)
+{
+	struct tps65217_charger *charger =3D power_supply_get_drvdata(psy);
+
+	if (psp =3D=3D POWER_SUPPLY_PROP_ONLINE) {
+		val->intval =3D charger->ac_online;
+		charger->prev_ac_online =3D charger->ac_online;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static irqreturn_t tps65217_charger_irq(int irq, void *dev)
+{
+	int ret, val;
+	struct tps65217_charger *charger =3D dev;
+
+	ret =3D tps65217_reg_read(charger->tps, TPS65217_REG_STATUS, &val);
+	if (ret < 0) {
+		dev_err(charger->dev, "%s: Error in reading reg 0x%x\n",
+				__func__, TPS65217_REG_STATUS);
+		return IRQ_HANDLED;
+	}
+
+	dev_dbg(charger->dev, "%s: 0x%x\n", __func__, val);
+
+	/* check for AC status bit */
+	if (val & TPS65217_STATUS_ACPWR) {
+		ret =3D tps65217_enable_charging(charger);
+		if (ret) {
+			dev_err(charger->dev,
+				"failed to enable charger: %d\n", ret);
+			return IRQ_HANDLED;
+		}
+	} else
+		charger->ac_online =3D 0;
+
+	if (charger->prev_ac_online !=3D charger->ac_online)
+		power_supply_changed(charger->ac);
+
+
+	ret =3D tps65217_reg_read(charger->tps, TPS65217_REG_CHGCONFIG0, &val=
);
+	if (ret < 0) {
+		dev_err(charger->dev, "%s: Error in reading reg 0x%x\n",
+				__func__, TPS65217_REG_CHGCONFIG0);
+		return IRQ_HANDLED;
+	}
+
+	if (val & TPS65217_CHGCONFIG0_ACTIVE)
+		dev_dbg(charger->dev, "%s: charger is charging\n", __func__);
+	else
+		dev_dbg(charger->dev,
+			"%s: charger is NOT charging\n", __func__);
+
+	return IRQ_HANDLED;
+}
+
+static int tps65217_charger_poll_task(void *data)
+{
+	set_freezable();
+
+	while (!kthread_should_stop()) {
+		schedule_timeout_interruptible(POLL_INTERVAL);
+		try_to_freeze();
+		tps65217_charger_irq(-1, data);
+	}
+	return 0;
+}
+
+static const struct power_supply_desc tps65217_charger_desc =3D {
+	.name			=3D "tps65217-ac",
+	.type			=3D POWER_SUPPLY_TYPE_MAINS,
+	.get_property		=3D tps65217_ac_get_property,
+	.properties		=3D tps65217_ac_props,
+	.num_properties		=3D ARRAY_SIZE(tps65217_ac_props),
+};
+
+static int tps65217_charger_probe(struct platform_device *pdev)
+{
+	struct tps65217 *tps =3D dev_get_drvdata(pdev->dev.parent);
+	struct tps65217_charger *charger;
+	int ret;
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
+	if (charger =3D=3D NULL)
+		return -ENOMEM;
+
+	charger->tps =3D tps;
+	charger->dev =3D &pdev->dev;
+
+	charger->ac =3D power_supply_register(&pdev->dev,
+					&tps65217_charger_desc, NULL);
+	if (IS_ERR(charger->ac)) {
+		dev_err(&pdev->dev, "failed: power supply register\n");
+		return PTR_ERR(charger->ac);
+	}
+
+	ret =3D tps65217_config_charger(charger);
+	if (ret < 0) {
+		dev_err(charger->dev, "charger config failed, err %d\n", ret);
+		goto fail_unregister_supply;
+	}
+
+	charger->poll_task =3D kthread_run(tps65217_charger_poll_task,
+				      charger, "ktps65217charger");
+	if (IS_ERR(charger->poll_task)) {
+		ret =3D PTR_ERR(charger->poll_task);
+		dev_err(charger->dev, "Unable to run kthread err %d\n", ret);
+		goto fail_unregister_supply;
+	}
+
+	return 0;
+
+fail_unregister_supply:
+	power_supply_unregister(charger->ac);
+
+	return ret;
+}
+
+static int tps65217_charger_remove(struct platform_device *pdev)
+{
+	struct tps65217_charger *charger =3D platform_get_drvdata(pdev);
+
+	kthread_stop(charger->poll_task);
+
+	power_supply_unregister(charger->ac);
+
+	return 0;
+}
+
+static const struct of_device_id tps65217_charger_match_table[] =3D {
+	{ .compatible =3D "ti,tps65217-charger", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tps65217_charger_match_table);
+
+static struct platform_driver tps65217_charger_driver =3D {
+	.probe	=3D tps65217_charger_probe,
+	.remove =3D tps65217_charger_remove,
+	.driver	=3D {
+		.name	=3D "tps65217-charger",
+		.of_match_table =3D of_match_ptr(tps65217_charger_match_table),
+	},
+
+};
+module_platform_driver(tps65217_charger_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Enric Balletbo Serra <enric.balletbo@collabora.com>");
+MODULE_DESCRIPTION("TPS65217 battery charger driver");
--=20
2.1.0
