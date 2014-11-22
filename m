From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] input: touchscreen: edt-ft5x06: fix driver autoprobing
Date: Fri, 21 Nov 2014 19:05:24 -0600
Message-ID: <20141122010524.GA26751@saruman>
References: <20141118192112.GM6179@saruman>
 <1416338862-8240-1-git-send-email-balbi@ti.com>
 <20141118195902.GF3003@dtor-ws>
 <20141118200340.GP6179@saruman>
 <20141118201421.GH3003@dtor-ws>
 <20141118201907.GQ6179@saruman>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141118201907.GQ6179@saruman>
Sender: stable-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, stable@vger.kernel.org, wsa@the-dreams.de
List-Id: linux-omap@vger.kernel.org

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Tue, Nov 18, 2014 at 02:19:07PM -0600, Felipe Balbi wrote:
> On Tue, Nov 18, 2014 at 12:14:21PM -0800, Dmitry Torokhov wrote:
> > On Tue, Nov 18, 2014 at 02:03:40PM -0600, Felipe Balbi wrote:
> > > On Tue, Nov 18, 2014 at 11:59:02AM -0800, Dmitry Torokhov wrote:
> > > > On Tue, Nov 18, 2014 at 01:27:42PM -0600, Felipe Balbi wrote:
> > > > > Because with OF we can pass more specific
> > > > > compatible flags (such as edt-ft5306) instead
> > > > > of generic edt-ft5x06, when i2c-core's
> > > > > of_i2c_register_devices() tries to request_module(),
> > > > > it'll request it with a non-existent specific module
> > > > > alias.
> > > > >=20
> > > > > In order to have this driver autoprobing again, we
> > > > > just need to add missing MODULE_ALIAS() entries to
> > > > > edt-ft5x06 driver.
> > > > >=20
> > > > > Thanks to Dmitry for noticing that it actually should
> > > > > autoprobe even with of_device_id.
> > > > >=20
> > > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > Cc: <linux-input@vger.kernel.org>
> > > > > Cc: <stable@vger.kernel.org> # v3.15+
> > > > > Fixes: dac90dc2 (Input: edt-ft5x06 - add DT support)
> > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > > ---
> > > > >  drivers/input/touchscreen/edt-ft5x06.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/inp=
ut/touchscreen/edt-ft5x06.c
> > > > > index ee3434f..bcbf688 100644
> > > > > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > > > > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > > > > @@ -1147,6 +1147,9 @@ static struct i2c_driver edt_ft5x06_ts_driv=
er =3D {
> > > > > =20
> > > > >  module_i2c_driver(edt_ft5x06_ts_driver);
> > > > > =20
> > > > > +MODULE_ALIAS("i2c:edt-ft5206");
> > > > > +MODULE_ALIAS("i2c:edt-ft5306");
> > > > > +MODULE_ALIAS("i2c:edt-ft5406");
> > > > >  MODULE_AUTHOR("Simon Budig <simon.budig@kernelconcepts.de>");
> > > > >  MODULE_DESCRIPTION("EDT FT5x06 I2C Touchscreen Driver");
> > > > >  MODULE_LICENSE("GPL");
> > > > > --=20
> > > > > 2.1.0.GIT
> > > > >=20
> > > >=20
> > > > Here is what I see if I run modinfo on the module:
> > > >=20
> > > > dtor@dtor-ws:~/kernel/work$ modinfo
> > > > drivers/input/touchscreen/edt-ft5x06.ko
> > > > filename:
> > > > /home/dtor/kernel/work/drivers/input/touchscreen/edt-ft5x06.ko
> > > > license:        GPL
> > > > description:    EDT FT5x06 I2C Touchscreen Driver
> > > > author:         Simon Budig <simon.budig@kernelconcepts.de>
> > > > alias:          i2c:edt-ft5x06
> > > > alias:          of:N*T*Cedt,edt-ft5406*
> > > > alias:          of:N*T*Cedt,edt-ft5306*
> > > > alias:          of:N*T*Cedt,edt-ft5206*
> > > > depends:        i2c-core
> > > > intree:         Y
> > > > vermagic:       3.17.0+ SMP preempt mod_unload=20
> > > >=20
> > > > As you can see we already have what I consider proper modaliases fo=
r the
> > > > driver. Why don't they work? Is it because modprobe doe snot know h=
ow to
> > > > handle OF-style modaliases or device's uevents are missing OF data =
in
> > > > them?
> > >=20
> > > no, it's because i2c call request_module for i2c:edt-ft5306. i2c core
> > > never uses any of the of aliases.
> >=20
> > 1. I think both i2c and spi are cheating in this regard: they should
> > rely on normal driver request paths through udev.
> >=20
> > 2. I2C should emit proper modalias for devices coming by the way of
> > devicetree. It already does special handling for ACPI, it needs to do
> > the same for OF. I think SPI does the right thing there.
>=20
> I'll let Wolfram comment here for I2C.

Can you comment on this ? As of today i2c-based drivers will probe with
DT-based boot if DT's compatible is set to the same id as in struct
i2c_device_id. No i2c driver with of_device_id can autoprobe using OF
ids.

cheers

--=20
balbi

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb+FUAAoJEIaOsuA1yqREA+QP/0FDexD+/AX7PBk7HRH8+oEF
NU2jF7xS2KmOCdMBAdXq4NZ+DF3bEwmdlBusWzEwqgDQerBT8aitOT3WeNnBIknB
6KbLYf7WohXvqdO+NDc+cF6aJsvxsho8b43Y4jN4JrYP3Y+zxubJr3zM6IuTOTpP
ZP3dkVrnn6c8eBXkHRoEg34P5Si0yg+ulu8f1G8AhoZzt4Y8xof3ToP9PctDCJg4
fyTad0mLeG845oe8s4BPQIklG00BgHOTK95vm2q7OsB/Q7ERIwW/6DraBwCTVYv1
leKhP00MUwv5oO4f8jdyHoDUWFf7kqayceeBBzN1ubKgpGIW6kzwz2BeC+F3OF+7
n77Wv/yHD6IfS2TH/EFY/2fI2X9eIxtOtAi4Rkpanp6iBEXC6NwO2olqFPQAGZFv
SZluXF+pf8H3aGmzKDj0hMKr8ayhEwbbjVpbYxnr3vTt+T1AN7C4N0AtRbWauWyP
+itmQuL2RbyIULH+Hq9ZJ9hoppLf9yCFyjGc15A1dMM0DL1rwLOwLwRPWeOcmMNr
N0WXhp0uGwXsGJFO4JjPn5R1YkcbeWRiRJgETsYZ4Tc1z0BBCfDaiELfdf5QaFNX
Cx8VyEYfs9sLNpNb1cHQ0DsdVk/Ryrh6lPop4ywSfc4lST/wzgQV+KVsCmejTdVb
BfqFT7O94pQ7zy/A9Dzu
=HJkL
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
