From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 6/6] dmaengine: omap-dma: Support for LinkedList
 transfer of slave_sg
Date: Mon, 8 Aug 2016 11:12:26 +0530
Message-ID: <20160808054226.GR9681@localhost>
References: <20160720085032.2955-1-peter.ujfalusi@ti.com>
 <20160720085032.2955-7-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160720085032.2955-7-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 20, 2016 at 11:50:32AM +0300, Peter Ujfalusi wrote:
> sDMA in OMAP3630 or newer SoC have support for LinkedList transfer. When
> LinkedList or Descriptor load feature is present we can create the
> descriptors for each and program sDMA to walk through the list of
> descriptors instead of the current way of sDMA stop, sDMA reconfiguration
> and sDMA start after each SG transfer.
> By using LinkedList transfer in sDMA the number of DMA interrupts will
> decrease dramatically.
> Booting up the board with filesystem on SD card for example:
> W/o LinkedList support:
>  27:       4436          0     WUGEN  13 Level     omap-dma-engine
> 
> Same board/filesystem with this patch:
>  27:       1027          0     WUGEN  13 Level     omap-dma-engine
> 
> Or copying files from SD card to eMCC:
> 2.1G    /usr/
> 232001
> 
> W/o LinkedList we see ~761069 DMA interrupts.
> With LinkedList support it is down to ~269314 DMA interrupts.
> 
> With the decreased DMA interrupt number the CPU load is dropping
> significantly as well.

Interesting, I would have counted the throughput of DMA by using time for
transfer and not really interrupts and CPU load. With LL mode, you get a
big performance boost due to starting next transaction by hardware without
waiting for CPU intervention and yes side effect is lesser interrupts and
load :)

> @@ -743,6 +863,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>  	struct omap_desc *d;
>  	dma_addr_t dev_addr;
>  	unsigned i, es, en, frame_bytes;
> +	bool ll_failed = false;
>  	u32 burst;
>  
>  	if (dir == DMA_DEV_TO_MEM) {
> @@ -818,16 +939,47 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>  	 */
>  	en = burst;
>  	frame_bytes = es_bytes[es] * en;
> +
> +	if (sglen >= 2)
> +		d->using_ll = od->ll123_supported;

No upperbound on length? Does the hardware support any lengths?



-- 
~Vinod
