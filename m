From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 18:24:07 +0400
Message-ID: <4A97E887.6000306@ru.mvista.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:54716 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751268AbZH1OWX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 10:22:23 -0400
In-Reply-To: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net, Swaminathan S <swami.iyer@ti.com>, Babu Ravi <ravibabu@ti.com>

Ajay Kumar Gupta wrote:

> Isochronous Tx DMA is getting programmed but never getting started
> for CPPI and TUSB DMAs and thus Isochronous Tx doesn't work.

> Fixing it by starting DMAs using musb_h_tx_dma_start().

> Signed-off-by: Swaminathan S <swami.iyer@ti.com>
> Signed-off-by: Babu Ravi <ravibabu@ti.com>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index cf94511..e3ab40a 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -1301,8 +1301,11 @@ void musb_host_tx(struct musb *musb, u8 epnum)
>  		return;
>  	} else	if (usb_pipeisoc(pipe) && dma) {
>  		if (musb_tx_dma_program(musb->dma_controller, hw_ep, qh, urb,
> -				offset, length))
> +				offset, length)) {
> +			if (is_cppi_enabled() || tusb_dma_omap())

    The latter check shouldn't really be needed, as in the TUSB DMA mode 
only DMA mode 0 is used, in which case the DMA interrupt filtering code 
above in this function shouldn't clear the TXCSR.DMAReEnab bit.

> +				musb_h_tx_dma_start(hw_ep);
>  			return;
> +		}
>  	} else	if (tx_csr & MUSB_TXCSR_DMAENAB) {
>  		DBG(1, "not complete, but DMA enabled?\n");
>  		return;

WBR, Sergei
