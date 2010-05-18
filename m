From: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Subject: Re: [PATCH 3/4] ASoC: mcbsp - add machine
	threshold	callback
Date: Tue, 18 May 2010 15:56:46 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B9145EC6A@dlee01.ent.ti.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-4-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1274213594-26554-4-git-send-email-lrg@slimlogic.co.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: linux-omap@vger.kernel.org

alsa-devel-bounces@alsa-project.org wrote:
> Add a mechanism to register a machine specific callback
> to calculate and set the McBSP Tx/Rx threshold.
> 
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  sound/soc/omap/omap-mcbsp.c |   22 +++++++++++++++++++++-
>  sound/soc/omap/omap-mcbsp.h |    2 ++
>  2 files changed, 23 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c
> b/sound/soc/omap/omap-mcbsp.c index 6f44cb4..9a1583d 100644 ---
> a/sound/soc/omap/omap-mcbsp.c +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -51,6 +51,9 @@ struct omap_mcbsp_data {
>  	unsigned int			bus_id;
>  	struct omap_mcbsp_reg_cfg	regs;
>  	unsigned int			fmt;
> +
> +	/* optional machine set_threshold() sample value */
> +	void (*mach_set_threshold)(struct snd_pcm_substream *substream); 
>  	 /* * Flags indicating is the bus already activated and
> configured by
>  	 * another substream
> @@ -306,7 +309,11 @@ static int
> omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>  	} else if (cpu_is_omap343x()) {
>  		dma = omap24xx_dma_reqs[bus_id][substream->stream];
>  		port = omap34xx_mcbsp_port[bus_id][substream->stream]; -
> omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
> +		if (mcbsp_data->mach_set_threshold)
> +
> omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold = +
> mcbsp_data->mach_set_threshold;
> +		else
> +
> omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
> 
> omap_mcbsp_set_threshold;
>  		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
>  		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
> @@ -835,6 +842,19 @@ int omap_mcbsp_st_add_controls(struct
> snd_soc_codec *codec, int mcbsp_id)
>  }
>  EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
> 
> +int omap_bcbsp_set_threshold_func(struct snd_soc_dai *cpu_dai,
> +		void (*mach_set_threshold)(struct
> snd_pcm_substream *substream))

I think you meant omap_mcbsp_set_threshold_func here.

> +{
> +	struct omap_mcbsp_data *mcbsp_data =
> to_mcbsp(cpu_dai->private_data);
> +
> +	if (!cpu_is_omap34xx())
> +		return -ENODEV;
> +
> +	mcbsp_data->mach_set_threshold = mach_set_threshold; +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(omap_bcbsp_set_threshold_func);
> +
>  static int __init snd_omap_mcbsp_init(void)
>  {
>  	return snd_soc_register_dais(omap_mcbsp_dai,
> diff --git a/sound/soc/omap/omap-mcbsp.h
> b/sound/soc/omap/omap-mcbsp.h index 6c363e5..f8d8044 100644 ---
> a/sound/soc/omap/omap-mcbsp.h +++ b/sound/soc/omap/omap-mcbsp.h
> @@ -58,5 +58,7 @@ enum omap_mcbsp_div {
>  extern struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS];
> 
>  int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec,
> int mcbsp_id);
> +int omap_bcbsp_set_threshold_func(struct snd_soc_dai *cpu_dai,
> +		void (*mach_set_threshold)(struct
> snd_pcm_substream *substream));

Also here.

> 
>  #endif
