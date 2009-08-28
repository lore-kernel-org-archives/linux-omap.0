From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 13:23:11 +0400
Message-ID: <4A97A1FF.5050501@ru.mvista.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:46035 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751049AbZH1JXT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 05:23:19 -0400
In-Reply-To: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com, david-b@pacbell.net, Swaminathan S <swami.iyer@ti.com>, Babu Ravi <ravibabu@ti.com>

Hello.

Ajay Kumar Gupta wrote:

> Isochronous Tx DMA is getting programmed but never getting started
> for CPPI and TUSB DMAs and thus Isochronous Tx doesn't work.
>   

   That's not true.

> Fixing it by starting DMAs using musb_h_tx_dma_start().
>
> Signed-off-by: Swaminathan S <swami.iyer@ti.com>
> Signed-off-by: Babu Ravi <ravibabu@ti.com>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>   

   NAK.

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
> +				musb_h_tx_dma_start(hw_ep);
>  			return;
>   

   It will have been already started by this moment -- from 
musb_start_urb() which is enough . Otherwise it wouldn't work, and I've 
made sure it *does* work.

WBR, Sergei


