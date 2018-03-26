From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Mon, 26 Mar 2018 22:31:54 +0200
Message-ID: <20180326203154.GA9334@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180326155828.ttnduivadob4iqmd@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Mon, Mar 26, 2018 at 04:16:38PM +0200, Pavel Machek wrote:
> > Do you have any ideas what needs to be done for voice calls
> > support?
>=20
> Sure.

:-).

> > I can talk to the modem and start a call.
>=20
> Doing an AT query is the easy part :)

Well, yes. Doing it right (ofono, etc) is not that easy.

> > Then something like this (untested!) is certainly needed.
> > Probably more...
>=20
> I intentionally left this part out. The CPCAP codec has two DAIs
> and not 3+. The code you just added is a hack from Motorola. Their
> driver is full of hacks and it's obvious its author(s) did not
> fully understand the ASoC APIs.

Ok.

> My understanding is, that we only need to replace the audio-graph-card
> driver to something more complex. The VOICE DAI needs to be configured
> differently based on the use case:
>=20
> call:
> 	* mode=3Di2s
> 	* freq=3D26000000
> 	* samprate=3D16000 or samprate=3D8000

Ok, lets ignore bluetooth for now. There is "normal" mode, and then
there's "call" mode, right? Where's "normal" mode configured?

Could we simply always configure the VOICE DAI in the call mode? Yes,
it would limit samplerates to 8 or 16k, but .. that's not too
important limitation for voice codec...?

> "audio-graph-card" is not capable of doing this. I was planning to
> try "audio-graph-scu-card" in combination with adding codecs for the
> modem and BT to DT. If that does not work we need a Droid 4 specific
> soundcard driver.
>=20
> Either way "audio-graph-card" is not the correct driver for D4. I
> added it nevertheless, since it gets audio working for now and there
> is no risk of DT breakage. Old *.dtb will continue to work with the
> "audio-graph-card" even after we switch to something else.

Well, you'll still cause regressions when you change the dts, as
people will have wrong .config for new dts.

Best regards,
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

iEYEARECAAYFAlq5WLoACgkQMOfwapXb+vLhUgCdH06JqVN5ITPivIsW8Zb/RK53
QFQAn2jIaSk5wuOSV70BAWIfItf3k3G3
=tVRF
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
