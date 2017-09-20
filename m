From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 3/4] usb: musb: musb_cppi41: Configure the number of
 channels for DA8xx
Date: Wed, 20 Sep 2017 12:21:16 +0300
Message-ID: <294030ff-73a3-62ed-2cbf-69db659f616e@cogentembedded.com>
References: <20170920073513.11650-1-abailon@baylibre.com>
 <20170920073513.11650-4-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920073513.11650-4-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello!

On 9/20/2017 10:35 AM, Alexandre Bailon wrote:

> Currently, the number of channels is set to 15 but in the case of DA8xx,
> the number of channels is 4.
> Update the driver to configure the number of channels at runtime.
> 
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/usb/musb/musb_cppi41.c | 31 ++++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
> index b2b1306c01cf..2d1468cccae0 100644
> --- a/drivers/usb/musb/musb_cppi41.c
> +++ b/drivers/usb/musb/musb_cppi41.c
[...]
> @@ -770,18 +776,33 @@ cppi41_dma_controller_create(struct musb *musb, void __iomem *base)
>   		controller->tdown_reg = DA8XX_USB_TEARDOWN;
>   		controller->autoreq_reg = DA8XX_USB_AUTOREQ;
>   		controller->set_dma_mode = da8xx_set_dma_mode;
> +		controller->num_channels = DA8XX_DMA_NUM_CHANNELS;
>   	} else {
>   		controller->tdown_reg = USB_TDOWN;
>   		controller->autoreq_reg = USB_CTRL_AUTOREQ;
>   		controller->set_dma_mode = cppi41_set_dma_mode;
> +		controller->num_channels = MUSB_DMA_NUM_CHANNELS;
>   	}
>   
> +	channel_size = controller->num_channels *
> +			sizeof(struct cppi41_dma_channel);
> +	controller->rx_channel = kzalloc(channel_size, GFP_KERNEL);
> +	if (controller->rx_channel)

    How can this work? The NULL check is reversed.

> +		goto rx_channel_alloc_fail;
> +	controller->tx_channel = kzalloc(channel_size, GFP_KERNEL);
> +	if (controller->tx_channel)

    Same here.

> +		goto tx_channel_alloc_fail;
> +
>   	ret = cppi41_dma_controller_start(controller);
>   	if (ret)
>   		goto plat_get_fail;
>   	return &controller->controller;
>   
>   plat_get_fail:
> +	kfree(controller->tx_channel);
> +tx_channel_alloc_fail:
> +	kfree(controller->rx_channel);
> +rx_channel_alloc_fail:
>   	kfree(controller);
>   kzalloc_fail:
>   	if (ret == -EPROBE_DEFER)
> 

MBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
