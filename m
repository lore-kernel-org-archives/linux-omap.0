From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 20:32:28 +0100
Message-ID: <20170220193228.GB23745@amd>
References: <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
 <20170219190547.GA17292@amd>
 <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
 <20170219205708.GA9641@amd>
 <20170219232918.53801560@aktux>
 <20170219223949.GA2470@amd>
 <EE81034E-C10E-4E8B-B026-B3E92C0DAA19@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EE81034E-C10E-4E8B-B026-B3E92C0DAA19@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Michel Verlaan <michel.verl@gmail.com>, Nick Dyer <nick@shmanahar.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@nokia.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Hans Verkuil <hans.verkuil@cisco.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > But if you have userspace that depends on touchscreen to be
> > calibrated... that _is_ wrong.
>=20
> User-space people and real users have the opposite opinion. They
> prefer if a touch is plug&play. I.e. without need for calibration.

Some people prefer to calibrate their touchscreens; because of
per-device variations, that gives better precision.

You can pass default calibration data from device tree to kernel to
userland. But you can not force people to use that calibration.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlirREwACgkQMOfwapXb+vL9WACgv4QUgsdFRlmmfcDNHeF6zy+p
2ZUAmwb6kpz2iVvbh5rIXETQpOoOaJc5
=heiN
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
