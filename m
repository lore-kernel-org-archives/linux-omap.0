From: Sebastian Reichel <sre@kernel.org>
Subject: Re: bh1770 hacks: get it to work on n950
Date: Fri, 17 Nov 2017 12:35:40 +0100
Message-ID: <20171117113540.3bapqvq6mfuovxuw@earth>
References: <20171116115703.GA26735@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="egdkituyjl4jzuhi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171116115703.GA26735@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, arnd@arndb.de, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--egdkituyjl4jzuhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 16, 2017 at 12:57:03PM +0100, Pavel Machek wrote:
> Hi!
>=20
> Ok, not for application, but I can get light sensor to work.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

There is no mainline user of this driver and it has a custom API, so
I think the driver should be dropped and an IIO based one should be
created instead.

-- Sebastian

> diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n=
950.dts
> index 50c4fc6..15841f7 100644
> --- a/arch/arm/boot/dts/omap3-n950.dts
> +++ b/arch/arm/boot/dts/omap3-n950.dts
> @@ -150,6 +150,23 @@
>                 };
>         };
> =20
> +       bh1770@38 {
> +       		 compatible =3D "bh1770glc";
> +		 reg =3D <0x38>;
> +
> +		 vdd-supply =3D <&vaux1>;
> +		 leds-supply =3D <&vaux1>; /* FIXME: really on vbat */
> +
> +		 /* GPIO 83 on n950.
> + 		 .leds              =3D BHSFH_LED1,
> + 		 .led_max_curr      =3D BHSFH_LED_100mA,
> + 		 .led_def_curr      =3D BHSFH_LED_50mA,
> + 		 .glass_attenuation =3D (16384 * 385) / 100, ... about 3.85x filtering
> + 		 */
> +       };
> +
> +       /* Also TLV320DAC33 and TPA6130A2 */
> +
>  	touch@4b {
>  		compatible =3D "atmel,maxtouch";
>  		reg =3D <0x4b>;
> diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
> index 9c62bf0..f08df29 100644
> --- a/drivers/misc/bh1770glc.c
> +++ b/drivers/misc/bh1770glc.c
> @@ -22,6 +22,7 @@
>   *
>   */
> =20
> +#define DEBUG
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> @@ -525,16 +526,22 @@ static int bh1770_detect(struct bh1770_chip *chip)
>  	s32 ret;
>  	u8 manu, part;
> =20
> +	printk("Detect...\n");
> +
>  	ret =3D i2c_smbus_read_byte_data(client, BH1770_MANUFACT_ID);
>  	if (ret < 0)
>  		goto error;
>  	manu =3D (u8)ret;
> =20
> +	printk("Detect... manufact\n");
> +
>  	ret =3D i2c_smbus_read_byte_data(client, BH1770_PART_ID);
>  	if (ret < 0)
>  		goto error;
>  	part =3D (u8)ret;
> =20
> +	printk("Detect... part ... got %x %x\n", manu, part);
> +
>  	chip->revision =3D (part & BH1770_REV_MASK) >> BH1770_REV_SHIFT;
>  	chip->prox_coef =3D BH1770_COEF_SCALER;
>  	chip->prox_const =3D 0;
> @@ -1179,6 +1186,8 @@ static const struct attribute_group bh1770_attribut=
e_group =3D {
>  	.attrs =3D sysfs_attrs
>  };
> =20
> +struct bh1770_platform_data def =3D {};
> +
>  static int bh1770_probe(struct i2c_client *client,
>  				const struct i2c_device_id *id)
>  {
> @@ -1189,6 +1198,8 @@ static int bh1770_probe(struct i2c_client *client,
>  	if (!chip)
>  		return -ENOMEM;
> =20
> +	printk("bh1770: probe\n");
> +
>  	i2c_set_clientdata(client, chip);
>  	chip->client  =3D client;
> =20
> @@ -1198,10 +1209,12 @@ static int bh1770_probe(struct i2c_client *client,
> =20
>  	if (client->dev.platform_data =3D=3D NULL) {
>  		dev_err(&client->dev, "platform data is mandatory\n");
> -		return -EINVAL;
> +		//return -EINVAL;
>  	}
> =20
>  	chip->pdata		=3D client->dev.platform_data;
> +	if (!chip->pdata)
> +		chip->pdata =3D &def;
>  	chip->lux_calib		=3D BH1770_LUX_NEUTRAL_CALIB_VALUE;
>  	chip->lux_rate_index	=3D BH1770_LUX_DEFAULT_RATE;
>  	chip->lux_threshold_lo	=3D BH1770_LUX_DEF_THRES;
> @@ -1220,6 +1233,8 @@ static int bh1770_probe(struct i2c_client *client,
>  	chip->prox_rate		=3D BH1770_PROX_DEFAULT_RATE;
>  	chip->prox_data		=3D 0;
> =20
> +	printk("bh1770: regulators\n");
> +=09
>  	chip->regs[0].supply =3D reg_vcc;
>  	chip->regs[1].supply =3D reg_vleds;
> =20
> @@ -1227,14 +1242,12 @@ static int bh1770_probe(struct i2c_client *client,
>  				      ARRAY_SIZE(chip->regs), chip->regs);
>  	if (err < 0) {
>  		dev_err(&client->dev, "Cannot get regulators\n");
> -		return err;
>  	}
> =20
>  	err =3D regulator_bulk_enable(ARRAY_SIZE(chip->regs),
>  				chip->regs);
>  	if (err < 0) {
>  		dev_err(&client->dev, "Cannot enable regulators\n");
> -		return err;
>  	}
> =20
>  	usleep_range(BH1770_STARTUP_DELAY, BH1770_STARTUP_DELAY * 2);
> @@ -1242,6 +1255,8 @@ static int bh1770_probe(struct i2c_client *client,
>  	if (err < 0)
>  		goto fail0;
> =20
> +	printk("bh1770: detected\n");
> +
>  	/* Start chip */
>  	bh1770_chip_on(chip);
>  	pm_runtime_set_active(&client->dev);
> @@ -1269,6 +1284,8 @@ static int bh1770_probe(struct i2c_client *client,
>  		goto fail1;
>  	}
> =20
> +	printk("bh1770: sysfs ok\n");
> +=09
>  	/*
>  	 * Chip needs level triggered interrupt to work. However,
>  	 * level triggering doesn't work always correctly with power
> @@ -1282,8 +1299,12 @@ static int bh1770_probe(struct i2c_client *client,
>  	if (err) {
>  		dev_err(&client->dev, "could not get IRQ %d\n",
>  			client->irq);
> -		goto fail2;
> +		//goto fail2;
>  	}
> +
> +	printk("bh1770: irq ok, all done\n");
> +	err =3D 0;
> +=09
>  	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
>  	return err;
>  fail2:
> @@ -1393,10 +1414,18 @@ static const struct dev_pm_ops bh1770_pm_ops =3D {
>  	SET_RUNTIME_PM_OPS(bh1770_runtime_suspend, bh1770_runtime_resume, NULL)
>  };
> =20
> +#ifdef CONFIG_OF
> +static const struct of_device_id bh1770_of_match_table[] =3D {
> +	{ .compatible =3D "bq27200" },
> +};
> +MODULE_DEVICE_TABLE(of, bh1770_of_match_table);
> +#endif=09
> +
>  static struct i2c_driver bh1770_driver =3D {
>  	.driver	 =3D {
>  		.name	=3D "bh1770glc",
>  		.pm	=3D &bh1770_pm_ops,
> +		.of_match_table =3D of_match_ptr(bh1770_of_match_table),
>  	},
>  	.probe	  =3D bh1770_probe,
>  	.remove	  =3D bh1770_remove,
>=20
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--egdkituyjl4jzuhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloOyYkACgkQ2O7X88g7
+po7Hg//Um8xFMxTaWkoRsS8eGhEsSbMnLsgBUuwCvp9ReI8G6pM8wB9aTVcjFyC
H+FoECanDIe3kOjWV87giLS8zoyxKOhogJpkaC1Cz69ql+Tc0+0B3HRS8WMMyKAC
ovDNITviuVKkEQkkxdIrBXDlBWbg3RSVd292NCj51WXVPYEynav+bSaUFKAFqWEk
Z60ARCz0tDdFFd6VINFD/lxI1CdIv7qJlQHUG72ggfDsIYJ/jTfJO1HJGDfGUuYH
2BFSobGos8gw0777fQLV2NnZtxJu2c6TiYvTcCxtwFHP8sa6SE7hmcf38NwAsQLS
rGz6biIk5FgBp1yRGtI05M4uNhKv/iv7FJQVVKAD2a+DvLjFmmNHgKZ5pr5F9Mk5
w+AyovfRZEPS1fYhlbrTUHVwIOvAVsNn+Pwt5bJ0FY/15RfpYdx+I/Xm4gF1Qvl7
3P6H4CIKWd8fd8OyIEJqCZY5GVvzOcjRcKPIMdEc/jWFDwRstlb+WPXn6wlxDbZW
Vxo1C5wdNPGCcjZX0b4JZkP9ebuMF/FVFocphCypav49nvwHuHoJ4tNr/nGw+JhX
b+N9fJuN3NRJ0igJZuWweyHsVPA9eqja/JC4ulN3TYx8zgt3rv7RCDKLhRiUsLeQ
pctfxQ8oElJbHOOEwvUxCMHb3xCen+ph6IFugt2anOL3YZyhTFs=
=n3yB
-----END PGP SIGNATURE-----

--egdkituyjl4jzuhi--
