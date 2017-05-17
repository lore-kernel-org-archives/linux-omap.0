From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH v3 3/9] usb: musb: tusb6010: Add MUSB_G_NO_SKB_RESERVE to
 quirks
Date: Wed, 17 May 2017 15:08:07 -0500
Message-ID: <20170517200807.GE651@uda0271908>
References: <20170512135752.1800-1-peter.ujfalusi@ti.com>
 <20170512135752.1800-4-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512135752.1800-4-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 12, 2017 at 04:57:46PM +0300, Peter Ujfalusi wrote:
> When using the g_ncm for networking this flag will make sure that the
> buffer is alligned to 32bit so the DMA can be used to offload the data

s/alligned/aligned/

Regards,
-Bin.

> movement.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/usb/musb/tusb6010.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
> index e85cc8e4e7a9..4253bfb22043 100644
> --- a/drivers/usb/musb/tusb6010.c
> +++ b/drivers/usb/musb/tusb6010.c
> @@ -1181,7 +1181,8 @@ static int tusb_musb_exit(struct musb *musb)
>  }
>  
>  static const struct musb_platform_ops tusb_ops = {
> -	.quirks		= MUSB_DMA_TUSB_OMAP | MUSB_IN_TUSB,
> +	.quirks		= MUSB_DMA_TUSB_OMAP | MUSB_IN_TUSB |
> +			  MUSB_G_NO_SKB_RESERVE,
>  	.init		= tusb_musb_init,
>  	.exit		= tusb_musb_exit,
>  
> -- 
> 2.13.0
> 
