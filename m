From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Wed, 28 Mar 2018 11:00:31 +0200
Message-ID: <20180328090031.GA17300@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180326155828.ttnduivadob4iqmd@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I can talk to the modem and start a call.
>=20
> Doing an AT query is the easy part :)
>=20
> > Then something like this (untested!) is certainly needed.
> > Probably more...
>=20
> I intentionally left this part out. The CPCAP codec has two DAIs
> and not 3+. The code you just added is a hack from Motorola. Their
> driver is full of hacks and it's obvious its author(s) did not
> fully understand the ASoC APIs.
>=20
> My understanding is, that we only need to replace the audio-graph-card
> driver to something more complex. The VOICE DAI needs to be configured
> differently based on the use case:

Does the voice part work for you? I configured all the mixers to
voice, and then am using

sudo aplay -D plughw:CARD=3DAudio,DEV=3D1 /usr/share/sounds/alsa/Front_Cent=
er.wav  -r 16000
X11 connection rejected because of wrong authentication.
xcb_connection_has_error() returned true
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
user@devuan:/my/tui/rweb$

to play the test sound. But I get white noise, not a test sound
:-(. [This also shows problem with card naming.]

Any ideas?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq7Wa8ACgkQMOfwapXb+vIATwCeOgkbcM0d8QDXDvcFTXgp03kW
BmUAnRiOuZwHPw3EtgKRu3+sYyYK87X/
=pttb
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
