From: Pavel Machek <pavel@ucw.cz>
Subject: [pre-rfc] focus and flash for Nokia N900 (was Re: v4l subdevs
 without big device was Re: drivers/media/i2c/adp1653.c: does not show as
 /dev/video* or v4l-subdev*)
Date: Fri, 29 Apr 2016 23:30:20 +0200
Message-ID: <20160429213020.GA25594@amd>
References: <20160428084546.GA9957@amd>
 <20160429071525.GA4823@amd>
 <57230DE7.3020701@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57230DE7.3020701@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, sakari.ailus@iki.fi, tuukkat76@gmail.com, mchehab@osg.samsung.com, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> "5. DT Bindings for flash & lens controllers
>=20
> There are drivers that create their MC topology using the device tree=
 information,
> which works great for entities that transport data, but how to detect=
 entities
> that don=E2=80=99t transport data such as flash devices, focusers, et=
c.? How can those be
> deduced using the device tree?
>=20
> Sensor DT node add phandle to focus controller: add generic v4l bindi=
ng properties
> to reference such devices."
>=20
> This wasn't a problem with the original N900 since that didn't use DT=
 AFAIK and
> these devices were loaded explicitly through board code.
>=20
> But now you run into the same problem that I have.
>=20
> The solution is that sensor devices have to provide phandles to those=
 controller
> devices. And to do that you need to define bindings which is always t=
he hard part.
>=20
> Look in Documentation/devicetree/bindings/media/video-interfaces.txt,=
 section
> "Optional endpoint properties".
>=20
> Something like:
>=20
> controllers: an array of phandles to controller devices associated wi=
th this
> endpoint such as flash and lens controllers.

Ok, so after a big fight, I got both auto focus and flash to work on
n900. Relative to N900 camera trees recently posted.

Subdevs behave rather funny, and --sleep-forever is needed for useful
operation.

YA=3D/my/tui/yavta/yavta
# torch
sudo $YA --sleep-forever --set-control '0x009c0901 2'  /dev/v4l-subdev1=
1

# focus -- near
sudo $YA --sleep-forever --set-control '0x009a090a 1023' /dev/l-subdev1=
2

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
index 9c9c1e8..acf1457 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -239,6 +239,7 @@
=20
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&camera_pins>;
+	ti,camera-flashes =3D <&adp1653 &cam1 &ad5820 &cam1>;
=20
 	ports {
 		port@1 {
@@ -251,7 +252,7 @@
 				data-lanes =3D <1>;
 				lane-polarity =3D <0 0>;
 				clock-inv =3D <0>;
-				strobe =3D <0>;
+				strobe =3D <1>;
 				crc =3D <0>;
 			};
 		};
@@ -879,6 +880,16 @@
 			};
 		};
 	};
+
+	/* D/A converter for auto-focus */
+	ad5820: dac@0c {
+		compatible =3D "adi,ad5820";
+		reg =3D <0x0c>;
+
+		VANA-supply =3D <&vaux4>;
+
+		#io-channel-cells =3D <0>;
+	};
 };
=20
 &mmc1 {
diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 254c106..77313a1 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -279,6 +279,13 @@ config VIDEO_ML86V7667
 	  To compile this driver as a module, choose M here: the
 	  module will be called ml86v7667.
=20
+config VIDEO_AD5820
+	tristate "AD5820 lens voice coil support"
+	depends on I2C && VIDEO_V4L2 && MEDIA_CONTROLLER
+	---help---
+	  This is a driver for the AD5820 camera lens voice coil.
+	  It is used for example in Nokia N900 (RX-51).
+
 config VIDEO_SAA7110
 	tristate "Philips SAA7110 video decoder"
 	depends on VIDEO_V4L2 && I2C
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index 05e79aa..34434ae 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_VIDEO_SAA717X) +=3D saa717x.o
 obj-$(CONFIG_VIDEO_SAA7127) +=3D saa7127.o
 obj-$(CONFIG_VIDEO_SAA7185) +=3D saa7185.o
 obj-$(CONFIG_VIDEO_SAA6752HS) +=3D saa6752hs.o
+obj-$(CONFIG_VIDEO_AD5820)  +=3D ad5820.o
 obj-$(CONFIG_VIDEO_ADV7170) +=3D adv7170.o
 obj-$(CONFIG_VIDEO_ADV7175) +=3D adv7175.o
 obj-$(CONFIG_VIDEO_ADV7180) +=3D adv7180.o
diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
new file mode 100644
index 0000000..5aee185
--- /dev/null
+++ b/drivers/media/i2c/ad5820.c
@@ -0,0 +1,526 @@
+/*
+ * drivers/media/i2c/ad5820.c
+ *
+ * AD5820 DAC driver for camera voice coil focus.
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * Contact: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
+ *          Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * Based on af_d88.c by Texas Instruments.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/regulator/consumer.h>
+
+#include <media/ad5820.h>
+#include <media/v4l2-device.h>
+
+#define CODE_TO_RAMP_US(s)	((s) =3D=3D 0 ? 0 : (1 << ((s) - 1)) * 50)
+#define RAMP_US_TO_CODE(c)	fls(((c) + ((c)>>1)) / 50)
+
+/**
+ * @brief I2C write using i2c_transfer().
+ * @param coil - the driver data structure
+ * @param data - register value to be written
+ * @returns nonnegative on success, negative if failed
+ */
+static int ad5820_write(struct ad5820_device *coil, u16 data)
+{
+	struct i2c_client *client =3D v4l2_get_subdevdata(&coil->subdev);
+	struct i2c_msg msg;
+	int r;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	data =3D cpu_to_be16(data);
+	msg.addr  =3D client->addr;
+	msg.flags =3D 0;
+	msg.len   =3D 2;
+	msg.buf   =3D (u8 *)&data;
+
+	r =3D i2c_transfer(client->adapter, &msg, 1);
+	if (r < 0) {
+		dev_err(&client->dev, "write failed, error %d\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
+/**
+ * @brief I2C read using i2c_transfer().
+ * @param coil - the driver data structure
+ * @returns unsigned 16-bit register value on success, negative if fai=
led
+ */
+static int ad5820_read(struct ad5820_device *coil)
+{
+	struct i2c_client *client =3D v4l2_get_subdevdata(&coil->subdev);
+	struct i2c_msg msg;
+	int r;
+	u16 data =3D 0;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	msg.addr  =3D client->addr;
+	msg.flags =3D I2C_M_RD;
+	msg.len   =3D 2;
+	msg.buf   =3D (u8 *)&data;
+
+	r =3D i2c_transfer(client->adapter, &msg, 1);
+	if (r < 0) {
+		dev_err(&client->dev, "read failed, error %d\n", r);
+		return r;
+	}
+
+	return be16_to_cpu(data);
+}
+
+/*
+ * Calculate status word and write it to the device based on current
+ * values of V4L2 controls. It is assumed that the stored V4L2 control
+ * values are properly limited and rounded.
+ */
+static int ad5820_update_hw(struct ad5820_device *coil)
+{
+	u16 status;
+
+	status =3D RAMP_US_TO_CODE(coil->focus_ramp_time);
+	status |=3D coil->focus_ramp_mode
+		? AD5820_RAMP_MODE_64_16 : AD5820_RAMP_MODE_LINEAR;
+	status |=3D coil->focus_absolute << AD5820_DAC_SHIFT;
+
+	if (coil->standby)
+		status |=3D AD5820_POWER_DOWN;
+
+	return ad5820_write(coil, status);
+}
+
+/*
+ * Power handling
+ */
+static int ad5820_power_off(struct ad5820_device *coil, int standby)
+{
+	int ret =3D 0;
+
+	/*
+	 * Go to standby first as real power off my be denied by the hardware
+	 * (single power line control for both coil and sensor).
+	 */
+	if (standby) {
+		coil->standby =3D 1;
+		ret =3D ad5820_update_hw(coil);
+	}
+
+//	ret |=3D coil->platform_data->set_xshutdown(&coil->subdev, 0);
+	ret |=3D regulator_disable(coil->vana);
+
+	return ret;
+}
+
+static int ad5820_power_on(struct ad5820_device *coil, int restore)
+{
+	int ret;
+
+	printk("ad5820_power_on: 1\n");
+	ret =3D regulator_enable(coil->vana);
+	if (ret < 0)
+		return ret;
+
+	printk("ad5820_power_on: 2\n");
+#if 0=09
+	printk("ad5820_power_on: pd %lx\n", coil->platform_data);
+	printk("ad5820_power_on: xs %lx\n", coil->platform_data->set_xshutdow=
n);
+	ret =3D coil->platform_data->set_xshutdown(&coil->subdev, 1);
+	if (ret)
+		goto fail;
+#endif
+
+	printk("ad5820_power_on: 3\n");
+	if (restore) {
+		/* Restore the hardware settings. */
+		coil->standby =3D 0;
+		printk("ad5820_power_on: 4\n");	=09
+		ret =3D ad5820_update_hw(coil);
+		if (ret)
+			goto fail;
+	}
+	printk("ad5820_power_on: 5\n");=20
+	return 0;
+
+fail:
+	coil->standby =3D 1;
+
+#if 0
+	coil->platform_data->set_xshutdown(&coil->subdev, 0);
+#endif
+	regulator_disable(coil->vana);
+
+	return ret;
+}
+
+/*
+ * V4L2 controls
+ */
+static int ad5820_set_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct ad5820_device *coil =3D
+		container_of(ctrl->handler, struct ad5820_device, ctrls);
+	u32 code;
+	int r =3D 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_FOCUS_ABSOLUTE:
+		coil->focus_absolute =3D ctrl->val;
+		return ad5820_update_hw(coil);
+
+	case V4L2_CID_FOCUS_AD5820_RAMP_TIME:
+		code =3D RAMP_US_TO_CODE(ctrl->val);
+		ctrl->val =3D CODE_TO_RAMP_US(code);
+		coil->focus_ramp_time =3D ctrl->val;
+		break;
+
+	case V4L2_CID_FOCUS_AD5820_RAMP_MODE:
+		coil->focus_ramp_mode =3D ctrl->val;
+		break;
+	}
+
+	return r;
+}
+
+static const struct v4l2_ctrl_ops ad5820_ctrl_ops =3D {
+	.s_ctrl =3D ad5820_set_ctrl,
+};
+
+static const char *ad5820_focus_menu[] =3D {
+	"Linear ramp",
+	"64/16 ramp",
+};
+
+static const struct v4l2_ctrl_config ad5820_ctrls[] =3D {
+	{
+		.ops		=3D &ad5820_ctrl_ops,
+		.id		=3D V4L2_CID_FOCUS_AD5820_RAMP_TIME,
+		.type		=3D V4L2_CTRL_TYPE_INTEGER,
+		.name		=3D "Focus ramping time [us]",
+		.min		=3D 0,
+		.max		=3D 3200,
+		.step		=3D 50,
+		.def		=3D 0,
+		.flags		=3D 0,
+	},
+	{
+		.ops		=3D &ad5820_ctrl_ops,
+		.id		=3D V4L2_CID_FOCUS_AD5820_RAMP_MODE,
+		.type		=3D V4L2_CTRL_TYPE_MENU,
+		.name		=3D "Focus ramping mode",
+		.min		=3D 0,
+		.max		=3D ARRAY_SIZE(ad5820_focus_menu),
+		.step		=3D 0,
+		.def		=3D 0,
+		.flags		=3D 0,
+		.qmenu		=3D ad5820_focus_menu,
+	},
+};
+
+
+static int ad5820_init_controls(struct ad5820_device *coil)
+{
+	unsigned int i;
+
+	v4l2_ctrl_handler_init(&coil->ctrls, ARRAY_SIZE(ad5820_ctrls) + 1);
+
+	/*
+	 * V4L2_CID_FOCUS_ABSOLUTE
+	 *
+	 * Minimum current is 0 mA, maximum is 100 mA. Thus, 1 code is
+	 * equivalent to 100/1023 =3D 0.0978 mA. Nevertheless, we do not use =
[mA]
+	 * for focus position, because it is meaningless for user. Meaningful
+	 * would be to use focus distance or even its inverse, but since the
+	 * driver doesn't have sufficiently knowledge to do the conversion, w=
e
+	 * will just use abstract codes here. In any case, smaller value =3D =
focus
+	 * position farther from camera. The default zero value means focus a=
t
+	 * infinity, and also least current consumption.
+	 */
+	v4l2_ctrl_new_std(&coil->ctrls, &ad5820_ctrl_ops,
+			  V4L2_CID_FOCUS_ABSOLUTE, 0, 1023, 1, 0);
+
+	/* V4L2_CID_TEST_PATTERN and V4L2_CID_MODE_* */
+	for (i =3D 0; i < ARRAY_SIZE(ad5820_ctrls); ++i)
+		v4l2_ctrl_new_custom(&coil->ctrls, &ad5820_ctrls[i], NULL);
+
+	if (coil->ctrls.error)
+		return coil->ctrls.error;
+
+	coil->focus_absolute =3D 0;
+	coil->focus_ramp_time =3D 0;
+	coil->focus_ramp_mode =3D 0;
+
+	coil->subdev.ctrl_handler =3D &coil->ctrls;
+	return 0;
+}
+
+/*
+ * V4L2 subdev operations
+ */
+static int
+ad5820_registered(struct v4l2_subdev *subdev)
+{
+	static const int CHECK_VALUE =3D 0x3FF0;
+
+	struct ad5820_device *coil =3D to_ad5820_device(subdev);
+	struct i2c_client *client =3D v4l2_get_subdevdata(subdev);
+	u16 status =3D AD5820_POWER_DOWN | CHECK_VALUE;
+	int rval;
+
+	printk("registered\n");
+	coil->vana =3D regulator_get(&client->dev, "VANA");
+	if (IS_ERR(coil->vana)) {
+		dev_err(&client->dev, "could not get regulator for vana\n");
+		return -ENODEV;
+	}
+#if 0
+	printk("detect\n");
+	/* Detect that the chip is there */
+	rval =3D ad5820_power_on(coil, 0);
+	if (rval)
+		goto not_detected;
+	rval =3D ad5820_write(coil, status);
+	if (rval)
+		goto not_detected;
+	rval =3D ad5820_read(coil);
+	if (rval !=3D status)
+		goto not_detected;
+
+
+	{
+		int i, j;
+		for (j =3D 0; j<5; j++) {
+			printk("hwtest: phase %d\n", j);
+			for (i=3D0; i<1023; i++) {
+				coil->focus_absolute =3D i;
+				msleep(1);
+				ad5820_update_hw(coil);
+			}
+		}
+	}=09
+
+	printk("detect ok, poweroff\n");=09
+	ad5820_power_off(coil, 1);
+#endif
+	printk("controls\n");=09
+	return ad5820_init_controls(coil);
+
+not_detected:
+	dev_err(&client->dev, "not detected\n");
+	ad5820_power_off(coil, 0);
+	regulator_put(coil->vana);
+	return -ENODEV;
+}
+
+static int
+ad5820_set_power(struct v4l2_subdev *subdev, int on)
+{
+	struct ad5820_device *coil =3D to_ad5820_device(subdev);
+	int ret =3D 0;
+
+	mutex_lock(&coil->power_lock);
+
+	/*
+	 * If the power count is modified from 0 to !=3D 0 or from !=3D 0 to =
0,
+	 * update the power state.
+	 */
+	if (coil->power_count =3D=3D !on) {
+		ret =3D on ? ad5820_power_on(coil, 1) : ad5820_power_off(coil, 1);
+		if (ret < 0)
+			goto done;
+	}
+
+	/* Update the power count. */
+	coil->power_count +=3D on ? 1 : -1;
+	WARN_ON(coil->power_count < 0);
+
+done:
+	mutex_unlock(&coil->power_lock);
+	return ret;
+}
+
+static int ad5820_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *=
fh)
+{
+	return ad5820_set_power(sd, 1);
+}
+
+static int ad5820_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh =
*fh)
+{
+	return ad5820_set_power(sd, 0);
+}
+
+static const struct v4l2_subdev_core_ops ad5820_core_ops =3D {
+	.s_power =3D ad5820_set_power,
+};
+
+static const struct v4l2_subdev_ops ad5820_ops =3D {
+	.core =3D &ad5820_core_ops,
+};
+
+static const struct v4l2_subdev_internal_ops ad5820_internal_ops =3D {
+	.registered =3D ad5820_registered,
+	.open =3D ad5820_open,
+	.close =3D ad5820_close,
+};
+
+/*
+ * I2C driver
+ */
+#ifdef CONFIG_PM
+
+static int ad5820_suspend(struct device *dev)
+{
+	struct i2c_client *client =3D container_of(dev, struct i2c_client, de=
v);
+	struct v4l2_subdev *subdev =3D i2c_get_clientdata(client);
+	struct ad5820_device *coil =3D to_ad5820_device(subdev);
+
+	if (!coil->power_count)
+		return 0;
+
+	return ad5820_power_off(coil, 0);
+}
+
+static int ad5820_resume(struct device *dev)
+{
+	struct i2c_client *client =3D container_of(dev, struct i2c_client, de=
v);
+	struct v4l2_subdev *subdev =3D i2c_get_clientdata(client);
+	struct ad5820_device *coil =3D to_ad5820_device(subdev);
+
+	if (!coil->power_count)
+		return 0;
+
+	return ad5820_power_on(coil, 1);
+}
+
+#else
+
+#define ad5820_suspend	NULL
+#define ad5820_resume	NULL
+
+#endif /* CONFIG_PM */
+
+static int ad5820_probe(struct i2c_client *client,
+			const struct i2c_device_id *devid)
+{
+	struct ad5820_device *coil;
+	int ret =3D 0;
+
+	coil =3D kzalloc(sizeof(*coil), GFP_KERNEL);
+	if (coil =3D=3D NULL)
+		return -ENOMEM;
+
+	coil->platform_data =3D NULL; // client->dev.platform_data;
+
+	mutex_init(&coil->power_lock);
+
+	v4l2_i2c_subdev_init(&coil->subdev, client, &ad5820_ops);
+	coil->subdev.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
+	coil->subdev.internal_ops =3D &ad5820_internal_ops;
+	strcpy(coil->subdev.name, "ad5820 focus");
+
+	ret =3D media_entity_pads_init(&coil->subdev.entity, 0, NULL);
+	if (ret < 0) {
+		kfree(coil);
+		return ret;
+	}
+
+	ret =3D v4l2_async_register_subdev(&coil->subdev);
+	if (ret < 0)
+		kfree(coil);
+
+	printk("Hack -- testing hw\n");
+	ad5820_registered(coil);
+
+	printk("hw test done\n");
+
+	return ret;
+}
+
+static int __exit ad5820_remove(struct i2c_client *client)
+{
+	struct v4l2_subdev *subdev =3D i2c_get_clientdata(client);
+	struct ad5820_device *coil =3D to_ad5820_device(subdev);
+
+	v4l2_device_unregister_subdev(&coil->subdev);
+	v4l2_ctrl_handler_free(&coil->ctrls);
+	media_entity_cleanup(&coil->subdev.entity);
+	if (coil->vana)
+		regulator_put(coil->vana);
+
+	kfree(coil);
+	return 0;
+}
+
+static const struct i2c_device_id ad5820_id_table[] =3D {
+	{ AD5820_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
+
+static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
+
+static struct i2c_driver ad5820_i2c_driver =3D {
+	.driver		=3D {
+		.name	=3D AD5820_NAME,
+		.pm	=3D &ad5820_pm,
+	},
+	.probe		=3D ad5820_probe,
+	.remove		=3D __exit_p(ad5820_remove),
+	.id_table	=3D ad5820_id_table,
+};
+
+static int __init ad5820_init(void)
+{
+	int rval;
+
+	rval =3D i2c_add_driver(&ad5820_i2c_driver);
+	if (rval)
+		printk(KERN_INFO "%s: failed registering " AD5820_NAME "\n",
+		       __func__);
+
+	return rval;
+}
+
+static void __exit ad5820_exit(void)
+{
+	i2c_del_driver(&ad5820_i2c_driver);
+}
+
+
+module_init(ad5820_init);
+module_exit(ad5820_exit);
+
+MODULE_AUTHOR("Tuukka Toivonen <tuukka.o.toivonen@nokia.com>");
+MODULE_DESCRIPTION("AD5820 camera lens driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/i2c/adp1653.c b/drivers/media/i2c/adp1653.c
index 0cd494e..6dd5d6a 100644
--- a/drivers/media/i2c/adp1653.c
+++ b/drivers/media/i2c/adp1653.c
@@ -306,6 +306,8 @@ adp1653_init_device(struct adp1653_flash *flash)
 		return -EIO;
 	}
=20
+	dev_info(&client->dev, "adp1653 device ok\n", __func__);
+
 	return 0;
 }
=20
@@ -492,6 +494,8 @@ static int adp1653_probe(struct i2c_client *client,
 	if (flash =3D=3D NULL)
 		return -ENOMEM;
=20
+	dev_info(&client->dev, "adp1653 probe\n");
+=09
 	if (client->dev.of_node) {
 		ret =3D adp1653_of_init(client, flash, client->dev.of_node);
 		if (ret)
@@ -505,11 +509,13 @@ static int adp1653_probe(struct i2c_client *clien=
t,
 		flash->platform_data =3D client->dev.platform_data;
 	}
=20
+	dev_info(&client->dev, "adp1653 probe: subdev\n", __func__);=09
 	mutex_init(&flash->power_lock);
=20
 	v4l2_i2c_subdev_init(&flash->subdev, client, &adp1653_ops);
 	flash->subdev.internal_ops =3D &adp1653_internal_ops;
 	flash->subdev.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
+	strcpy(flash->subdev.name, "adp1653 flash");
=20
 	ret =3D adp1653_init_controls(flash);
 	if (ret)
@@ -519,6 +525,14 @@ static int adp1653_probe(struct i2c_client *client=
,
 	if (ret < 0)
 		goto free_and_quit;
=20
+	dev_info(&client->dev, "adp1653 probe: should be ok\n");
+
+	ret =3D v4l2_async_register_subdev(&flash->subdev);
+	if (ret < 0)
+		goto free_and_quit;
+
+	dev_info(&client->dev, "adp1653 probe: async register subdev ok\n");=09
+
 	flash->subdev.entity.function =3D MEDIA_ENT_F_FLASH;
=20
 	return 0;
@@ -538,6 +552,8 @@ static int adp1653_remove(struct i2c_client *client=
)
 	v4l2_ctrl_handler_free(&flash->ctrls);
 	media_entity_cleanup(&flash->subdev.entity);
=20
+	dev_info(&client->dev, "adp1653 remove\n");		=09
+
 	return 0;
 }
=20
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/plat=
form/omap3isp/isp.c
index 6361fde..23d484c 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -2095,13 +2095,20 @@ static void isp_of_parse_node_csi2(struct devic=
e *dev,
 	buscfg->bus.csi2.crc =3D 1;
 }
=20
-static int isp_of_parse_node(struct device *dev, struct device_node *n=
ode,
-			     struct isp_async_subdev *isd)
+static int isp_of_parse_node_endpoint(struct device *dev,
+				      struct device_node *node,
+				      struct isp_async_subdev *isd)
 {
-	struct isp_bus_cfg *buscfg =3D &isd->bus;
+	struct isp_bus_cfg *buscfg;
 	struct v4l2_of_endpoint vep;
 	int ret;
=20
+	isd->bus =3D devm_kzalloc(dev, sizeof(*isd->bus), GFP_KERNEL);
+	if (!isd->bus)
+		return -ENOMEM;
+
+	buscfg =3D isd->bus;
+
 	ret =3D v4l2_of_parse_endpoint(node, &vep);
 	if (ret)
 		return ret;
@@ -2144,10 +2151,51 @@ static int isp_of_parse_node(struct device *dev=
, struct device_node *node,
 	return 0;
 }
=20
+static int isp_of_parse_node(struct device *dev, struct device_node *n=
ode,
+			     struct v4l2_async_notifier *notifier,
+			     u32 group_id, bool link)
+{
+	struct isp_async_subdev *isd;
+
+	isd =3D devm_kzalloc(dev, sizeof(*isd), GFP_KERNEL);
+	if (!isd) {
+		of_node_put(node);
+		return -ENOMEM;
+	}
+
+	notifier->subdevs[notifier->num_subdevs] =3D &isd->asd;
+
+	if (link) {
+		if (isp_of_parse_node_endpoint(dev, node, isd)) {
+			of_node_put(node);
+			return -EINVAL;
+		}
+
+		isd->asd.match.of.node =3D of_graph_get_remote_port_parent(node);
+		of_node_put(node);
+	} else {
+		isd->asd.match.of.node =3D node;
+	}
+
+	if (!isd->asd.match.of.node) {
+		dev_warn(dev, "bad remote port parent\n");
+		return -EINVAL;
+	}
+
+	isd->asd.match_type =3D V4L2_ASYNC_MATCH_OF;
+	isd->group_id =3D group_id;
+	notifier->num_subdevs++;
+
+	return 0;
+}
+
 static int isp_of_parse_nodes(struct device *dev,
 			      struct v4l2_async_notifier *notifier)
 {
 	struct device_node *node =3D NULL;
+	int ret;
+	unsigned int flash =3D 0;
+	u32 group_id =3D 0;
=20
 	notifier->subdevs =3D devm_kcalloc(
 		dev, ISP_MAX_SUBDEVS, sizeof(*notifier->subdevs), GFP_KERNEL);
@@ -2156,30 +2204,57 @@ static int isp_of_parse_nodes(struct device *de=
v,
=20
 	while (notifier->num_subdevs < ISP_MAX_SUBDEVS &&
 	       (node =3D of_graph_get_next_endpoint(dev->of_node, node))) {
-		struct isp_async_subdev *isd;
+		ret =3D isp_of_parse_node(dev, node, notifier, group_id++, true);
+		if (ret)
+			return ret;
+	}
=20
-		isd =3D devm_kzalloc(dev, sizeof(*isd), GFP_KERNEL);
-		if (!isd) {
-			of_node_put(node);
-			return -ENOMEM;
-		}
+	while (notifier->num_subdevs < ISP_MAX_SUBDEVS &&
+	       (node =3D of_parse_phandle(dev->of_node, "ti,camera-flashes",
+					flash++))) {
+		struct device_node *sensor_node =3D
+			of_parse_phandle(dev->of_node, "ti,camera-flashes",
+					 flash++);
+		unsigned int i;
+		u32 flash_group_id;
+
+		if (!sensor_node)
+			return -EINVAL;
=20
-		notifier->subdevs[notifier->num_subdevs] =3D &isd->asd;
+		for (i =3D 0; i < notifier->num_subdevs; i++) {
+			struct isp_async_subdev *isd =3D container_of(
+				notifier->subdevs[i], struct isp_async_subdev,
+				asd);
=20
-		if (isp_of_parse_node(dev, node, isd)) {
-			of_node_put(node);
-			return -EINVAL;
+			if (!isd->bus)
+				continue;
+
+			dev_dbg(dev, "match \"%s\", \"%s\"\n",sensor_node->name,
+				isd->asd.match.of.node->name);
+
+			if (sensor_node !=3D isd->asd.match.of.node)
+				continue;
+
+			dev_dbg(dev, "found\n");
+
+			flash_group_id =3D isd->group_id;
+			break;
 		}
=20
-		isd->asd.match.of.node =3D of_graph_get_remote_port_parent(node);
-		of_node_put(node);
-		if (!isd->asd.match.of.node) {
-			dev_warn(dev, "bad remote port parent\n");
-			return -EINVAL;
+		/*
+		 * No sensor was found --- complain and allocate a new
+		 * group ID.
+		 */
+		if (i =3D=3D notifier->num_subdevs) {
+			dev_warn(dev, "no device node \"%s\" was found",
+				 sensor_node->name);
+			flash_group_id =3D group_id++;
 		}
=20
-		isd->asd.match_type =3D V4L2_ASYNC_MATCH_OF;
-		notifier->num_subdevs++;
+		ret =3D isp_of_parse_node(dev, node, notifier, flash_group_id,
+					false);
+		if (ret)
+			return ret;
 	}
=20
 	return notifier->num_subdevs;
@@ -2192,8 +2267,9 @@ static int isp_subdev_notifier_bound(struct v4l2_=
async_notifier *async,
 	struct isp_async_subdev *isd =3D
 		container_of(asd, struct isp_async_subdev, asd);
=20
+//	subdev->entity.group_id =3D isd->group_id;
 	isd->sd =3D subdev;
-	isd->sd->host_priv =3D &isd->bus;
+	isd->sd->host_priv =3D isd->bus;
=20
 	return 0;
 }
@@ -2396,12 +2472,15 @@ static int isp_probe(struct platform_device *pd=
ev)
 	if (ret < 0)
 		goto error_register_entities;
=20
-	isp->notifier.bound =3D isp_subdev_notifier_bound;
-	isp->notifier.complete =3D isp_subdev_notifier_complete;
+	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
+		isp->notifier.bound =3D isp_subdev_notifier_bound;
+		isp->notifier.complete =3D isp_subdev_notifier_complete;
=20
-	ret =3D v4l2_async_notifier_register(&isp->v4l2_dev, &isp->notifier);
-	if (ret)
-		goto error_register_entities;
+		ret =3D v4l2_async_notifier_register(&isp->v4l2_dev,
+						   &isp->notifier);
+		if (ret)
+			goto error_register_entities;
+	}
=20
 	isp_core_init(isp, 1);
 	omap3isp_put(isp);
diff --git a/drivers/media/platform/omap3isp/isp.h b/drivers/media/plat=
form/omap3isp/isp.h
index 7e6f663..639b3ca 100644
--- a/drivers/media/platform/omap3isp/isp.h
+++ b/drivers/media/platform/omap3isp/isp.h
@@ -228,8 +228,9 @@ struct isp_device {
=20
 struct isp_async_subdev {
 	struct v4l2_subdev *sd;
-	struct isp_bus_cfg bus;
+	struct isp_bus_cfg *bus;
 	struct v4l2_async_subdev asd;
+	u32 group_id;
 };
=20
 #define v4l2_dev_to_isp_device(dev) \
diff --git a/drivers/media/platform/omap3isp/ispcsiphy.c b/drivers/medi=
a/platform/omap3isp/ispcsiphy.c
index 495447d..750ce93 100644
--- a/drivers/media/platform/omap3isp/ispcsiphy.c
+++ b/drivers/media/platform/omap3isp/ispcsiphy.c
@@ -177,7 +177,7 @@ static int omap3isp_csiphy_config(struct isp_csiphy=
 *phy)
 		struct isp_async_subdev *isd =3D
 			container_of(pipe->external->asd,
 				     struct isp_async_subdev, asd);
-		buscfg =3D &isd->bus;
+		buscfg =3D isd->bus;
 	}
=20
 	if (buscfg->interface =3D=3D ISP_INTERFACE_CCP2B_PHY1
diff --git a/include/media/ad5820.h b/include/media/ad5820.h
new file mode 100644
index 0000000..f5a1565
--- /dev/null
+++ b/include/media/ad5820.h
@@ -0,0 +1,70 @@
+/*
+ * include/media/ad5820.h
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * Contact: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
+ *          Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * Based on af_d88.c by Texas Instruments.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#ifndef AD5820_H
+#define AD5820_H
+
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/videodev2.h>
+
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-subdev.h>
+
+struct regulator;
+
+#define AD5820_NAME		"ad5820"
+#define AD5820_I2C_ADDR		(0x18 >> 1)
+
+/* Register definitions */
+#define AD5820_POWER_DOWN		(1 << 15)
+#define AD5820_DAC_SHIFT		4
+#define AD5820_RAMP_MODE_LINEAR		(0 << 3)
+#define AD5820_RAMP_MODE_64_16		(1 << 3)
+
+struct ad5820_platform_data {
+	int (*set_xshutdown)(struct v4l2_subdev *subdev, int set);
+};
+
+#define to_ad5820_device(sd)	container_of(sd, struct ad5820_device, su=
bdev)
+
+struct ad5820_device {
+	struct v4l2_subdev subdev;
+	struct ad5820_platform_data *platform_data;
+	struct regulator *vana;
+
+	struct v4l2_ctrl_handler ctrls;
+	u32 focus_absolute;
+	u32 focus_ramp_time;
+	u32 focus_ramp_mode;
+
+	struct mutex power_lock;
+	int power_count;
+
+	int standby : 1;
+};
+
+#endif /* AD5820_H */


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
