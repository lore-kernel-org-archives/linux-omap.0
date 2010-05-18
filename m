From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6] musb: dma: use optimal transfer element for sdma
Date: Tue, 18 May 2010 13:47:49 +0400
Message-ID: <4BF26245.4070707@ru.mvista.com>
References: <1274094488-15925-1-git-send-email-ajay.gupta@ti.com> <1274094488-15925-2-git-send-email-ajay.gupta@ti.com> <1274094488-15925-3-git-send-email-ajay.gupta@ti.com> <1274094488-15925-4-git-send-email-ajay.gupta@ti.com> <1274094488-15925-5-git-send-email-ajay.gupta@ti.com> <1274094488-15925-6-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274094488-15925-6-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Ajay Kumar Gupta wrote:

> Use optimal values of transfer element based on buffer address in system
> DMA programming. This would improve the performance.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/musb/musbhsdma.c |   29 ++++++++++++++++++++++++++---
>  1 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index d29e487..39c1801 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -52,11 +52,34 @@ static void musb_sdma_channel_program(struct musb *musb,
>  		struct musb_dma_channel *musb_channel,
>  		dma_addr_t dma_addr, u32 len)
>  {
> +	u16 frame = len;
> +	int data_type = OMAP_DMA_DATA_TYPE_S8;
> +
> +	switch (dma_addr & 0x3) {
> +	case 0:
> +		if ((len % 4) == 0) {
> +			data_type = OMAP_DMA_DATA_TYPE_S32;
> +			frame = len / 4;
> +			break;
> +		}
> +	case 2:
> +		if ((len % 2) == 0) {
> +			data_type = OMAP_DMA_DATA_TYPE_S16;
> +			frame = len / 2;
> +			break;
> +		}
> +	case 1:
> +	case 3:
> +	default:
> +		data_type = OMAP_DMA_DATA_TYPE_S8;
> +		frame = len;
> +			break;

    The *break* is overindented.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
