From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv3] dt-bindings: Avago APDS990X light sensor
Date: Mon, 8 Jan 2018 23:20:54 +0100
Message-ID: <20180108222054.GA17452@amd>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
 <20180102124450.GA18659@amd>
 <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>
> >=20
> > This prepares binding for light sensor used in Nokia N9.
>=20
> "dt-bindings: ..." is the preferred subject prefix.

Ok.

> > +++ b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
>=20
> Put this with other light sensors whether you use IIO or not:
>=20
> bindings/iio/light/

Makes sense. Patches to convert to IIO are available.

> > @@ -0,0 +1,41 @@
> > +Avago APDS990X driver
>=20
> Bindings aren't drivers.

Ok.

> > +https://docs.broadcom.com/docs/AV02-2867EN
> > +
> > +Required properties:
> > +- compatible: "avago,apds990x"
> > +- reg: address on the I2C bus
> > +- interrupts: external interrupt line number
> > +- vdd-supply: power supply for VDD
> > +- vled-supply: power supply for LEDA
> > +- avago,ga: Glass attenuation
>=20
> We already have "upisemi,glass-coef". Can we align on something
> common.

upisemi seems to have different units (1/1000 vs. 1/4096). Do you want
me to do change to avago,glass-coef or ....?

> > +- avago,cf1: Clear channel factor 1
> > +- avago,irf1: IR channel factor 1
> > +- avago,cf2: Clear channel factor 2
> > +- avago,irf2: IR channel factor 2
>=20
> Perhaps 2 properties with 2 cells for factor 1 and 2.

This is obviously easier to keep, but I can change.

> > +- avago,df: Device factor
>=20
> Units/range for all these?

Fixed point, with 4096 =3D=3D 1.00.

> > +- avago,pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
>=20
> Don't we have standard current property for LEDs?

We do have "led-max-microamp"; which is not quite what this is. I
guess we can do "led-microamp" if you prefer?

> > +- avago,ppcount: Proximity pulse count
>=20
> Is this standard for prox sensors?

I don't know many proximity sensors. Seems like way to raise sensitivity.

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpT7sYACgkQMOfwapXb+vLAXgCglt43i+HEWzoljbgqEZtk2Zzr
MgoAoMNiPx0hIbJvI+J+XZnjwQN2HlED
=GnNg
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
