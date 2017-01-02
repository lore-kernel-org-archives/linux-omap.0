From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 2 Jan 2017 10:33:45 +0100
Message-ID: <20170102093345.GA20104@amd>
References: <201701012054.54505@pali>
 <20170101223639.GA13868@amd>
 <4f150265-aa9b-c1f3-4634-9df8b320836b@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4f150265-aa9b-c1f3-4634-9df8b320836b@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I'd like to get detection of headset button presses to work in recent
> > kernels, but could not figure it out :-(.
> >=20
> My vague memory doesn't tell how basic button press detection was
> implemented in Maemo kernel. Was it codec, same voltage detection
> circuit than ECI or some another GPIO? I don't even remember did we
> implement it for the MeeGo N900 developer edition :-(

Another GPIO, as far as I can tell. There was some delay logic in 2.6
kernel (it removed false events happening when jack was inserted),
other that that it should be quite simple. (But I did not yet figure
it out in 4.x kernel).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhqHnkACgkQMOfwapXb+vKFsgCfXmsfqtCBv6nof8CI84BX+Anz
ydUAoLy3hPP6f9fhSn+nMMroXiYCw2i8
=lorm
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
