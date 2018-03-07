From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv3] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on Droid 4
Date: Wed,  7 Mar 2018 06:56:40 -0800
Message-ID: <20180307145640.93867-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
It is used on some Motorola Mapphone series of phones and tablets such
as Droid 4.

The MDM6600 is hardwired to the first OHCI port in the Droid 4 case, and
is controlled by several GPIOs. The USB PHY is integrated into the MDM6600
device it seems. We know this as we get L3 errors from omap-usb-host if
trying to use the PHY before MDM6600 is configured.

The GPIOs controlling MDM6600 are used to power device on and off, to
configure the USB start-up mode (normal mode versus USB flashing), and
they also tell the state of the MDM6600 device.

The two start-up mode GPIOs are dual-purposed and used for out of band
(OOB) wake-up for USB and TS 27.010 serial mux. But we need to configure
the USB start-up mode first to get MDM6600 booted in the right mode to
be usable in the first place.

Note that the Motorola Mapphone Linux kernel tree has a "radio-ctrl"
driver for modems. But it really does not control the radio at all, it
just controls the modem power and start-up mode for USB. So I came to
the conclusion that we're better off having this done in the USB PHY
driver. For adding support for USB flashing mode, we can later on add
a kernel module option for flash_mode=1 or something similar.

Also note that currently there is no PM runtime support for the OHCI
on omap variant SoCs. So for low(er) power idle states, currenty both
ohci-platform and phy-mapphone-mdm6600 must be unloaded or unbound.

For reference here is what I measured for total power consumption on
an idle Droid 4 with and without USB related MDM6600 modules:

idle lcd off	phy-mapphone-mdm6600	ohci-platform
153mW		284mW			344mW

So it seems that MDM6600 is currently not yet idling even with it's
radio turned off, but that's something that is beyond the control of
this USB PHY driver. This patch does get us to the point where modem
data and GPS are usable with libqmi and ModemManager for example.
Voice calls need more audio driver work.

Cc: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v2:
- Dropped OTG as suggested by Kishon
- Added Rob's Reviewed-by

Changes since v1:
- Fixed up issues noticed by Rob and Sebastian
- Implemented wake irq handler (for debug use only for now)
- Improved error handling based on more testing

---
 .../bindings/phy/phy-mapphone-mdm6600.txt          |  30 ++
 drivers/phy/motorola/Kconfig                       |   9 +
 drivers/phy/motorola/Makefile                      |   1 +
 drivers/phy/motorola/phy-mapphone-mdm6600.c        | 549 +++++++++++++++++++++
 4 files changed, 589 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
 create mode 100644 drivers/phy/motorola/phy-mapphone-mdm6600.c

diff --git a/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt b/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
@@ -0,0 +1,30 @@
+Device tree binding documentation for Motorola Mapphone MDM6600 USB PHY
+
+Required properties:
+- compatible		Must be "motorola,mapphone-mdm6600"
+- enable-gpios		GPIO to enable the USB PHY
+- power-gpios		GPIO to power on the device
+- reset-gpios		GPIO to reset the device
+- motorola,mode-gpios	Two GPIOs to configure MDM6600 USB start-up mode for
+			normal mode versus USB flashing mode
+- motorola,cmd-gpios	Three GPIOs to control the power state of the MDM6600
+- motorola,status-gpios	Three GPIOs to read the power state of the MDM6600
+
+Example:
+
+usb-phy {
+	compatible = "motorola,mapphone-mdm6600";
+	enable-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;
+	power-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+	motorola,mode-gpios = <&gpio5 20 GPIO_ACTIVE_HIGH>,
+			      <&gpio5 21 GPIO_ACTIVE_HIGH>;
+	motorola,cmd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>,
+			     <&gpio4 8 GPIO_ACTIVE_HIGH>,
+			     <&gpio5 14 GPIO_ACTIVE_HIGH>;
+	motorola,status-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>,
+				<&gpio2 21 GPIO_ACTIVE_HIGH>,
+				<&gpio2 23 GPIO_ACTIVE_HIGH>;
+	#phy-cells = <0>;
+};
+
diff --git a/drivers/phy/motorola/Kconfig b/drivers/phy/motorola/Kconfig
--- a/drivers/phy/motorola/Kconfig
+++ b/drivers/phy/motorola/Kconfig
@@ -10,3 +10,12 @@ config PHY_CPCAP_USB
 	help
 	  Enable this for USB to work on Motorola phones and tablets
 	  such as Droid 4.
+
+config PHY_MAPPHONE_MDM6600
+	tristate "Motorola Mapphone MDM6600 modem USB PHY driver"
+	depends on OF && USB_SUPPORT
+	select GENERIC_PHY
+	select USB_PHY
+	help
+	  Enable this for MDM6600 USB modem to work on Motorola phones
+	  and tablets such as Droid 4.
diff --git a/drivers/phy/motorola/Makefile b/drivers/phy/motorola/Makefile
--- a/drivers/phy/motorola/Makefile
+++ b/drivers/phy/motorola/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_PHY_CPCAP_USB)		+= phy-cpcap-usb.o
+obj-$(CONFIG_PHY_MAPPHONE_MDM6600)	+= phy-mapphone-mdm6600.o
diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
new file mode 100644
--- /dev/null
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -0,0 +1,549 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Motorola Mapphone MDM6600 modem GPIO controlled USB PHY driver
+ * Copyright (C) 2018 Tony Lindgren <tony@atomide.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/phy_companion.h>
+
+#define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
+#define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
+
+enum phy_mdm6600_ctrl_lines {
+	PHY_MDM6600_ENABLE,			/* USB PHY enable */
+	PHY_MDM6600_POWER,			/* Device power */
+	PHY_MDM6600_RESET,			/* Device reset */
+	PHY_MDM6600_NR_CTRL_LINES,
+};
+
+enum phy_mdm6600_bootmode_lines {
+	PHY_MDM6600_MODE0,			/* out USB mode0 and OOB wake */
+	PHY_MDM6600_MODE1,			/* out USB mode1, in OOB wake */
+	PHY_MDM6600_NR_MODE_LINES,
+};
+
+enum phy_mdm6600_cmd_lines {
+	PHY_MDM6600_CMD0,
+	PHY_MDM6600_CMD1,
+	PHY_MDM6600_CMD2,
+	PHY_MDM6600_NR_CMD_LINES,
+};
+
+enum phy_mdm6600_status_lines {
+	PHY_MDM6600_STATUS0,
+	PHY_MDM6600_STATUS1,
+	PHY_MDM6600_STATUS2,
+	PHY_MDM6600_NR_STATUS_LINES,
+};
+
+/*
+ * MDM6600 command codes. These are based on Motorola Mapphone Linux
+ * kernel tree.
+ */
+enum phy_mdm6600_cmd {
+	PHY_MDM6600_CMD_BP_PANIC_ACK,
+	PHY_MDM6600_CMD_DATA_ONLY_BYPASS,	/* Reroute USB to CPCAP PHY */
+	PHY_MDM6600_CMD_FULL_BYPASS,		/* Reroute USB to CPCAP PHY */
+	PHY_MDM6600_CMD_NO_BYPASS,		/* Request normal USB mode */
+	PHY_MDM6600_CMD_BP_SHUTDOWN_REQ,	/* Request device power off */
+	PHY_MDM6600_CMD_BP_UNKNOWN_5,
+	PHY_MDM6600_CMD_BP_UNKNOWN_6,
+	PHY_MDM6600_CMD_UNDEFINED,
+};
+
+/*
+ * MDM6600 status codes. These are based on Motorola Mapphone Linux
+ * kernel tree.
+ */
+enum phy_mdm6600_status {
+	PHY_MDM6600_STATUS_PANIC,		/* Seems to be really off */
+	PHY_MDM6600_STATUS_PANIC_BUSY_WAIT,
+	PHY_MDM6600_STATUS_QC_DLOAD,
+	PHY_MDM6600_STATUS_RAM_DOWNLOADER,	/* MDM6600 USB flashing mode */
+	PHY_MDM6600_STATUS_PHONE_CODE_AWAKE,	/* MDM6600 normal USB mode */
+	PHY_MDM6600_STATUS_PHONE_CODE_ASLEEP,
+	PHY_MDM6600_STATUS_SHUTDOWN_ACK,
+	PHY_MDM6600_STATUS_UNDEFINED,
+};
+
+static const char * const
+phy_mdm6600_status_name[] = {
+	"off", "busy", "qc_dl", "ram_dl", "awake",
+	"asleep", "shutdown", "undefined",
+};
+
+struct phy_mdm6600 {
+	struct device *dev;
+	struct usb_phy phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct gpio_desc *ctrl_gpios[PHY_MDM6600_NR_CTRL_LINES];
+	struct gpio_descs *mode_gpios;
+	struct gpio_descs *status_gpios;
+	struct gpio_descs *cmd_gpios;
+	struct delayed_work bootup_work;
+	struct delayed_work status_work;
+	struct completion ack;
+	bool enabled;				/* mdm6600 phy enabled */
+	bool running;				/* mdm6600 boot done */
+	int status;
+};
+
+static int phy_mdm6600_init(struct phy *x)
+{
+	struct phy_mdm6600 *ddata = phy_get_drvdata(x);
+	struct gpio_desc *enable_gpio = ddata->ctrl_gpios[PHY_MDM6600_ENABLE];
+
+	if (!ddata->enabled)
+		return -EPROBE_DEFER;
+
+	gpiod_set_value_cansleep(enable_gpio, 0);
+
+	return 0;
+}
+
+static int phy_mdm6600_power_on(struct phy *x)
+{
+	struct phy_mdm6600 *ddata = phy_get_drvdata(x);
+	struct gpio_desc *enable_gpio = ddata->ctrl_gpios[PHY_MDM6600_ENABLE];
+
+	if (!ddata->enabled)
+		return -ENODEV;
+
+	gpiod_set_value_cansleep(enable_gpio, 1);
+
+	return 0;
+}
+
+static int phy_mdm6600_power_off(struct phy *x)
+{
+	struct phy_mdm6600 *ddata = phy_get_drvdata(x);
+	struct gpio_desc *enable_gpio = ddata->ctrl_gpios[PHY_MDM6600_ENABLE];
+
+	if (!ddata->enabled)
+		return -ENODEV;
+
+	gpiod_set_value_cansleep(enable_gpio, 0);
+
+	return 0;
+}
+
+static const struct phy_ops gpio_usb_ops = {
+	.init = phy_mdm6600_init,
+	.power_on = phy_mdm6600_power_on,
+	.power_off = phy_mdm6600_power_off,
+	.owner = THIS_MODULE,
+};
+
+/**
+ * phy_mdm6600_cmd() - send a command request to mdm6600
+ * @ddata: device driver data
+ *
+ * Configures the three command request GPIOs to the specified value.
+ */
+static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
+{
+	int values[PHY_MDM6600_NR_CMD_LINES];
+	int i;
+
+	val &= (1 << PHY_MDM6600_NR_CMD_LINES) - 1;
+	for (i = 0; i < PHY_MDM6600_NR_CMD_LINES; i++)
+		values[i] = (val & BIT(i)) >> i;
+
+	gpiod_set_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
+				       ddata->cmd_gpios->desc, values);
+}
+
+/**
+ * phy_mdm6600_status() - read mdm6600 status lines
+ * @ddata: device driver data
+ */
+static void phy_mdm6600_status(struct work_struct *work)
+{
+	struct phy_mdm6600 *ddata;
+	struct device *dev;
+	int values[PHY_MDM6600_NR_STATUS_LINES];
+	int error, i, val = 0;
+
+	ddata = container_of(work, struct phy_mdm6600, status_work.work);
+	dev = ddata->dev;
+
+	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
+					       ddata->status_gpios->desc,
+					       values);
+	if (error)
+		return;
+
+	for (i = 0; i < PHY_MDM6600_NR_CMD_LINES; i++) {
+		val |= values[i] << i;
+		dev_dbg(ddata->dev, "XXX %s: i: %i values[i]: %i val: %i\n",
+			__func__, i, values[i], val);
+	}
+	ddata->status = val;
+
+	dev_info(dev, "modem status: %i %s\n",
+		 ddata->status,
+		 phy_mdm6600_status_name[ddata->status & 7]);
+	complete(&ddata->ack);
+}
+
+static irqreturn_t phy_mdm6600_irq_thread(int irq, void *data)
+{
+	struct phy_mdm6600 *ddata = data;
+
+	schedule_delayed_work(&ddata->status_work, msecs_to_jiffies(10));
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * phy_mdm6600_wakeirq_thread - handle mode1 line OOB wake after booting
+ * @irq: interrupt
+ * @data: interrupt handler data
+ *
+ * GPIO mode1 is used initially as output to configure the USB boot
+ * mode for mdm6600. After booting it is used as input for OOB wake
+ * signal from mdm6600 to the SoC. Just use it for debug info only
+ * for now.
+ */
+static irqreturn_t phy_mdm6600_wakeirq_thread(int irq, void *data)
+{
+	struct phy_mdm6600 *ddata = data;
+	struct gpio_desc *mode_gpio1;
+
+	mode_gpio1 = ddata->mode_gpios->desc[PHY_MDM6600_MODE1];
+	dev_dbg(ddata->dev, "OOB wake on mode_gpio1: %i\n",
+		gpiod_get_value(mode_gpio1));
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * phy_mdm6600_init_irq() - initialize mdm6600 status IRQ lines
+ * @ddata: device driver data
+ */
+static void phy_mdm6600_init_irq(struct phy_mdm6600 *ddata)
+{
+	struct device *dev = ddata->dev;
+	int i, error, irq;
+
+	for (i = PHY_MDM6600_STATUS0;
+	     i <= PHY_MDM6600_STATUS2; i++) {
+		struct gpio_desc *gpio = ddata->status_gpios->desc[i];
+
+		irq = gpiod_to_irq(gpio);
+		if (irq <= 0)
+			continue;
+
+		error = devm_request_threaded_irq(dev, irq, NULL,
+					phy_mdm6600_irq_thread,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					"mdm6600",
+					ddata);
+		if (error)
+			dev_warn(dev, "no modem status irq%i: %i\n",
+				 irq, error);
+	}
+}
+
+struct phy_mdm6600_map {
+	const char *name;
+	int direction;
+};
+
+static const struct phy_mdm6600_map
+phy_mdm6600_ctrl_gpio_map[PHY_MDM6600_NR_CTRL_LINES] = {
+	{ "enable", GPIOD_OUT_LOW, },		/* low = phy disabled */
+	{ "power", GPIOD_OUT_LOW, },		/* low = off */
+	{ "reset", GPIOD_OUT_HIGH, },		/* high = reset */
+};
+
+/**
+ * phy_mdm6600_init_lines() - initialize mdm6600 GPIO lines
+ * @ddata: device driver data
+ */
+static int phy_mdm6600_init_lines(struct phy_mdm6600 *ddata)
+{
+	struct device *dev = ddata->dev;
+	int i;
+
+	/* MDM6600 control lines */
+	for (i = 0; i < ARRAY_SIZE(phy_mdm6600_ctrl_gpio_map); i++) {
+		const struct phy_mdm6600_map *map =
+			&phy_mdm6600_ctrl_gpio_map[i];
+		struct gpio_desc **gpio = &ddata->ctrl_gpios[i];
+
+		*gpio = devm_gpiod_get(dev, map->name, map->direction);
+		if (IS_ERR(*gpio)) {
+			dev_info(dev, "gpio %s error %li\n",
+				 map->name, PTR_ERR(*gpio));
+			return PTR_ERR(*gpio);
+		}
+	}
+
+	/* MDM6600 USB start-up mode output lines */
+	ddata->mode_gpios = devm_gpiod_get_array(dev, "motorola,mode",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(ddata->mode_gpios))
+		return PTR_ERR(ddata->mode_gpios);
+
+	if (ddata->mode_gpios->ndescs != PHY_MDM6600_NR_MODE_LINES)
+		return -EINVAL;
+
+	/* MDM6600 status input lines */
+	ddata->status_gpios = devm_gpiod_get_array(dev, "motorola,status",
+						   GPIOD_IN);
+	if (IS_ERR(ddata->status_gpios))
+		return PTR_ERR(ddata->status_gpios);
+
+	if (ddata->status_gpios->ndescs != PHY_MDM6600_NR_STATUS_LINES)
+		return -EINVAL;
+
+	/* MDM6600 cmd output lines */
+	ddata->cmd_gpios = devm_gpiod_get_array(dev, "motorola,cmd",
+						GPIOD_OUT_LOW);
+	if (IS_ERR(ddata->cmd_gpios))
+		return PTR_ERR(ddata->cmd_gpios);
+
+	if (ddata->cmd_gpios->ndescs != PHY_MDM6600_NR_CMD_LINES)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * phy_mdm6600_device_power_on() - power on mdm6600 device
+ * @ddata: device driver data
+ *
+ * To get the integrated USB phy in MDM6600 takes some hoops. We must ensure
+ * the shared USB bootmode GPIOs are configured, then request modem start-up,
+ * reset and power-up.. And then we need to recycle the shared USB bootmode
+ * GPIOs as they are also used for Out of Band (OOB) wake for the USB and
+ * TS 27.010 serial mux.
+ */
+static int phy_mdm6600_device_power_on(struct phy_mdm6600 *ddata)
+{
+	struct gpio_desc *mode_gpio0, *mode_gpio1, *reset_gpio, *power_gpio;
+	int error = 0, wakeirq;
+
+	mode_gpio0 = ddata->mode_gpios->desc[PHY_MDM6600_MODE0];
+	mode_gpio1 = ddata->mode_gpios->desc[PHY_MDM6600_MODE1];
+	reset_gpio = ddata->ctrl_gpios[PHY_MDM6600_RESET];
+	power_gpio = ddata->ctrl_gpios[PHY_MDM6600_POWER];
+
+	/*
+	 * Shared GPIOs must be low for normal USB mode. After booting
+	 * they are used for OOB wake signaling. These can be also used
+	 * to configure USB flashing mode later on based on a module
+	 * parameter.
+	 */
+	gpiod_set_value_cansleep(mode_gpio0, 0);
+	gpiod_set_value_cansleep(mode_gpio1, 0);
+
+	/* Request start-up mode */
+	phy_mdm6600_cmd(ddata, PHY_MDM6600_CMD_NO_BYPASS);
+
+	/* Request a reset first */
+	gpiod_set_value_cansleep(reset_gpio, 0);
+	msleep(100);
+
+	/* Toggle power GPIO to request mdm6600 to start */
+	gpiod_set_value_cansleep(power_gpio, 1);
+	msleep(100);
+	gpiod_set_value_cansleep(power_gpio, 0);
+
+	/*
+	 * Looks like the USB PHY needs between 2.2 to 4 seconds.
+	 * If we try to use it before that, we will get L3 errors
+	 * from omap-usb-host trying to access the PHY. See also
+	 * phy_mdm6600_init() for -EPROBE_DEFER.
+	 */
+	msleep(PHY_MDM6600_PHY_DELAY_MS);
+	ddata->enabled = true;
+
+	/* Booting up the rest of MDM6600 will take total about 8 seconds */
+	dev_info(ddata->dev, "Waiting for power up request to complete..\n");
+	if (wait_for_completion_timeout(&ddata->ack,
+			msecs_to_jiffies(PHY_MDM6600_ENABLED_DELAY_MS))) {
+		if (ddata->status > PHY_MDM6600_STATUS_PANIC &&
+		    ddata->status < PHY_MDM6600_STATUS_SHUTDOWN_ACK)
+			dev_info(ddata->dev, "Powered up OK\n");
+	} else {
+		ddata->enabled = false;
+		error = -ETIMEDOUT;
+		dev_err(ddata->dev, "Timed out powering up\n");
+	}
+
+	/* Reconfigure mode1 GPIO as input for OOB wake */
+	gpiod_direction_input(mode_gpio1);
+
+	wakeirq = gpiod_to_irq(mode_gpio1);
+	if (wakeirq <= 0)
+		return wakeirq;
+
+	error = devm_request_threaded_irq(ddata->dev, wakeirq, NULL,
+					  phy_mdm6600_wakeirq_thread,
+					  IRQF_TRIGGER_RISING |
+					  IRQF_TRIGGER_FALLING |
+					  IRQF_ONESHOT,
+					  "mdm6600-wake",
+					  ddata);
+	if (error)
+		dev_warn(ddata->dev, "no modem wakeirq irq%i: %i\n",
+			 wakeirq, error);
+
+	ddata->running = true;
+
+	return error;
+}
+
+/**
+ * phy_mdm6600_device_power_off() - power off mdm6600 device
+ * @ddata: device driver data
+ */
+static void phy_mdm6600_device_power_off(struct phy_mdm6600 *ddata)
+{
+	struct gpio_desc *reset_gpio =
+		ddata->ctrl_gpios[PHY_MDM6600_RESET];
+
+	ddata->enabled = false;
+	phy_mdm6600_cmd(ddata, PHY_MDM6600_CMD_BP_SHUTDOWN_REQ);
+	msleep(100);
+
+	gpiod_set_value_cansleep(reset_gpio, 1);
+
+	dev_info(ddata->dev, "Waiting for power down request to complete.. ");
+	if (wait_for_completion_timeout(&ddata->ack,
+					msecs_to_jiffies(5000))) {
+		if (ddata->status == PHY_MDM6600_STATUS_PANIC)
+			dev_info(ddata->dev, "Powered down OK\n");
+	} else {
+		dev_err(ddata->dev, "Timed out powering down\n");
+	}
+}
+
+static void phy_mdm6600_deferred_power_on(struct work_struct *work)
+{
+	struct phy_mdm6600 *ddata;
+	int error;
+
+	ddata = container_of(work, struct phy_mdm6600, bootup_work.work);
+
+	error = phy_mdm6600_device_power_on(ddata);
+	if (error)
+		dev_err(ddata->dev, "Device not functional\n");
+}
+
+static const struct of_device_id phy_mdm6600_id_table[] = {
+	{ .compatible = "motorola,mapphone-mdm6600", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, phy_mdm6600_id_table);
+
+static int phy_mdm6600_probe(struct platform_device *pdev)
+{
+	struct phy_mdm6600 *ddata;
+	int error;
+
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&ddata->bootup_work,
+			  phy_mdm6600_deferred_power_on);
+	INIT_DELAYED_WORK(&ddata->status_work, phy_mdm6600_status);
+	init_completion(&ddata->ack);
+
+	ddata->dev = &pdev->dev;
+	ddata->phy.dev = ddata->dev;
+	ddata->phy.label = "phy_mdm6600";
+	ddata->phy.type = USB_PHY_TYPE_USB2;
+
+	platform_set_drvdata(pdev, ddata);
+
+	error = phy_mdm6600_init_lines(ddata);
+	if (error)
+		return error;
+
+	phy_mdm6600_init_irq(ddata);
+
+	ddata->generic_phy = devm_phy_create(ddata->dev, NULL, &gpio_usb_ops);
+	if (IS_ERR(ddata->generic_phy)) {
+		error = PTR_ERR(ddata->generic_phy);
+		goto cleanup;
+	}
+
+	phy_set_drvdata(ddata->generic_phy, ddata);
+
+	ddata->phy_provider =
+		devm_of_phy_provider_register(ddata->dev,
+					      of_phy_simple_xlate);
+	if (IS_ERR(ddata->phy_provider)) {
+		error = PTR_ERR(ddata->phy_provider);
+		goto cleanup;
+	}
+
+	schedule_delayed_work(&ddata->bootup_work, 0);
+
+	/*
+	 * See phy_mdm6600_device_power_on(). We should be able
+	 * to remove this eventually when ohci-platform can deal
+	 * with -EPROBE_DEFER.
+	 */
+	msleep(PHY_MDM6600_PHY_DELAY_MS + 500);
+
+	usb_add_phy_dev(&ddata->phy);
+
+	return 0;
+
+cleanup:
+	phy_mdm6600_device_power_off(ddata);
+	return error;
+}
+
+static int phy_mdm6600_remove(struct platform_device *pdev)
+{
+	struct phy_mdm6600 *ddata = platform_get_drvdata(pdev);
+	struct gpio_desc *reset_gpio = ddata->ctrl_gpios[PHY_MDM6600_RESET];
+
+	if (!ddata->running)
+		wait_for_completion_timeout(&ddata->ack,
+			msecs_to_jiffies(PHY_MDM6600_ENABLED_DELAY_MS));
+
+	gpiod_set_value_cansleep(reset_gpio, 1);
+	phy_mdm6600_device_power_off(ddata);
+
+	cancel_delayed_work_sync(&ddata->bootup_work);
+	cancel_delayed_work_sync(&ddata->status_work);
+
+	return 0;
+}
+
+static struct platform_driver phy_mdm6600_driver = {
+	.probe = phy_mdm6600_probe,
+	.remove = phy_mdm6600_remove,
+	.driver = {
+		.name = "phy-mapphone-mdm6600",
+		.of_match_table = of_match_ptr(phy_mdm6600_id_table),
+	},
+};
+
+module_platform_driver(phy_mdm6600_driver);
+
+MODULE_ALIAS("platform:gpio_usb");
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
+MODULE_DESCRIPTION("mdm6600 gpio usb phy driver");
+MODULE_LICENSE("GPL v2");
-- 
2.16.2
