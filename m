From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv5,5/5] ARM: dts: omap4-droid4: add soundcard
Date: Fri, 23 Mar 2018 00:48:32 +0100
Message-ID: <20180322234832.o24ut5ahon46mdu4@earth.universe>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y5ecaf34wtg5q27y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322204804.GA26871@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--y5ecaf34wtg5q27y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Thu, Mar 22, 2018 at 09:48:05PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > Add sound support to Motorola Droid 4 using simple-soundcard
> > and CPCAP's audio codec. This does not yet correctly represent
> > the whole audio routing, since McBSP3 is also connected to
> > Bluetooth and MDM6600 modem (and probably also 4G modem).
> > These extra DAI links are not yet supported and have not been
> > tested.
>=20
> I applied the series on top v4.16-rc5, but I can't seem to get it
> to work:
>=20
> root@devuan:/sys/devices/platform/usb-phy@1# cat /proc/asound/cards
>  0 [H58006000encode]: HDMI_58006000_e - HDMI 58006000.encoder
>                        HDMI 58006000.encoder
> root@devuan:/sys/devices/platform/usb-phy@1#
> [   10.819122] ALSA device list:
> [   10.832641]   #0: HDMI 58006000.encoder
> [   10.842407] Waiting 10 sec before mounting root device...
>=20
> I think I should have the required options enabled...=20
>=20
> CONFIG_SND_OMAP_SOC=3Dy
> CONFIG_SND_OMAP_SOC_DMIC=3Dy
> CONFIG_SND_OMAP_SOC_MCBSP=3Dy
> CONFIG_SND_OMAP_SOC_MCPDM=3Dy
> CONFIG_SND_OMAP_SOC_HDMI_AUDIO=3Dy

That's the SoC (OMAP) side.

> # CONFIG_SND_OMAP_SOC_RX51 is not set
> # CONFIG_SND_OMAP_SOC_N9 is not set
> CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dy
> CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=3Dy

That's not needed (but does not hurt). The Droid 4
has no TWL companion chip and uses CPCAP instead.

> # CONFIG_SND_SOC_IMG is not set
>=20
> #
> # STMicroelectronics STM32 SOC audio support
> #
> # CONFIG_SND_SOC_XTFPGA_I2S is not set
> # CONFIG_ZX_TDM is not set
> CONFIG_SND_SOC_I2C_AND_SPI=3Dy
> CONFIG_SND_SOC_CPCAP=3Dy

That's the codec side.

> Any ideas?

You probably did not enable the soundcard driver, that binds against
"audio-graph-card" compatible and connects the codec driver with the
SoC driver: CONFIG_SND_AUDIO_GRAPH_CARD

-- Sebastian

--y5ecaf34wtg5q27y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq0QMUACgkQ2O7X88g7
+ppWzQ/+N0e86wVGZ+cWdPiKhD18HNNtj9xaw2MrU9lgDBKHWqOqQr4Tx7ghG0os
EKZe4dvtOaaeb2ecNh907LOWlOdmJHI/naBWbiv5ZJIVX/8TNRUDizGrCXcv+qQv
2Z3Fdlf/74gV6yJVTyKWJ6hsMnxUrv8WGKzF3t3hCv4uBft5k3GuZZdYrYfiPebw
v5VY5iJwY2Ai9x43ulw8OsuJBZCm+4Q01gkc76nRGQmfSB7dkqicNRa5fsq6xjuf
WGta9XsdutJwPDg3UNON2Fgelh9x3zl8n2yL8Ooj+O/7Lz80y5ihQ+gjLygppyWy
HDe3pNi9OzBHGBHWzJdLGVsLhhfY/2cX6yjn1d52Qcdil7iI5KRj6TeEIOckXtfC
VX9umFJgVlso5pBrxpBFp29XN0SMe3bAjc++FnFx2kv34A97sdKyReWunVvfWaPw
iq3lxPKxskZtir02Sfl94+EfGSgT54U1GgyL62lpu+2bj627Rp/wTmK2GDfrq1BO
MZFDWNYyVNSmq8s0IWiTHycyOU/z0F9xfwC/LVXurV0X0dMGQ3ywSbU/einkRkuo
ydJGb0ftTHXx8sYf1s0P1SMULdo7heV00iYLRlgtvwCZyEI0i9nXf3QrpKiKNYAg
6FCeJdTkeDhgniiqNccv+skLvJhuusfWUJQUz/Vh+B3Zb9gHKDU=
=gDeS
-----END PGP SIGNATURE-----

--y5ecaf34wtg5q27y--
