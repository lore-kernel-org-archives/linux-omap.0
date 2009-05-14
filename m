From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: Added OMAP3 EVM support in ASoC.
Date: Thu, 14 May 2009 08:39:27 -0700
Message-ID: <20090514153927.GI5593@atomide.com>
References: <1242289759-6577-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59718 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbZENPjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 11:39:33 -0400
Content-Disposition: inline
In-Reply-To: <1242289759-6577-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hi Mark,

One question below.

* Anuj Aggarwal <anuj.aggarwal@ti.com> [090514 01:30]:
> Resending the patch after fixing the minor issues.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  sound/soc/omap/Kconfig    |    8 +++
>  sound/soc/omap/Makefile   |    2 +
>  sound/soc/omap/omap3evm.c |  147 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 157 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/omap/omap3evm.c

<snip snip>
 
> --- /dev/null
> +++ b/sound/soc/omap/omap3evm.c

<snip snip>

> +static int __init omap3evm_soc_init(void)
> +{
> +	int ret;
> +
> +	if (!machine_is_omap3evm()) {
> +		pr_err("Not OMAP3 EVM!\n");
> +		return -ENODEV;
> +	}
> +	pr_info("OMAP3 EVM SoC init\n");
> +
> +	omap3evm_snd_device = platform_device_alloc("soc-audio", -1);
> +	if (!omap3evm_snd_device) {
> +		printk(KERN_ERR "Platform device allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(omap3evm_snd_device, &omap3evm_snd_devdata);
> +	omap3evm_snd_devdata.dev = &omap3evm_snd_device->dev;
> +	*(unsigned int *)omap3evm_dai.cpu_dai->private_data = 1;
> +
> +	ret = platform_device_add(omap3evm_snd_device);
> +	if (ret)
> +		goto err1;
> +
> +	return 0;
> +
> +err1:
> +	printk(KERN_ERR "Unable to add platform device\n");
> +	platform_device_put(omap3evm_snd_device);
> +
> +	return ret;
> +}
> +
> +static void __exit omap3evm_soc_exit(void)
> +{
> +	platform_device_unregister(omap3evm_snd_device);
> +}

Are there still some problems from ASoC point of view to
convert ASoC to do the platform_device_alloc() from
board init files?

So for omaps, the platform_device_add() sould be called from
the arch/arm/*omap*/board-*.c files.

To recap, there should not be any need to do the machine_is_xxx()
calls in the drivers. Currently if multiple boards are called,
all the xxx_soc_init() calls get unnecessarily called.

Regards,

Tony
