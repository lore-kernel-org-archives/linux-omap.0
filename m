From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 18:15:18 +0100
Message-ID: <20170219171518.GA12833@amd>
References: <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
 <20170217204041.GE13050@dtor-ws>
 <20170218091526.GC8937@amd>
 <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com>
 <20170218180811.GB9377@amd>
 <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com>
 <20170218225435.GA4693@amd>
 <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
 <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>Benjamin Tissoires <be>
List-Id: linux-omap@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Solve it properly. That means passing calibration
> > data from kernel to userland.
>=20
> As written before, the really proper solution would be to provide floating
> or fixed point subpixel input events. Not arbitrarily scaling up in kernel
> and leaving downscaling to user space (where everybody can make it
> worse).

That has no advantages, and floating point in kernel is hard. Also
you'd either have to invent new interface, or you'd break touchscreen
for people that already have their touchscreens calibrated. Just
pass calibration data to userland.

> But I don't think it is worth implementing subpixel touch events for real
> world devices due to the jitter I mentioned.

Yes, that's not really proper solution, that just overengineered. Not
worth implementing. Pass calibration data to userland.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlip0qYACgkQMOfwapXb+vLiFQCeKjGeHS0AZN0qawWIgzFobC8P
2goAnifAx3O1l1Y2ea59Q3l+ZqDCYqOF
=vz/X
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
