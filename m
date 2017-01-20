From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: microphone mixers
Date: Fri, 20 Jan 2017 20:32:24 +0100
Message-ID: <20170120193224.GA14527@amd>
References: <20170114225614.GA25321@amd>
 <201701150100.54214@pali>
 <20170115100533.GA15816@amd>
 <40dbce4e-d99d-d77d-e682-5b004c70ca40@bitmer.com>
 <d2c78625-565a-86ec-a03e-f15ae071942a@ti.com>
 <ecdc073b-d83f-ba7d-89bf-da8899414217@bitmer.com>
 <20170120133159.GA5241@amd>
 <20170120133830.GF32502@pali>
 <20170120140047.GB5241@amd>
 <20170120140404.GG32502@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120140404.GG32502@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, alsa-devel@alsa-project.org, helen.koike@collabora.co.uk, lars@metafoo.de, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-01-20 15:04:04, Pali Roh=E1r wrote:
> On Friday 20 January 2017 15:00:47 Pavel Machek wrote:
> > On Fri 2017-01-20 14:38:30, Pali Roh=E1r wrote:
> > > On Friday 20 January 2017 14:31:59 Pavel Machek wrote:
> > > > Hi!
> > > >=20
> > > > Do you have any idea how to control the microphone? I'd like the au=
dio
> > > > source to be microphone on headset (not the built in one). So I run
> > > > alsamixer, set everything in "capture" section to zero... and I sti=
ll
> > > > get the audio from the internal microphone :-(.
> > > >=20
> > > > Tested with arecord | aplay.
> > > >=20
> > > > Any ideas?
> > >=20
> > > Hi! Try to set Jack Function to Headset or enable b HS Mic.
> >=20
> > I can't find "b HS Mic" function. I can set "Input Select" to "ADC",
> > and ten internal microphone is off, but I can't get any audio on
> > input. I tried with "Jack function" both "headset" and "headphone".
> >=20
> > Do I need to enable microphone bias voltage somewhere?
>=20
> When you set Jack function to headset it automatically enable HS Mic
> control which controls mic bias.
>=20
> If Jack function in headset mode does not work, then there is bug. Try
> older versions of kernel...

Would you know which mainline kernel version is "known good"?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliCZcgACgkQMOfwapXb+vK9tQCfbe4Y/NYXn+xk1HDM8Z8vtv9C
MdMAn3EqC83qKTdOewm9NkudZHrKN4BC
=nyxW
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
