From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Tue, 27 Mar 2018 01:10:22 +0200
Message-ID: <20180326231022.vilvxwqkniffk775@earth.universe>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180326203154.GA9334@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i5uadt65azdtfiis"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180326203154.GA9334@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--i5uadt65azdtfiis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 26, 2018 at 10:31:54PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > On Mon, Mar 26, 2018 at 04:16:38PM +0200, Pavel Machek wrote:
> > > Do you have any ideas what needs to be done for voice calls
> > > support?
> >=20
> > Sure.
>=20
> :-).
>=20
> > > I can talk to the modem and start a call.
> >=20
> > Doing an AT query is the easy part :)
>=20
> Well, yes. Doing it right (ofono, etc) is not that easy.

I agree. That can be worked on independently.

> > > Then something like this (untested!) is certainly needed.
> > > Probably more...
> >=20
> > I intentionally left this part out. The CPCAP codec has two DAIs
> > and not 3+. The code you just added is a hack from Motorola. Their
> > driver is full of hacks and it's obvious its author(s) did not
> > fully understand the ASoC APIs.
>=20
> Ok.
>=20
> > My understanding is, that we only need to replace the audio-graph-card
> > driver to something more complex. The VOICE DAI needs to be configured
> > differently based on the use case:
> >=20
> > call:
> > 	* mode=3Di2s
> > 	* freq=3D26000000
> > 	* samprate=3D16000 or samprate=3D8000
>=20
> Ok, lets ignore bluetooth for now. There is "normal" mode, and then
> there's "call" mode, right? Where's "normal" mode configured?

mcbsp3_port: port {
	cpu_dai3: endpoint {
		dai-format =3D "dsp_a";
		frame-master =3D <&cpcap_audio_codec1>;
		bitclock-master =3D <&cpcap_audio_codec1>;
		remote-endpoint =3D <&cpcap_audio_codec1>;
	};
};

> Could we simply always configure the VOICE DAI in the call mode? Yes,
> it would limit samplerates to 8 or 16k, but .. that's not too
> important limitation for voice codec...?

I think we could configure "normal" mode to use the same settings
as call mode. But ASoC will disable CPCAP, since there will be no
active user without ASoC knowing about the modem.

> > "audio-graph-card" is not capable of doing this. I was planning to
> > try "audio-graph-scu-card" in combination with adding codecs for the
> > modem and BT to DT. If that does not work we need a Droid 4 specific
> > soundcard driver.
> >=20
> > Either way "audio-graph-card" is not the correct driver for D4. I
> > added it nevertheless, since it gets audio working for now and there
> > is no risk of DT breakage. Old *.dtb will continue to work with the
> > "audio-graph-card" even after we switch to something else.
>=20
> Well, you'll still cause regressions when you change the dts, as
> people will have wrong .config for new dts.

That's correct, the .config needs to change. I think that's
ok, because the only alternative is having no audio support
at all until the soundcard driver is ready. This means, that
you also need to change .config once its ready (in case you
want to use it).

-- Sebastian

--i5uadt65azdtfiis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq5fdsACgkQ2O7X88g7
+prhZRAApQkHNTKBiekdTd0mHMdQBdikbMO5XeqxlFQ98eR0aXm0tKf6Akf0ogLh
pPIp8NOjCJhAG3oSQbK9ouuc12GhEqHZXBwYbHl9GUudpOrR3eBCjwQ/6/KBFu28
pRye5PXGK1aTWYco2+QPqFYfJAvkXlOYfgf26DvphSGsRwuvn/O48YVljbFRRjWx
cQv6lFWT68S4Wes+2OO7KEO6a6OiS3SMvK0D6KzQ5VImTaARtN/H8eZ0qTs7KSYn
7XRmepBhvp1IEjZsfjmo2pvbo/AmA0PrO/QVmXl2PsQSPGt79l/jZnxOj6Hynyl2
QHcWp2PHevxQVfOnuZCVud4DFwe4VZrADMOCcjcBuHbS0uLIJPL/xOyDOvBi+TIW
KPtQX0vc3Pi+6xFE3nYRukp7rPh+vs30Z8v4tt5sMDJzJHvInLrQX2Wbxm/1WRc5
g0k1SREexBPfgn5mulrFH6VY0SWAvG2EvWl9mw9ZwjAS6u1EARHT87CGY7H1kegx
w0fOkMrTvcHkNwZq4V7ETzsmVCdCgCiyksQLgeI8olK6oc20SQRn5BdjF6ajUVoV
Yj46zhSoERZsZ5u2bcL25UuDd8t/n/LwKN5O4BD8ECOHA7Dnf+tlS9LkyHhnqL/j
DN8NWLVgCeFnyvn758PD2E2l6S8IWbxFfX2yEnISTSU0KfXvPO0=
=PU4x
-----END PGP SIGNATURE-----

--i5uadt65azdtfiis--
