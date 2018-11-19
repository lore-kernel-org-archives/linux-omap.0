From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Mon, 19 Nov 2018 20:46:50 +0200
Message-ID: <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119104040.12885-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, rmk+kernel@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Nov 19, 2018 at 12:40:40PM +0200, Peter Ujfalusi wrote:
> When the channel is configured for slave operation the LCH_TYPE needs to be
> set to LCh-P. For memcpy channels the LCH_TYPE must be set to LCh-2D.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I don't have the documentation, but based on what omap_udc driver (still
using the legacy OMAP DMA API) does this seems to be correct.

I tested the patch on Nokia 770 with MMC and couldn't see any negative
impact.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  drivers/dma/ti/omap-dma.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index a4a931ddf6f6..a18cfd497f04 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -185,6 +185,10 @@ enum {
>  
>  	CLNK_CTRL_ENABLE_LNK	= BIT(15),
>  
> +	/* OMAP1 only */
> +	LCH_CTRL_LCH_2D		= 0,
> +	LCH_CTRL_LCH_P		= 2,
> +
>  	CDP_DST_VALID_INC	= 0 << 0,
>  	CDP_DST_VALID_RELOAD	= 1 << 0,
>  	CDP_DST_VALID_REUSE	= 2 << 0,
> @@ -529,6 +533,7 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d)
>  
>  static void omap_dma_start_desc(struct omap_chan *c)
>  {
> +	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
>  	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
>  	struct omap_desc *d;
>  	unsigned cxsa, cxei, cxfi;
> @@ -570,6 +575,12 @@ static void omap_dma_start_desc(struct omap_chan *c)
>  	omap_dma_chan_write(c, CSDP, d->csdp);
>  	omap_dma_chan_write(c, CLNK_CTRL, d->clnk_ctrl);
>  
> +	if (dma_omap1() && !__dma_omap15xx(od->plat->dma_attr)) {
> +		if (is_slave_direction(d->dir))
> +			omap_dma_chan_write(c, LCH_CTRL, LCH_CTRL_LCH_P);
> +		else
> +			omap_dma_chan_write(c, LCH_CTRL, LCH_CTRL_LCH_2D);
> +	}
>  	omap_dma_start_sg(c, d);
>  }
>  
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
