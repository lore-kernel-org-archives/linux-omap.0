From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v3 03/11] ASoC: davinci-mcasp: Add
 DMA register locations to DT
Date: Mon, 7 Oct 2013 22:47:18 +0100
Message-ID: <20131007214718.GA2976@kartoffel>
References: <cover.1379590035.git.jsarha@ti.com>
 <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379590036.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379590036.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jsarha@ti.com
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "joelf@ti.com" <joelf@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Darren Etheridge <detheridge@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Thu, Sep 26, 2013 at 08:18:28PM +0100, Jyri Sarha wrote:
> This patch adds DMA register location to mcasp DT bindings. On am33xx
> SoCs the McASP registers are mapped trough L4 interconnect, which is
> not accessible by the DMA controller, so McASP data port is mapped
> trough L3 to a different location.
> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../bindings/sound/davinci-mcasp-audio.txt         |    8 ++-
>  sound/soc/davinci/davinci-mcasp.c                  |   59 +++++++++++++-------
>  2 files changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> index 374e145..63b67ae 100644
> --- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> @@ -6,7 +6,11 @@ Required properties:
>  	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
>  	"ti,omap2-mcasp-audio"	: for OMAP2 platforms (TI81xx, AM33xx)
>  
> -- reg : Should contain McASP registers offset and length
> +- reg : Should contain McASP registers address and length for mpu and
> +	optionally for dma controller access.
> +- reg-names : The mandatory reg-range must be named "mpu" and the optional DMA
> +	      reg-range must be named "dma". For backward compatibility it is
> +	      good to keep "mpu" first in the list.

I've never heard the term "reg-range" before. The should probably be something
like "reg entry". How about something like the following instead:

- reg: Should contain reg specifiers for the entries in the reg-names property.

- reg-names: Should contain:
	     * "mpu" for the main registers (required). For compatibility with
	       existing software, it is recommended this is the first entry.
	     * "dma" for the DMA registers (optional).

That way we don't end up describing each reg entry twice.

I have some questions however. I took a look at the McASP (TMS320C6000)
reference guide, and the registers appeared to all be in one contiguous bank,
and "mpu" and "dma" don't appear to be names of particular registers or names
of banks of particular registers. Am I looking in the wrong place? Is there
up-to-date documentation I can look at?

Why are these split across two reg entries, and which particular registers do
they actually cover?

I have some concern about the description of other properties too. If we're
going to amend the binding, they should be fixed up too.

>  - interrupts : Interrupt number for McASP

The device also seems to be able to generate multiple interrupts -- which
interrupt does this actually cover?

The driver doesn't seem to use it (by a grep of irq|interrupt). Have I missed
something?

>  - op-mode : I2S/DIT ops mode.

What type is this?

What are valid values?

>  - tdm-slots : Slots for TDM operation.

Here too. This description is completely opaque.

Taking a look at the version in kernel sources this appears to be a list of
values, in groups of four?

What is the format of this property?

> @@ -15,7 +19,6 @@ Required properties:
>  		to "num-serializer" parameter. Each entry is a number indication
>  		serializer pin direction. (0 - INACTIVE, 1 - TX, 2 - RX)
>  
> -
>  Optional properties:
>  
>  - ti,hwmods : Must be "mcasp<n>", n is controller instance starting 0
> @@ -31,6 +34,7 @@ mcasp0: mcasp0@1d00000 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;

Why does this have #address-cells and #size-cells? There are no children in the
example.

>  	reg = <0x100000 0x3000>;
> +	reg-names "mpu";
>  	interrupts = <82 83>;
>  	op-mode = <0>;		/* MCASP_IIS_MODE */
>  	tdm-slots = <2>;

A few questions from a brief skim of the documentation:

There seem to be external clocks (AHCLKR and ACLKR), but they aren't described.
Are we always able to use an internal clock instead? Is no external reference
clock needed?

The err_release_clk label in the error path confuses me -- which clock(s) does
the preceding pm_runtime_get ensure remains active? One internal to the McASP?

It looks like some pins can be used as GPIO -- is there not a need for something
like pinctrl for configuring this?

Cheers,
Mark.

> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 32ddb7f..a056fc5 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -1001,18 +1001,40 @@ static const struct snd_soc_component_driver davinci_mcasp_component = {
>  	.name		= "davinci-mcasp",
>  };
>  
> +/* Some HW specific values and defaults. The rest is filled in from DT. */
> +static struct snd_platform_data dm646x_mcasp_pdata = {
> +	.tx_dma_offset = 0x400,
> +	.rx_dma_offset = 0x400,
> +	.asp_chan_q = EVENTQ_0,
> +	.version = MCASP_VERSION_1,
> +};
> +
> +static struct snd_platform_data da830_mcasp_pdata = {
> +	.tx_dma_offset = 0x2000,
> +	.rx_dma_offset = 0x2000,
> +	.asp_chan_q = EVENTQ_0,
> +	.version = MCASP_VERSION_2,
> +};
> +
> +static struct snd_platform_data omap2_mcasp_pdata = {
> +	.tx_dma_offset = 0,
> +	.rx_dma_offset = 0,
> +	.asp_chan_q = EVENTQ_0,
> +	.version = MCASP_VERSION_3,
> +};
> +
>  static const struct of_device_id mcasp_dt_ids[] = {
>  	{
>  		.compatible = "ti,dm646x-mcasp-audio",
> -		.data = (void *)MCASP_VERSION_1,
> +		.data = &dm646x_mcasp_pdata,
>  	},
>  	{
>  		.compatible = "ti,da830-mcasp-audio",
> -		.data = (void *)MCASP_VERSION_2,
> +		.data = &da830_mcasp_pdata,
>  	},
>  	{
>  		.compatible = "ti,omap2-mcasp-audio",
> -		.data = (void *)MCASP_VERSION_3,
> +		.data = &omap2_mcasp_pdata,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1035,20 +1057,13 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
>  		pdata = pdev->dev.platform_data;
>  		return pdata;
>  	} else if (match) {
> -		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> -		if (!pdata) {
> -			ret = -ENOMEM;
> -			goto nodata;
> -		}
> +		pdata = (struct snd_platform_data *) match->data;
>  	} else {
>  		/* control shouldn't reach here. something is wrong */
>  		ret = -EINVAL;
>  		goto nodata;
>  	}
>  
> -	if (match->data)
> -		pdata->version = (u8)((int)match->data);
> -
>  	ret = of_property_read_u32(np, "op-mode", &val);
>  	if (ret >= 0)
>  		pdata->op_mode = val;
> @@ -1145,10 +1160,15 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
>  	if (!mem) {
> -		dev_err(&pdev->dev, "no mem resource?\n");
> -		return -ENODEV;
> +		dev_warn(dev->dev,
> +			 "\"mpu\" mem resource not found, using index 0\n");
> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!mem) {
> +			dev_err(&pdev->dev, "no mem resource?\n");
> +			return -ENODEV;
> +		}
>  	}
>  
>  	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
> @@ -1182,13 +1202,16 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  	dev->rxnumevt = pdata->rxnumevt;
>  	dev->dev = &pdev->dev;
>  
> +	dma = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
> +	if (!dma)
> +		dma = mem;
> +
>  	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
>  	dma_data->asp_chan_q = pdata->asp_chan_q;
>  	dma_data->ram_chan_q = pdata->ram_chan_q;
>  	dma_data->sram_pool = pdata->sram_pool;
>  	dma_data->sram_size = pdata->sram_size_playback;
> -	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
> -							mem->start);
> +	dma_data->dma_addr = dma->start + pdata->tx_dma_offset;
>  
>  	/* first TX, then RX */
>  	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> @@ -1205,8 +1228,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  	dma_data->ram_chan_q = pdata->ram_chan_q;
>  	dma_data->sram_pool = pdata->sram_pool;
>  	dma_data->sram_size = pdata->sram_size_capture;
> -	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
> -							mem->start);
> +	dma_data->dma_addr = dma->start + pdata->rx_dma_offset;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>  	if (!res) {
> @@ -1266,4 +1288,3 @@ module_platform_driver(davinci_mcasp_driver);
>  MODULE_AUTHOR("Steve Chen");
>  MODULE_DESCRIPTION("TI DAVINCI McASP SoC Interface");
>  MODULE_LICENSE("GPL");
> -
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
