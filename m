From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 04/12] OMAPDSS: hdmi_audio: Integrated ASoC DAI component
 driver implementation
Date: Fri, 27 Jun 2014 14:10:29 +0300
Message-ID: <53AD5125.4040006@ti.com>
References: <cover.1403807781.git.jsarha@ti.com> <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="o32J7124B18dJ7EPASTM4qUDo9LDXdTON"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43211 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbaF0LKw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 07:10:52 -0400
In-Reply-To: <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

--o32J7124B18dJ7EPASTM4qUDo9LDXdTON
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/06/14 22:20, Jyri Sarha wrote:
> Integrate ASoC DAI component driver in to the OMAP hdmi driver. The
> patch also updates the relevant entry in ti,omap5-dss DT binding
> document. The driver registers a dummy hdmi codec driver and a
> simple-card driver to produce a fully functional ALSA device. The DAI
> driver is implemented in hdmi_audio.c, but it still needs to be
> registered from hdmi4.c or hdmi5.c.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/Makefile     |    2 +
>  drivers/video/fbdev/omap2/dss/hdmi.h       |   38 +++-
>  drivers/video/fbdev/omap2/dss/hdmi_audio.c |  317 ++++++++++++++++++++=
++++++++
>  3 files changed, 355 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/video/fbdev/omap2/dss/hdmi_audio.c
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/Makefile b/drivers/video/fbd=
ev/omap2/dss/Makefile
> index 245f933..8260987 100644
> --- a/drivers/video/fbdev/omap2/dss/Makefile
> +++ b/drivers/video/fbdev/omap2/dss/Makefile
> @@ -14,5 +14,7 @@ omapdss-$(CONFIG_OMAP2_DSS_DSI) +=3D dsi.o
>  omapdss-$(CONFIG_OMAP2_DSS_HDMI_COMMON) +=3D hdmi_common.o hdmi_wp.o h=
dmi_pll.o \
>  	hdmi_phy.o
>  omapdss-$(CONFIG_OMAP4_DSS_HDMI) +=3D hdmi4.o hdmi4_core.o
> +omapdss-$(CONFIG_OMAP4_DSS_HDMI_AUDIO) +=3D hdmi_audio.o
>  omapdss-$(CONFIG_OMAP5_DSS_HDMI) +=3D hdmi5.o hdmi5_core.o
> +omapdss-$(CONFIG_OMAP5_DSS_HDMI_AUDIO) +=3D hdmi_audio.o
>  ccflags-$(CONFIG_OMAP2_DSS_DEBUG) +=3D -DDEBUG
> diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev=
/omap2/dss/hdmi.h
> index 927cb4d..cc6ecb5 100644
> --- a/drivers/video/fbdev/omap2/dss/hdmi.h
> +++ b/drivers/video/fbdev/omap2/dss/hdmi.h
> @@ -25,6 +25,11 @@
>  #include <linux/hdmi.h>
>  #include <video/omapdss.h>
> =20
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_H=
DMI_AUDIO)

I think you're a bit overeager with these ifdefs =3D). They make the code=

more difficult to read. The question is, what is their purpose here? I'm
quite sure those includes below can be included just fine even without
HDMI support in the driver. So as far as I see, their only purpose would
be to very minimally speed up the kernel compilation.

> +#include <sound/dmaengine_pcm.h>
> +#include <uapi/sound/asound.h>
> +#endif
> +
>  #include "dss.h"
> =20
>  /* HDMI Wrapper */
> @@ -338,6 +343,35 @@ int hdmi_parse_lanes_of(struct platform_device *pd=
ev, struct device_node *ep,
>  	struct hdmi_phy_data *phy);
> =20
>  #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO) || defined(CONFIG_OMAP5_DSS_H=
DMI_AUDIO)

Same here. The struct definition doesn't do any harm, even if the audio
support is not compiled in.

> +struct hdmi_audio_data {
> +	/* These should be initialized when hdmi_audio_register() is called *=
/
> +	struct mutex *hdmi_lock;
> +	struct hdmi_wp_data *wp;
> +	struct hdmi_core_data *core;
> +	struct hdmi_config *cfg;
> +	struct snd_soc_dai_driver *hdmi_dai_drv;
> +
> +	int (*audio_start)(struct hdmi_core_data *core,
> +			   struct hdmi_wp_data *wp);
> +	void (*audio_stop)(struct hdmi_core_data *core,
> +			   struct hdmi_wp_data *wp);
> +	int (*audio_config)(struct hdmi_core_data *core,
> +			    struct hdmi_wp_data *wp,
> +			    struct omap_dss_audio *audio,
> +			    u32 pclk);
> +
> +	/* These are of audio implementation's private use */
> +	struct snd_dmaengine_dai_dma_data dma_data;
> +	struct omap_dss_audio dss_audio;
> +	struct snd_aes_iec958 iec;
> +	struct snd_cea_861_aud_if cea;
> +	struct platform_device *codec_pdev;
> +	struct platform_device *card_pdev;
> +};

 Tomi




--o32J7124B18dJ7EPASTM4qUDo9LDXdTON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrVEqAAoJEPo9qoy8lh71/LwP/i8wEqAyCmej15rxHgDwgqyV
qPJNNqn4n3iRqGf6cyj2oIDh3cjF92rLfUziJ0A4pJVkyh81DioOHDmPHBTO3HG8
E6dh7s+JFyLfvlShbraOi/aKnFXmjMhAxXA69R5GL010+GUCZiDDwCjz5OL3pyP+
xJdIzgaucRx7G1TRYSpO+Wlm9LpADQsJMr4e8E5+i4GJIuCWTF+C/3lB8i7Jz2FX
3i3TddRsJM6IC6I1v/jN9xh47WFYgWKdl8nQe2uZSF1fo77KQvrLjN/27K4HbXhi
Fzh/we/gnVrd8cGSGJ8iXEO0pRvSe6fEuGjcPg2q9BFG1aJm0e2OL8+gH1sjsA+Y
KN1CGx14DLfIav014gXOSY0IY9V450j9i16QouVZYx1JOFiND3Ncb2DOR3b1rggo
m13qH/woq4b6YUzJRmAtET8xxkBLiYtmKg/pNJTiZn5ia3tG6DUXqtdc7d2+jrqm
YGv3ObEqMft6fg80go1Zf4pMSXRJy6n8P9iFw9W+uy/x6q4+7titC/cRpvOfkndm
5s9bE60qCJU3CjkD3cx2eCBfMTrmKHCCEHbFfg4BiJ4tUmqnLNYn/fobFJdoTWp0
y2EMUhD0QCod/TvpIgwQ/1Mwt4pOxU1U0uXNUQ9gxWzDN3wRADf4p5ancYmN3Nst
yN9/ez5vLAiuhggWsiXZ
=qz5n
-----END PGP SIGNATURE-----

--o32J7124B18dJ7EPASTM4qUDo9LDXdTON--
