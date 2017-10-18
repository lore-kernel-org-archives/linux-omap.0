From: Pavel Machek <pavel@ucw.cz>
Subject: Re: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
Date: Wed, 18 Oct 2017 14:28:04 +0200
Message-ID: <20171018122804.GA14376@amd>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth>
 <20170908113231.GJ18365@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170908113231.GJ18365@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
Cc: Marek Belisko <marek.belisko@open-nandra.com>, robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-omap@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Without patch description: See Last Question in
> >=20
> > Documentation/power/power_supply_class.txt
>=20
> ...should be done in libbattery, yet to be written. :-).
>=20
> Do you have specific guidance what you'd like to see in libbattery?

So I started something, it is at.

https://github.com/pavelmachek/libbattery

My battery on n900 is currently uncalibrated (and charging), still it
gets some kind of estimation:

Battery -1 %
Seconds -1
State 1
Voltage 3.88 V
Battery 63 %

Of course, there's a lot more work to be done.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnnSNQACgkQMOfwapXb+vIvsQCfdBsdDQfqmnJUL4FhqOfZYDNe
hiEAmQHrDB2kCeGo4a2VyguJDLSK+vDM
=4bLx
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
