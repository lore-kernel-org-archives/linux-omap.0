From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Choose PCM driver based on configured
 DMA controller
Date: Tue, 2 Jun 2015 13:31:28 +0300
Message-ID: <556D8600.1060204@ti.com>
References: <bcd986aa18bf41643f1d190739381a890313ac61.1433235274.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56580 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbbFBKbp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 06:31:45 -0400
In-Reply-To: <bcd986aa18bf41643f1d190739381a890313ac61.1433235274.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, misael.lopez@ti.com

On 06/02/2015 11:58 AM, Jyri Sarha wrote:
> Find the configured DMA controller by asking for a DMA channel in the
> probe phase and releasing it right after. The controller device can b=
e
> found via the dma_chan struct and the controller is recognized from
> the compatible property of its device node. The patch assumes EDMA if
> there is no device node.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 61 +++++++++++++++++++++++++++++=
+++-------
>  1 file changed, 51 insertions(+), 10 deletions(-)
>=20
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/da=
vinci-mcasp.c
> index d793494..5bc2712 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -1565,6 +1565,46 @@ static int davinci_mcasp_init_ch_constraints(s=
truct davinci_mcasp *mcasp)
>  	return ret;
>  }
> =20
> +enum {
> +	MCASP_EDMA =3D 1,

Why start from 1?
I'm not sure about the name. It somehow implies that McASP has somethin=
g to do
with the dma engine.
MCASP_SERVICED_BY_E/SDMA
PLATFORM_USES_E/SDMA

I can not come up with a decent name :(


> +	MCASP_SDMA,
> +};
> +static const char *sdma_prefix =3D "ti,omap";
> +
> +static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
> +{
> +	struct dma_chan *chan;
> +	const char *tmp;
> +	int ret =3D MCASP_EDMA;
> +
> +	tmp =3D mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data;
> +	chan =3D dma_request_slave_channel_reason(mcasp->dev, tmp);

this will return with error in case of !dev->of_node.
The first check should be:
if (!mcasp->dev->of_node)
	return MCASP_EDMA;

since we can only boot in legacy mode with daVinci devices and they are=
 using
eDMA.

> +	if (IS_ERR(chan)) {
> +		if (PTR_ERR(chan) !=3D -EPROBE_DEFER)
> +			dev_err(mcasp->dev,
> +				"Can't verify DMA configuration (%ld)\n",
> +				PTR_ERR(chan));
> +		return PTR_ERR(chan);
> +	}
> +	BUG_ON(!chan->device || !chan->device->dev);
> +
> +	if (chan->device->dev->of_node)
> +		ret =3D of_property_read_string(chan->device->dev->of_node,
> +					      "compatible", &tmp);
> +	else
> +		dev_dbg(mcasp->dev, "DMA controller has no of-node\n");

Now this is not likely to happen...

> +
> +	dma_release_channel(chan);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(mcasp->dev, "DMA controller compatible =3D \"%s\"\n", tmp);
> +	if (!strncmp(tmp, sdma_prefix, strlen(sdma_prefix)))
> +		return MCASP_SDMA;
> +
> +	return MCASP_EDMA;
> +}
> +
>  static int davinci_mcasp_probe(struct platform_device *pdev)
>  {
>  	struct snd_dmaengine_dai_dma_data *dma_data;
> @@ -1763,27 +1803,28 @@ static int davinci_mcasp_probe(struct platfor=
m_device *pdev)
>  	if (ret !=3D 0)
>  		goto err;
> =20
> -	switch (mcasp->version) {
> +	ret =3D -EINVAL;

Why? What was the problem with setting the ret in the default case?

> +	switch (davinci_mcasp_get_dma_type(mcasp)) {
> +	case MCASP_EDMA:
>  #if IS_BUILTIN(CONFIG_SND_EDMA_SOC) || \
>  	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
>  	 IS_MODULE(CONFIG_SND_EDMA_SOC))
> -	case MCASP_VERSION_1:
> -	case MCASP_VERSION_2:
> -	case MCASP_VERSION_3:
>  		ret =3D edma_pcm_platform_register(&pdev->dev);
> -		break;
> +#else
> +		dev_err(&pdev->dev, "Missing SND_EDMA_SOC\n");
>  #endif
> +		break;
> +	case MCASP_SDMA:
>  #if IS_BUILTIN(CONFIG_SND_OMAP_SOC) || \
>  	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
>  	 IS_MODULE(CONFIG_SND_OMAP_SOC))
> -	case MCASP_VERSION_4:
>  		ret =3D omap_pcm_platform_register(&pdev->dev);
> -		break;
> +#else
> +		dev_err(&pdev->dev, "Missing SND_SDMA_SOC\n");
>  #endif
> +		break;
>  	default:
> -		dev_err(&pdev->dev, "Invalid McASP version: %d\n",
> -			mcasp->version);
> -		ret =3D -EINVAL;
> +		dev_err(&pdev->dev, "No DMA controller found\n");
>  		break;
>  	}
> =20
>=20


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
