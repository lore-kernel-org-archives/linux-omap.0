From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 21:57:08 +0100
Message-ID: <20170219205708.GA9641@amd>
References: <20170218180811.GB9377@amd>
 <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com>
 <20170218225435.GA4693@amd>
 <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
 <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
 <20170219190547.GA17292@amd>
 <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EB41EEED-0D94-473F-944F-757B25350A4C-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>Benjamin Tissoires <be>
List-Id: linux-omap@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> But as said I don't think we need float or fixed point for practical syst=
ems
> at all.

So you are going to loose precision. And if userspace decides to
calibrate it slightly differently from kernel, lost precision will
matter.

> >>> and floating point in kernel is hard. Also
> >>> you'd either have to invent new interface, or you'd break touchscreen
> >>> for people that already have their touchscreens calibrated.
> >>=20
> >> No, I don't break calibration for people using a different chip.
> >=20
> > So you propose your touchscreen to behave differently from all other
> > touchscreens in tree?
>=20
> No. I only propose that my touch screen behaves properly and in the
> best way it can. If others are worse, they should also be improved at
> some time.

Different from all other drivers. Read: broken.

No. You have to design interface such that they _can_ be improved, and
what you propose does not work that way.=20

> And note that I am not making things different from others in tree, I
> am making the tsc2007 right (incl. following the touchscreen bindings
> which define the touchscreen size in "Pixels").

Your touch screen is not in any way special, so it has to behave in
the same way others do.

> > That's just no-go.
>=20
> In other words: you want to block any improvements unless your favourite
> touchscreen is giving directions...

Yes. I want to prevent you from pushing crap into the kernel.

If you want to improve it in reasonable way, you know what to do.

> >> You seem to repeat yourself and just say which solution you prefer,
> >> but I am missing the arguments why your solution (Pass calibration data
> >> to userland) is right and the best one.
> >> Which problems does it solve?
> >=20
> > All you described.
>=20
> I think you are missing one problem: providing already properly scaled to=
uch
> values to user space.

I'm not. Userspace has to know how to do the calibration _anyway_ (for
other hardware), so giving scaled values to userspace is useless.

> >> How can you implement it in
> >> a stable and portable way?
> >=20
> > Easily.
>=20
> Please go ahead and show code.

You don't get to tell me what to do, unless you pay me.

You want to break kernel, you do coding. Or pay someone else,
preferably someone who knows how to design kernel code.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliqBqQACgkQMOfwapXb+vI3EgCfTXHQiQCyMcxM4jU5YBg6ysum
UmIAoJQdh3wzIYAvltybgJ9v238pFL8C
=haEX
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
