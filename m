From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 kernel support
Date: Fri, 10 Nov 2017 18:16:39 +0100
Message-ID: <20171110171639.GB31871@amd>
References: <20171110144519.o2dccswmzdjkfrnt@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171110144519.o2dccswmzdjkfrnt@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, ivo.g.dimitrov.75@gmail.com, sakari.ailus@iki.fi, patrikbachan@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hi! Yesterday I updated https://elinux.org/N900 page based on data which
> I found in linux git repository. So driver status should be up-to-date.
>=20
> I would like to ask, what is current status of the bluetooth driver? It
> is working on N900, or it has a problems?

See other email.

> Also are the any plans for bringing front webcam to work? IIRC there was
> problem that it was not possible to describe in DT that back and front
> cameras.

Front webcam... Few lines of code (or maybe only few lines of dts) and
perhaps quite a lot of debugging would be required there. OTOH... its
quality is not great, so...

BTW main camera only works in 1.3MPix mode. Getting 5MPix there would
be nice...=20

> And what happened with ramp mode for camera autofocus?

We don't have userland application using those, so it was easier not
to merge them. It is few lines of code if you have application needing
these.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloF3vcACgkQMOfwapXb+vJzwACgrjMQ/9VjGAb96Eg2yxOm8CdE
ZO0AoJf2vev3Aka2BzVwHT9I7BUijOZ7
=ZGjx
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
