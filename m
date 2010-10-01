From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v3 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 20:34:46 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE0D1@dbde02.ent.ti.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com>
 <1285936577-14881-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45138 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757244Ab0JAPE6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 11:04:58 -0400
In-Reply-To: <1285936577-14881-3-git-send-email-peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Peter Ujfalusi
> Sent: Friday, October 01, 2010 6:06 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Jarkko Nikula; Liam Girdwood
> Subject: [PATCH v3 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
> finish
> 
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
Just fyi, FIFO drain errata is not applicable for OMAP4 SDMA IP version.
Patch looks good to me.

> The same errata exists for OMAP2, where the suggestion is to disable the
> buffering to avoid this type of error.
> On OMAP3 the suggestion is to set sDMA to NoStandby before disabling
> the channel, and wait for the drain to finish, than configure sDMA to
> SmartStandby again.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/plat-omap/dma.c              |   36
> +++++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/dma.h |    3 ++
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 7115884..b298361 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -30,6 +30,7 @@
>  #include <linux/irq.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/delay.h>
> 
>  #include <asm/system.h>
>  #include <mach/hardware.h>
> @@ -1018,8 +1019,39 @@ void omap_stop_dma(int lch)
>  		dma_write(0, CICR(lch));
> 
>  	l = dma_read(CCR(lch));
> -	l &= ~OMAP_DMA_CCR_EN;
> -	dma_write(l, CCR(lch));
> +	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */
> +	if (cpu_is_omap34xx() && (l & OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
> +		int i = 0;
> +		u32 sys_cf;
> +
> +		/* Configure No-Standby */
> +		l = dma_read(OCP_SYSCONFIG);
> +		sys_cf = l;
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
> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-
> omap/include/plat/dma.h
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
