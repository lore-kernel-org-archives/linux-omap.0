From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v3 04/11] ASoC: davinci-mcasp:
 Extract DMA channels directly from DT
Date: Mon, 7 Oct 2013 22:53:24 +0100
Message-ID: <20131007215323.GB2976@kartoffel>
References: <cover.1379590035.git.jsarha@ti.com>
 <dc7012e1c2ae59c35eedd9328139f1060048b395.1379590036.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <dc7012e1c2ae59c35eedd9328139f1060048b395.1379590036.git.jsarha@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "joelf@ti.com" <joelf@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 26, 2013 at 08:18:29PM +0100, Jyri Sarha wrote:
> Extract DMA channels directly from DT as they can not be found from
> platform resources anymore. This is a work-around until davinci audio
> driver is updated to use dmaengine.

How long will this conversion take?

> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../bindings/sound/davinci-mcasp-audio.txt         |    5 +++
>  include/linux/platform_data/davinci_asp.h          |    2 +
>  sound/soc/davinci/davinci-mcasp.c                  |   47 +++++++++++++-------
>  3 files changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> index 63b67ae..68e0f47 100644
> --- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> @@ -18,6 +18,11 @@ Required properties:
>  - serial-dir : A list of serializer pin mode. The list number should be equal
>  		to "num-serializer" parameter. Each entry is a number indication
>  		serializer pin direction. (0 - INACTIVE, 1 - TX, 2 - RX)
> +- dmas: two element list of DMA controller phandles and DMA request line
> +        ordered pairs.

Please describe this in terms of dma-names. That makes it clear that elements
cannot be retrieved consistently by index, and prevents duplicate descriptions.

I'd prefer for the sake of consistent terminology that these were referred to
as phandles + dma-specifiers rather than phandles and DMA request lines --
#dma-cells may be an arbitrary number of cells and encode arbitrary information
for some abstract DMA engine.

> +- dma-names: identifier string for each DMA request line in the dmas property.
> +	     These strings correspond 1:1 with the ordered pairs in dmas. The dma
> +	     identifiers must be "rx" and "tx".

For consistency and future expandability:

s/must be/should contain/

Cheers,
Mark.

>  
>  Optional properties:
>  
> diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
> index 8db5ae0..689a856 100644
> --- a/include/linux/platform_data/davinci_asp.h
> +++ b/include/linux/platform_data/davinci_asp.h
> @@ -84,6 +84,8 @@ struct snd_platform_data {
>  	u8 version;
>  	u8 txnumevt;
>  	u8 rxnumevt;
> +	int tx_dma_channel;
> +	int rx_dma_channel;
>  };
>  
>  enum {
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index a056fc5..acbf5f8 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -1047,6 +1047,7 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
>  	struct snd_platform_data *pdata = NULL;
>  	const struct of_device_id *match =
>  			of_match_device(mcasp_dt_ids, &pdev->dev);
> +	struct of_phandle_args dma_spec;
>  
>  	const u32 *of_serial_dir32;
>  	u8 *of_serial_dir;
> @@ -1109,6 +1110,28 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
>  		pdata->serial_dir = of_serial_dir;
>  	}
>  
> +	ret = of_property_match_string(np, "dma-names", "tx");
> +	if (ret < 0)
> +		goto nodata;
> +
> +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
> +					 &dma_spec);
> +	if (ret < 0)
> +		goto nodata;
> +
> +	pdata->tx_dma_channel = dma_spec.args[0];
> +
> +	ret = of_property_match_string(np, "dma-names", "rx");
> +	if (ret < 0)
> +		goto nodata;
> +
> +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
> +					 &dma_spec);
> +	if (ret < 0)
> +		goto nodata;
> +
> +	pdata->rx_dma_channel = dma_spec.args[0];
> +
>  	ret = of_property_read_u32(np, "tx-num-evt", &val);
>  	if (ret >= 0)
>  		pdata->txnumevt = val;
> @@ -1139,7 +1162,7 @@ nodata:
>  static int davinci_mcasp_probe(struct platform_device *pdev)
>  {
>  	struct davinci_pcm_dma_params *dma_data;
> -	struct resource *mem, *ioarea, *res;
> +	struct resource *mem, *ioarea, *res, *dma;
>  	struct snd_platform_data *pdata;
>  	struct davinci_audio_dev *dev;
>  	int ret;
> @@ -1213,15 +1236,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  	dma_data->sram_size = pdata->sram_size_playback;
>  	dma_data->dma_addr = dma->start + pdata->tx_dma_offset;
>  
> -	/* first TX, then RX */
>  	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "no DMA resource\n");
> -		ret = -ENODEV;
> -		goto err_release_clk;
> -	}
> -
> -	dma_data->channel = res->start;
> +	if (res)
> +		dma_data->channel = res->start;
> +	else
> +		dma_data->channel = pdata->tx_dma_channel;
>  
>  	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_CAPTURE];
>  	dma_data->asp_chan_q = pdata->asp_chan_q;
> @@ -1231,13 +1250,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  	dma_data->dma_addr = dma->start + pdata->rx_dma_offset;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> -	if (!res) {
> -		dev_err(&pdev->dev, "no DMA resource\n");
> -		ret = -ENODEV;
> -		goto err_release_clk;
> -	}
> +	if (res)
> +		dma_data->channel = res->start;
> +	else
> +		dma_data->channel = pdata->rx_dma_channel;
>  
> -	dma_data->channel = res->start;
>  	dev_set_drvdata(&pdev->dev, dev);
>  	ret = snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
>  					 &davinci_mcasp_dai[pdata->op_mode], 1);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
