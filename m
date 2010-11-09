From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 13/13] OMAP: PM: DMA: Enable runtime pm
Date: Tue, 09 Nov 2010 14:48:25 -0800
Message-ID: <87fwvajepy.fsf@deeprootsystems.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-14-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43657 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488Ab0KIWs2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Nov 2010 17:48:28 -0500
Received: by pva4 with SMTP id 4so403164pva.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 14:48:28 -0800 (PST)
In-Reply-To: <1288099513-1854-14-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 26 Oct 2010 18:55:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Enable runtime pm and use pm_runtime_get and pm_runtime_put
> for OMAP DMA driver.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/dma.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 41b14b0..feac7ee 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -35,6 +35,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <asm/system.h>
>  #include <mach/hardware.h>
> @@ -367,6 +368,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	chan = dma_chan + free_ch;
>  	chan->dev_id = dev_id;
>  
> +	pm_runtime_get(&pd->dev);

The _get() call is asynchronous.  So if the device was actually
idled/disabled, immediately after this call it may still be
idle/disabled.   When using the asynchronous versions of the API, the
device should not be touched until the driver's ->runtime_resume()
callback is called.

>  	if (d->dev_caps & IS_WORD_16)
>  		p->clear_lch_regs(free_ch);
>  	else
> @@ -452,6 +455,7 @@ void omap_free_dma(int lch)
>  		omap_clear_dma(lch);
>  		p->clear_dma_sglist_mode(lch);
>  	}
> +	pm_runtime_put(&pd->dev);
>  	spin_lock_irqsave(&dma_chan_lock, flags);
>  	dma_chan[lch].dev_id = -1;
>  	dma_chan[lch].next_lch = -1;
> @@ -819,6 +823,11 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
>  	dma_chan_count		= d->chan_count;
>  	dma_chan		= d->chan;
>  
> +	/* Enable run time PM */

comment is redundant

> +	pm_runtime_enable(&pd->dev);
> +
> +	/* Accessing hw registers, get clock */

comment is wrong, driver doesn't know anything about clocks.
Just drop comment as it doesn't tell you anything that the following
'get' doesn't.

> +	pm_runtime_get(&pd->dev);

see above Re: async calls.

>  	for (ch = 0; ch < dma_chan_count; ch++) {
>  		unsigned long flags;
>  		omap_clear_dma(ch);
> @@ -846,6 +855,10 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
>  		dma_chan[0].dev_id = 0;
>  		dma_chan[1].dev_id = 1;
>  	}
> +
> +	if (!omap_dma_reserve_channels)
> +		pm_runtime_put(&pd->dev);
> +

So if the reserve channels feature is used, PM is essentially disabled
for sDMA.  You should add a warning here to that effect as well.


>  	return 0;
>  
>  exit_release_region:

Kevin
