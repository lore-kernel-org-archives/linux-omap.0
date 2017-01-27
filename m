From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 1/5] usb: musb: da8xx: Remove CPPI 3.0 quirk and
 methods
Date: Fri, 27 Jan 2017 09:08:53 -0600
Message-ID: <20170127150853.GB21144@uda0271908>
References: <20170125103319.26021-1-abailon@baylibre.com>
 <20170125103319.26021-2-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170125103319.26021-2-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2017 at 11:33:15AM +0100, Alexandre Bailon wrote:
> DA8xx driver is registering and using the CPPI 3.0 DMA controller but
> actually, the DA8xx has a CPPI 4.1 DMA controller.
> Remove the CPPI 3.0 quirk and methods.
> 
> Fixes: f8e9f34f80a2 ("usb: musb: Fix up DMA related macros")
> Fixes: 7f6283ed6fe8 ("usb: musb: Set up function pointers for DMA")
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Acked-by: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Applied, and added 'cc stable' tag.

Since the dependant patch set is not ready to merge yet, I only picked
this patch in this set for v4.11-rc1.

Thanks,
-Bin.

> ---
>  drivers/usb/musb/da8xx.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index e89708d..cd3d763 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -458,15 +458,11 @@ static inline u8 get_vbus_power(struct device *dev)
>  }
>  
>  static const struct musb_platform_ops da8xx_ops = {
> -	.quirks		= MUSB_DMA_CPPI | MUSB_INDEXED_EP,
> +	.quirks		= MUSB_INDEXED_EP,
>  	.init		= da8xx_musb_init,
>  	.exit		= da8xx_musb_exit,
>  
>  	.fifo_mode	= 2,
> -#ifdef CONFIG_USB_TI_CPPI_DMA
> -	.dma_init	= cppi_dma_controller_create,
> -	.dma_exit	= cppi_dma_controller_destroy,
> -#endif
>  	.enable		= da8xx_musb_enable,
>  	.disable	= da8xx_musb_disable,
>  
> -- 
> 2.10.2
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
