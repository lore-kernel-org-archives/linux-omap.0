From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Nokia N9: add support for up/down keys in the dts
Date: Sun, 28 Jan 2018 10:16:12 +0100
Message-ID: <20180128091612.GB23818@amd>
References: <20180102125948.GA20051@amd>
 <20180102194236.ahrhkvnefre2l6gf@earth.universe>
 <20180118220348.GD17196@amd>
 <20180119154325.GF4042@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119154325.GF4042@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, bcousson@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > This adds support for volume up/down keys in the dts.
> > > >=20
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > >=20
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >=20
> > Tony, ping? Can I get you to apply this one?
>=20
> OK applying that for v4.16 so we have some kind of control of the
> device without having to rely on the touch screen :)

Thanks :-).

> > [PATCHv2] nokia N9: Add support for magnetometer
> >=20
> > should be good to go, too...
>=20
> I have that tagged for next after -rc1 thanks.

Actually, if you could get that one to v4.16, too. There's still lot
of work to be done to get N9 into usable state, and delaying here does
not do any good.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlptlNwACgkQMOfwapXb+vLNuwCfbo6HLZG1vwShhn/ZHLgsaXyP
IckAmwbKCoxKkD4wOGS8xDAIj8MzSrvU
=sB+X
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
