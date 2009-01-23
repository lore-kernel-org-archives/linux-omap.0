From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] usb: musb: fix bug in musbhsdma programming
Date: Fri, 23 Jan 2009 12:18:12 +0200
Message-ID: <20090123101812.GP9233@scadufax.research.nokia.com>
References: <1231417896-32363-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35724 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbZAWKaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 05:30:07 -0500
Content-Disposition: inline
In-Reply-To: <1231417896-32363-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com

On Thu, Jan 08, 2009 at 06:01:36PM +0530, Ajay Kumar Gupta wrote:
> Mode bit should be set based on function parameter "mode" of
> configure_channel() function.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  drivers/usb/musb/musbhsdma.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index a23d005..d87c6c7 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -225,13 +225,14 @@ static void configure_channel(struct dma_channel *channel,
>  			csr |= MUSB_HSDMA_BURSTMODE_INCR4;
>  
>  		csr |= (musb_channel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
> -			| MUSB_HSDMA_MODE1
>  			| MUSB_HSDMA_ENABLE
>  			| MUSB_HSDMA_IRQENABLE
>  			| (musb_channel->transmit
>  					? MUSB_HSDMA_TRANSMIT
>  					: 0);
>  
> +		if (mode)
> +			csr |= MUSB_HSDMA_MODE1;
>  		/* address/count */
>  		musb_write_hsdma_addr(mbase, bchannel, dma_addr);
>  		musb_write_hsdma_count(mbase, bchannel, len);
> -- 
> 1.5.6

-- 
balbi
