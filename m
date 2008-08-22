From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP:MUSB: Fixes the TT programming.
Date: Thu, 21 Aug 2008 23:30:06 -0700
Message-ID: <200808212330.06650.david-b@pacbell.net>
References: <1219385613-20108-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:47614 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752688AbYHVGaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Aug 2008 02:30:13 -0400
In-Reply-To: <1219385613-20108-1-git-send-email-ajay.gupta@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ajay.gupta@ti.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, felipe.balbi@nokia.com

On Thursday 21 August 2008, ajay.gupta@ti.com wrote:
> From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Fixes enumeration failures when a USB device attached to a LS hub
> is connected to OMAP EVM via HS hub. This is fixed by correctly
> programming hub address register in enqueue path.  
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Looks right to me, other than the lack of line wrapping in that
summary (corrected above).  Moreover, there ought to be some way
to make all high speed hosts share TT scheduling code ... ;)

Acked-by: David Brownell <dbrownell@users.sourceforge.net>


> ---
>  drivers/usb/musb/musb_host.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 52ac02a..90d3733 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -1869,7 +1869,11 @@ static int musb_urb_enqueue(
>  			/* set up tt info if needed */
>  			if (urb->dev->tt) {
>  				qh->h_port_reg = (u8) urb->dev->ttport;
> -				qh->h_addr_reg |= 0x80;
> +				if (urb->dev->tt->hub)
> +					qh->h_addr_reg =
> +						(u8) urb->dev->tt->hub->devnum;
> +				if (urb->dev->tt->multi)
> +					qh->h_addr_reg |= 0x80;
>  			}
>  		}
>  	}
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


