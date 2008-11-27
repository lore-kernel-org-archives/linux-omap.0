From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel][PATCHv2 1/1] OMAP_TWL4030 SoC Audio driver.
Date: Thu, 27 Nov 2008 13:19:26 +0000
Message-ID: <20081127131923.GC3933@sirena.org.uk>
References: <1227790257-14221-1-git-send-email-stanley.miao@windriver.com> <1227790257-14221-2-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2185 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbYK0NTb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 08:19:31 -0500
Content-Disposition: inline
In-Reply-To: <1227790257-14221-2-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Thu, Nov 27, 2008 at 08:50:57PM +0800, Stanley.Miao wrote:

> Add a shared omap_twl4030 driver to avoid reduplicate code among omap drivers.
> This drive also provides a extended interface for some board specific features.

As discussed in the thread following your initial submission it'd be
better to do something like having flags specifying which outputs are
connected up rather than just leaving all that stuff to per-board code.
At the minute all that's being shared is a bit of boiler plate (which
will get smaller) and the hw_params function at the source code level.

As I said in response to your original posting I'd strongly urge you to
look at the s3c24xx_uda134x driver for an example of how something like
this can be implemented.

Some more specific comments below...

> +config SND_OMAP_TWL4030_SPECIFIC
> +	bool
> +	default n
> +

This really needs some documentation.  I think a better name should be
possible too but see my comments below for the header...

> +config SND_OMAP_SOC_OMAP3EVM
> +	tristate "SoC Audio support for OMAP3EVM"
> +	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3EVM
> +	select SND_OMAP_SOC_MCBSP
> +	select SND_SOC_TWL4030
> +	help
> +	  Say Y if you want to add support for SoC audio on the omap3evm board.
> +config SND_OMAP_SOC_3430SDP
> +	tristate "SoC Audio support for OMAP 3430SDP"

You need a blank line between multiple Kconfig entries.

> index 29cf3a8..66785cb 100644
> --- a/sound/soc/omap/Makefile
> +++ b/sound/soc/omap/Makefile
> @@ -7,13 +7,19 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
>  
>  # OMAP Machine Support
>  snd-soc-n810-objs := n810.o
> +snd-soc-omap3beagle-objs := omap_twl4030.o
>  snd-soc-osk5912-objs := osk5912.o
> -snd-soc-overo-objs := overo.o
> -snd-soc-omap2evm-objs := omap2evm.o
> -snd-soc-sdp3430-objs := sdp3430.o

If you're trying to replace the existing drivers you need to remove
them.  It might be better to split this into multiple patches,
separating out the removal of the existing drivers from the addition of
the new framework - at the minute there's no removal, though.

> +snd-soc-overo-objs := omap_twl4030.o
> +snd-soc-3430sdp-objs := omap_twl4030.o
> +snd-soc-ldp-objs := omap_twl4030.o
> +snd-soc-omap2evm-objs := omap_twl4030.o
> +snd-soc-omap3evm-objs := omap_twl4030.o

Why are you building multiple copies of the driver?

> --- /dev/null
> +++ b/sound/soc/omap/omap_twl4030.c

The name should probably indicate that this is a generic driver.

> +       printk(KERN_INFO "OMAP_TWL4030 SoC audio driver init\n");
> +
> +       omap_twl4030_specific_init(&omap_twl4030_snd_devdata);

While this is better than the previous ifdef scheme it's still not doing
this as a platform device

> +	}
> +
> +	platform_set_drvdata(omap_twl4030_snd_device, &omap_twl4030_snd_devdata);
> +	omap_twl4030_snd_devdata.dev = &omap_twl4030_snd_device->dev;
> +	if(omap_twl4030_data)

Please check patches with scripts/checkpatch.pl before submitting.

> +#ifndef __OMAP_TWL4030_H__
> +#define __OMAP_TWL4030_H__
> +
> +struct omap_twl4030_platform_data {
> +	int (*board_init)(struct platform_device *);
> +	void (*board_exit)(void);
> +	void *data;
> +};

What is this data value for?  I'd have expected to see it being passed
into the callbacks...

> +#ifdef CONFIG_SND_OMAP_TWL4030_SPECIFIC
> +extern void omap_twl4030_specific_init(struct snd_soc_device *);
> +#else
> +static inline void omap_twl4030_specific_init(struct snd_soc_device *snd_dev)
> +{
> +	if(snd_dev == NULL)
> +		return;
> +	/* McBSP2 */
> +	*(unsigned int *)snd_dev->machine->dai_link->cpu_dai->private_data = 1;
> +	omap_twl4030_data = NULL;
> +}
> +#endif

This still has the previous problem with your use of ifdefs: it means
that it's not possible to build the driver for configurations that both
do and don't need this.
