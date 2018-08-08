From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations on Droid 4?
Date: Wed, 8 Aug 2018 19:09:33 +0200
Message-ID: <20180808170933.GC7306@amd>
References: <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
 <20180716075926.GU99251@atomide.com>
 <20180801185823.GC26087@amd>
 <20180802110701.3b4voigegy67h4p5@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802110701.3b4voigegy67h4p5@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, narmstrong@baylibre.com, claudiu.beznea@microchip.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Wed, Aug 01, 2018 at 08:58:24PM +0200, Pavel Machek wrote:
> > > > Yep, so I have two patches that make the device appear, but vibrati=
ons
> > > > still do not work for me.
> > > >=20
> > > > a) any ideas how to debug that / get them to work?
> > >=20
> > > Hmm no new ideas except I wonder if there is also some other
> > > regression with the timer pdata not being passed properly now.
> >=20
> > I checked vibrations work in original Motorola Android; my hardware is
> > not broken.
>=20
> You got it working, but this information might still be interesting
> in case of future problems:
>=20
> The Android "driver" is very different from the one I wrote from
> scratch and upstreamed. The mainline driver is less lines of code
> (iirc 25%), less complicated (Android vibration support is spread
> over multiple drivers/arch code), more efficient (Android drivers
> does GPIO bitbanging instead of PWM) and provides more features
> (Android driver does not allow all strength settings). Also it uses
> normal input device API instead of a custom one.

Thanks for doing it right.

> P.S.: Sorry, I don't have much time to work on D4 at the moment :(

Thanks for doing the work, d4 seems to be the most usable phone at the
moment. Yes, there's more work to do, but there's always more work to
do.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltrI80ACgkQMOfwapXb+vLgkQCggzpi9K5+lYalLpefgKEEBvYI
JaQAn3jjgKOiQ5LPwnbzA0ucR8NGi9t0
=oSb0
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
