From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sat, 18 Feb 2017 04:22:33 +0100
Message-ID: <20170218032233.3qh5xdjbx5kkq5hm@earth>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
 <20170128193342.GB38136@dtor-ws>
 <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
 <20170217204041.GE13050@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5d3kcryff2vvmr7k"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170217204041.GE13050@dtor-ws>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr
List-Id: linux-omap@vger.kernel.org


--5d3kcryff2vvmr7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 17, 2017 at 12:40:41PM -0800, Dmitry Torokhov wrote:
> > AFAIK there is no mainline board using the DT except ours (and the upco=
ming
> > OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can remo=
ve this
> > compatibility property. We don't need it for our devices.

$ cd linux.git/arch
$ git grep -l tsc2004
arm/boot/dts/imx6qdl-nit6xlite.dtsi
arm/boot/dts/imx7d-nitrogen7.dts
arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
arm/boot/dts/omap4-var-som-om44.dtsi
$ git grep -l tsc2005
arm/boot/dts/omap3-n900.dts
$ git grep -l tsc2007
arm/boot/dts/imx28-tx28.dts
arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
arm/boot/dts/imx53-tx53-x03x.dts
arm/boot/dts/imx6qdl-tx6.dtsi
arm/boot/dts/imx6ul-tx6ul.dtsi
arm/boot/dts/omap3-gta04.dtsi
sh/boards/mach-ecovec24/setup.c

> You seem to be treating DT data as something very fluid, which is wrong.
> You need to treat it as a firmware, unlikely to change once device is
> shipped. Unlike legacy platform data, the fact that DTS files are not
> present in mainline does not mean that we can ignore such users and
> change behavior at will.
>=20
> That said, if driver behavior is out of line from the subsystem
> expectations, we need to fix it.
>=20
> =20
> > That the function name is wrong is a second issue and this double negat=
ion might
> > confuse a litte.
> >=20
> > Please test on a real device if the patched driver reports pressure now=
 (unless
> > ti,report-resistance is specified).
>=20
> I unfortunately can not test this driver as I do not have the hardware.
> So all my observations are from code and data sheets.
>=20
> That said, what is the values emitted as ABS_PRESSURE when finger is not
> touching the device, barely touching the device, or pressing firmly?
> It seems that between TSC2007, TSC2004, TSC2005, and ADS7846, we have
> confusion as to what is being reported.

As far as I can see all calculate Rtouch and ADS7846 reports
(Rmax - Rtouch), which looks sensible.

> I am adding a few more folks to the CC so we can try and soft this out.
> Sebastian, Pali, Pavel, any input here?

I think tsc200x works, since usually userspace is Xorg and I think
it only cares for x/y coordinates + boolean pressure. Since
no-pressure is correctly reported as 0, everything works as
expected. I currently don't have X running on my N900 due some
omapdrm bug, so I can't test this, sorry.

I suggest to put the resistance vs pressure thing in its own patch,
that also fixes tsc200x-core and merge it to linux-next after the
merge window.

-- Sebastian

--5d3kcryff2vvmr7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlinvfYACgkQ2O7X88g7
+pr1VQ/+NMIi+Md4Bn6yVkswG/Sd+KFLDtCDYylEoaaYxyP4uy+NcmJfBfDyUKeI
UBjuvPAE+Aav6oLbYCIaN+uHw1eyG2Z43wPIb1xe9P0jYImcPGcqhXZzrS7CVeQH
CjoKbt/0gv17YAZHSO/mqNKBiu8n1kUB7rY25AkVesLPKm9vnTA6mucn9o1I/BWF
iPkfKoyfg0hWraR0ZL7YLu8Ha9Juu0aeDOWhd2Mk5Bjz5/7B1qnXAwEhzTQzmcW7
Edzvp28ag8aPKGIzNL+kw5H8FHnPYEg5IdFN/Apwa+MUhJVCP+ghY5m3W3JiqDuO
CW6oCDDxO1PDHEZoULyY/+00u1BbrdQi297nRrzgcX2RUEXpQIwBEtmLfbNikkAE
lC0n4ovQo6Mh53ni0STh9Yo6AzPzr8COyRWRt59fg4Oti+mlNq5o3cMCAn09BgqR
f1Szb8ix5BzVJdXFP49tjAl2wOKvdMmOeMfy0Rw6ZE8xb2K5+A9T4Q4jEZQy+NLA
zW5iGwjCx5ZT/IutMqeMYDQgYSLEztaK617nCInFgNeCNx0IvYax5cnNfy4FXPVI
j885zZisWtVoU7OPqH+0gwkXDO0CYwdkFWhL3iRV6GZiBoRIp48mWdy3A77saslJ
lm+tMqm6Vd6/Dmy/YIV3M/U5jQh529MQVfuPI+3XbDgaNbQGX4c=
=dLlo
-----END PGP SIGNATURE-----

--5d3kcryff2vvmr7k--
