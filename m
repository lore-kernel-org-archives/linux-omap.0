From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/12] OMAPDSS: hdmi4: Register HDMI audio ASoC drivers
 from HDMI driver
Date: Fri, 27 Jun 2014 14:39:37 +0300
Message-ID: <53AD57F9.3030300@ti.com>
References: <cover.1403807781.git.jsarha@ti.com> <f61b31d0b08c8a0b6ee295d5b0da62ead23983c9.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="TPsEj1PjE6qxVk8nnWc7L2b22Bb92R5TR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44142 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874AbaF0LkA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 07:40:00 -0400
In-Reply-To: <f61b31d0b08c8a0b6ee295d5b0da62ead23983c9.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

--TPsEj1PjE6qxVk8nnWc7L2b22Bb92R5TR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/06/14 22:20, Jyri Sarha wrote:
> Add audio datamember to hdmi struct and call register and unregister
> functions form hdmi_audio.c. Register function registers the
> integrated cpu dai, dummy HDMI codec, and simple-card machine driver
> for complete HDMI audio support.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/hdmi4.c |   45 +++++++++++++++++++++++++=
++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbde=
v/omap2/dss/hdmi4.c
> index 342ddb4..48f11f8 100644
> --- a/drivers/video/fbdev/omap2/dss/hdmi4.c
> +++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
> @@ -34,6 +34,11 @@
>  #include <linux/regulator/consumer.h>
>  #include <video/omapdss.h>
> =20
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)

No need for the ifdef here either.

> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +#endif
> +
>  #include "hdmi4_core.h"
>  #include "dss.h"
>  #include "dss_features.h"
> @@ -52,6 +57,9 @@ static struct {
>  	struct clk *sys_clk;
>  	struct regulator *vdda_hdmi_dac_reg;
> =20
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
> +	struct hdmi_audio_data audio;
> +#endif
>  	bool core_enabled;
> =20
>  	struct omap_dss_device output;
> @@ -671,6 +679,21 @@ err:
>  	return r;
>  }
> =20
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
> +static struct snd_soc_dai_driver omap_hdmi_dai =3D {
> +	.name =3D "omap4-hdmi-dai",
> +	.playback =3D {
> +		.channels_min =3D 2,
> +		.channels_max =3D 8,
> +		.rates =3D (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
> +			  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
> +			  SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
> +			  SNDRV_PCM_RATE_192000),
> +		.formats =3D SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
> +	},
> +};
> +#endif
> +
>  /* HDMI HW IP initialisation */
>  static int omapdss_hdmihw_probe(struct platform_device *pdev)
>  {
> @@ -727,6 +750,25 @@ static int omapdss_hdmihw_probe(struct platform_de=
vice *pdev)
> =20
>  	hdmi_init_output(pdev);
> =20
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
> +	/* drvdata is only used by HDMI audio */
> +	hdmi.audio.hdmi_lock =3D &hdmi.lock;
> +	hdmi.audio.wp =3D &hdmi.wp;
> +	hdmi.audio.core =3D &hdmi.core;
> +	hdmi.audio.cfg =3D &hdmi.cfg;
> +	hdmi.audio.hdmi_dai_drv =3D &omap_hdmi_dai;
> +	hdmi.audio.audio_start =3D hdmi4_audio_start;
> +	hdmi.audio.audio_stop =3D hdmi4_audio_stop;
> +	hdmi.audio.audio_config =3D hdmi4_audio_config;
> +	dev_set_drvdata(&pdev->dev, &hdmi.audio);
> +	r =3D hdmi_audio_register(pdev);
> +	if (r) {
> +		DSSERR("Registering HDMI audio failed\n");
> +		hdmi_uninit_output(pdev);
> +		pm_runtime_disable(&pdev->dev);
> +		return r;
> +	}
> +#endif

I don't think it's a good idea to reserve the driver data for audio. We
need to change the hdmi drivers sooner or later to support multiple
instances, and at that point having drvdata for audio will cause problems=
=2E

If you don't want to make the hdmi struct public yet, maybe just add a
function to this file which takes a pointer to the hdmi struct and
returns the audio part. That way you can set the whole hdmi struct as
driver data, which should be future safe.

 Tomi



--TPsEj1PjE6qxVk8nnWc7L2b22Bb92R5TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrVf+AAoJEPo9qoy8lh71iZIP/2qyB+dSIgED/cDSZold9OgR
fWpVOVi7yJ0Ja5a0tiKBE2KY99HCkERDkKJvbQtEhDXpKbcQ9iGpLT6zrB0uOlWL
sZKGKx/Mchv01oKTSvb2S3KrLSz3cxbwTTT6zG1eUCs1IQm+EdizBCNyVhxWuy87
uewvBoe6wOol9Pnrpfewt13DiurKHcnqDQGGjija0j1c/prgVGKUwQtWHa/P5Nbh
wXhmZAXORQTWqnJiq/OwJsNHxbVGYWASlD3azse8MXEOvaFbY0dAf9Kcshmo6hRb
l3jlAdeV7Z2fveCEBlOJEl/gVvCRxR6v67Z0L+X/iLyj1WZKMYOJlkHfvh41/vd4
KnIjPZ6gYWce0KCQyRxh/pWs+IiVYFet9us8QKTzqkBFSSbLk3irQS2B2NdSgonO
8v76gEusJBJR2SY7dBuPvLNg6WPU2NX8mOqWdv2IgCljhW22fl5ABQPpNSyCMBHs
QddWSsKslcFEyizwjfMDMk0D4c5DtVWvFQv3POxrpgrSu7wbId8lx/fIIWne8FpW
PO5iHGMp2UIhV1Iy+z/RtC/ZdeMWmNCM6nB+Wf+wPvEG3cDiWCMAeJ85EwRzK1U9
CWgfEJj39twfGBg2dN1vb4S2vSVIZfMEIj++7kQ5B0osjZ+KM5YAfv/wATG93hjC
hTgM43URNT5sSVNukEq9
=T0rQ
-----END PGP SIGNATURE-----

--TPsEj1PjE6qxVk8nnWc7L2b22Bb92R5TR--
