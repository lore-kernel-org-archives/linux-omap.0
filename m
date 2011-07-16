From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Sat, 16 Jul 2011 15:22:20 +0400
Message-ID: <4E21746C.4040301@ru.mvista.com>
References: <1310773489-19184-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53396 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286Ab1GPLXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jul 2011 07:23:38 -0400
In-Reply-To: <1310773489-19184-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, gadiyar@ti.com, linux-omap@vger.kernel.org, Moiz Sonasath <m-sonasath@ti.com>

Hello.

On 16-07-2011 3:44, Vikram Pandita wrote:

> From: Vikram Pandita <vikram.pandita@ti.com>

> This patch enables the DMA mode1 RX support.
> This feature is enabled based on the short_not_ok flag passed from
> gadget drivers.

> This will result in a thruput performance gain of around
> 40% for USB mass-storage/mtp use cases.

> Based on Original work by
> Anand Gadiyar<gadiyar@ti.com>  on 2.6.35 kernel

> Tested on OMAP4460 Blaze board.

> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>   drivers/usb/musb/musb_gadget.c |   42 ++++++++++++++++++++++++++++-----------
>   1 files changed, 30 insertions(+), 12 deletions(-)

> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 9412410..e643ec2 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -624,6 +624,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>   /*
>    * Context: controller locked, IRQs blocked, endpoint selected
>    */
> +

    Why?

>   static void rxstate(struct musb *musb, struct musb_request *req)
>   {
>   	const u8		epnum = req->epnum;
> @@ -714,10 +728,13 @@ static void rxstate(struct musb *musb, struct musb_request *req)
>   	 * then becomes usable as a runtime "use mode 1" hint...
>   	 */
>
> -				csr |= MUSB_RXCSR_DMAENAB;
> -#ifdef USE_MODE1
> +	/* Experimental: Mode1 works with mass storage use cases
> +	 */
> +		if (use_mode_1) {

    No, you can't put the code at the arbitrary indentation levels. Please 
indent properly.

>   				csr |= MUSB_RXCSR_AUTOCLEAR;
> -				/* csr |= MUSB_RXCSR_DMAMODE; */
> +				musb_writew(epio, MUSB_RXCSR, csr);
> +				csr |= MUSB_RXCSR_DMAENAB;
> +				musb_writew(epio, MUSB_RXCSR, csr);
>
>   				/* this special sequence (enabling and then
>   				 * disabling MUSB_RXCSR_DMAMODE) is required
> @@ -725,26 +742,27 @@ static void rxstate(struct musb *musb, struct musb_request *req)
>   				 */
>   				musb_writew(epio, MUSB_RXCSR,
>   					csr | MUSB_RXCSR_DMAMODE);
> -#else
> +				musb_writew(epio, MUSB_RXCSR, csr);
> +
> +		} else {
>   				if (!musb_ep->hb_mult &&
>   					musb_ep->hw_ep->rx_double_buffered)
>   					csr |= MUSB_RXCSR_AUTOCLEAR;
> -#endif
> +				csr |= MUSB_RXCSR_DMAENAB;
>   				musb_writew(epio, MUSB_RXCSR, csr);
> +		}
>
>   				if (request->actual<  request->length) {
>   					int transfer_size = 0;
> -#ifdef USE_MODE1
> +		if (use_mode_1) {

    Same here.

>   					transfer_size = min(request->length - request->actual,
>   							channel->max_len);
> -#else
> +					musb_ep->dma->desired_mode = 1;
> +		} else {
>   					transfer_size = min(request->length - request->actual,
>   							(unsigned)len);
> -#endif
> -					if (transfer_size <= musb_ep->packet_sz)
> -						musb_ep->dma->desired_mode = 0;
> -					else
> -						musb_ep->dma->desired_mode = 1;
> +					musb_ep->dma->desired_mode = 0;
> +		}
>
>   					use_dma = c->channel_program(
>   							channel,

WBR, Sergei
