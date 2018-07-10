From: Pavel Machek <pavel@ucw.cz>
Subject: Re: droid 4: no sound in the morning
Date: Tue, 10 Jul 2018 15:53:26 +0200
Message-ID: <20180710135325.GA23878@amd>
References: <20180710105910.GA4442@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180710105910.GA4442@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-10 12:59:10, Pavel Machek wrote:
> Hi!
>=20
> I attempted to use droid 4 as an alarm clock, but got no sound in the
> morning.
>=20
> Log said:
>=20
> [78798.682830] omap-mcbsp 40124000.mcbsp: CLKS: could not
> clk_set_parent() to prcm_fck
> [78803.561767] omap-mcbsp 40126000.mcbsp: CLKS: could not
> clk_set_parent() to prcm_fck
>=20
> Could it be related? Everything ok after reboot, v4.18-rc4.
>=20
> Does anyone else see that? Any ideas?

Ok, so I see that

[ 1775.896270] Charging, 4350000 uV, 532000 uA
[ 1778.700286] omap-mcbsp 40124000.mcbsp: CLKS: could not
clk_set_parent() to prcm_fck
[ 1778.898468] Charging, 4350000 uV, 532000 uA

=2E..even when audio still works. So possibly not related.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltEulUACgkQMOfwapXb+vJTMACeIPf7uc+TNJ5u3B2DyqzETeFi
5eUAnRiPLxAC+DKBwE/o/KfX6a3Bv+QX
=emDT
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
