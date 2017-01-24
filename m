From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Tue, 24 Jan 2017 15:15:48 +0100
Message-ID: <20170124141548.GA14489@amd>
References: <20170123124058.GA17134@amd>
 <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd>
 <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface>
 <b6d1670c-a83f-55aa-efd1-e52adb297ac6@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6d1670c-a83f-55aa-efd1-e52adb297ac6@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Zhang Rui <rui.zhang@intel.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>>/sys files related to battery no longer appear. I beieve this has
> >>>>something to do with it:
> >>>>
> >>>>[    2.374877] of_get_named_gpiod_flags: parsed 'reset-gpios' property
> >>>>of node '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
> >>>>[    2.375946] input: TSC2005 touchscreen as
> >>>>/devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/in=
put/input5
> >>>>[    2.392120] rx51-battery: probe of n900-battery failed with error
> >>>>-22
> >>>
> >>>Mystery solved:
> >>>
> >>>diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> >>>index 3932f92..fe5ec82 100644
> >>>--- a/drivers/hwmon/hwmon.c
> >>>+++ b/drivers/hwmon/hwmon.c
> >>>@@ -545,8 +545,10 @@ __hwmon_device_register(struct device *dev, const=
 char *name, void *drvdata,
> >>> 	int i, j, err, id;
> >>>
> >>> 	/* Do not accept invalid characters in hwmon name attribute */
> >>>-	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
> >>>+	if (name && (!strlen(name) || strpbrk(name, "-* \t\n"))) {
> >>>+		printk("hwmon: Invalid character detected: %s\n", name);
> >>> 		return ERR_PTR(-EINVAL);
> >>>+	}
> >>>
> >>> 	id =3D ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
> >>> 	if (id < 0)
> >>>
> >>>
> >>>pavel@n900:~$ dmesg | grep -5 Invalid
> >>>[    0.829650] of_get_named_gpiod_flags: parsed 'gpio-reset' property
> >>>of node '/ocp@68000000/i2c@48072000/tlv320aic3x@19[0]' - status (0)
> >>>[    0.833831] tsl2563 2-0029: model 7, rev. 0
> >>>[    0.837768] of_get_named_gpiod_flags: parsed 'enable-gpio' property
> >>>of node '/ocp@68000000/i2c@48072000/lp5523@32[0]' - status (0)
> >>>[    1.921417] omap_i2c 48072000.i2c: controller timed out
> >>>[    2.056823] lp5523x 2-0032: lp5523 Programmable led chip found
> >>>[    2.064147] hwmon: Invalid character detected: bq27200-0
> >>
> >>So the problem is really that the thermal driver needs to create a vali=
d name.
> >>
> >Right.
> >
> >Before reverting, can you please try if this patch works or not?

> >diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_h=
wmon.c
> >index c4a508a..0c6789f 100644
> >--- a/drivers/thermal/thermal_hwmon.c
> >+++ b/drivers/thermal/thermal_hwmon.c
> >@@ -157,8 +157,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_devi=
ce *tz)
> >
> > 	INIT_LIST_HEAD(&hwmon->tz_list);
> > 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> >-	hwmon->device =3D hwmon_device_register_with_info(NULL, hwmon->type,
> >-							hwmon, NULL, NULL);
> >+	hwmon->device =3D hwmon_device_register_with_info(NULL, NULL, NULL,
> >+							NULL, NULL);
>=20
> This is wrong. The name should be converted to a valid name. Otherwise yo=
u would
> still have to provide the name attribute yourself, and the resulting name=
 would
> still be invalid. A simple fix would be to add
> 	strreplace(hwmon->type, '-', '_');
> after strlcpy().

Simple, yes. But that will change userland interface. Is it okay thing
to do?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliHYZQACgkQMOfwapXb+vIZ7gCeL4wb6UjV39P/AeXDJMLTKc1T
H5UAoLDJ0yaGQiCl/gBfmTQyPA71etds
=XB0B
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
