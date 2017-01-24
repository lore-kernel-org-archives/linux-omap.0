From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Tue, 24 Jan 2017 08:37:20 +0100
Message-ID: <20170124073720.GB5603@amd>
References: <20170123124058.GA17134@amd>
 <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd>
 <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124070639.GA5068@rzhang1-surface>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-01-24 15:06:39, Zhang Rui wrote:
> On Mon, Jan 23, 2017 at 03:49:12PM -0800, Guenter Roeck wrote:
> > On Tue, Jan 24, 2017 at 12:26:54AM +0100, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > > >I'll try to revert it on the top of v4.10-rc5 now... and yes, it=
 fixes
> > > > > >the issue.
> > > > > >
> > > > > >Any idea what went wrong and how to fix that?
> > > > > >
> > > > > >Anyway as we are at -rc5 and this is warning fix that caused a
> > > > > >regression on different hardware... it should be reverted.
> > > > > >
> > > > > Agreed.
> > > > >=20
> > > > > What exactly does "stopped working" mean ? That might help unders=
tanding
> > > > > what went wrong.
> > > >=20
> > > > /sys files related to battery no longer appear. I beieve this has
> > > > something to do with it:
> > > >=20
> > > > [    2.374877] of_get_named_gpiod_flags: parsed 'reset-gpios' prope=
rty
> > > > of node '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
> > > > [    2.375946] input: TSC2005 touchscreen as
> > > > /devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/=
input/input5
> > > > [    2.392120] rx51-battery: probe of n900-battery failed with error
> > > > -22
> > >=20
> > > Mystery solved:
> > >=20
> > > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > > index 3932f92..fe5ec82 100644
> > > --- a/drivers/hwmon/hwmon.c
> > > +++ b/drivers/hwmon/hwmon.c
> > > @@ -545,8 +545,10 @@ __hwmon_device_register(struct device *dev, cons=
t char *name, void *drvdata,
> > >  	int i, j, err, id;
> > > =20
> > >  	/* Do not accept invalid characters in hwmon name attribute */
> > > -	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
> > > +	if (name && (!strlen(name) || strpbrk(name, "-* \t\n"))) {
> > > +		printk("hwmon: Invalid character detected: %s\n", name);
> > >  		return ERR_PTR(-EINVAL);
> > > +	}
> > > =20
> > >  	id =3D ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
> > >  	if (id < 0)
> > >=20
> > >=20
> > > pavel@n900:~$ dmesg | grep -5 Invalid
> > > [    0.829650] of_get_named_gpiod_flags: parsed 'gpio-reset' property
> > > of node '/ocp@68000000/i2c@48072000/tlv320aic3x@19[0]' - status (0)
> > > [    0.833831] tsl2563 2-0029: model 7, rev. 0
> > > [    0.837768] of_get_named_gpiod_flags: parsed 'enable-gpio' property
> > > of node '/ocp@68000000/i2c@48072000/lp5523@32[0]' - status (0)
> > > [    1.921417] omap_i2c 48072000.i2c: controller timed out
> > > [    2.056823] lp5523x 2-0032: lp5523 Programmable led chip found
> > > [    2.064147] hwmon: Invalid character detected: bq27200-0
> >=20
> > So the problem is really that the thermal driver needs to create a vali=
d name.
> >
> Right.
>=20
> Before reverting, can you please try if this patch works or not?

Not really. Revert now. Sorry.

Are you sure? This does not look equivalent to me at all.

"name" file handling moved from drivers to the core, which added some
crazy checks what name can contain. Even if this "works", what is the
expected effect on the "name" file?

								Pavel

> thanks,
> rui
>=20
> >From 79320ea3721314ec29ed6cdd6987ff922b11d6f9 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Tue, 24 Jan 2017 14:11:03 +0800
> Subject: [PATCH] thermal: fix parameter when registering hwmon
>=20
> commit 7611fb68062f ("thermal: thermal_hwmon: Convert to
> hwmon_device_register_with_info()") converts thermal core to use
> hwmon_device_register_with_info() to register to hwmon instead of
> deprecated hwmon_device_register().
> But at the same time, the name of the hwmon device created is changed to
> the thermal zone device name in this commit, which may contain
> incompatible characters for hwmon.
>=20
> Fixes it by using exactly the same parameters as before this commit.
>=20
> Fixes: 7611fb68062f ("thermal: thermal_hwmon: Convert to hwmon_devce_regi=
ster_with_info()")
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hw=
mon.c
> index c4a508a..0c6789f 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -157,8 +157,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_devic=
e *tz)
> =20
>  	INIT_LIST_HEAD(&hwmon->tz_list);
>  	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> -	hwmon->device =3D hwmon_device_register_with_info(NULL, hwmon->type,
> -							hwmon, NULL, NULL);
> +	hwmon->device =3D hwmon_device_register_with_info(NULL, NULL, NULL,
> +							NULL, NULL);
>  	if (IS_ERR(hwmon->device)) {
>  		result =3D PTR_ERR(hwmon->device);
>  		goto free_mem;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliHBDAACgkQMOfwapXb+vJAKQCfU5lpC8BcWMw5W3rdGtJEwQaE
mE4AoLNe5UU8KAJt3av1cM8DEMMBX7f+
=0cyJ
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
