From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Vibrations on Droid 4?
Date: Wed, 1 Aug 2018 20:58:24 +0200
Message-ID: <20180801185823.GC26087@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd>
 <20180716075926.GU99251@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716075926.GU99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, j-keerthy@ti.com, narmstrong@baylibre.com, claudiu.beznea@microchip.com
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Yep, so I have two patches that make the device appear, but vibrations
> > still do not work for me.
> >=20
> > a) any ideas how to debug that / get them to work?
>=20
> Hmm no new ideas except I wonder if there is also some other
> regression with the timer pdata not being passed properly now.

I checked vibrations work in original Motorola Android; my hardware is
not broken.

I see:

commit b7290cf6ff7869ec12070aa146c370728cab62c2
Author: Keerthy <j-keerthy@ti.com>
Date:   Thu Feb 15 11:31:50 2018 +0530

    pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtimer pdata ops

    Adapt driver to utilize dmtimer pdata ops instead of pdata-quirks.

 Signed-off-by: Keerthy <j-keerthy@ti.com>
 Acked-by: Neil Armstrong <narmstrong@baylibre.com>
 Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
 Signed-off-by: Tony Lindgren <tony@atomide.com>
	=09
should I try to revert that one? (Are pdata still there in the board
files somewhere).

Do vibrations work for you?

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltiAs8ACgkQMOfwapXb+vJF5wCdEvDRoobAoL6iVOgPyg+w61n6
39QAnAz8PfDiNDfiq4y9xbihCPfH+rUk
=EOB9
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
