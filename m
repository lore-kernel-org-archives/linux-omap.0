From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: musb_cppi41: Fix cppi41_set_dma_mode() for
 DA8xx
Date: Tue, 15 Aug 2017 13:23:12 +0300
Message-ID: <5d11b390-636e-fd65-f330-c6052a8ffce5@cogentembedded.com>
References: <20170813120423.16371-1-abailon@baylibre.com>
 <20170813120423.16371-3-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170813120423.16371-3-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 8/13/2017 3:04 PM, Alexandre Bailon wrote:

> The way to configure the DMA mode on DA8xx is different from DSPS.
> Add a new function to configure DMA mode on DA8xx and use a callback
> to call the right function based on the platform.
> 
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/usb/musb/musb_cppi41.c | 40 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
> index dbff0e0a4ff5..7284ec7ecff7 100644
> --- a/drivers/usb/musb/musb_cppi41.c
> +++ b/drivers/usb/musb/musb_cppi41.c
> @@ -26,6 +26,7 @@
>   
>   #define MUSB_DMA_NUM_CHANNELS 15

    Perhaps this needs parametrizing too? DA8xx only has 4 channels IIRC...


> +#define DA8XX_USB_MODE_REG	0x10

    Drop this _REG suffix please.

>   #define DA8XX_USB_AUTOREQ_REG	0x14
>   #define DA8XX_USB_TEARDOWN_REG	0x1c
>   
[...]
> @@ -413,14 +444,15 @@ static bool cppi41_configure_channel(struct dma_channel *channel,
>   		} else {
>   			musb_writel(musb->ctrl_base,
>   					RNDIS_REG(cppi41_channel->port_num), 0);
> -			cppi41_set_dma_mode(cppi41_channel,
> +			controller->set_dma_mode(cppi41_channel,
>   					EP_MODE_DMA_TRANSPARENT);
>   			cppi41_set_autoreq_mode(cppi41_channel,
>   					EP_MODE_AUTOREQ_NONE);
>   		}
>   	} else {
>   		/* fallback mode */
> -		cppi41_set_dma_mode(cppi41_channel, EP_MODE_DMA_TRANSPARENT);
> +		controller->set_dma_mode(cppi41_channel,
> +					EP_MODE_DMA_TRANSPARENT);

    Inconsistent indentation -- you used 2 extra tabs above and 3 here.

[...]

MBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
