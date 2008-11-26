From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 11:08:55 +0000
Message-ID: <20081126110854.GA6234@sirena.org.uk>
References: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1841 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbYKZLI5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 06:08:57 -0500
Content-Disposition: inline
In-Reply-To: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Wed, Nov 26, 2008 at 06:47:58PM +0800, Stanley.Miao wrote:
> Add a shared omap SoC driver to avoid reduplicate code among omap soc drivers.

It's really good to see work on this but I've got some concerns with the
approach being taken here.

> +
> +config SND_OMAP_SOC_OVERO
> +	tristate "SoC Audio support for Gumstix Overo"
> +	depends on SND_OMAP_SOC && MACH_OVERO

This won't apply - this and several of the other machines are already
present.

> +#ifdef CONFIG_SND_OMAP_SOC_N810
> +#include "../codecs/tlv320aic3x.h"
> +#define CODEC_SYS_CLOCK		12000000
> +#define CODEC_NAME		"TLV320AIC33"
> +#define STREAM_NAME		"AIC33"
> +#define CODEC_DEV		(&soc_codec_dev_aic3x)
> +#define CODEC_DAI		(&aic3x_dai)
> +#define CODEC_SETUP_DATA	(&&n810_aic33_setup)
> +#define DAI_LINK_INIT		(n810_aic33_init)
> +#define SOC_OPS_STARTUP		(n810_startup)
> +#define SOC_OPS_SHUTDOWN	(n810_shutdown)

Please change this to use a platform data based approach rather than
these ifdefs: it's not a good approach for readability and it prevents
building multiple board drivers in one kernel which isn't good for
distributions.  The s3c24xx_uda134x.c provides an example of how this
can be done.  It may be more sensible to have a separate driver per
codec.
