From: Pavel Machek <pavel@ucw.cz>
Subject: Droid 4: poweroff does not work? calls
Date: Sun, 9 Dec 2018 13:13:18 +0100
Message-ID: <20181209121318.GA24478@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
affected. It is bad, because when your battery is low, you get into
reboot loop and discharge it furher, which batteries do not like.

Any ideas, or at least idea how to debug this?

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNBt4ACgkQMOfwapXb+vLUqgCgpNoWs1ZF9EPprWwWF0RemEED
xFEAoJBxpNOAr8LoKxNRLnEQb/j1bA7D
=Mhar
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
