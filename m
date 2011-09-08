From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: omap: convert per-board modules to
 platform drivers
Date: Thu, 08 Sep 2011 17:15:03 +0200
Message-ID: <4E68DBF7.1030009@metafoo.de>
References: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans.rullgard@linaro.org>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/08/2011 05:05 PM, Mans Rullgard wrote:
> This converts the per-board modules to platform drivers for a
> device created by in main platform setup.  These drivers call
> snd_soc_register_card() directly instead of going via a "soc-audio"
> device and the corresponding driver in soc-core.
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 5b8ca68..7cb93d9 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -299,6 +299,11 @@ static struct platform_device omap_pcm = {
>  	.id	= -1,
>  };
>  
> +static struct platform_device omap_soc_audio = {
> +	.name	= "omap-soc-audio",
> +	.id	= -1,
> +};
> +
>  /*
>   * OMAP2420 has 2 McBSP ports
>   * OMAP2430 has 5 McBSP ports
> @@ -323,6 +328,7 @@ static void omap_init_audio(void)
>  		platform_device_register(&omap_mcbsp5);
>  
>  	platform_device_register(&omap_pcm);
> +	platform_device_register(&omap_soc_audio);
>  }
>  
>  #else
> diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
> index 73dde4a..fcd18af 100644
> --- a/sound/soc/omap/am3517evm.c
> +++ b/sound/soc/omap/am3517evm.c
> @@ -151,45 +151,60 @@ static struct snd_soc_card snd_soc_am3517evm = {
>  	.num_links = 1,
>  };
>  
> [...]
> +static struct platform_driver am3517evm_driver = {
> +	.driver = {
> +		.name = "omap-soc-audio",
> +		.owner = THIS_MODULE,
> +	},
>  
> -	return ret;
> +	.probe = am3517evm_soc_probe,
> +	.remove = __devexit_p(am3517evm_soc_remove),
> +};
> +[...]
> +
> +static struct platform_driver igep2_driver = {
> +	.driver = {
> +		.name = "omap-soc-audio",
> +		.owner = THIS_MODULE,
> +	},
> +
> +	.probe = igep2_soc_probe,
> +	.remove = __devexit_p(igep2_soc_remove),
> +};
> [...]
>  
> +static struct platform_driver n810_driver = {
> +	.driver = {
> +		.name = "omap-soc-audio",
> +		.owner = THIS_MODULE,
> +	},
> +
> +	.probe = n810_soc_probe,
> +	.remove = __devexit_p(n810_soc_remove),
> +};
> [...]

This isn't really any better then using the soc-core device, since all your
drivers are still named the same. udev still wouldn't know which one to load.
Use different device driver names for different drivers.
