From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Wed, 28 Mar 2018 11:36:41 +0200
Message-ID: <20180328093641.GA17774@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180328090031.GA17300@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3301934277111650717=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180328090031.GA17300@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============3301934277111650717==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I can talk to the modem and start a call.
> >=20
> > Doing an AT query is the easy part :)
> >=20
> > > Then something like this (untested!) is certainly needed.
> > > Probably more...
> >=20
> > I intentionally left this part out. The CPCAP codec has two DAIs
> > and not 3+. The code you just added is a hack from Motorola. Their
> > driver is full of hacks and it's obvious its author(s) did not
> > fully understand the ASoC APIs.
> >=20
> > My understanding is, that we only need to replace the audio-graph-card
> > driver to something more complex. The VOICE DAI needs to be configured
> > differently based on the use case:
>=20
> Does the voice part work for you? I configured all the mixers to
> voice, and then am using

I tried with 8kHz, 8-bit, too:

user@devuan:/my/tui/rweb$ arecord -D plughw:CARD=3DAudio,DEV=3D1 -t wav
--max-file-time 30 mon.wav
Recording WAVE 'mon.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...
arecord: pcm_read:2103: read error: Interrupted system call
user@devuan:/my/tui/rweb$ aplay -D plughw:CARD=3DAudio,DEV=3D1 -t wav
mon.wav
Playing WAVE 'mon.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...

Recording works okay, but playback produces ugly noise (not white this
time). If I copy mon.wav to PC, it playes back in pretty acceptable
quality.

So summary

HIFI DAI works
VOICE DAI recording is ok
VOICE DAI playbacks plays noise.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq7YikACgkQMOfwapXb+vLxNwCdE/Fragqrz7l3vrPSiD4kZkYU
mkgAnjYnKZqJYm5pviMW9kjZfIIfJ++H
=xgf1
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

--===============3301934277111650717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3301934277111650717==--
