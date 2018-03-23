From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv5,
	5/5] ARM: dts: omap4-droid4: add soundcard
Date: Fri, 23 Mar 2018 11:09:30 +0100
Message-ID: <20180323100930.GA21644@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6956086639242749605=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180322234832.o24ut5ahon46mdu4@earth.universe>
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


--===============6956086639242749605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > # CONFIG_SND_OMAP_SOC_RX51 is not set
> > # CONFIG_SND_OMAP_SOC_N9 is not set
> > CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dy
> > CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=3Dy
>=20
> That's not needed (but does not hurt). The Droid 4
> has no TWL companion chip and uses CPCAP instead.

Aha, thanks. I was doing wild experiments to get something that
boots... I turned them off.

> > Any ideas?
>=20
> You probably did not enable the soundcard driver, that binds against
> "audio-graph-card" compatible and connects the codec driver with the
> SoC driver: CONFIG_SND_AUDIO_GRAPH_CARD

Ok, that certainly changed things; I am now getting this:

Mar 23 08:39:17 devuan kernel: [   11.633605] asoc-audio-graph-card soundca=
rd: GPIO lookup for
 consumer pa
Mar 23 08:39:17 devuan kernel: [   11.644958] asoc-audio-graph-card soundca=
rd: using device tr
ee for GPIO lookup
Mar 23 08:39:17 devuan kernel: [   11.656677] of_get_named_gpiod_flags: can=
't parse 'pa-gpios'
 property of node '/soundcard[0]'
Mar 23 08:39:17 devuan kernel: [   11.669738] of_get_named_gpiod_flags: can=
't parse 'pa-gpio'=20
property of node '/soundcard[0]'
Mar 23 08:39:17 devuan kernel: [   11.682617] asoc-audio-graph-card soundca=
rd: using lookup ta
bles for GPIO lookup
Mar 23 08:39:17 devuan kernel: [   11.694427] asoc-audio-graph-card soundca=
rd: lookup for GPIO
 pa failed

Indeed the dts does not seem to contain any gpios

        soundcard {
                compatible =3D "audio-graph-card";
                label =3D "Droid 4 Audio";

                simple-graph-card,widgets =3D
                        "Speaker", "Earpiece",
                        "Speaker", "Loudspeaker",
	                "Headphone", "Headphone Jack",
	                "Microphone", "Internal Mic";

                simple-graph-card,routing =3D
	                "Earpiece", "EP",
		        "Loudspeaker", "SPKR",
                        "Headphone Jack", "HSL",
                        "Headphone Jack", "HSR",
	                "MICR", "Internal Mic";

                dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
	};

Any more ideas? :-)

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq00loACgkQMOfwapXb+vL71wCfei9Wakmc6L0+DQQ6ydjcLxIl
d54AnAmfV0UHVbqUBgYCCLQbQS1kZVmN
=VTw6
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============6956086639242749605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6956086639242749605==--
