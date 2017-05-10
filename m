From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH v2 05/10] usb: musb: tusb6010_omap: Do not reset the
 other direction's packet size
Date: Wed, 10 May 2017 12:07:54 -0500
Message-ID: <20170510170754.GA7154@uda0271908>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
 <20170510084231.19302-6-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170510084231.19302-6-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, May 10, 2017 at 11:42:27AM +0300, Peter Ujfalusi wrote:
> We have one register for each EP to set the maximum packet size for both
> TX and RX.
> If for example an RX programming would happen before the previous TX
> transfer finishes we would reset the TX packet side.
> 
> To fix this issue, only modify the TX or RX part of the register.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/usb/musb/tusb6010_omap.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
> index db2e4c379ccf..4e1a6e4a61b8 100644
> --- a/drivers/usb/musb/tusb6010_omap.c
> +++ b/drivers/usb/musb/tusb6010_omap.c
> @@ -389,15 +389,19 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  
>  	if (chdat->tx) {
>  		/* Send transfer_packet_sz packets at a time */
> -		musb_writel(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET,
> -			chdat->transfer_packet_sz);
> +		u32 psize = musb_readl(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET);

checkpatch.pl complains about declaration and assignment together.

> +		psize &= ~0x7ff;
> +		psize |= chdat->transfer_packet_sz;
> +		musb_writel(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET, psize);
>  
>  		musb_writel(ep_conf, TUSB_EP_TX_OFFSET,
>  			TUSB_EP_CONFIG_XFR_SIZE(chdat->transfer_len));
>  	} else {
>  		/* Receive transfer_packet_sz packets at a time */
> -		musb_writel(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET,
> -			chdat->transfer_packet_sz << 16);
> +		u32 psize = musb_readl(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET);

and at here too.

> +		psize &= ~(0x7ff << 16);
> +		psize |= (chdat->transfer_packet_sz << 16);
> +		musb_writel(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET, psize);
>  
>  		musb_writel(ep_conf, TUSB_EP_RX_OFFSET,
>  			TUSB_EP_CONFIG_XFR_SIZE(chdat->transfer_len));

Regards,
-Bin.
