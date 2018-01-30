From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Date: Tue, 30 Jan 2018 09:53:14 +0100
Message-ID: <20180130085314.GA4585@amd>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd> <20180130083446.GA13498@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1760227130724844823=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180130083446.GA13498@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tony@atomide.com, abcloriens@gmail.com, tiwai@suse.com, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, patrikbachan@gmail.com, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, serge@hallyn.com, devicetree@vger.kernel.org, pali.rohar@gmail.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, aaro.koskinen@iki.fi, linux-kernel@vger.kernel.org, broonie@kernel.org, clayton@craftyguy.net, sakari.ailus@linux.intel.com, sre@kernel.org, bhumirks@gmail.com
List-Id: linux-omap@vger.kernel.org


--===============1760227130724844823==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-01-30 09:34:46, Ladislav Michl wrote:
> On Tue, Jan 30, 2018 at 12:33:01AM +0100, Pavel Machek wrote:
> > On Tue 2018-01-30 00:20:31, Ladislav Michl wrote:
> > > On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
> > > >=20
> > > > This adds device tree support to tlv320dac33.c.
> > > >=20
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.tx=
t b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > > > new file mode 100644
> > > > index 0000000..6cbd311
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > > > @@ -0,0 +1,32 @@
> > > > +Texas Instruments - tlv320dac33 Codec module
> > > > +
> > > > +The tlv320dac33 serial control bus communicates through I2C protoc=
ols.
> > > > +
> > > > +Required properties:
> > > > +
> > > > +- compatible - "ti,tlv320dac33"
> > > > +- reg - I2C slave address
> > > > +
> > > > +Optional properties:
> > > > +
> > > > +- power-gpios - gpio pin to power the device, active high
> > >=20
> > > While driver used gpio in platform data, isn't it more likely
> > > regulator which powers device?
> >=20
> >                 power-gpios =3D <&gpio2 28 0>; /* gpio_60 */
> >=20
> > Looks like GPIO to me -- example is from Nokia N9. So this appears to
> > be correct.
>=20
> Device datasheet doesn't list any pin which looks like "power-gpio"
> http://www.ti.com/lit/ds/symlink/tlv320dac32.pdf
> Unfortunately I do not know much about N9, but was able to find Nokia 5610
> scheme to get clue how could be tlv320dac33 hardwired (see page 2):
> http://mastermobile.spb.ru/service/nokia_5610_rm-242_service_schematics.p=
df
> Here AVDD is powered by LP3985 voltage regulator which is enabled using
> VEN pin which might be connected to gpio. Or there could be completely
> different voltage regulator with different controls. And since Linux
> already has voltage regulator class, lets not limit ourselves to gpio
> pins.

Well, notice I'm converting existing driver to device tree. And that
one already has GPIO dependency. It is possible that more work needs
to be done there, but that should not be a reason to delay this. Feel
free to help.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpwMnoACgkQMOfwapXb+vIKPwCdG8H/ZWOTQRjFZjbnChEVSYks
82YAoIXPhu/in6U7iXC9VjAC/JRVGBOe
=ne5K
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

--===============1760227130724844823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1760227130724844823==--
