From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/13] dmaengine: edma: Optimize memcpy operation
Date: Wed, 14 Oct 2015 20:11:05 +0530
Message-ID: <20151014144105.GV27370@localhost>
References: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
 <1444828344-21378-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444828344-21378-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 14, 2015 at 04:12:13PM +0300, Peter Ujfalusi wrote:
> @@ -1320,41 +1317,92 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>  	struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  	size_t len, unsigned long tx_flags)
>  {
> -	int ret;
> +	int ret, nslots;
>  	struct edma_desc *edesc;
>  	struct device *dev = chan->device->dev;
>  	struct edma_chan *echan = to_edma_chan(chan);
> -	unsigned int width;
> +	unsigned int width, pset_len;
>  
>  	if (unlikely(!echan || !len))
>  		return NULL;
>  
> -	edesc = kzalloc(sizeof(*edesc) + sizeof(edesc->pset[0]), GFP_ATOMIC);
> +	if (len < SZ_64K) {
> +		/*
> +		 * Transfer size less than 64K can be handled with one paRAM
> +		 * slot. ACNT = length
> +		 */
> +		width = len;
> +		pset_len = len;
> +		nslots = 1;
> +	} else {
> +		/*
> +		 * Transfer size bigger than 64K will be handled with maximum of
> +		 * two paRAM slots.
> +		 * slot1: ACNT = 32767, length1: (length / 32767)
> +		 * slot2: the remaining amount of data.
> +		 */
> +		width = SZ_32K - 1;
> +		pset_len = rounddown(len, width);
> +		/* One slot is enough for lengths multiple of (SZ_32K -1) */

Hmm so does this mean if I have 140K transfer, it will do two 64K for 1st
slot and 12K in second slot ?

Is there a limit on 'blocks' of 64K we can do here?

-- 
~Vinod
