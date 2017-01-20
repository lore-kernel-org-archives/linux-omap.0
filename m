From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: microphone mixers
Date: Fri, 20 Jan 2017 15:00:47 +0100
Message-ID: <20170120140047.GB5241@amd>
References: <20170112181826.GA28290@amd>
 <201701121934.19810@pali>
 <20170114225614.GA25321@amd>
 <201701150100.54214@pali>
 <20170115100533.GA15816@amd>
 <40dbce4e-d99d-d77d-e682-5b004c70ca40@bitmer.com>
 <d2c78625-565a-86ec-a03e-f15ae071942a@ti.com>
 <ecdc073b-d83f-ba7d-89bf-da8899414217@bitmer.com>
 <20170120133159.GA5241@amd>
 <20170120133830.GF32502@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120133830.GF32502@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, alsa-devel@alsa-project.org, helen.koike@collabora.co.uk, lars@metafoo.de, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-01-20 14:38:30, Pali Roh=E1r wrote:
> On Friday 20 January 2017 14:31:59 Pavel Machek wrote:
> > Hi!
> >=20
> > Do you have any idea how to control the microphone? I'd like the audio
> > source to be microphone on headset (not the built in one). So I run
> > alsamixer, set everything in "capture" section to zero... and I still
> > get the audio from the internal microphone :-(.
> >=20
> > Tested with arecord | aplay.
> >=20
> > Any ideas?
>=20
> Hi! Try to set Jack Function to Headset or enable b HS Mic.

I can't find "b HS Mic" function. I can set "Input Select" to "ADC",
and ten internal microphone is off, but I can't get any audio on
input. I tried with "Jack function" both "headset" and "headphone".

Do I need to enable microphone bias voltage somewhere?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliCGA8ACgkQMOfwapXb+vIPRgCgtRbIyklhlO8klMafJk86HJj8
HkAAoKL88nL5llp27M84oI6YDnd7MhVZ
=zXUB
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
