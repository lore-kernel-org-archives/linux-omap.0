From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] input: touchscreen: edt-ft5x06: fix driver autoprobing
Date: Tue, 18 Nov 2014 14:03:40 -0600
Message-ID: <20141118200340.GP6179@saruman>
References: <20141118192112.GM6179@saruman>
 <1416338862-8240-1-git-send-email-balbi@ti.com>
 <20141118195902.GF3003@dtor-ws>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8G1nIWD3RY794FAy"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141118195902.GF3003@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--8G1nIWD3RY794FAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 11:59:02AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 18, 2014 at 01:27:42PM -0600, Felipe Balbi wrote:
> > Because with OF we can pass more specific
> > compatible flags (such as edt-ft5306) instead
> > of generic edt-ft5x06, when i2c-core's
> > of_i2c_register_devices() tries to request_module(),
> > it'll request it with a non-existent specific module
> > alias.
> >=20
> > In order to have this driver autoprobing again, we
> > just need to add missing MODULE_ALIAS() entries to
> > edt-ft5x06 driver.
> >=20
> > Thanks to Dmitry for noticing that it actually should
> > autoprobe even with of_device_id.
> >=20
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: <linux-input@vger.kernel.org>
> > Cc: <stable@vger.kernel.org> # v3.15+
> > Fixes: dac90dc2 (Input: edt-ft5x06 - add DT support)
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/input/touchscreen/edt-ft5x06.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
> > index ee3434f..bcbf688 100644
> > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > @@ -1147,6 +1147,9 @@ static struct i2c_driver edt_ft5x06_ts_driver =3D=
 {
> > =20
> >  module_i2c_driver(edt_ft5x06_ts_driver);
> > =20
> > +MODULE_ALIAS("i2c:edt-ft5206");
> > +MODULE_ALIAS("i2c:edt-ft5306");
> > +MODULE_ALIAS("i2c:edt-ft5406");
> >  MODULE_AUTHOR("Simon Budig <simon.budig@kernelconcepts.de>");
> >  MODULE_DESCRIPTION("EDT FT5x06 I2C Touchscreen Driver");
> >  MODULE_LICENSE("GPL");
> > --=20
> > 2.1.0.GIT
> >=20
>=20
> Here is what I see if I run modinfo on the module:
>=20
> dtor@dtor-ws:~/kernel/work$ modinfo
> drivers/input/touchscreen/edt-ft5x06.ko
> filename:
> /home/dtor/kernel/work/drivers/input/touchscreen/edt-ft5x06.ko
> license:        GPL
> description:    EDT FT5x06 I2C Touchscreen Driver
> author:         Simon Budig <simon.budig@kernelconcepts.de>
> alias:          i2c:edt-ft5x06
> alias:          of:N*T*Cedt,edt-ft5406*
> alias:          of:N*T*Cedt,edt-ft5306*
> alias:          of:N*T*Cedt,edt-ft5206*
> depends:        i2c-core
> intree:         Y
> vermagic:       3.17.0+ SMP preempt mod_unload=20
>=20
> As you can see we already have what I consider proper modaliases for the
> driver. Why don't they work? Is it because modprobe doe snot know how to
> handle OF-style modaliases or device's uevents are missing OF data in
> them?

no, it's because i2c call request_module for i2c:edt-ft5306. i2c core
never uses any of the of aliases.

--=20
balbi

--8G1nIWD3RY794FAy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa6YcAAoJEIaOsuA1yqREJA0P/16Y/8eOQ2TuR97euBTNNmM3
wy5pkBL/EyzqcZVgyZkbA0kVN4jnjh7r8rPFd8ihFiPr6arYRz9tbbyKIcQJ5SYH
KZBW+sxiircjo3i79sqNMr2YZ4+uUthTF9ZJu0rluxOr26IQKNEW/OGm6aE/h+XL
t+FPqyWxixiCSnVlXAUUQOlOZ/A463WTP+mq09MzidxYkjvqe+i1tPdFligO7MTQ
xPoFeelCGzH1g9Qp8PMjBNVI4SHvu12+G4+O2XPaSpW74n1JIwIipDShJZ1VU1Oq
cgRmJAv6zFpgqbpzRUFUXB/jXnbtmLoixDUZb0pJesDPZpA6RGv6AaaIu127ksGm
2OR4IgowPTX+IEr20IfbJjZuCA3Eq/RAVgtzh1Dj2l7xHHD9LmgauV8H/K2m46mY
IEsij3us1Y6Dz46Mxv7Vp7VPRoKtiPbZflJPlIbB+YlrYCfgjsUBDynOlVPXGhK/
bjchEtYOoNpDBLFT5nkE/B1Ic1avejLTO3YoHq3y1yB9n/GLmHa/BJd+V6zrxD/x
u6Q7bCmyNTtFe8pBG7OAnqyPX//CYpyv+zbpyRdNvecsQBpBbEWfbCGTCkxJak4t
tarTG0MpV7JHn7L8Xp3ka+7OX4bsMbJlsVmisoE18PAdNIl43Z3N1P95qEI96Ph+
u6sTHuBcriUfjyljeTY1
=Kveb
-----END PGP SIGNATURE-----

--8G1nIWD3RY794FAy--
