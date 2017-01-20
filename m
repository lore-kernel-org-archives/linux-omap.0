From: Pavel Machek <pavel@ucw.cz>
Subject: Nokia N900: microphone mixers
Date: Fri, 20 Jan 2017 14:31:59 +0100
Message-ID: <20170120133159.GA5241@amd>
References: <20170112181826.GA28290@amd>
 <201701121934.19810@pali>
 <20170114225614.GA25321@amd>
 <201701150100.54214@pali>
 <20170115100533.GA15816@amd>
 <40dbce4e-d99d-d77d-e682-5b004c70ca40@bitmer.com>
 <d2c78625-565a-86ec-a03e-f15ae071942a@ti.com>
 <ecdc073b-d83f-ba7d-89bf-da8899414217@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ecdc073b-d83f-ba7d-89bf-da8899414217@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, alsa-devel@alsa-project.org, helen.koike@collabora.co.uk, lars@metafoo.de, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Do you have any idea how to control the microphone? I'd like the audio
source to be microphone on headset (not the built in one). So I run
alsamixer, set everything in "capture" section to zero... and I still
get the audio from the internal microphone :-(.

Tested with arecord | aplay.

Any ideas?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliCEU8ACgkQMOfwapXb+vLD2ACeOJKzB0J4siOEs7CEfDnlHSt9
RKsAnRUM2YkLTqb7KUkMYUXHpLNf8KY4
=FZYE
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
