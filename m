From: Pavel Machek <pavel@ucw.cz>
Subject: [crazy hacks] N900 flashlight
Date: Fri, 15 Sep 2017 10:46:04 +0200
Message-ID: <20170915084604.GA9858@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
Cc: jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This adds /sys interface to n900 flash. So you can do stuff...

/sys/class/leds/led-controller:flash# echo 0 > ../led-controller\:indicator=
/brightness

Needs _way_ more work. Also... contains way too much boilerplate, see
leds-flash.c . We'll need to figure out how to share more code between
drivers.

GPL.

Best regards,

									Pavel

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n90=
0.dts
index c4e8de7..1b88494 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -618,16 +618,21 @@
 	};
=20
 	adp1653: led-controller@30 {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+=09
 		compatible =3D "adi,adp1653";
 		reg =3D <0x30>;
 		enable-gpios =3D <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
=20
-		flash {
+		adp_flash: flash@0 {
+		        reg =3D <0x0>;
 			flash-timeout-us =3D <500000>;
 			flash-max-microamp =3D <320000>;
 			led-max-microamp =3D <50000>;
 		};
-		indicator {
+		adp_indicator: indicator@1 {
+		        reg =3D <0x1>;
 			led-max-microamp =3D <17500>;
 		};
 	};
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index b7af41e..78bbcbf 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -7,6 +7,9 @@ obj-$(CONFIG_LEDS_CLASS)		+=3D led-class.o
 obj-$(CONFIG_LEDS_CLASS_FLASH)		+=3D led-class-flash.o
 obj-$(CONFIG_LEDS_TRIGGERS)		+=3D led-triggers.o
=20
+obj-$(CONFIG_LEDS_CLASS_FLASH) 		+=3D leds-flash.o
+obj-y					+=3D leds-adp1653.o
+
 # LED Platform Drivers
 obj-$(CONFIG_LEDS_88PM860X)		+=3D leds-88pm860x.o
 obj-$(CONFIG_LEDS_AAT1290)		+=3D leds-aat1290.o
diff --git a/drivers/leds/leds-adp1653.c b/drivers/leds/leds-adp1653.c
new file mode 100644
index 0000000..96444a7
--- /dev/null
+++ b/drivers/leds/leds-adp1653.c
@@ -0,0 +1,756 @@
+/*
+ * Example of i2c flash LED driver
+ *
+ * Copyright (c) 2008-2011 Nokia Corporation
+ * Copyright (c) 2011, 2017 Intel Corporation
+ * Copyright (c) 2017 Pavel Machek <pavel@ucw.cz>
+ *
+ * Based on drivers/media/i2c/, by Sakari Ailus <sakari.ailus@iki.fi>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#define DEBUG
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/led-class-flash.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <media/i2c/adp1653.h>
+
+#include <media/v4l2-flash-led-class.h>
+
+/* LED numbers for Devicetree */
+#define AS_LED_FLASH		0
+#define AS_LED_INDICATOR	1
+
+enum as_mode {
+	AS_MODE_EXT_TORCH =3D 0,
+	AS_MODE_INDICATOR =3D 1,
+	AS_MODE_ASSIST =3D 2,
+	AS_MODE_FLASH =3D 3,
+	AS_MODE_OFF =3D 4,
+};
+
+struct fl_config {
+	u32 flash_timeout_us;
+	u32 flash_max_ua;
+	u32 assist_max_ua;
+	u32 indicator_max_ua;
+	u32 voltage_reference;
+	u32 peak;
+};
+
+struct fl_names {
+	char flash[32];
+	char indicator[32];
+};
+
+struct fl {
+	struct i2c_client *client;
+
+	struct mutex mutex;
+
+	struct led_classdev_flash fled;
+	struct led_classdev iled_cdev;
+
+	struct v4l2_flash *vf;
+	struct v4l2_flash *vfind;
+
+	struct fwnode_handle *flash_node;
+	struct fwnode_handle *indicator_node;
+
+	struct fl_config cfg;
+
+	enum as_mode mode;
+	unsigned int timeout;
+	unsigned int flash_current;
+	unsigned int assist_current;
+	unsigned int indicator_current;
+	enum v4l2_flash_strobe_source strobe_source;
+
+	int indicator_intensity_min;
+	int indicator_intensity_step;
+	int torch_intensity_min;
+	int torch_intensity_step;
+	int flash_intensity_min;
+	int flash_intensity_step;
+	int flash_timeout_min;
+	int flash_timeout_step;
+
+	int fault;
+	struct gpio_desc *enable_gpio;
+};
+
+#define fled_to_fl(__fled) container_of(__fled, struct fl, fled)
+#define iled_cdev_to_fl(__iled_cdev) \
+	container_of(__iled_cdev, struct fl, iled_cdev)
+
+/* Return negative errno else zero on success */
+static int fl_write(struct fl *flash, u8 addr, u8 val)
+{
+	struct i2c_client *client =3D flash->client;
+	int rval;
+
+	rval =3D i2c_smbus_write_byte_data(client, addr, val);
+
+	dev_dbg(&client->dev, "Write Addr:%02X Val:%02X %s\n", addr, val,
+		rval < 0 ? "fail" : "ok");
+
+	return rval;
+}
+
+/* Return negative errno else a data byte received from the device. */
+static int fl_read(struct fl *flash, u8 addr)
+{
+	struct i2c_client *client =3D flash->client;
+	int rval;
+
+	rval =3D i2c_smbus_read_byte_data(client, addr);
+
+	dev_dbg(&client->dev, "Read Addr:%02X Val:%02X %s\n", addr, rval,
+		rval < 0 ? "fail" : "ok");
+
+	return rval;
+}
+
+/* -----------------------------------------------------------------------=
------
+ * Hardware configuration and trigger
+ */
+
+#define TIMEOUT_MAX		820000
+#define TIMEOUT_STEP		54600
+#define TIMEOUT_MIN		(TIMEOUT_MAX - ADP1653_REG_CONFIG_TMR_SET_MAX \
+				 * TIMEOUT_STEP)
+#define TIMEOUT_US_TO_CODE(t)	((TIMEOUT_MAX + (TIMEOUT_STEP / 2) - (t)) \
+				 / TIMEOUT_STEP)
+#define TIMEOUT_CODE_TO_US(c)	(TIMEOUT_MAX - (c) * TIMEOUT_STEP)
+
+/* Write values into ADP1653 registers. */
+static int adp1653_update_hw(struct fl *flash)
+{
+	struct i2c_client *client =3D flash->client;
+	u8 out_sel;
+	u8 config =3D 0;
+	int rval;
+
+	printk("Using current %d uA, indicator %d uA, assist %d uA\n",
+	       flash->flash_current, flash->indicator_current, flash->assist_curr=
ent);
+	if (flash->flash_current > 100000)
+		flash->flash_current =3D 100000;
+	if (flash->indicator_current > ADP1653_REG_OUT_SEL_ILED_MAX)
+		flash->indicator_current =3D ADP1653_REG_OUT_SEL_ILED_MAX;
+	if (flash->assist_current > ADP1653_REG_OUT_SEL_HPLED_TORCH_MAX)
+		flash->assist_current =3D ADP1653_REG_OUT_SEL_HPLED_TORCH_MAX;
+	out_sel =3D flash->indicator_current << ADP1653_REG_OUT_SEL_ILED_SHIFT;
+
+	/* FIXME: use flash current somewhere? :-) */
+
+	switch (flash->mode) {
+	case AS_MODE_OFF:
+		break;
+	case AS_MODE_FLASH:
+		printk("mode: flash\n");
+#if 0
+		/* Flash mode, light on with strobe, duration from timer */
+		config =3D ADP1653_REG_CONFIG_TMR_CFG;
+		config |=3D TIMEOUT_US_TO_CODE(flash->flash_timeout->val)
+			  << ADP1653_REG_CONFIG_TMR_SET_SHIFT;
+		break;
+#endif
+	case AS_MODE_EXT_TORCH:
+		printk("mode: torch\n");
+	case AS_MODE_INDICATOR:
+		printk("mode: indicator\n");
+	case AS_MODE_ASSIST:
+		printk("mode: assist\n");	=09
+		/* Torch mode, light immediately on, duration indefinite */
+		if (flash->assist_current)
+			out_sel |=3D flash->assist_current << ADP1653_REG_OUT_SEL_HPLED_SHIFT;
+		break;
+	}
+
+	rval =3D fl_write(flash, ADP1653_REG_OUT_SEL, out_sel);
+	if (rval < 0)
+		return rval;
+
+	rval =3D fl_write(flash, ADP1653_REG_CONFIG, config);
+	if (rval < 0)
+		return rval;
+
+	return 0;
+}
+
+/**
+ * fl_set_config - Set flash configuration registers
+ * @flash: The flash
+ *
+ * Configure the hardware with flash, assist and indicator currents, as we=
ll as
+ * flash timeout.
+ *
+ * Return 0 on success, or a negative error code if an I2C communication e=
rror
+ * occurred.
+ */
+
+/**
+ * fl_set_control - Set flash control register
+ * @flash: The flash
+ * @mode: Desired output mode
+ * @on: Desired output state
+ *
+ * Configure the hardware with output mode and state.
+ *
+ * Return 0 on success, or a negative error code if an I2C communication e=
rror
+ * occurred.
+ */
+
+static int __fl_get_fault(struct fl *flash, u32 *_fault)
+{
+	u32 fault;
+	int rval;
+
+	fault =3D fl_read(flash, ADP1653_REG_FAULT);
+	if (fault < 0)
+		return fault;
+
+	flash->fault |=3D fault;
+
+	if (!flash->fault)
+		return 0;
+
+	/* Clear faults. */
+	rval =3D fl_write(flash, ADP1653_REG_OUT_SEL, 0);
+	if (rval < 0)
+		return rval;
+
+	printk("Flash: fault %lx\n", fault);
+	*_fault =3D fault;
+	flash->mode =3D AS_MODE_OFF;
+
+	rval =3D adp1653_update_hw(flash);
+	if (rval)
+		return rval;
+
+	return flash->fault;
+}
+
+static int fl_get_fault(struct led_classdev_flash *fled, u32 *fault)
+{
+	struct fl *flash =3D fled_to_fl(fled);
+
+	return __fl_get_fault(flash, fault);
+}
+
+static unsigned int __fl_current_to_reg(unsigned int min, unsigned int max,
+					     unsigned int step,
+					     unsigned int val)
+{
+	if (val < min)
+		val =3D min;
+
+	if (val > max)
+		val =3D max;
+
+	return (val - min) / step;
+}
+
+static unsigned int fl_current_to_reg(struct fl *flash, bool is_flash,
+					   unsigned int ua)
+{
+	if (is_flash)
+		return __fl_current_to_reg(flash->torch_intensity_min,
+						flash->cfg.assist_max_ua,
+						flash->torch_intensity_step, ua);
+	else
+		return __fl_current_to_reg(flash->flash_intensity_min,
+						flash->cfg.flash_max_ua,
+						flash->flash_intensity_step, ua);
+}
+
+static int fl_set_indicator_brightness(struct led_classdev *iled_cdev,
+					    enum led_brightness brightness)
+{
+	struct fl *flash =3D iled_cdev_to_fl(iled_cdev);
+	int rval;
+
+	flash->indicator_current =3D brightness;
+	flash->mode =3D AS_MODE_INDICATOR;
+
+	return adp1653_update_hw(flash);
+}
+
+static int fl_set_assist_brightness(struct led_classdev *fled_cdev,
+					 enum led_brightness brightness)
+{
+	struct led_classdev_flash *fled =3D lcdev_to_flcdev(fled_cdev);
+	struct fl *flash =3D fled_to_fl(fled);
+	int rval;
+
+=09
+	flash->assist_current =3D brightness;
+	flash->mode =3D AS_MODE_ASSIST;
+
+	return adp1653_update_hw(flash);=09
+}
+
+static int fl_set_flash_brightness(struct led_classdev_flash *fled,
+					u32 brightness_ua)
+{
+	struct fl *flash =3D fled_to_fl(fled);
+
+	printk("set_flash_brightness: %d uA, %d\n", brightness_ua, fled->brightne=
ss);
+
+	flash->flash_current =3D brightness_ua;
+
+	return adp1653_update_hw(flash);=09
+}
+
+static int fl_set_flash_timeout(struct led_classdev_flash *fled,
+				     u32 timeout_us)
+{
+	struct fl *flash =3D fled_to_fl(fled);
+
+	flash->timeout =3D 0; // FIXME AS_TIMER_US_TO_CODE(timeout_us);
+	return adp1653_update_hw(flash);=09
+}
+
+static int fl_set_strobe(struct led_classdev_flash *fled, bool state)
+{
+	struct fl *flash =3D fled_to_fl(fled);
+
+	flash->mode =3D AS_MODE_FLASH;
+	return adp1653_update_hw(flash);=09
+}
+
+static const struct led_flash_ops fl_led_flash_ops =3D {
+	.flash_brightness_set =3D fl_set_flash_brightness,
+	.timeout_set =3D fl_set_flash_timeout,
+	.strobe_set =3D fl_set_strobe,
+	.fault_get =3D fl_get_fault,
+};
+
+static int fl_setup(struct fl *flash)
+{
+	struct device *dev =3D &flash->client->dev;
+	u32 fault =3D 0;
+	int rval;
+
+	/* clear errors */
+	rval =3D __fl_get_fault(flash, &fault);
+	if (rval < 0)
+		return rval;
+
+	dev_dbg(dev, "Fault info: %02x\n", rval);
+
+	flash->mode =3D AS_MODE_OFF;
+
+	rval =3D adp1653_update_hw(flash);
+	if (rval < 0)
+		return rval;
+
+	/* read status */
+	rval =3D fl_get_fault(&flash->fled, &fault);
+	if (rval < 0)
+		return rval;
+
+	return rval ? -EIO : 0;
+}
+
+static int
+adp1653_init_device(struct fl *flash)
+{
+	struct i2c_client *client =3D flash->client;
+	int rval;
+
+	/* Clear FAULT register by writing zero to OUT_SEL */
+	rval =3D fl_write(flash, ADP1653_REG_OUT_SEL, 0);
+	if (rval < 0) {
+		dev_err(&client->dev, "failed writing fault register\n");
+		return -EIO;
+	}
+
+	/* Reset faults before reading new ones. */
+	flash->fault =3D 0;
+	return 0;
+}
+
+static int fl_test(struct fl *flash)
+{
+	int i;
+	flash->flash_current =3D 0;
+	for (i =3D 0; i<100; i++) {
+		flash->assist_current =3D i*100;
+		flash->mode =3D AS_MODE_ASSIST;
+		adp1653_update_hw(flash);
+		mdelay(50);
+	}
+	flash->mode =3D AS_MODE_OFF;
+	adp1653_update_hw(flash);
+=09
+}
+
+
+static int fl_detect(struct fl *flash)
+{
+	struct device *dev =3D &flash->client->dev;
+	int rval, man, model, rfu, version;
+	const char *vendor;
+	u32 fault;
+
+	rval =3D adp1653_init_device(flash);
+	if (rval)
+		return rval;
+
+	printk("flash: testing\n");
+	fl_test(flash);
+	printk("flash: test done\n");=09
+
+	rval =3D __fl_get_fault(flash, &fault);
+	return rval;
+}
+
+static int fl_parse_node(struct fl *flash,
+			      struct fl_names *names,
+			      struct fwnode_handle *fwnode)
+{
+	struct fl_config *cfg =3D &flash->cfg;
+	struct fwnode_handle *child;
+	const char *name;
+	const char *str;
+	int rval;
+	int on =3D 1;
+
+	flash->enable_gpio =3D devm_gpiod_get(&flash->client->dev, "enable", GPIO=
D_OUT_LOW);
+	if (IS_ERR(flash->enable_gpio)) {
+		dev_err(&flash->client->dev, "Error getting GPIO\n");
+		return PTR_ERR(flash->enable_gpio);
+	}
+
+	gpiod_set_value(flash->enable_gpio, on);
+	if (on)
+		/* Some delay is apparently required. */
+		udelay(20);
+=09
+	fwnode_for_each_child_node(fwnode, child) {
+		u32 id =3D 0;
+
+		fwnode_property_read_u32(
+			child, is_of_node(child) ? "reg" : "led", &id);
+
+		switch (id) {
+		case AS_LED_FLASH:
+			flash->flash_node =3D child;
+			break;
+		case AS_LED_INDICATOR:
+			flash->indicator_node =3D child;
+			break;
+		default:
+			dev_warn(&flash->client->dev,
+				 "unknown LED %u encountered, ignoring\n", id);
+			break;
+		}
+		fwnode_handle_get(child);
+	}
+
+	if (!flash->flash_node) {
+		dev_err(&flash->client->dev, "can't find flash node\n");
+		return -ENODEV;
+	}
+
+	rval =3D fwnode_property_read_string(flash->flash_node, "label", &name);
+	if (!rval) {
+		strlcpy(names->flash, name, sizeof(names->flash));
+	} else if (is_of_node(fwnode)) {
+		snprintf(names->flash, sizeof(names->flash),
+			 "%s:flash", to_of_node(fwnode)->name);
+	} else {
+		dev_err(&flash->client->dev, "flash node has no label!\n");
+		return -EINVAL;
+	}
+
+	rval =3D fwnode_property_read_u32(flash->flash_node, "flash-timeout-us",
+				    &cfg->flash_timeout_us);
+	if (rval < 0) {
+		dev_err(&flash->client->dev,
+			"can't read flash-timeout-us property for flash\n");
+		cfg->flash_timeout_us =3D 1;
+		//goto out_err;
+	}
+
+	rval =3D fwnode_property_read_u32(flash->flash_node, "flash-max-microamp",
+				    &cfg->flash_max_ua);
+	if (rval < 0) {
+		dev_err(&flash->client->dev,
+			"can't read flash-max-microamp property for flash\n");
+		cfg->flash_max_ua =3D 1;
+		//goto out_err;
+	}
+
+	rval =3D fwnode_property_read_u32(flash->flash_node, "led-max-microamp",
+				    &cfg->assist_max_ua);
+	if (rval < 0) {
+		dev_err(&flash->client->dev,
+			"can't read led-max-microamp property for flash\n");
+		cfg->assist_max_ua =3D 1;
+		//goto out_err;
+	}
+
+	fwnode_property_read_u32(flash->flash_node, "voltage-reference",
+			     &cfg->voltage_reference);
+
+	if (!flash->indicator_node) {
+		dev_warn(&flash->client->dev,
+			 "can't find indicator node\n");
+		//goto out_err;
+	}
+
+	rval =3D fwnode_property_read_string(flash->indicator_node, "label", &nam=
e);
+	if (!rval) {
+		strlcpy(names->indicator, name, sizeof(names->indicator));
+	} else if (is_of_node(fwnode)) {
+		snprintf(names->indicator, sizeof(names->indicator),
+			 "%s:indicator", to_of_node(fwnode)->name);
+	} else {
+		dev_err(&flash->client->dev, "flash node has no label!\n");
+		return -EINVAL;
+	}
+
+	rval =3D fwnode_property_read_u32(flash->indicator_node, "led-max-microam=
p",
+				    &cfg->indicator_max_ua);
+	if (rval < 0) {
+		dev_err(&flash->client->dev,
+			"can't read led-max-microamp property for indicator\n");
+		goto out_err;
+	}
+
+	printk("flash: indicator_max_ua %d, assist_max_ua %d, flash_max_ua %d\n",
+	       cfg->indicator_max_ua, cfg->assist_max_ua, cfg->flash_max_ua);
+
+	return 0;
+
+out_err:
+	fwnode_handle_put(flash->flash_node);
+	fwnode_handle_put(flash->indicator_node);
+
+	return rval;
+}
+
+static int fl_led_class_setup(struct fl *flash,
+				   struct fl_names *names)
+{
+	struct led_classdev *fled_cdev =3D &flash->fled.led_cdev;
+	struct led_classdev *iled_cdev =3D &flash->iled_cdev;
+	struct led_flash_setting *cfg;
+	int rval;
+
+	iled_cdev->name =3D names->indicator;
+	iled_cdev->brightness_set_blocking =3D fl_set_indicator_brightness;
+	iled_cdev->max_brightness =3D
+		flash->cfg.indicator_max_ua / flash->indicator_intensity_step;
+	iled_cdev->flags =3D LED_CORE_SUSPENDRESUME;
+
+	rval =3D led_classdev_register(&flash->client->dev, iled_cdev);
+	if (rval < 0)
+		return rval;
+
+	cfg =3D &flash->fled.brightness;
+	cfg->min =3D flash->flash_intensity_min;
+	cfg->max =3D flash->cfg.flash_max_ua;
+	cfg->step =3D flash->flash_intensity_step;
+	cfg->val =3D flash->cfg.flash_max_ua;
+
+	cfg =3D &flash->fled.timeout;
+	cfg->min =3D flash->flash_timeout_min;
+	cfg->max =3D flash->cfg.flash_timeout_us;
+	cfg->step =3D flash->flash_timeout_step;
+	cfg->val =3D flash->cfg.flash_timeout_us;
+
+	flash->fled.ops =3D &fl_led_flash_ops;
+
+	fled_cdev->name =3D names->flash;
+	fled_cdev->brightness_set_blocking =3D fl_set_assist_brightness;
+	/* Value 0 is off in LED class. */
+	fled_cdev->max_brightness =3D
+		fl_current_to_reg(flash, false,
+				       flash->cfg.assist_max_ua) + 1;
+	fled_cdev->flags =3D LED_DEV_CAP_FLASH | LED_CORE_SUSPENDRESUME;
+
+	rval =3D led_classdev_flash_register(&flash->client->dev, &flash->fled);
+	if (rval) {
+		led_classdev_unregister(iled_cdev);
+		dev_err(&flash->client->dev,
+			"led_classdev_flash_register() failed, error %d\n",
+			rval);
+	}
+
+	return rval;
+}
+
+static int fl_v4l2_setup(struct fl *flash)
+{
+	struct led_classdev_flash *fled =3D &flash->fled;
+	struct led_classdev *led =3D &fled->led_cdev;
+	struct v4l2_flash_config cfg =3D {
+		.intensity =3D {
+			.min =3D flash->torch_intensity_min,
+			.max =3D flash->cfg.assist_max_ua,
+			.step =3D flash->torch_intensity_step,
+			.val =3D flash->cfg.assist_max_ua,
+		},
+	};
+	struct v4l2_flash_config cfgind =3D {
+		.intensity =3D {
+			.min =3D flash->indicator_intensity_min,
+			.max =3D flash->cfg.indicator_max_ua,
+			.step =3D flash->indicator_intensity_step,
+			.val =3D flash->cfg.indicator_max_ua,
+		},
+	};
+
+	strlcpy(cfg.dev_name, led->name, sizeof(cfg.dev_name));
+	strlcpy(cfgind.dev_name, flash->iled_cdev.name, sizeof(cfg.dev_name));
+
+	flash->vf =3D v4l2_flash_init(
+		&flash->client->dev, flash->flash_node, &flash->fled, NULL,
+		&cfg);
+	if (IS_ERR(flash->vf))
+		return PTR_ERR(flash->vf);
+
+	flash->vfind =3D v4l2_flash_indicator_init(
+		&flash->client->dev, flash->indicator_node, &flash->iled_cdev,
+		&cfgind);
+	if (IS_ERR(flash->vfind)) {
+		v4l2_flash_release(flash->vf);
+		return PTR_ERR(flash->vfind);
+	}
+
+	return 0;
+}
+
+static int fl_probe(struct i2c_client *client)
+{
+	struct fl_names names;
+	struct fl *flash;
+	int rval;
+
+	printk("flash: probe\n");
+	if (!dev_fwnode(&client->dev))
+		return -ENODEV;
+
+	flash =3D devm_kzalloc(&client->dev, sizeof(*flash), GFP_KERNEL);
+	if (flash =3D=3D NULL)
+		return -ENOMEM;
+
+	flash->client =3D client;
+=09
+	printk("flash: parse node\n");
+	rval =3D fl_parse_node(flash, &names, dev_fwnode(&client->dev));
+	if (rval < 0)
+		return rval;
+
+	printk("flash: detect\n");
+	rval =3D fl_detect(flash);
+	if (rval < 0)
+		goto out_put_nodes;
+
+	mutex_init(&flash->mutex);
+	i2c_set_clientdata(client, flash);
+
+	printk("flash: setup\n");=09
+	rval =3D fl_setup(flash);
+	if (rval)
+		goto out_mutex_destroy;
+
+	flash->indicator_intensity_step =3D ADP1653_INDICATOR_INTENSITY_STEP;
+	flash->flash_intensity_step =3D ADP1653_FLASH_INTENSITY_STEP;
+	flash->flash_intensity_min =3D ADP1653_FLASH_INTENSITY_MIN;
+	flash->torch_intensity_step =3D ADP1653_FLASH_INTENSITY_STEP;
+	flash->torch_intensity_min =3D ADP1653_TORCH_INTENSITY_MIN;
+	flash->flash_timeout_step =3D 1;
+
+	printk("flash: led class setup\n");	=09
+	rval =3D fl_led_class_setup(flash, &names);
+	if (rval)
+		goto out_mutex_destroy;
+
+	printk("flash: v4l2 class setup\n");	=09
+	rval =3D fl_v4l2_setup(flash);
+	if (rval)
+		goto out_led_classdev_flash_unregister;
+	printk("flash: all done\n");		=09
+
+	return 0;
+
+out_led_classdev_flash_unregister:
+	led_classdev_flash_unregister(&flash->fled);
+
+out_mutex_destroy:
+	mutex_destroy(&flash->mutex);
+
+out_put_nodes:
+	fwnode_handle_put(flash->flash_node);
+	fwnode_handle_put(flash->indicator_node);
+
+	return rval;
+}
+
+static int fl_remove(struct i2c_client *client)
+{
+	struct fl *flash =3D i2c_get_clientdata(client);
+
+	flash->mode =3D AS_MODE_OFF;
+	adp1653_update_hw(flash);
+
+	v4l2_flash_release(flash->vf);
+
+	led_classdev_flash_unregister(&flash->fled);
+	led_classdev_unregister(&flash->iled_cdev);
+
+	mutex_destroy(&flash->mutex);
+
+	fwnode_handle_put(flash->flash_node);
+	fwnode_handle_put(flash->indicator_node);
+
+	return 0;
+}
+
+static const struct i2c_device_id fl_id_table[] =3D {
+	{ ADP1653_NAME, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, fl_id_table);
+
+static const struct of_device_id fl_of_table[] =3D {
+	{ .compatible =3D "fixme?" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, fl_of_table);
+
+static struct i2c_driver fl_i2c_driver =3D {
+	.driver	=3D {
+		.of_match_table =3D fl_of_table,
+		.name =3D ADP1653_NAME,
+	},
+	.probe_new	=3D fl_probe,
+	.remove	=3D fl_remove,
+	.id_table =3D fl_id_table,
+};
+
+module_i2c_driver(fl_i2c_driver);
+
+MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
+MODULE_AUTHOR("Sakari Ailus <sakari.ailus@iki.fi>");
+MODULE_AUTHOR("Pavel Machek <pavel@ucw.cz>");
+MODULE_DESCRIPTION("LED flash driver for ADP1653");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/leds/leds-flash.c b/drivers/leds/leds-flash.c
new file mode 100644
index 0000000..4a95a4f
--- /dev/null
+++ b/drivers/leds/leds-flash.c
@@ -0,0 +1,620 @@
+/*
+ * Example of i2c flash LED driver
+ *
+ * Copyright (C) 2008-2011 Nokia Corporation
+ * Copyright (c) 2011, 2017 Intel Corporation.
+ *
+ * Based on drivers/media/i2c/fl.c.
+ *
+ * Contact: Sakari Ailus <sakari.ailus@iki.fi>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/led-class-flash.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include <media/v4l2-flash-led-class.h>
+
+/* LED numbers for Devicetree */
+#define AS_LED_FLASH		0
+#define AS_LED_INDICATOR	1
+
+enum as_mode {
+	AS_MODE_EXT_TORCH =3D 0,
+	AS_MODE_INDICATOR =3D 1,
+	AS_MODE_ASSIST =3D 2,
+	AS_MODE_FLASH =3D 3,
+};
+
+struct fl_config {
+	u32 flash_timeout_us;
+	u32 flash_max_ua;
+	u32 assist_max_ua;
+	u32 indicator_max_ua;
+	u32 voltage_reference;
+	u32 peak;
+};
+
+struct fl_names {
+	char flash[32];
+	char indicator[32];
+};
+
+struct fl {
+	struct i2c_client *client;
+
+	struct mutex mutex;
+
+	struct led_classdev_flash fled;
+	struct led_classdev iled_cdev;
+
+	struct v4l2_flash *vf;
+	struct v4l2_flash *vfind;
+
+	struct fwnode_handle *flash_node;
+	struct fwnode_handle *indicator_node;
+
+	struct fl_config cfg;
+
+	enum as_mode mode;
+	unsigned int timeout;
+	unsigned int flash_current;
+	unsigned int assist_current;
+	unsigned int indicator_current;
+	enum v4l2_flash_strobe_source strobe_source;
+
+	int indicator_intensity_min;
+	int indicator_intensity_step;
+	int torch_intensity_min;
+	int torch_intensity_step;
+	int flash_intensity_min;
+	int flash_intensity_step;
+	int flash_timeout_min;
+	int flash_timeout_step;
+};
+
+#define fled_to_fl(__fled) container_of(__fled, struct fl, fled)
+#define iled_cdev_to_fl(__iled_cdev) \
+	container_of(__iled_cdev, struct fl, iled_cdev)
+
+/* Return negative errno else zero on success */
+static int fl_write(struct fl *flash, u8 addr, u8 val)
+{
+	struct i2c_client *client =3D flash->client;
+	int rval;
+
+	rval =3D i2c_smbus_write_byte_data(client, addr, val);
+
+	dev_dbg(&client->dev, "Write Addr:%02X Val:%02X %s\n", addr, val,
+		rval < 0 ? "fail" : "ok");
+
+	return rval;
+}
+
+/* Return negative errno else a data byte received from the device. */
+static int fl_read(struct fl *flash, u8 addr)
+{
+	struct i2c_client *client =3D flash->client;
+	int rval;
+
+	rval =3D i2c_smbus_read_byte_data(client, addr);
+
+	dev_dbg(&client->dev, "Read Addr:%02X Val:%02X %s\n", addr, rval,
+		rval < 0 ? "fail" : "ok");
+
+	return rval;
+}
+
+/* -----------------------------------------------------------------------=
------
+ * Hardware configuration and trigger
+ */
+
+/**
+ * fl_set_config - Set flash configuration registers
+ * @flash: The flash
+ *
+ * Configure the hardware with flash, assist and indicator currents, as we=
ll as
+ * flash timeout.
+ *
+ * Return 0 on success, or a negative error code if an I2C communication e=
rror
+ * occurred.
+ */
+static int fl_set_current(struct fl *flash)
+{
+	printk("flash: set_current\n");
+
+	//return fl_write(flash, AS_CURRENT_SET_REG, val);
+	return -EINVAL;
+}
+
+static int fl_set_timeout(struct fl *flash)
+{
+	printk("flash: set_timeout\n");
+
+	//return fl_write(flash, AS_INDICATOR_AND_TIMER_REG, val);
+	return -EINVAL;
+}
+
+/**
+ * fl_set_control - Set flash control register
+ * @flash: The flash
+ * @mode: Desired output mode
+ * @on: Desired output state
+ *
+ * Configure the hardware with output mode and state.
+ *
+ * Return 0 on success, or a negative error code if an I2C communication e=
rror
+ * occurred.
+ */
+static int
+fl_set_control(struct fl *flash, enum as_mode mode, bool on)
+{
+	printk("flash: set_control\n");
+
+	//return fl_write(flash, AS_CONTROL_REG, reg);
+}
+
+static int __fl_get_fault(struct fl *flash, u32 *fault)
+{
+		printk("flash: get_fault\n");
+		return 0;
+}
+
+static int fl_get_fault(struct led_classdev_flash *fled, u32 *fault)
+{
+	struct fl *flash =3D fled_to_fl(fled);
+
+	return __fl_get_fault(flash, fault);
+}
+
+static unsigned int __fl_current_to_reg(unsigned int min, unsigned int max,
+					     unsigned int step,
+					     unsigned int val)
+{
+	if (val < min)
+		val =3D min;
+
+	if (val > max)
+		val =3D max;
+
+	return (val - min) / step;
+}
+
+static unsigned int fl_current_to_reg(struct fl *flash, bool is_flash,
+					   unsigned int ua)
+{
+	if (is_flash)
+		return __fl_current_to_reg(flash->torch_intensity_min,
+						flash->cfg.assist_max_ua,
+						flash->torch_intensity_step, ua);
+	else
+		return __fl_current_to_reg(flash->flash_intensity_min,
+						flash->cfg.flash_max_ua,
+						flash->flash_intensity_step, ua);
+}
+
+static int fl_set_indicator_brightness(struct led_classdev *iled_cdev,
+					    enum led_brightness brightness)
+{
+	struct fl *flash =3D iled_cdev_to_fl(iled_cdev);
+	int rval;
+
+	flash->indicator_current =3D brightness;
+
+	rval =3D fl_set_timeout(flash);
+	if (rval)
+		return rval;
+
+	return fl_set_control(flash, AS_MODE_INDICATOR, brightness);
+}
+
+static int fl_set_assist_brightness(struct led_classdev *fled_cdev,
+					 enum led_brightness brightness)
+{
+	struct led_classdev_flash *fled =3D lcdev_to_flcdev(fled_cdev);
+	struct fl *flash =3D fled_to_fl(fled);
+	int rval;
+
+	if (brightness) {
+		/* Register value 0 is 20 mA. */
+		flash->assist_current =3D brightness - 1;
+
+		rval =3D fl_set_current(flash);
+		if (rval)
+			return rval;
+	}
+
+	return fl_set_control(flash, AS_MODE_ASSIST, brightness);
+}
+
+static int fl_set_flash_brightness(struct led_classdev_flash *fled,
+					u32 brightness_ua)
+{
+	struct fl *flash =3D fled_to_fl(fled);
+
+	flash->flash_current =3D fl_current_to_reg(flash, true, brightness_ua);
+
+	return fl_set_current(flash);
+}
+
+static int fl_set_flash_timeout(struct led_classdev_flash *fled,
+				     u32 timeout_us)
+{
+	struct fl *flash =3D fled_to_fl(fled);
+
+	flash->timeout =3D 0; // FIXME AS_TIMER_US_TO_CODE(timeout_us);
+
+	return fl_set_timeout(flash);
+}
+
+static int fl_set_strobe(struct led_classdev_flash *fled, bool state)
+{
+	struct fl *flash =3D fled_to_fl(fled);
+
+	return fl_set_control(flash, AS_MODE_FLASH, state);
+}
+
+static const struct led_flash_ops fl_led_flash_ops =3D {
+	.flash_brightness_set =3D fl_set_flash_brightness,
+	.timeout_set =3D fl_set_flash_timeout,
+	.strobe_set =3D fl_set_strobe,
+	.fault_get =3D fl_get_fault,
+};
+
+static int fl_setup(struct fl *flash)
+{
+	struct device *dev =3D &flash->client->dev;
+	u32 fault =3D 0;
+	int rval;
+
+	/* clear errors */
+	rval =3D fl_get_fault(flash, &fault);
+	if (rval < 0)
+		return rval;
+
+	dev_dbg(dev, "Fault info: %02x\n", rval);
+
+	rval =3D fl_set_current(flash);
+	if (rval < 0)
+		return rval;
+
+	rval =3D fl_set_timeout(flash);
+	if (rval < 0)
+		return rval;
+
+	rval =3D fl_set_control(flash, AS_MODE_INDICATOR, false);
+	if (rval < 0)
+		return rval;
+
+	/* read status */
+	rval =3D fl_get_fault(&flash->fled, &fault);
+	if (rval < 0)
+		return rval;
+
+	return rval ? -EIO : 0;
+}
+
+static int fl_detect(struct fl *flash)
+{
+	struct device *dev =3D &flash->client->dev;
+	int rval, man, model, rfu, version;
+	const char *vendor;
+
+	//return fl_write(flash, AS_BOOST_REG, AS_BOOST_CURRENT_DISABLE);
+}
+
+static int fl_parse_node(struct fl *flash,
+			      struct fl_names *names,
+			      struct fwnode_handle *fwnode)
+{
+	struct fl_config *cfg =3D &flash->cfg;
+	struct fwnode_handle *child;
+	const char *name;
+	const char *str;
+	int rval;
+
+	fwnode_for_each_child_node(fwnode, child) {
+		u32 id =3D 0;
+
+		fwnode_property_read_u32(
+			child, is_of_node(child) ? "reg" : "led", &id);
+
+		switch (id) {
+		case AS_LED_FLASH:
+			flash->flash_node =3D child;
+			break;
+		case AS_LED_INDICATOR:
+			flash->indicator_node =3D child;
+			break;
+		default:
+			dev_warn(&flash->client->dev,
+				 "unknown LED %u encountered, ignoring\n", id);
+			break;
+		}
+		fwnode_handle_get(child);
+	}
+
+	if (!flash->flash_node) {
+		dev_err(&flash->client->dev, "can't find flash node\n");
+		return -ENODEV;
+	}
+
+	rval =3D fwnode_property_read_string(flash->flash_node, "label", &name);
+	if (!rval) {
+		strlcpy(names->flash, name, sizeof(names->flash));
+	} else if (is_of_node(fwnode)) {
+		snprintf(names->flash, sizeof(names->flash),
+			 "%s:flash", to_of_node(fwnode)->name);
+	} else {
+		dev_err(&flash->client->dev, "flash node has no label!\n");
+		return -EINVAL;
+	}
+
+	rval =3D fwnode_property_read_u32(flash->flash_node, "flash-timeout-us",
+				    &cfg->flash_timeout_us);
+	if (rval < 0) {
+		dev_err(&flash->client->dev,
+			"can't read flash-timeout-us property for flash\n");
+		goto out_err;
+	}
+
+	rval =3D fwnode_property_read_u32(flash->flash_node, "flash-max-microamp",
+				    &cfg->flash_max_ua);
+	if (rval < 0) {
+		dev_err(&flash->client->dev,
+			"can't read flash-max-microamp property for flash\n");
+		goto out_err;
+	}
+
+	rval =3D fwnode_property_read_u32(flash->flash_node, "led-max-microamp",
+				    &cfg->assist_max_ua);
+	if (rval < 0) {
+		dev_err(&flash->client->dev,
+			"can't read led-max-microamp property for flash\n");
+		goto out_err;
+	}
+
+	fwnode_property_read_u32(flash->flash_node, "voltage-reference",
+			     &cfg->voltage_reference);
+
+	if (!flash->indicator_node) {
+		dev_warn(&flash->client->dev,
+			 "can't find indicator node\n");
+		goto out_err;
+	}
+
+	rval =3D fwnode_property_read_string(flash->indicator_node, "label", &nam=
e);
+	if (!rval) {
+		strlcpy(names->indicator, name, sizeof(names->indicator));
+	} else if (is_of_node(fwnode)) {
+		snprintf(names->indicator, sizeof(names->indicator),
+			 "%s:indicator", to_of_node(fwnode)->name);
+	} else {
+		dev_err(&flash->client->dev, "flash node has no label!\n");
+		return -EINVAL;
+	}
+
+	rval =3D fwnode_property_read_u32(flash->indicator_node, "led-max-microam=
p",
+				    &cfg->indicator_max_ua);
+	if (rval < 0) {
+		dev_err(&flash->client->dev,
+			"can't read led-max-microamp property for indicator\n");
+		goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	fwnode_handle_put(flash->flash_node);
+	fwnode_handle_put(flash->indicator_node);
+
+	return rval;
+}
+
+static int fl_led_class_setup(struct fl *flash,
+				   struct fl_names *names)
+{
+	struct led_classdev *fled_cdev =3D &flash->fled.led_cdev;
+	struct led_classdev *iled_cdev =3D &flash->iled_cdev;
+	struct led_flash_setting *cfg;
+	int rval;
+
+	iled_cdev->name =3D names->indicator;
+	iled_cdev->brightness_set_blocking =3D fl_set_indicator_brightness;
+	iled_cdev->max_brightness =3D
+		flash->cfg.indicator_max_ua / flash->indicator_intensity_step;
+	iled_cdev->flags =3D LED_CORE_SUSPENDRESUME;
+
+	rval =3D led_classdev_register(&flash->client->dev, iled_cdev);
+	if (rval < 0)
+		return rval;
+
+	cfg =3D &flash->fled.brightness;
+	cfg->min =3D flash->flash_intensity_min;
+	cfg->max =3D flash->cfg.flash_max_ua;
+	cfg->step =3D flash->flash_intensity_step;
+	cfg->val =3D flash->cfg.flash_max_ua;
+
+	cfg =3D &flash->fled.timeout;
+	cfg->min =3D flash->flash_timeout_min;
+	cfg->max =3D flash->cfg.flash_timeout_us;
+	cfg->step =3D flash->flash_timeout_step;
+	cfg->val =3D flash->cfg.flash_timeout_us;
+
+	flash->fled.ops =3D &fl_led_flash_ops;
+
+	fled_cdev->name =3D names->flash;
+	fled_cdev->brightness_set_blocking =3D fl_set_assist_brightness;
+	/* Value 0 is off in LED class. */
+	fled_cdev->max_brightness =3D
+		fl_current_to_reg(flash, false,
+				       flash->cfg.assist_max_ua) + 1;
+	fled_cdev->flags =3D LED_DEV_CAP_FLASH | LED_CORE_SUSPENDRESUME;
+
+	rval =3D led_classdev_flash_register(&flash->client->dev, &flash->fled);
+	if (rval) {
+		led_classdev_unregister(iled_cdev);
+		dev_err(&flash->client->dev,
+			"led_classdev_flash_register() failed, error %d\n",
+			rval);
+	}
+
+	return rval;
+}
+
+static int fl_v4l2_setup(struct fl *flash)
+{
+	struct led_classdev_flash *fled =3D &flash->fled;
+	struct led_classdev *led =3D &fled->led_cdev;
+	struct v4l2_flash_config cfg =3D {
+		.intensity =3D {
+			.min =3D flash->torch_intensity_min,
+			.max =3D flash->cfg.assist_max_ua,
+			.step =3D flash->torch_intensity_step,
+			.val =3D flash->cfg.assist_max_ua,
+		},
+	};
+	struct v4l2_flash_config cfgind =3D {
+		.intensity =3D {
+			.min =3D flash->indicator_intensity_min,
+			.max =3D flash->cfg.indicator_max_ua,
+			.step =3D flash->indicator_intensity_step,
+			.val =3D flash->cfg.indicator_max_ua,
+		},
+	};
+
+	strlcpy(cfg.dev_name, led->name, sizeof(cfg.dev_name));
+	strlcpy(cfgind.dev_name, flash->iled_cdev.name, sizeof(cfg.dev_name));
+
+	flash->vf =3D v4l2_flash_init(
+		&flash->client->dev, flash->flash_node, &flash->fled, NULL,
+		&cfg);
+	if (IS_ERR(flash->vf))
+		return PTR_ERR(flash->vf);
+
+	flash->vfind =3D v4l2_flash_indicator_init(
+		&flash->client->dev, flash->indicator_node, &flash->iled_cdev,
+		&cfgind);
+	if (IS_ERR(flash->vfind)) {
+		v4l2_flash_release(flash->vf);
+		return PTR_ERR(flash->vfind);
+	}
+
+	return 0;
+}
+
+static int fl_probe(struct i2c_client *client)
+{
+	struct fl_names names;
+	struct fl *flash;
+	int rval;
+
+	if (!dev_fwnode(&client->dev))
+		return -ENODEV;
+
+	flash =3D devm_kzalloc(&client->dev, sizeof(*flash), GFP_KERNEL);
+	if (flash =3D=3D NULL)
+		return -ENOMEM;
+
+	flash->client =3D client;
+
+	rval =3D fl_parse_node(flash, &names, dev_fwnode(&client->dev));
+	if (rval < 0)
+		return rval;
+
+	rval =3D fl_detect(flash);
+	if (rval < 0)
+		goto out_put_nodes;
+
+	mutex_init(&flash->mutex);
+	i2c_set_clientdata(client, flash);
+
+	rval =3D fl_setup(flash);
+	if (rval)
+		goto out_mutex_destroy;
+
+	rval =3D fl_led_class_setup(flash, &names);
+	if (rval)
+		goto out_mutex_destroy;
+
+	rval =3D fl_v4l2_setup(flash);
+	if (rval)
+		goto out_led_classdev_flash_unregister;
+
+	return 0;
+
+out_led_classdev_flash_unregister:
+	led_classdev_flash_unregister(&flash->fled);
+
+out_mutex_destroy:
+	mutex_destroy(&flash->mutex);
+
+out_put_nodes:
+	fwnode_handle_put(flash->flash_node);
+	fwnode_handle_put(flash->indicator_node);
+
+	return rval;
+}
+
+static int fl_remove(struct i2c_client *client)
+{
+	struct fl *flash =3D i2c_get_clientdata(client);
+
+	fl_set_control(flash, AS_MODE_EXT_TORCH, false);
+
+	v4l2_flash_release(flash->vf);
+
+	led_classdev_flash_unregister(&flash->fled);
+	led_classdev_unregister(&flash->iled_cdev);
+
+	mutex_destroy(&flash->mutex);
+
+	fwnode_handle_put(flash->flash_node);
+	fwnode_handle_put(flash->indicator_node);
+
+	return 0;
+}
+
+static const struct i2c_device_id fl_id_table[] =3D {
+	{ "fixme", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, fl_id_table);
+
+static const struct of_device_id fl_of_table[] =3D {
+	{ .compatible =3D "ams,fl" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, fl_of_table);
+
+static struct i2c_driver fl_i2c_driver =3D {
+	.driver	=3D {
+		.of_match_table =3D fl_of_table,
+		.name =3D "fixme",
+	},
+	.probe_new	=3D fl_probe,
+	.remove	=3D fl_remove,
+	.id_table =3D fl_id_table,
+};
+
+module_i2c_driver(fl_i2c_driver);
+
+MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
+MODULE_AUTHOR("Sakari Ailus <sakari.ailus@iki.fi>");
+MODULE_DESCRIPTION("LED flash driver for FL, LM3555 and their clones");
+MODULE_LICENSE("GPL v2");

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlm7k0sACgkQMOfwapXb+vKSqACfVhMIVwL8EP4zfACiQjrUL+8t
i1QAnRCZQQq63WQ8eb+ApHiiwS1iktKW
=OUN6
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
