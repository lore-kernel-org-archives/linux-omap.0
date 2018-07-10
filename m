From: Pavel Machek <pavel@ucw.cz>
Subject: droid 4: no sound in the morning
Date: Tue, 10 Jul 2018 12:59:10 +0200
Message-ID: <20180710105910.GA4442@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I attempted to use droid 4 as an alarm clock, but got no sound in the
morning.

Log said:

[78798.682830] omap-mcbsp 40124000.mcbsp: CLKS: could not
clk_set_parent() to prcm_fck
[78803.561767] omap-mcbsp 40126000.mcbsp: CLKS: could not
clk_set_parent() to prcm_fck

Could it be related? Everything ok after reboot, v4.18-rc4.

Does anyone else see that? Any ideas?
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltEkX4ACgkQMOfwapXb+vIVyACgi+jFy1H0hV29Qq8MvlQvM3Qn
I4gAoL46n4KX/taKaR5VcxNTiFfC/S0F
=/FWp
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
