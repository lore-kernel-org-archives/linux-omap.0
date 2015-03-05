From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 12/15] twl4030_charger: add software controlled linear
 charging mode.
Date: Thu, 5 Mar 2015 17:33:50 +1100
Message-ID: <20150305173350.50502b95@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043352.4243.11227.stgit@notabene.brown>
	<20150302210926.GP13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/5CaA8x8rsCH.nSBTYOkVRGn"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150302210926.GP13270@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/5CaA8x8rsCH.nSBTYOkVRGn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:09:26 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> On Tue 2015-02-24 15:33:52, NeilBrown wrote:
> > Add a 'continuous' option for usb charging which enabled
> > the "linear" charging mode of the twl4030.
>=20
> Documentation/ :-).

!

>=20
> > Linear charging does a good job with not so reliable power sources, sin=
ce
> > several voltage controlling is then often too intelligent.
>=20
> Parse error.

=3D=3D=3D=3D=3D=3D=3D=3D
Linear charging does a good job with not-so-reliable power sources.
Auto mode does not work well as it switches off when voltage drops
momentarily.  Care must be taken not to over-charge.

It was used with a bike hub dynamo since a year or so. In that case
there are automatically charging stops when the cyclist needs a break.
=3D=3D=3D=3D=3D=3D=3D=3D=3D

>=20
> > It was used with a bike hub dynamo since a year or so. In that case the=
re
> > are automatically charging stops when the cyclist needs a break.
> >=20
> > Orignal-by: Andreas Kemnade <andreas@kemnade.info>
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
>=20
> > +			ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x33,
> > +					       TWL4030_BCIWDKEY);
> > +			/* 0x24 + EKEY6:  off mode */
>=20
> "  " -> " "
>=20
> > +			ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x2a,
> > +					       TWL4030_BCIMDKEY);
> > +			/* EKEY2: Linear charge: usb path */
>=20
> USB
>=20
> > +			ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x26,
> > +					       TWL4030_BCIMDKEY);
> > +			/* WDKEY5: stop watchdog count */
> > +			ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0xf3,
> > +					       TWL4030_BCIWDKEY);
> > +			/* enable MFEN3 access */
> > +			ret =3D twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x9c,
> > +					       TWL4030_BCIMFKEY);
> > +			 /* ICHGEOCEN - end-of-charge monitor (current < 80mA)
> > +			  *                      (charging continues)
> > +			  * ICHGLOWEN - current level monitor (charge continues)
> > +			  * don't monitor over-current or heat save
>=20
> Heat save? Is ignoring over-current good idea?

The data sheet refers to a flag "HSEN" which is "Heat Save function enable".

your guess is as good as mine.

We don't currently have any code for responding to warnings.  Maybe we shou=
ld.

For now this feature is "use at your own risk" - and one person has found it
very useful.

>=20
> > @@ -650,6 +684,8 @@ twl4030_bci_mode_store(struct device *dev, struct d=
evice_attribute *attr,
> >  		mode =3D 0;
> >  	else if (sysfs_streq(buf, modes[1]))
> >  		mode =3D 1;
> > +	else if (sysfs_streq(buf, modes[2]))
> > +		mode =3D 2;
>=20
> Time for loop?

When we get one more mode it will be :-)

Thanks,
NeilBrown


--Sig_/5CaA8x8rsCH.nSBTYOkVRGn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPf4zznsnt1WYoG5AQKNdg//ZBD/iu0PwhRkPs3AuN2XA5gyjPgqJ9SQ
4kxcWwObCeXF6xlRLs7o78QS2MUO73J63Qk4jun5/1jBpGj4KZoOXu78nNUh9zoA
o6Kx7+yjNWhcEnlEA6FcTVZMz2qZNBpoAGqDIYipUELdXZEcHYgeO9eU+NHRc+b9
1cdaeHkyVkUI9qIfIRhUkItzp8S02x++yMg3L4tszM8lEaYFa0W0tv3/NSTKS7Kh
hvl9FxaoRlZIH55vZz/ckuQsfbFMEt1A3JpDj6nHEIL4tQSqChzF29CK99aFP0EI
IQKOh/U2DiYpRoPPXPZMnfTrTk1Ta1AraNAf/Y0idz6t1gyVS+PZr/F5tBZ3iicp
/etNtVL/t7nwLX9Iq7HK2YBcSgAaWpC1/q+auHXWt1iyi9FI8La0lEwe44Wa/IF9
jpvKeD+mgAv/+gfDrz9WGC7mYgDUASMEizBkmWUbsvUs0E2Lu/uIEgzR0dg60KXq
arv6JztPll88G/PdHlBXTWe9meH0X8TCPf8End9mYX1r5Xv0Pq9doUln17RGrvr7
V5mlYnq+DEn0WsOEhMWMknW0BtzwVIkT7yIzmxBgIPKnkN4Fb9rchWewHzGoqcin
T2eKXAtTS6J2Pg93/n2KLUjXdTTg1KDf7yOUTP6+5vNB+OiMh271kCbGoLKJQ6yH
anc9QKQtPB8=
=lqyE
-----END PGP SIGNATURE-----

--Sig_/5CaA8x8rsCH.nSBTYOkVRGn--
