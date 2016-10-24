From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] shutdown machine when li-ion battery goes below 3V
Date: Mon, 24 Oct 2016 23:41:52 +0200
Message-ID: <20161024214152.GA32310@amd>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161024212932.uhjz752z2cy5hohl@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-10-24 14:29:33, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [161024 14:24]:
> > Hi!
> >=20
> > What about something like this? N900 will drain the battery down to
> > system crash, which is quite uncool.
>=20
> Can't we make that generic and configurable for the voltage somehow?

I was afraid someone would ask :-).

Yes, we probably need to create battery object in the device tree,
then add properties there.

> Also, the shutdown voltage can depend on external devices connected.
> It could be for example 3.3V depending on eMMC on some devices while
> devices with no eMMC could have it at 3.0V.

Actually, I'd like to shutdown at 3.3V or more (like 3.5V), because
going below that is pretty mean to the battery. But if I set threshold
too high, GSM activity will push it below that for a very short while,
and I'll shutdown too soon.

Ideas welcome...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgOgCAACgkQMOfwapXb+vKhLACgml8iTAENbqR8NSespLqW1+3K
fLoAn01UQ70P4EjnN6YpkHPAYc2jJdiv
=wTNS
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
