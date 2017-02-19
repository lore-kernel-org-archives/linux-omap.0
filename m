From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 23:19:30 +0100
Message-ID: <20170219221930.GA1568@amd>
References: <20170218225435.GA4693@amd>
 <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
 <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
 <20170219190547.GA17292@amd>
 <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
 <20170219205708.GA9641@amd>
 <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>Benjamin Tissoires <be>
List-Id: linux-omap@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi!

> >> But as said I don't think we need float or fixed point for practical s=
ystems
> >> at all.
> >=20
> > So you are going to loose precision. And if userspace decides to
> > calibrate it slightly differently from kernel, lost precision will
> > matter.
>=20
> Really?

Really.

> Example:
>=20
> ADC values go 100 .. 3995 (i.e. touch margin is 100 steps in pre-calibrat=
ion)
>=20
> This is scaled to let's say 0..640.

Ok. Now userspace realizes that kernel alignemnt is off, and it would
want to scale it to 1..642. That will mean that single pixel will be
inaccessible, right?

> > No. You have to design interface such that they _can_ be improved, and
> > what you propose does not work that way.
>=20
> It works. Please do real world tests...

You do a real world test on N900, and propose upgrade path.

> > Yes. I want to prevent you from pushing crap into the kernel.
>=20
> Crap? Well, we have discussed this driver for months here on the list and
> after a lot of improvements we came up to v9.
>=20
> And you still think it is crap and none of the other reviewers has notice=
d?

I'm pretty sure you will not be able to push calibration into kernel.

> > Userspace has to know how to do the calibration _anyway_ (for
> > other hardware),
>=20
> What for? I do not understand which other hardware you are talking about.
>=20
> On our devices there is only one touch glued to the panel and that one
> has to be calibrated. Ideally before the user gets the device into his
> hands =3D> precalibration...
>=20
> If you connect a digitizer, then that one has to be calibrated of course,
> but it is not glued onto the display panel. Hence it is a different
> issue.

It is actually same issue. One kernel interface should work for all
the touchscreens.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliqGfIACgkQMOfwapXb+vLnywCcDxW/8Yj5fNqSy76uLBFBw6oN
auUAoI+rBman4w0thzCt4C1J1ytz8kvD
=KbZI
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
