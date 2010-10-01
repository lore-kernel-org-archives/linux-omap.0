From: David Cohen <david.cohen@nokia.com>
Subject: Re: [PATCH v2 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 14:50:37 +0300
Message-ID: <20101001115037.GA12614@esdhcp036161.research.nokia.com>
References: <1285931095-21053-1-git-send-email-peter.ujfalusi@nokia.com>
 <1285931095-21053-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:55463 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932355Ab0JAMAy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 08:00:54 -0400
Content-Disposition: inline
In-Reply-To: <1285931095-21053-3-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Nishanth Menon <nm@ti.com>

Hi,

On Fri, Oct 01, 2010 at 01:04:55PM +0200, ext Peter Ujfalusi wrote:
> Implement the suggested workaround for OMAP3 regarding to sDMA draining
> issue, when the channel is disabled on the fly.
> This errata affects the following configuration:
> sDMA transfer is source synchronized
> Buffering is enabled
> SmartStandby is selected.
> 
> The issue can be easily reproduced by creating overrun situation while
> recording audio.
> Either introduce load to the CPU:
> nice -19 arecord -D hw:0 -M -B 10000 -F 5000 -f dat > /dev/null & \
> dd if=/dev/urandom of=/dev/null
> 
> or suspending the arecord, and resuming it:
> arecord -D hw:0 -M -B 10000 -F 5000 -f dat > /dev/null
> CTRL+Z; fg; CTRL+Z; fg; ...
> 
> In case of overrun audio stops DMA, and restarts it (without reseting
> the sDMA channel). When we hit this errata in stop case (sDMA drain did
> not complete), at the coming start the sDMA will not going to be
> operational (it is still draining).
> This leads to DMA stall condition.
> On OMAP3 we can recover with sDMA channel reset, it has been observed
> that by introducing unrelated sDMA activity might also help (reading
> from MMC for example).
> 
> The same errata exists for OMAP2, where the suggestion is to disable the
> buffering to avoid this type of error.
> On OMAP3 the suggestion is to set sDMA to NoStandby before disabling
> the channel, and wait for the drain to finish, than configure sDMA to
> SmartStandby again.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c              |   35 +++++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/dma.h |    3 ++
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 7115884..287a00e 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c

[snip]

> +		l = sys_cf = dma_read(OCP_SYSCONFIG);

Shouldn't it be avoided?

Regards,

David

> +		l &= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
> +		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
> +		dma_write(l , OCP_SYSCONFIG);
> +
> +		l = dma_read(CCR(lch));
> +		l &= ~OMAP_DMA_CCR_EN;
> +		dma_write(l, CCR(lch));
> +
> +		/* Wait for sDMA FIFO drain */
> +		l = dma_read(CCR(lch));
> +		while (i < 100 && (l & (OMAP_DMA_CCR_RD_ACTIVE |
> +					OMAP_DMA_CCR_WR_ACTIVE))) {
> +			udelay(5);
> +			i++;
> +			l = dma_read(CCR(lch));
> +		}
> +		if (i >= 100)
> +			printk(KERN_ERR "DMA drain did not completed on "
> +					"lch %d\n", lch);
> +		/* Restore OCP_SYSCONFIG */
> +		dma_write(sys_cf, OCP_SYSCONFIG);
> +	} else {
> +		l &= ~OMAP_DMA_CCR_EN;
> +		dma_write(l, CCR(lch));
> +	}
>  
>  	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
>  		int next_lch, cur_lch = lch;
> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
> index 776ba44..cf66f85 100644
> --- a/arch/arm/plat-omap/include/plat/dma.h
> +++ b/arch/arm/plat-omap/include/plat/dma.h
> @@ -335,6 +335,9 @@
>  #define OMAP2_DMA_MISALIGNED_ERR_IRQ	(1 << 11)
>  
>  #define OMAP_DMA_CCR_EN			(1 << 7)
> +#define OMAP_DMA_CCR_RD_ACTIVE		(1 << 9)
> +#define OMAP_DMA_CCR_WR_ACTIVE		(1 << 10)
> +#define OMAP_DMA_CCR_SEL_SRC_DST_SYNC	(1 << 24)
>  #define OMAP_DMA_CCR_BUFFERING_DISABLE	(1 << 25)
>  
>  #define OMAP_DMA_DATA_TYPE_S8		0x00
> -- 
> 1.7.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
