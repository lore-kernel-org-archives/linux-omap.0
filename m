From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Allow only formats with 1, 2, and 4 byte
 physical size
Date: Tue, 3 Mar 2015 13:41:21 +0200
Message-ID: <54F59DE1.2010406@ti.com>
References: <1425382133-17120-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45978 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754491AbbCCLlg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Mar 2015 06:41:36 -0500
In-Reply-To: <1425382133-17120-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, jarkko.nikula@bitmer.com

On 03/03/2015 01:28 PM, Jyri Sarha wrote:
> sDMA support only transfer elements with 1, 2, and 4 byte physical
> size. Initialize the pcm driver accordingly.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  sound/soc/omap/omap-pcm.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index f4b05bc..e49ee23 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -39,7 +39,7 @@
>  #define pcm_omap1510()	0
>  #endif
> =20
> -static const struct snd_pcm_hardware omap_pcm_hardware =3D {
> +static struct snd_pcm_hardware omap_pcm_hardware =3D {
>  	.info			=3D SNDRV_PCM_INFO_MMAP |
>  				  SNDRV_PCM_INFO_MMAP_VALID |
>  				  SNDRV_PCM_INFO_INTERLEAVED |
> @@ -53,6 +53,24 @@ static const struct snd_pcm_hardware omap_pcm_hard=
ware =3D {
>  	.buffer_bytes_max	=3D 128 * 1024,
>  };
> =20
> +/* sDMA supports only 1, 2, and 4 byte transfer elements. */
> +static void omap_pcm_limit_supported_formats(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
> +		switch (snd_pcm_format_physical_width(i)) {
> +		case 8:
> +		case 16:
> +		case 32:
> +			omap_pcm_hardware.formats |=3D (1LL << i);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
>  /* this may get called several times by oss emulation */
>  static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
>  			      struct snd_pcm_hw_params *params)
> @@ -235,6 +253,7 @@ static struct snd_soc_platform_driver omap_soc_pl=
atform =3D {
> =20
>  int omap_pcm_platform_register(struct device *dev)
>  {
> +	omap_pcm_limit_supported_formats();
>  	return devm_snd_soc_register_platform(dev, &omap_soc_platform);
>  }
>  EXPORT_SYMBOL_GPL(omap_pcm_platform_register);
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
