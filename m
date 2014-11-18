From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] input: touchscreen: edt-ft5x06: fix driver autoprobing
Date: Tue, 18 Nov 2014 14:19:07 -0600
Message-ID: <20141118201907.GQ6179@saruman>
References: <20141118192112.GM6179@saruman>
 <1416338862-8240-1-git-send-email-balbi@ti.com>
 <20141118195902.GF3003@dtor-ws>
 <20141118200340.GP6179@saruman>
 <20141118201421.GH3003@dtor-ws>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XQ/JOjNzrAcf1KaA"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141118201421.GH3003@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, stable@vger.kernel.org, wsa@the-dreams.de
List-Id: linux-omap@vger.kernel.org

--XQ/JOjNzrAcf1KaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 12:14:21PM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 18, 2014 at 02:03:40PM -0600, Felipe Balbi wrote:
> > On Tue, Nov 18, 2014 at 11:59:02AM -0800, Dmitry Torokhov wrote:
> > > On Tue, Nov 18, 2014 at 01:27:42PM -0600, Felipe Balbi wrote:
> > > > Because with OF we can pass more specific
> > > > compatible flags (such as edt-ft5306) instead
> > > > of generic edt-ft5x06, when i2c-core's
> > > > of_i2c_register_devices() tries to request_module(),
> > > > it'll request it with a non-existent specific module
> > > > alias.
> > > >=20
> > > > In order to have this driver autoprobing again, we
> > > > just need to add missing MODULE_ALIAS() entries to
> > > > edt-ft5x06 driver.
> > > >=20
> > > > Thanks to Dmitry for noticing that it actually should
> > > > autoprobe even with of_device_id.
> > > >=20
> > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Cc: <linux-input@vger.kernel.org>
> > > > Cc: <stable@vger.kernel.org> # v3.15+
> > > > Fixes: dac90dc2 (Input: edt-ft5x06 - add DT support)
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > ---
> > > >  drivers/input/touchscreen/edt-ft5x06.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input=
/touchscreen/edt-ft5x06.c
> > > > index ee3434f..bcbf688 100644
> > > > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > > > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > > > @@ -1147,6 +1147,9 @@ static struct i2c_driver edt_ft5x06_ts_driver=
 =3D {
> > > > =20
> > > >  module_i2c_driver(edt_ft5x06_ts_driver);
> > > > =20
> > > > +MODULE_ALIAS("i2c:edt-ft5206");
> > > > +MODULE_ALIAS("i2c:edt-ft5306");
> > > > +MODULE_ALIAS("i2c:edt-ft5406");
> > > >  MODULE_AUTHOR("Simon Budig <simon.budig@kernelconcepts.de>");
> > > >  MODULE_DESCRIPTION("EDT FT5x06 I2C Touchscreen Driver");
> > > >  MODULE_LICENSE("GPL");
> > > > --=20
> > > > 2.1.0.GIT
> > > >=20
> > >=20
> > > Here is what I see if I run modinfo on the module:
> > >=20
> > > dtor@dtor-ws:~/kernel/work$ modinfo
> > > drivers/input/touchscreen/edt-ft5x06.ko
> > > filename:
> > > /home/dtor/kernel/work/drivers/input/touchscreen/edt-ft5x06.ko
> > > license:        GPL
> > > description:    EDT FT5x06 I2C Touchscreen Driver
> > > author:         Simon Budig <simon.budig@kernelconcepts.de>
> > > alias:          i2c:edt-ft5x06
> > > alias:          of:N*T*Cedt,edt-ft5406*
> > > alias:          of:N*T*Cedt,edt-ft5306*
> > > alias:          of:N*T*Cedt,edt-ft5206*
> > > depends:        i2c-core
> > > intree:         Y
> > > vermagic:       3.17.0+ SMP preempt mod_unload=20
> > >=20
> > > As you can see we already have what I consider proper modaliases for =
the
> > > driver. Why don't they work? Is it because modprobe doe snot know how=
 to
> > > handle OF-style modaliases or device's uevents are missing OF data in
> > > them?
> >=20
> > no, it's because i2c call request_module for i2c:edt-ft5306. i2c core
> > never uses any of the of aliases.
>=20
> 1. I think both i2c and spi are cheating in this regard: they should
> rely on normal driver request paths through udev.
>=20
> 2. I2C should emit proper modalias for devices coming by the way of
> devicetree. It already does special handling for ACPI, it needs to do
> the same for OF. I think SPI does the right thing there.

I'll let Wolfram comment here for I2C.

--=20
balbi

--XQ/JOjNzrAcf1KaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa6m7AAoJEIaOsuA1yqREviEP/Ah/qlNTCSXJGe1eEkTKUHXu
ClsQNMz5zNPGD26EG+TM+OoJr2ps8siL4Qksn/gYQx/95LLjIX3gL4JOpQq3iIOH
h03FsjxUGFl9OPg4fxTU+QZHxOgi1wKqkJSQ5pwEdW1hqn8qGFS6Z0CA2H6KDwml
Rm0hiIFp2P/mI0TU4QvLEDO6KXPBdGX6ScHgGdwhu6UscuXARCANSAsbQVRYbJgq
D0EZWhSXyHW9r5BrVdV+BjrGKKWGe7EsJkRyZuKHHyuO5S2BnAusu3yThS0eCm0k
gORQF/EiOpoAuFOQqxBNHg4cNWnJr0hsLLTad6XpAmu+b90rruVycENwosNEHnUV
YVOZoHZnggKpI42nrPNXUGJxFmHzd9XAv1zDymnMyxHIBqyCrXFAjbekQoWwicTO
iAgkgXFPv04BYeZ0ZaS6OLvW8oY/28TSG4pKVf3QxlPVj31VTUnxbxKH+ft9suSW
P+IjwPzRloPJcAXMsHgzYy8RMMR9sSEHl6HnlAEIWqv7afClfJa/1OlPvLlqa1Xx
EoUK3/Ckmi4iAzm8JE29Ha0l7EJs4Iz50z5r4QXVUvcQ/hFu/UZt+XbO0PiKzyvr
J7tUH2ttEBtgHG7MyL+Wr4wlZttpdektMgcImbQBeIGNUPJenijpproTzOSuR8Ou
KVuIzX0oYamHnsDxI9Lo
=BkvA
-----END PGP SIGNATURE-----

--XQ/JOjNzrAcf1KaA--
