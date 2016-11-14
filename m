From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] dmaengine: omap-dma: Support for slave devices with
 data port window
Date: Mon, 14 Nov 2016 16:25:46 +0530
Message-ID: <20161114105546.GF3000@localhost>
References: <20161025105019.24475-1-peter.ujfalusi@ti.com>
 <20161025105019.24475-3-peter.ujfalusi@ti.com>
 <20161114043517.GO3000@localhost>
 <11c9dee6-1ddf-f2d3-e616-73fbac7cfd4f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11c9dee6-1ddf-f2d3-e616-73fbac7cfd4f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 14, 2016 at 11:44:33AM +0200, Peter Ujfalusi wrote:
> On 11/14/2016 06:35 AM, Vinod Koul wrote:

> >>  	} else {
> >> -		d->ccr |= CCR_DST_AMODE_CONSTANT | CCR_SRC_AMODE_POSTINC;
> >>  		d->csdp = CSDP_SRC_BURST_64 | CSDP_SRC_PACKED;
> >> +
> >> +		d->ccr |= CCR_SRC_AMODE_POSTINC;
> >> +		if (port_window) {
> >> +			d->ccr |= CCR_DST_AMODE_DBLIDX;
> >> +
> >> +			if (port_window / 64)
> >> +				d->csdp = CSDP_DST_BURST_64 | CSDP_DST_PACKED;
> >> +			else if (port_window / 32)
> >> +				d->csdp = CSDP_DST_BURST_32 | CSDP_DST_PACKED;
> >> +			else if (port_window / 16)
> >> +				d->csdp = CSDP_DST_BURST_16 | CSDP_DST_PACKED;
> > 
> > what does these mean?
> 
> To optimize the speed on the write side. First check if the window size is
> multiple of 64 bytes, we enable the 64byte burst and packed transfer, if not
> try the 32bytes, then 16bytes.
> Same for the opposite direction previously.

Ah and how does client know the size of window..?

> 
> > 
> >> +		} else {
> >> +			d->ccr |= CCR_DST_AMODE_CONSTANT;
> >> +		}
> >>  	}
> >>  
> >>  	d->cicr = CICR_DROP_IE | CICR_BLOCK_IE;
> >> @@ -945,6 +979,9 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
> >>  			d->ccr |= CCR_TRIGGER_SRC;
> >>  
> >>  		d->cicr |= CICR_MISALIGNED_ERR_IE | CICR_TRANS_ERR_IE;
> >> +
> >> +		if (port_window)
> >> +			d->csdp |= CSDP_WRITE_LAST_NON_POSTED;
> >>  	}
> >>  	if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
> >>  		d->clnk_ctrl = c->dma_ch;
> >> @@ -970,6 +1007,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
> >>  		osg->addr = sg_dma_address(sgent);
> >>  		osg->en = en;
> >>  		osg->fn = sg_dma_len(sgent) / frame_bytes;
> >> +		if (port_window && dir == DMA_MEM_TO_DEV) {
> >> +			osg->ei = 1;
> >> +			osg->fi = (-1) * (port_window - 1);
> >> +		}
> > 
> > can you describe what you are trying here..
> 
> The DMA is set up so one frame covers the port window. When the frame is
> finished we need to start reading the next frame from the start of the window
> again. The FI as (-1) * (port_window - 1) will take us to the start of the
> window. When the frame is finished the DMA is pointing to the last byte of the
> window.

Sound right to me, would help to add this as a comment..

-- 
~Vinod
