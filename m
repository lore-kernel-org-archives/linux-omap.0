From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Patch [2/2] DaVinci CPPI TX DMA tasklet
Date: Thu, 21 Aug 2008 17:25:46 +0300
Message-ID: <20080821142546.GZ23346@gandalf.research.nokia.com>
References: <1219327122-28334-1-git-send-email-swami.iyer@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53667 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbYHUOYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 10:24:50 -0400
Content-Disposition: inline
In-Reply-To: <1219327122-28334-1-git-send-email-swami.iyer@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Swaminathan S <swami.iyer@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, felipe.balbi@nokia.com

On Thu, Aug 21, 2008 at 07:28:42PM +0530, ext Swaminathan S wrote:
> 
>     Signed-off-by: Swaminathan S <swami.iyer@ti.com>
>     
>     This patch implements a tasklet to poll for TX Endpoint FIFO
>     empty status before completing a transfer.  This is required
>     in the context of DaVinci CPPI DMA Tx transfers.  CPPI
>     DMA engine generates completion interrupt before the data
>     actually moves out of TX FIFO and the driver needs to save the
>     Data toggle after ensuring that the FIFO is empty.

same comments from before.

> diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
> index d443a61..9dd24c3 100644
> --- a/drivers/usb/musb/davinci.c
> +++ b/drivers/usb/musb/davinci.c
> @@ -421,6 +421,12 @@ int __init musb_platform_init(struct musb *musb)
>  		musb_readb(tibase, DAVINCI_USB_CTRL_REG));
>  
>  	musb->isr = davinci_interrupt;
> +#ifdef CONFIG_USB_MUSB_HDRC_HCD

use if (is_host_capable()) instead.

> +		if (hw_ep->fifo_flush_check) {
> +			csr = musb_readw(hw_ep->regs, MUSB_TXCSR);
> +			if (((csr & MUSB_TXCSR_FIFONOTEMPTY) ||
> +				(csr & MUSB_TXCSR_TXPKTRDY)))
> +				sch_tsklt = 1;
> +			else {

put {} on both branches.

> +

this new line is unnecessary

this was just a primary overview. I wanna test more this patch since it
changes a bit musb_ep_program() which would affect all archs using musb.

I'll leave my n810 testing during this weekend and get back to you later
on.

-- 
balbi
