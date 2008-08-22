From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP:MUSB: Corrects urb unlink function path
Date: Fri, 22 Aug 2008 10:27:33 +0300
Message-ID: <20080822072733.GC9474@gandalf.research.nokia.com>
References: <1219386656-31072-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18678 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897AbYHVH0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 03:26:52 -0400
Content-Disposition: inline
In-Reply-To: <1219386656-31072-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext ajay.gupta@ti.com" <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, felipe.balbi@nokia.com, ajaykuee@gmail.com

On Fri, Aug 22, 2008 at 12:00:56PM +0530, ext ajay.gupta@ti.com wrote:
> From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Fixes kernel panic while ISO IN transfer is aborted.Replaced
> usb_hcd_unlink_urb_from_ep() from musb_giveback() to __musb_giveback()
> to make sure urb is unlinked before giveback when __musb_giveback() is
> called from musb_urb_dequeue().

looks right as well

note: please break your patch header after 72 caracters

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  drivers/usb/musb/musb_host.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 93b0678..a889ac4 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -292,6 +292,7 @@ __acquires(musb->lock)
>  			);
>  
>  	spin_unlock(&musb->lock);
> +	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
>  	usb_hcd_giveback_urb(musb_to_hcd(musb), urb, status);
>  	spin_lock(&musb->lock);
>  }
> @@ -353,8 +354,6 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
>  		break;
>  	}
>  
> -	usb_hcd_unlink_urb_from_ep(musb_to_hcd(musb), urb);
> -
>  	qh->is_ready = 0;
>  	__musb_giveback(musb, urb, status);
>  	qh->is_ready = ready;
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
