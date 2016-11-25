From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] dmaengine: omap-dma: Support for slave devices
 with data port window
Date: Fri, 25 Nov 2016 11:42:26 +0530
Message-ID: <20161125061225.GJ2698@localhost>
References: <20161117125017.14954-1-peter.ujfalusi@ti.com>
 <20161117125017.14954-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161117125017.14954-3-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, tony@atomide.com, linux@armlinux.org.uk, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 17, 2016 at 02:50:17PM +0200, Peter Ujfalusi wrote:
> @@ -921,11 +931,45 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
>  
>  	d->ccr = c->ccr | CCR_SYNC_FRAME;
>  	if (dir == DMA_DEV_TO_MEM) {
> -		d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_CONSTANT;
>  		d->csdp = CSDP_DST_BURST_64 | CSDP_DST_PACKED;
> +
> +		d->ccr |= CCR_DST_AMODE_POSTINC;
> +		if (port_window) {
> +			d->ccr |= CCR_SRC_AMODE_DBLIDX;
> +			d->ei = 1;
> +			/*
> +			 * One frame covers the port_window and by  configure
> +			 * the source frame index to be -1 * (port_window - 1)
> +			 * we instruct the sDMA that after a frame is processed
> +			 * it should move back to the start of the window.
> +			 */
> +			d->fi = -(port_window - 1);
> +
> +			if (port_window >= 64)
> +				d->csdp = CSDP_SRC_BURST_64 | CSDP_SRC_PACKED;
> +			else if (port_window >= 32)
> +				d->csdp = CSDP_SRC_BURST_32 | CSDP_SRC_PACKED;
> +			else if (port_window >= 16)
> +				d->csdp = CSDP_SRC_BURST_16 | CSDP_SRC_PACKED;

this and other would look better with a switch..

-- 
~Vinod
