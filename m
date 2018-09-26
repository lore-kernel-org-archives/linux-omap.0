From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 7/9] leds: lm3633: Introduce the lm3633 driver
Date: Thu, 27 Sep 2018 00:36:12 +0200
Message-ID: <20180926223612.GA32286@amd>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-8-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926130921.12329-8-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduce the LED LM3633 driver.  This LED
> driver has 9 total LED outputs with runtime
> internal ramp configurations.
>=20
> Data sheet:
> http://www.ti.com/lit/ds/symlink/lm3633.pdf
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

I did some editing... and this code looks very similar to 3697 code.

> diff --git a/drivers/leds/leds-lm3633.c b/drivers/leds/leds-lm3633.c
> new file mode 100644
> index 000000000000..3d29b0ed67d3
> --- /dev/null
> +++ b/drivers/leds/leds-lm3633.c
> @@ -0,0 +1,430 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// TI LM3633 LED chip family driver
> +// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <uapi/linux/uleds.h>
> +
> +#include "ti-lmu-led-common.h"

You might want to move includes to ti-lmu-led-common.h, so these are
not repeated?

> +/**
> + * struct lm3633 -
> + * @enable_gpio - Hardware enable gpio
> + * @regulator - LED supply regulator pointer
> + * @client - Pointer to the I2C client
> + * @regmap - Devices register map
> + * @dev - Pointer to the devices device struct
> + * @lock - Lock for reading/writing the device
> + * @leds - Array of LED strings
> + */
> +struct lm3633 {
> +	struct gpio_desc *enable_gpio;
> +	struct regulator *regulator;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock;
> +	struct lm3633_led leds[];
> +};

Exactly same structure is used for 3697. Worth sharing?

> +static const struct regmap_config lm3633_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +
> +	.max_register =3D LM3633_CTRL_ENABLE,
> +	.reg_defaults =3D lm3633_reg_defs,
> +	.num_reg_defaults =3D ARRAY_SIZE(lm3633_reg_defs),
> +	.cache_type =3D REGCACHE_FLAT,
> +};

Same regmap config. Maybe difficult to share.

> +static int lm3633_brightness_set(struct led_classdev *led_cdev,
> +				enum led_brightness brt_val)
> +{
> +	struct lm3633_led *led =3D container_of(led_cdev, struct lm3633_led,
> +					      led_dev);
> +	int ctrl_en_val;
> +	int ret;
> +
> +	mutex_lock(&led->priv->lock);
> +
> +	if (led->control_bank =3D=3D LM3633_CONTROL_A) {
> +		led->lmu_data.msb_brightness_reg =3D LM3633_CTRL_A_BRT_MSB;
> +		led->lmu_data.lsb_brightness_reg =3D LM3633_CTRL_A_BRT_LSB;
> +		ctrl_en_val =3D LM3633_CTRL_A_EN;
> +	} else {
> +		led->lmu_data.msb_brightness_reg =3D LM3633_CTRL_B_BRT_MSB;
> +		led->lmu_data.lsb_brightness_reg =3D LM3633_CTRL_B_BRT_LSB;
> +		ctrl_en_val =3D LM3633_CTRL_B_EN;
> +	}
> +
> +	if (brt_val =3D=3D LED_OFF)
> +		ret =3D regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
> +					 ctrl_en_val, ~ctrl_en_val);
> +	else
> +		ret =3D regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
> +					 ctrl_en_val, ctrl_en_val);
> +
> +	ret =3D ti_lmu_common_set_brightness(&led->lmu_data, brt_val);
> +	if (ret)
> +		dev_err(&led->priv->client->dev, "Cannot write brightness\n");
> +
> +	mutex_unlock(&led->priv->lock);
> +	return ret;
> +}

Duplicate of 3697 function with different constants.

> +static int lm3633_set_control_bank(struct lm3633 *priv)
> +{
> +	u8 control_bank_config =3D 0;
> +	struct lm3633_led *led;
> +	int ret, i;
> +
> +	led =3D &priv->leds[0];
> +	if (led->control_bank =3D=3D LM3633_CONTROL_A)
> +		led =3D &priv->leds[1];
> +
> +	for (i =3D 0; i < LM3633_MAX_HVLED_STRINGS; i++)
> +		if (led->hvled_strings[i] =3D=3D LM3633_HVLED_ASSIGNMENT)
> +			control_bank_config |=3D 1 << i;
> +
> +	ret =3D regmap_write(priv->regmap, LM3633_HVLED_OUTPUT_CONFIG,
> +			   control_bank_config);
> +	if (ret)
> +		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
> +
> +	return ret;
> +}

Duplicate of 3697 function.

> +static int lm3633_init(struct lm3633 *priv)
> +{
> +	struct lm3633_led *led;
> +	int i, ret;
> +
> +	if (priv->enable_gpio) {
> +		gpiod_direction_output(priv->enable_gpio, 1);
> +	} else {
> +		ret =3D regmap_write(priv->regmap, LM3633_RESET, LM3633_SW_RESET);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "Cannot reset the device\n");
> +			goto out;
> +		}
> +	}
> +
> +	ret =3D regmap_write(priv->regmap, LM3633_CTRL_ENABLE, 0x0);
> +	if (ret) {
> +		dev_err(&priv->client->dev, "Cannot write ctrl enable\n");
> +		goto out;
> +	}
> +
> +	ret =3D lm3633_set_control_bank(priv);
> +	if (ret)
> +		dev_err(&priv->client->dev, "Setting the CRTL bank failed\n");
> +
> +	for (i =3D 0; i < LM3633_MAX_CONTROL_BANKS; i++) {
> +		led =3D &priv->leds[i];
> +		ti_lmu_common_set_ramp(&led->lmu_data);
> +		if (ret)
> +			dev_err(&priv->client->dev, "Setting the ramp rate failed\n");
> +	}
> +out:
> +	return ret;
> +}

Duplicate of 3697 function.

> +static int lm3633_probe_dt(struct lm3633 *priv)
> +{
> +	struct fwnode_handle *child =3D NULL;
> +	struct lm3633_led *led;
> +	const char *name;
> +	int control_bank;
> +	size_t i =3D 0;
> +	int ret;
> +
> +	priv->enable_gpio =3D devm_gpiod_get_optional(&priv->client->dev,
> +						   "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->enable_gpio)) {
> +		ret =3D PTR_ERR(priv->enable_gpio);
> +		dev_err(&priv->client->dev, "Failed to get enable gpio: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	priv->regulator =3D devm_regulator_get(&priv->client->dev, "vled");
> +	if (IS_ERR(priv->regulator))
> +		priv->regulator =3D NULL;
> +
> +	device_for_each_child_node(priv->dev, child) {
> +		ret =3D fwnode_property_read_u32(child, "reg", &control_bank);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "reg property missing\n");
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		if (control_bank > LM3633_CONTROL_B) {
> +			dev_err(&priv->client->dev, "reg property is invalid\n");
> +			ret =3D -EINVAL;
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		led =3D &priv->leds[i];
> +
> +		led->control_bank =3D control_bank;
> +		led->lmu_data.bank_id =3D control_bank;
> +		led->lmu_data.enable_reg =3D LM3633_CTRL_ENABLE;
> +		led->lmu_data.regmap =3D priv->regmap;
> +		if (control_bank =3D=3D LM3633_CONTROL_A)
> +			led->lmu_data.runtime_ramp_reg =3D LM3633_CTRL_A_RAMP;
> +		else
> +			led->lmu_data.runtime_ramp_reg =3D LM3633_CTRL_B_RAMP;
> +
> +		if (control_bank <=3D LM3633_CONTROL_B)
> +			ret =3D fwnode_property_read_u32_array(child, "led-sources",
> +						    led->hvled_strings,
> +						    LM3633_MAX_HVLED_STRINGS);
> +		else
> +			ret =3D fwnode_property_read_u32_array(child, "led-sources",
> +						    led->lvled_strings,
> +						    LM3633_MAX_LVLED_STRINGS);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "led-sources property missing\n");
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		ret =3D ti_lmu_common_get_ramp_params(&priv->client->dev, child, &led-=
>lmu_data);
> +		if (ret)
> +			dev_warn(&priv->client->dev, "runtime-ramp properties missing\n");
> +
> +		fwnode_property_read_string(child, "linux,default-trigger",
> +					    &led->led_dev.default_trigger);
> +
> +		ret =3D fwnode_property_read_string(child, "label", &name);
> +		if (ret)
> +			snprintf(led->label, sizeof(led->label),
> +				"%s::", priv->client->name);
> +		else
> +			snprintf(led->label, sizeof(led->label),
> +				 "%s:%s", priv->client->name, name);
> +
> +		led->priv =3D priv;
> +		led->led_dev.name =3D led->label;
> +		led->led_dev.brightness_set_blocking =3D lm3633_brightness_set;
> +
> +		ret =3D devm_led_classdev_register(priv->dev, &led->led_dev);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "led register err: %d\n",
> +				ret);
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		i++;
> +	}
> +
> +child_out:
> +	return ret;
> +}

Very similar, but not quite same.

> +static int lm3633_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct lm3633 *led;
> +	int count;
> +	int ret;
> +
> +	count =3D device_get_child_node_count(&client->dev);
> +	if (!count) {
> +		dev_err(&client->dev, "LEDs are not defined in device tree!");
> +		return -ENODEV;
> +	}
> +
> +	led =3D devm_kzalloc(&client->dev, struct_size(led, leds, count),
> +			   GFP_KERNEL);
> +	if (!led)
> +		return -ENOMEM;
> +
> +	mutex_init(&led->lock);
> +	i2c_set_clientdata(client, led);
> +
> +	led->client =3D client;
> +	led->dev =3D &client->dev;
> +	led->regmap =3D devm_regmap_init_i2c(client, &lm3633_regmap_config);
> +	if (IS_ERR(led->regmap)) {
> +		ret =3D PTR_ERR(led->regmap);
> +		dev_err(&client->dev, "Failed to allocate register map: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret =3D lm3633_probe_dt(led);
> +	if (ret)
> +		return ret;
> +
> +	return lm3633_init(led);
> +}

Duplicate.

> +static int lm3633_remove(struct i2c_client *client)
> +{
> +	struct lm3633 *led =3D i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret =3D regmap_update_bits(led->regmap, LM3633_CTRL_ENABLE,
> +				 LM3633_CTRL_A_B_EN, 0);
> +	if (ret) {
> +		dev_err(&led->client->dev, "Failed to disable the device\n");
> +		return ret;
> +	}
> +
> +	if (led->enable_gpio)
> +		gpiod_direction_output(led->enable_gpio, 0);
> +
> +	if (led->regulator) {
> +		ret =3D regulator_disable(led->regulator);
> +		if (ret)
> +			dev_err(&led->client->dev,
> +				"Failed to disable regulator\n");
> +	}
> +
> +	mutex_destroy(&led->lock);
> +
> +	return 0;
> +}

Duplicate.

Can we get some more sharing? One way would be to have struct with
all the constants (instead of #defines) use that...?

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlusCdwACgkQMOfwapXb+vIMeQCgt/BFsztdwtGe/a74jaCOFVbQ
pRgAn1JCsTRDgYbhoPHFrCEoy1iQgamP
=g1HH
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
