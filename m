From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola Droid 4 progress, power consumption
Date: Wed, 2 May 2018 23:32:10 +0200
Message-ID: <20180502213210.GA10306@amd>
References: <20180501183148.GA26996@amd>
 <20180502144158.GJ98604@atomide.com>
 <20180502191049.ximiyccwfkjqcj7m@devuan>
 <20180502194229.GM98604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502194229.GM98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I also have some hacks to allow configuration of the full
> > voltage. Charging to 4.35V is pretty agressive, and I believe baterry
> > will be damaged less if we only charge to 4.1V.
>=20
> That should be based on the PMIC register values that Android
> uses. Worth rechecking for sure, I thought it is higher than
> normal too for the charge voltage.

Actually that part is ok. Android probably charges it to 4.35V, and
battery is designed to handle that... For a year, or two. But I don't need
full capacity at the moment, and perhaps battery will last three years
if it is only charged to 4.1V.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrqLloACgkQMOfwapXb+vK36ACeIVRUG8qo5IiJ6IEkHGYTXv8k
5q8AoIt6016ajIioM5IFMwSGuNsvAVdI
=LpUG
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
