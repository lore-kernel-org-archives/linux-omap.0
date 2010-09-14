From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [RESEND/PATCH 6/6] USB: musb-gadget: fix dma length in txstate
Date: Tue, 14 Sep 2010 21:43:25 +0400
Message-ID: <4C8FB43D.5020604@ru.mvista.com>
References: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com> <1283873014-32511-7-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283873014-32511-7-git-send-email-tom.leiming@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tom.leiming@gmail.com
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <me@felipebalbi.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

Hello.

tom.leiming@gmail.com wrote:

> From: Ming Lei <tom.leiming@gmail.com>

> DMA length should not go beyond the availabe space of request buffer,
> so fix it.

> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Felipe Balbi <me@felipebalbi.com>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

[...]

> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index fa826f9..cacae96 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -300,6 +300,11 @@ static void txstate(struct musb *musb, struct musb_request *req)
>  #ifndef	CONFIG_MUSB_PIO_ONLY
>  	if (is_dma_capable() && musb_ep->dma) {
>  		struct dma_controller	*c = musb->dma_controller;
> +		size_t request_size;
> +
> +		/* setup DMA, then program endpoint CSR */
> +		request_size = min_t(size_t, request->length - request->actual,
> +					musb_ep->dma->max_len);

    Er, you're moving this from under #ifdef CONFIG_USB_INVENTRA_DMA to the 
common code, right? Do you know that not all DMA drivers initialize max_len? For 
example CPPI driver doesn't, so it's left at zero. You're going to break DMA for 
CPPI. Please extend your patch, adding cppi_dma.c to it.

> @@ -307,11 +312,6 @@ static void txstate(struct musb *musb, struct musb_request *req)
>  
>  #ifdef CONFIG_USB_INVENTRA_DMA
>  		{
> -			size_t request_size;
> -
> -			/* setup DMA, then program endpoint CSR */
> -			request_size = min_t(size_t, request->length,
> -						musb_ep->dma->max_len);
>  			if (request_size < musb_ep->packet_sz)
>  				musb_ep->dma->desired_mode = 0;
>  			else

WBR, Sergei
