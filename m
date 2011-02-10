From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v2] OMAP: PM: DMA: Enable runtime pm
Date: Fri, 11 Feb 2011 00:18:52 +0530
Message-ID: <20110210184809.GA2196@manju-desktop>
References: <1297082286-8449-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:55516 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750917Ab1BJStS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 13:49:18 -0500
Received: by mail-iy0-f170.google.com with SMTP id 14so2086074iym.15
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 10:49:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297082286-8449-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com

Kevin,
Do you have any comments on these changes. I am planning to have these changes
as part of new dma series(runtime support+mstandby mode api changes+removing
redundant code). I am in the process of testing all the above changes on all 
the omap boards.

-Manjunath

On Mon, Feb 07, 2011 at 06:08:06PM +0530, G, Manjunath Kondaiah wrote:
> From: Manjunath G Kondaiah <manjugk@ti.com>
> 
> Enable runtime pm and use pm_runtime_get_sync and pm_runtime_put_autosuspend
> for OMAP DMA driver.
> 
> The DMA driver uses auto suspend feature of runtime pm framework through
> which the clock gets disabled automatically if there is no activity for
> more than one second.
> 
> Testing:
> Compile: omap1_defconfig and omap2plus_defconfig
> Boot: OMAP1710(H3), OMAP2420(H4), OMAP3630(Zoom3), OMAP4(Blaze)
> 
> On zoom3 core retention is tested with following steps:
> echo 1 > /debug/pm_debug/sleep_while_idle
> echo 1 > /debug/pm_debug/enable_off_mode
> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
> 
> It is observed that(on pm branch), core retention count gets increasing if the
> board is left idle for more than 5 seconds. However, it doesnot enter off mode
> (even without DMA runtime changes).
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  arch/arm/plat-omap/dma.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 2ec3b5d..6bfe25c 100644
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
> @@ -59,6 +60,7 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
>  
>  static struct omap_system_dma_plat_info *p;
>  static struct omap_dma_dev_attr *d;
> +static struct device *dev;
>  
>  static int enable_1510_mode;
>  static u32 errata;
> @@ -676,6 +678,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	unsigned long flags;
>  	struct omap_dma_lch *chan;
>  
> +	pm_runtime_get_sync(dev);
>  	spin_lock_irqsave(&dma_chan_lock, flags);
>  	for (ch = 0; ch < dma_chan_count; ch++) {
>  		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
> @@ -686,6 +689,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	}
>  	if (free_ch == -1) {
>  		spin_unlock_irqrestore(&dma_chan_lock, flags);
> +		pm_runtime_put_autosuspend(dev);
>  		return -EBUSY;
>  	}
>  	chan = dma_chan + free_ch;
> @@ -743,6 +747,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  	}
>  
>  	*dma_ch_out = free_ch;
> +	pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  }
> @@ -871,6 +876,8 @@ void omap_start_dma(int lch)
>  {
>  	u32 l;
>  
> +	pm_runtime_get_sync(dev);
> +
>  	/*
>  	 * The CPC/CDAC register needs to be initialized to zero
>  	 * before starting dma transfer.
> @@ -1805,6 +1812,8 @@ static int omap1_dma_handle_ch(int ch)
>  	if (likely(dma_chan[ch].callback != NULL))
>  		dma_chan[ch].callback(ch, csr, dma_chan[ch].data);
>  
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	return 1;
>  }
>  
> @@ -1899,6 +1908,8 @@ static int omap2_dma_handle_ch(int ch)
>  	if (likely(dma_chan[ch].callback != NULL))
>  		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
>  
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	return 0;
>  }
>  
> @@ -1978,6 +1989,7 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	dev			= &pdev->dev;
>  	d			= p->dma_attr;
>  	errata			= p->errata;
>  
> @@ -1999,6 +2011,11 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
>  	spin_lock_init(&dma_chan_lock);
>  	for (ch = 0; ch < dma_chan_count; ch++) {
>  		omap_clear_dma(ch);
> @@ -2064,6 +2081,16 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
>  		dma_chan[1].dev_id = 1;
>  	}
>  	p->show_dma_caps();
> +
> +	/*
> +	 * Note: If dma channels are reserved through boot paramters,
> +	 * then dma device is always enabled.
> +	 */
> +	if (omap_dma_reserve_channels)
> +		pm_runtime_get(dev);
> +
> +	pm_runtime_put_autosuspend(dev);
> +
>  	return 0;
>  
>  exit_dma_irq_fail:
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
