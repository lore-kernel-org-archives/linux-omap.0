From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] IrDA: Fix omap-ir build
Date: Tue, 8 May 2007 14:38:55 -0700
Message-ID: <20070508213855.GK32547@atomide.com>
References: <5d5443650705080041l5082ac73jd69ed20bfbb185e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650705080041l5082ac73jd69ed20bfbb185e8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070508 00:41]:
> Tony,
> 
> Attached patch fixes omap-ir build.
> 
> -- 
> --Trilok Soni

> From 3e6d5cad52aac28ff88baa62943600e4b490dfc6 Mon Sep 17 00:00:00 2001
> From: Trilok Soni <soni.trilok@gmail.com>
> Date: Tue, 8 May 2007 18:40:54 +0530
> Subject: [PATCH] IrDA: Fix omap-ir build
> 
> - use new skb_reset_mac_header and
>   skb_copy_from_linear_data functions.
> 
> Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
> ---
>  drivers/net/irda/omap-ir.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/irda/omap-ir.c b/drivers/net/irda/omap-ir.c
> index 85658dc..1fc8c31 100644
> --- a/drivers/net/irda/omap-ir.c
> +++ b/drivers/net/irda/omap-ir.c
> @@ -395,7 +395,7 @@ omap_irda_irq(int irq, void *dev_id)
>  					w - 4);
>  
>  		skb->dev = dev;
> -		skb->mac.raw = skb->data;
> +		skb_reset_mac_header(skb);
>  		skb->protocol = htons(ETH_P_IRDA);
>  		omap_ir->stats.rx_packets++;
>  		omap_ir->stats.rx_bytes += skb->len;
> @@ -444,7 +444,7 @@ static int omap_irda_hard_xmit(struct sk_buff *skb, struct net_device *dev)
>  	netif_stop_queue(dev);
>  
>  	/* Copy skb data to DMA buffer */
> -	memcpy(omap_ir->tx_buf_dma_virt, skb->data, skb->len);
> +	skb_copy_from_linear_data(skb, omap_ir->tx_buf_dma_virt, skb->len);
>  
>  	/* Copy skb data to DMA buffer */
>  	omap_ir->stats.tx_bytes += skb->len;
> -- 
> 1.5.0

Thanks, pushing today.

Tony
