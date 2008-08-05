From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MUSB: Fix bug - don't mess up count number and CSR0
	register value
Date: Tue, 5 Aug 2008 11:45:50 +0300
Message-ID: <20080805084549.GC7193@atomide.com>
References: <1217907118963-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51283 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbYHEIp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 04:45:58 -0400
Content-Disposition: inline
In-Reply-To: <1217907118963-git-send-email-cooloney@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org

Hi,

* Bryan Wu <cooloney@kernel.org> [080805 06:27]:
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> ---
>  drivers/usb/musb/musb_gadget_ep0.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)

I think all musb patches should be now posted to linux-usb list as the
patches are queued for integration.

So I'll be using plain code coming from mainline tree and
won't apply any patches to musb code except temporary fixes if compile
breaks.

Cheers,

Tony

> diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
> index 2d2574c..e7b56df 100644
> --- a/drivers/usb/musb/musb_gadget_ep0.c
> +++ b/drivers/usb/musb/musb_gadget_ep0.c
> @@ -452,7 +452,7 @@ static void ep0_rxstate(struct musb *musb)
>  {
>  	void __iomem		*regs = musb->control_ep->regs;
>  	struct usb_request	*req;
> -	u16			tmp;
> +	u16			count, csr;
>  
>  	req = next_ep0_request(musb);
>  
> @@ -464,34 +464,34 @@ static void ep0_rxstate(struct musb *musb)
>  		unsigned	len = req->length - req->actual;
>  
>  		/* read the buffer */
> -		tmp = musb_readb(regs, MUSB_COUNT0);
> -		if (tmp > len) {
> +		count = musb_readb(regs, MUSB_COUNT0);
> +		if (count > len) {
>  			req->status = -EOVERFLOW;
> -			tmp = len;
> +			count = len;
>  		}
> -		musb_read_fifo(&musb->endpoints[0], tmp, buf);
> -		req->actual += tmp;
> -		tmp = MUSB_CSR0_P_SVDRXPKTRDY;
> -		if (tmp < 64 || req->actual == req->length) {
> +		musb_read_fifo(&musb->endpoints[0], count, buf);
> +		req->actual += count;
> +		csr = MUSB_CSR0_P_SVDRXPKTRDY;
> +		if (count < 64 || req->actual == req->length) {
>  			musb->ep0_state = MUSB_EP0_STAGE_STATUSIN;
> -			tmp |= MUSB_CSR0_P_DATAEND;
> +			csr |= MUSB_CSR0_P_DATAEND;
>  		} else
>  			req = NULL;
>  	} else
> -		tmp = MUSB_CSR0_P_SVDRXPKTRDY | MUSB_CSR0_P_SENDSTALL;
> +		csr = MUSB_CSR0_P_SVDRXPKTRDY | MUSB_CSR0_P_SENDSTALL;
>  
>  
>  	/* Completion handler may choose to stall, e.g. because the
>  	 * message just received holds invalid data.
>  	 */
>  	if (req) {
> -		musb->ackpend = tmp;
> +		musb->ackpend = csr;
>  		musb_g_ep0_giveback(musb, req);
>  		if (!musb->ackpend)
>  			return;
>  		musb->ackpend = 0;
>  	}
> -	musb_writew(regs, MUSB_CSR0, tmp);
> +	musb_writew(regs, MUSB_CSR0, csr);
>  }
>  
>  /*
> -- 
> 1.5.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
