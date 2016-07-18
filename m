From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 7/7] dmaengine: omap-dma: Support for LinkedList transfer
 of slave_sg
Date: Mon, 18 Jul 2016 11:42:00 +0100
Message-ID: <20160718104159.GI5783@n2100.arm.linux.org.uk>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-8-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160714124242.7579-8-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 14, 2016 at 03:42:42PM +0300, Peter Ujfalusi wrote:
>  struct omap_desc {
> +	struct omap_chan *c;
>  	struct virt_dma_desc vd;

No need for this.  to_omap_dma_chan(foo->vd.tx.chan) will give you the
omap_chan for the descriptor.  In any case, I question whether you
actually need this (see below.)

> +	bool using_ll;
>  	enum dma_transfer_direction dir;
>  	dma_addr_t dev_addr;
>  
> @@ -81,6 +109,9 @@ struct omap_desc {
>  };
>  
>  enum {
> +	CAPS_0_SUPPORT_LL123	= BIT(20),	/* Linked List type1/2/3 */
> +	CAPS_0_SUPPORT_LL4	= BIT(21),	/* Linked List type4 */
> +
>  	CCR_FS			= BIT(5),
>  	CCR_READ_PRIORITY	= BIT(6),
>  	CCR_ENABLE		= BIT(7),
> @@ -151,6 +182,19 @@ enum {
>  	CICR_SUPER_BLOCK_IE	= BIT(14),	/* OMAP2+ only */
>  
>  	CLNK_CTRL_ENABLE_LNK	= BIT(15),
> +
> +	CDP_DST_VALID_INC	= 0 << 0,
> +	CDP_DST_VALID_RELOAD	= 1 << 0,
> +	CDP_DST_VALID_REUSE	= 2 << 0,
> +	CDP_SRC_VALID_INC	= 0 << 2,
> +	CDP_SRC_VALID_RELOAD	= 1 << 2,
> +	CDP_SRC_VALID_REUSE	= 2 << 2,
> +	CDP_NTYPE_TYPE1		= 1 << 4,
> +	CDP_NTYPE_TYPE2		= 2 << 4,
> +	CDP_NTYPE_TYPE3		= 3 << 4,
> +	CDP_TMODE_NORMAL	= 0 << 8,
> +	CDP_TMODE_LLIST		= 1 << 8,
> +	CDP_FAST		= BIT(10),
>  };
>  
>  static const unsigned es_bytes[] = {
> @@ -180,7 +224,64 @@ static inline struct omap_desc *to_omap_dma_desc(struct dma_async_tx_descriptor
>  
>  static void omap_dma_desc_free(struct virt_dma_desc *vd)
>  {
> -	kfree(container_of(vd, struct omap_desc, vd));
> +	struct omap_desc *d = container_of(vd, struct omap_desc, vd);

	struct omap_desc *d = to_omap_dma_desc(&vd->tx);

works just as well, and looks much nicer, and follows the existing code
pattern.

> +
> +	if (d->using_ll) {
> +		struct omap_chan *c = d->c;
> +		int i;
> +
> +		for (i = 0; i < d->sglen; i++) {
> +			if (d->sg[i].t2_desc)
> +				dma_pool_free(c->desc_pool, d->sg[i].t2_desc,
> +					      d->sg[i].t2_desc_paddr);

Why do you need a per-channel pool of descriptors?  Won't a per-device
descriptor pool be much better, and simplify the code here?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
