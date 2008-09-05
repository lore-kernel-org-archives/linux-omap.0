From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] MUSB: Removes compilation warning in gadget mode
Date: Fri, 5 Sep 2008 12:00:00 +0300
Message-ID: <20080905085959.GA7420@frodo>
References: <1220524485-8283-1-git-send-email-ajay.gupta@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49476 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbYIEJAG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 05:00:06 -0400
Content-Disposition: inline
In-Reply-To: <1220524485-8283-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Sep 04, 2008 at 04:04:45PM +0530, Ajay Kumar Gupta wrote:
> Fixes compilation warning when musb is configured in gadget mode.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  drivers/usb/musb/omap2430.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 472c304..ea5c504 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -53,7 +53,9 @@ static void musb_do_idle(unsigned long _musb)
>  {
>  	struct musb	*musb = (void *)_musb;
>  	unsigned long	flags;
> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
>  	u8	power;
> +#endif
>  	u8	devctl;
>  
>  	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
> -- 
> 1.5.6

-- 
balbi
