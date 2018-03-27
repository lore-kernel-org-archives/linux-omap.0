From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Tue, 27 Mar 2018 22:41:12 +0200
Message-ID: <20180327204111.GA2254@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180326203154.GA9334@amd>
 <20180326231022.vilvxwqkniffk775@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4093762889331988064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180326231022.vilvxwqkniffk775@earth.universe>
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


--===============4093762889331988064==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > My understanding is, that we only need to replace the audio-graph-card
> > > driver to something more complex. The VOICE DAI needs to be configured
> > > differently based on the use case:
> > >=20
> > > call:
> > > 	* mode=3Di2s
> > > 	* freq=3D26000000
> > > 	* samprate=3D16000 or samprate=3D8000
> >=20
> > Ok, lets ignore bluetooth for now. There is "normal" mode, and then
> > there's "call" mode, right? Where's "normal" mode configured?
>=20
> mcbsp3_port: port {
> 	cpu_dai3: endpoint {
> 		dai-format =3D "dsp_a";
> 		frame-master =3D <&cpcap_audio_codec1>;
> 		bitclock-master =3D <&cpcap_audio_codec1>;
> 		remote-endpoint =3D <&cpcap_audio_codec1>;
> 	};
> };

Hmm. Can't tell mode and freq here easily. Does it default to i2s /
26000000?

> > Could we simply always configure the VOICE DAI in the call mode? Yes,
> > it would limit samplerates to 8 or 16k, but .. that's not too
> > important limitation for voice codec...?
>=20
> I think we could configure "normal" mode to use the same settings
> as call mode. But ASoC will disable CPCAP, since there will be no
> active user without ASoC knowing about the modem.

Ok, but then we can just start playback/recording with the call, and
everything should work, no?

But Motorola code seems to do different magic according to modem type,
so things may not be as easy.

                if (pdata->voice_type =3D=3D VOICE_TYPE_STE) {
                        /* STE_M570 */
                        ret =3D cpcap_audio_reg_write(codec, 2, 0xAE06);
                        if (rate =3D=3D 16000)
				ret |=3D cpcap_audio_reg_write(codec, 1, 0x8720);
                        else
                                ret |=3D cpcap_audio_reg_write(codec, 1, 0x=
8120);
                } else if (pdata->voice_type =3D=3D VOICE_TYPE_QC) {
                        /* MDM6600 */
                        ret =3D cpcap_audio_reg_write(codec, 2, 0xAE02);
                        if (rate =3D=3D 16000) {
                                ret |=3D cpcap_audio_reg_write(codec, 1, 0x=
6720);
                        } else {
                                ret |=3D cpcap_audio_reg_write(codec, 1, 0x=
6120);
                        }


> > > "audio-graph-card" is not capable of doing this. I was planning to
> > > try "audio-graph-scu-card" in combination with adding codecs for the
> > > modem and BT to DT. If that does not work we need a Droid 4 specific
> > > soundcard driver.
> > >=20
> > > Either way "audio-graph-card" is not the correct driver for D4. I
> > > added it nevertheless, since it gets audio working for now and there
> > > is no risk of DT breakage. Old *.dtb will continue to work with the
> > > "audio-graph-card" even after we switch to something else.
> >=20
> > Well, you'll still cause regressions when you change the dts, as
> > people will have wrong .config for new dts.
>=20
> That's correct, the .config needs to change. I think that's
> ok, because the only alternative is having no audio support
> at all until the soundcard driver is ready. This means, that
> you also need to change .config once its ready (in case you
> want to use it).

Ok, another problem seems to be that spaces in audio device name seem
to confuse the userland.

Aha, here:

user@devuan:~$ cat /proc/asound/cards
 0 [H58006000encode]: HDMI_58006000_e - HDMI 58006000.encoder
                       HDMI 58006000.encoder
 1 [Audio          ]: Droid_4_Audio - Droid 4 Audio
                       Droid 4 Audio
		      =20
See how the card is refered simply as "Audio"? Same thing then happens
in alsa "state" file:

state.Audio {
        control.1 {

=2E

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq6rGcACgkQMOfwapXb+vIqOQCghGvv04YmFycuGlKWckl00eAD
GtoAoINkt2oBkgwMbiOS8ATGe8+RmCjI
=P5O7
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

--===============4093762889331988064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4093762889331988064==--
