From: Pavel Machek <pavel@ucw.cz>
Subject: Re: regression v4.16 on Nokia N900: sound does not work
Date: Fri, 2 Mar 2018 17:53:21 +0100
Message-ID: <20180302165321.GG28931@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd>
 <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
 <20180302111040.GA6344@amd>
 <0f090cc7-2b72-a038-26ee-d43077cb9663@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3561972999218363336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <0f090cc7-2b72-a038-26ee-d43077cb9663@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, ext Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, =?utf-8?B?TWlja3Vsw6HFoQ==?= Qwertz <abcloriens@gmail.com>, Sebastian Reichel <sre@kernel.org>, Martijn Braam <martijn@brixit.nl>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Patrik Bachan <patrikbachan@gmail.com>, Ivajlo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Kevin Hilman <khilman@kernel.org>, serge@hallyn.com, Thorsten Leemhuis <regressions@leemhuis.info>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel Baluta <daniel.baluta@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, kernel list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, clayton@craftyguy.net, Sakari Ailus <sakari.ailus@linux.intel.com>, Pali
List-Id: linux-omap@vger.kernel.org


--===============3561972999218363336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-02 08:22:52, Andrew F. Davis wrote:
> On 03/02/2018 05:10 AM, Pavel Machek wrote:
> > Hi!
> >=20
> >>> If this is taking longer to fix, should c85823390215 be reverted in
> >>> the meantime? It does not seem particulary important/urgent...
> >>
> >> No patience between the v4.16 release candidates eh ;)
> >>
> >> commit 6662ae6af82df10259a70c7569b4c12ea7f3ba93
> >> ("gpiolib: Keep returning EPROBE_DEFER when we should")
> >>
> >> and
> >>
> >> commit ce27fb2c56db6ccfe8099343bb4afdab15e77e7b
> >> ("gpio: Handle deferred probing in of_find_gpio() properly")
> >>
> >> that are both in Torvalds' tree since yesterday should be fixing
> >> this, I think? Did you try just using the upstream HEAD?
> >=20
> > Ok, so this code looks pretty crazy to me: I tried removing the
> > "of_find_spi_gpio" part, and audio started working.
> >=20
> > What is going on with the ()s around =3D=3D s? You made me look up C
> > operator precedence.
> >=20
> > Hmm, and it is also wrong, right? It turns any error code into ENOENT,
> > as it tries to do the "special handling".
> >=20
> >                  *                                                     =
                =20
> >                  * This means we don't need to look any further for    =
                =20
> >                  * alternate name conventions, and we should really    =
                =20
> >                  * preserve the return code for our user to be able to =
                =20
> >                  * retry probing later.                                =
                =20
> >                  */
> >                 if (IS_ERR(desc) && PTR_ERR(desc) =3D=3D -EPROBE_DEFER)
> >                         return desc;
> >=20
> >                 if (!IS_ERR(desc) || (PTR_ERR(desc) !=3D -ENOENT))
> >                         break;
> >         }
> >=20
> >         /* Special handling for SPI GPIOs if used */
> >         if (IS_ERR(desc))
> >                 desc =3D of_find_spi_gpio(dev, con_id, &of_flags);
> >=20
> >         /* Special handling for regulator GPIOs if used */
> >         if (IS_ERR(desc) && PTR_ERR(desc) !=3D -EPROBE_DEFER)
> >                 desc =3D of_find_regulator_gpio(dev, con_id, &of_flags);
> >=20
> > Something like this?
> >=20
> > diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> > index 84e5a9d..f0fab26 100644
> > --- a/drivers/gpio/gpiolib-of.c
> > +++ b/drivers/gpio/gpiolib-of.c
> > @@ -241,29 +241,17 @@ struct gpio_desc *of_find_gpio(struct device *dev=
, const char *con_id,
> > =20
> >  		desc =3D of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
> >  						&of_flags);
> > -		/*
> > -		 * -EPROBE_DEFER in our case means that we found a
> > -		 * valid GPIO property, but no controller has been
> > -		 * registered so far.
> > -		 *
> > -		 * This means we don't need to look any further for
> > -		 * alternate name conventions, and we should really
> > -		 * preserve the return code for our user to be able to
> > -		 * retry probing later.
> > -		 */
> > -		if (IS_ERR(desc) && PTR_ERR(desc) =3D=3D -EPROBE_DEFER)
> > -			return desc;
> > =20
> > -		if (!IS_ERR(desc) || (PTR_ERR(desc) !=3D -ENOENT))
> > +		if (!IS_ERR(desc) || PTR_ERR(desc) !=3D -ENOENT)
>=20
>=20
> I rather like the () so one doesn't always have to look up C operator
> precedence to verify..

Well, Ok, but then the ()s should be at the other ifs nearby, too. See?

>=20
> >  			break;
> >  	}
> > =20
> >  	/* Special handling for SPI GPIOs if used */
> > -	if (IS_ERR(desc))
> > +	if (IS_ERR(desc) && PTR_ERR(desc) =3D=3D -ENOENT)
> >  		desc =3D of_find_spi_gpio(dev, con_id, &of_flags);
> > =20
> >  	/* Special handling for regulator GPIOs if used */
> > -	if (IS_ERR(desc) && PTR_ERR(desc) !=3D -EPROBE_DEFER)
> > +	if (IS_ERR(desc) && PTR_ERR(desc) =3D=3D -ENOENT)
> >  		desc =3D of_find_regulator_gpio(dev, con_id, &of_flags);
> > =20
> >  	if (IS_ERR(desc))
> >
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqZgYEACgkQMOfwapXb+vKYrgCgq/LotlSJkgk8G9ReSt1U59PP
lvcAn1zphgqZ/jPIgpqJhh/0Q7kLFG2r
=LNlr
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--

--===============3561972999218363336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3561972999218363336==--
