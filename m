From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Battery charging, battery status on Nokia N9, N950
Date: Tue, 7 Nov 2017 20:50:20 +0100
Message-ID: <20171107195020.GA19508@amd>
References: <20171103210349.GA14071@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171103210349.GA14071@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm fighting with battery status & battery charging on Nokia
> N9/N950. https://elinux.org/N950 contains enough info to get battery
> status (and below is first attempt at kernel implementation), but I'm
> not sure what needs to be done to charge the battery (or at least
> power phone from USB).

Nemo recovery system (2824336 Jul 25  2016 zImage-moslo) seems to
either charge phone from USB or at power it from USB.

But 4.13 does not; it seems there are two separate issue.

First, something needs to be done to enable system power from the
USB. I'm not sure what that one would be :-(. Then, it should be
possible to ask bq24153 to charge the battery.

Best regards,
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloCDnwACgkQMOfwapXb+vJPjQCgr3voTFKuZfZ2N8eWbEdkAc0Z
7lQAn1zx41o+j3qRSOY07t0v7ry7xAvm
=nH86
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
