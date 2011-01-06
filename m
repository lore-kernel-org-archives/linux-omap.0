From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/4] ASoC: DMIC: Adding the OMAP DMIC
	driver
Date: Thu, 6 Jan 2011 22:20:52 +0000
Message-ID: <20110106222052.GC8408@opensource.wolfsonmicro.com>
References: <1294322439-16305-1-git-send-email-dlambert@ti.com>
	<1294322439-16305-2-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1294322439-16305-2-git-send-email-dlambert@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Lambert <dlambert@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 06, 2011 at 08:00:36AM -0600, David Lambert wrote:

> @@ -103,6 +106,7 @@ config SND_OMAP_SOC_SDP4430
>  	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
>  	select SND_OMAP_SOC_MCPDM
>  	select SND_SOC_TWL6040
> +	select SND_SOC_DMIC
>  	help
>  	  Say Y if you want to add support for SoC audio on Texas Instruments
>  	  SDP4430.

Any tweaks to specific machines should be done separately to adding the
new drivers.

> +	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
> +	int ctrl, div_sel = -EINVAL;
> +
> +	if (div_id != OMAP_DMIC_CLKDIV)
> +		return -ENODEV;
> +
> +	switch (dmic->clk_freq) {
> +	case 19200000:
> +		if (div == 5)
> +			div_sel = 0x1;
> +		else if (div == 8)
> +			div_sel = 0x0;

I suggested switch statements previously; you didn't comment on my
reply.

> +static irqreturn_t omap_dmic_irq_handler(int irq, void *dev_id)
> +{
> +	struct omap_dmic *dmic = dev_id;

My comments on this function appear to have been mostly ignored also.

> +	switch (rate) {
> +	case 192000:
> +		div = 5;
> +		break;
> +	default:
> +		div = 8;

Shouldn't the default case be a case 96000?

> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		break;
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		break;

Remove the empty cases, they're handled by the default.

> +
> +MODULE_AUTHOR("David Lambert <dlambert@ti.com>");
> +MODULE_DESCRIPTION("OMAP DMIC SoC Interface");
> +MODULE_LICENSE("GPL");

As also previously noted you should have a MODULE_ALIAS.
