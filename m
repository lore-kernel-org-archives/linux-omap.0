From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 23:39:49 +0100
Message-ID: <20170219223949.GA2470@amd>
References: <20170218225435.GA4693@amd>
 <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
 <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
 <20170219190547.GA17292@amd>
 <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
 <20170219205708.GA9641@amd>
 <20170219232918.53801560@aktux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170219232918.53801560@aktux>
Sender: linux-input-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Michel Verlaan <michel.verl@gmail.com>, Nick Dyer <nick@shmanahar.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@nokia.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Hans Verkuil <hans.verkuil@cisco.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > And note that I am not making things different from others in tree,
> > > I am making the tsc2007 right (incl. following the touchscreen
> > > bindings which define the touchscreen size in "Pixels").
> >=20
> > Your touch screen is not in any way special, so it has to behave in
> > the same way others do.
> >=20
>=20
> I agree, the tsc2007 (=3Dwhat the interface provides to userspace) should
> not behave special, for example it should behave like the virtual
> touchscreen (=3Dwhat the interface provides to userspace) virtualbox
> gives. No need to be calibrated. Well, the internals are different. But
> that is what the kernel is good for, abstract such things.
> Conclusion: It cannot be totally wrong behavior to have pixel values
> there.

It is not "totally wrong". But it is useless code that should not be
in kernel. Calibration certainly does not belong to single
_driver_. Feel free to submit driver but keep the calibration code out
of tree...

But if you have userspace that depends on touchscreen to be
calibrated... that _is_ wrong.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliqHrUACgkQMOfwapXb+vKmjgCgxGN0+2UP2ztzrW4TKK0NyeMN
ufEAoImVS6jw6yD9lt/JsIf5RjRXfSa5
=OgiH
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
