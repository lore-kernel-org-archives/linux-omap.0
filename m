From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] dt-bindings: Nokia N9 audio support
Date: Wed, 10 Jan 2018 12:31:02 +0100
Message-ID: <20180110113102.GA26812@amd>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
 <20180102124450.GA18659@amd>
 <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
 <20180108222054.GA17452@amd>
 <20180110085315.GA17841@amd>
 <20180110093930.wq5darjgtuugc6ad@paasikivi.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180110093930.wq5darjgtuugc6ad@paasikivi.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Wed, Jan 10, 2018 at 09:53:15AM +0100, Pavel Machek wrote:
> > From: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>
> >=20
> > Add bindings for Nokia N9 audio components.
> >=20
> > Signed-off-by: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > diff --git a/Documentation/devicetree/bindings/media/ti-wl1273.txt b/Do=
cumentation/devicetree/bindings/media/ti-wl1273.txt
> > new file mode 100644
> > index 0000000..21db389
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/ti-wl1273.txt
> > @@ -0,0 +1,36 @@
> > +Texas Instruments - wl1273 radio/bluetooth module
> > +
> > +Required properties:
> > +
> > +- compatible - "ti,wl1273-core"
> > +- reg - I2C slave address
> > +- interrupts       - The interrupt output from the device.
> > +- interrupt-parent - The parent interrupt controller.
> > +- power-gpio       - gpio pin to power the device.
> > +
> > +- wl1273radio child - compatible =3D "ti,wl1273-fm-radio";
>=20
> I'd document this under a separate section, as the compatible property for
> the other child node.
>=20
> You use "property - description" here but "property: description" in the
> file below. It'd be nice to be consistent, albeit it's separate
> files.

Heh. If we want to do consistency, it should be consistent in whole
documentation. I looked at cec-gpio.txt and it uses both
styles. Sampled few more files, and seems ":" is more common here.

> > +
> > +Optional properties:
> > +
> > +- wl1273codec child - compatible =3D "ti,wl1273codec";
>=20
> "ti,wl1273-codec"

Ok.

> > diff --git a/Documentation/devicetree/bindings/sound/nokia,n9.txt b/Doc=
umentation/devicetree/bindings/sound/nokia,n9.txt
> > new file mode 100644
> > index 0000000..230b1eb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/nokia,n9.txt
> > @@ -0,0 +1,32 @@
> > +* Nokia N9/N950 audio setup
> > +
>=20
> A small description saying what this really is would be nice.

I'm actually not sure what to say here. Suggestions?

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpV+XYACgkQMOfwapXb+vI8egCfWctQNJhRkE7/Y6qXth/sj3wB
TlMAn15ol3CMRAyNXDMyCAHOyfP2nJ85
=jA5z
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
