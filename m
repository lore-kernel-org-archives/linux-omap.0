From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 20:05:47 +0100
Message-ID: <20170219190547.GA17292@amd>
References: <20170218091526.GC8937@amd>
 <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com>
 <20170218180811.GB9377@amd>
 <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com>
 <20170218225435.GA4693@amd>
 <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
 <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>Benjamin Tissoires <be>
List-Id: linux-omap@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hi Pavel,
> I love discussions with you :)

Unfortunately I can't say the same.

> > Am 19.02.2017 um 18:15 schrieb Pavel Machek <pavel@ucw.cz>:
> >=20
> >=20
> >>> Solve it properly. That means passing calibration
> >>> data from kernel to userland.
> >>=20
> >> As written before, the really proper solution would be to provide floa=
ting
> >> or fixed point subpixel input events. Not arbitrarily scaling up in ke=
rnel
> >> and leaving downscaling to user space (where everybody can make it
> >> worse).
> >=20
> > That has no advantages,
>=20
> It has the advantage of providing you with the full precision of raw data=
 (but
> properly scaled) so that you don't loose any bit of information. This is =
what
> you just asked for - one or two mails before.

Not really, right? No matter what kind of fixed point you introduce,
you'll still loose precision.

> > and floating point in kernel is hard. Also
> > you'd either have to invent new interface, or you'd break touchscreen
> > for people that already have their touchscreens calibrated.
>=20
> No, I don't break calibration for people using a different chip.

So you propose your touchscreen to behave differently from all other
touchscreens in tree? That's just no-go.

> > Yes, that's not really proper solution, that just overengineered. Not
> > worth implementing. Pass calibration data to userland.
>=20
> You seem to repeat yourself and just say which solution you prefer,
> but I am missing the arguments why your solution (Pass calibration data
> to userland) is right and the best one.
> Which problems does it solve?

All you described.

> Which one does it solve better than others?

It is not terminally ugly.

> How can you implement it in
> a stable and portable way?

Easily.

> How can you make sure that all user-space GUI
> systems can and will make use of this calibration data?

You can't, and you don't need to.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlip7IsACgkQMOfwapXb+vJz1ACbBm1XiEklbcPpEKAifUTzqcpl
C7IAnimyfkFxjDaJFywe9TTgBzkYsL1v
=XerP
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
