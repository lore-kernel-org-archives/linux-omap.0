From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Date: Tue, 30 Jan 2018 00:33:01 +0100
Message-ID: <20180129233301.GA18104@amd>
References: <20180129230539.GA18280@amd>
 <20180129232031.GA7695@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180129232031.GA7695@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-01-30 00:20:31, Ladislav Michl wrote:
> On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
> >=20
> > This adds device tree support to tlv320dac33.c.
> >=20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/=
Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > new file mode 100644
> > index 0000000..6cbd311
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > @@ -0,0 +1,32 @@
> > +Texas Instruments - tlv320dac33 Codec module
> > +
> > +The tlv320dac33 serial control bus communicates through I2C protocols.
> > +
> > +Required properties:
> > +
> > +- compatible - "ti,tlv320dac33"
> > +- reg - I2C slave address
> > +
> > +Optional properties:
> > +
> > +- power-gpios - gpio pin to power the device, active high
>=20
> While driver used gpio in platform data, isn't it more likely
> regulator which powers device?

                power-gpios =3D <&gpio2 28 0>; /* gpio_60 */

Looks like GPIO to me -- example is from Nokia N9. So this appears to
be correct.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpvry0ACgkQMOfwapXb+vLHTACfV4JuhSGlzSuH7qrPsaADNfih
3FMAnjiR8iiqupvp0pOGyN+i8t14+vhG
=y43O
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
