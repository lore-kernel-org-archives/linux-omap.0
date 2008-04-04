From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] USB: MUSB: Be sure that we enable musb->clock
Date: Fri, 4 Apr 2008 12:33:15 +0300
Message-ID: <20080404093315.GG3505@atomide.com>
References: <1207222710-10120-1-git-send-email-felipe.balbi@nokia.com> <0c65e3d506e8fd8a7579091f73c3b4fb@felipebalbi.com> <20080403135937.GB7004@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52214 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbYDDJdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 05:33:21 -0400
Content-Disposition: inline
In-Reply-To: <20080403135937.GB7004@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi@nokia.com> [080403 17:01]:
> On Thu, Apr 03, 2008 at 06:56:01AM -0500, ext Felipe Balbi wrote:
> > 
> > 
> > On Thu,  3 Apr 2008 14:38:30 +0300, Felipe Balbi <felipe.balbi@nokia.com>
> > wrote:
> > 
> > The following is better as I'm also disabling the clock on suspend to
> > conserve power.
> 
> The spinlock wasn't needed, stupid brain-fart.
> Sorry for that.
> 
> Tony, updated patch below:

Pushing today.

Tony

> From cb08008da5e4a514d7b4784cbaf599ac119376ff Mon Sep 17 00:00:00 2001
> From: Felipe Balbi <felipe.balbi@nokia.com>
> Date: Thu, 3 Apr 2008 14:35:33 +0300
> Subject: [PATCH] USB: MUSB: Be sure that we enable musb->clock
> 
> If CONFIG_OMAP_RESET_CLOCKS is enabled, musb->clock would
> be disabled because nobody was enabling it.
> 
> Be sure that omap2430.c enables musb->clock to avoid problems
> later.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/usb/musb/omap2430.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 8041dde..c21d93a 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -246,6 +246,9 @@ int __init musb_platform_init(struct musb *musb)
>  
>  int musb_platform_suspend(struct musb *musb)
>  {
> +	if (!musb->clock)
> +		return 0;
> +
>  	/* in any role */
>  	OTG_FORCESTDBY_REG &= ~ENABLEFORCE; /* disable MSTANDBY */
>  	OTG_SYSCONFIG_REG &= FORCESTDBY;	/* enable force standby */
> @@ -257,14 +260,27 @@ int musb_platform_suspend(struct musb *musb)
>  	if (musb->xceiv.set_suspend)
>  		musb->xceiv.set_suspend(&musb->xceiv, 1);
>  
> +	if (musb->set_clock)
> +		musb->set_clock(musb->clock, 0);
> +	else
> +		clk_disable(musb->clock);
> +
>  	return 0;
>  }
>  
>  int musb_platform_resume(struct musb *musb)
>  {
> +	if (!musb->clock)
> +		return 0;
> +
>  	if (musb->xceiv.set_suspend)
>  		musb->xceiv.set_suspend(&musb->xceiv, 0);
>  
> +	if (musb->set_clock)
> +		musb->set_clock(musb->clock, 1);
> +	else
> +		clk_enable(musb->clock);
> +
>  	OTG_FORCESTDBY_REG &= ~ENABLEFORCE; /* disable MSTANDBY */
>  	OTG_SYSCONFIG_REG |= SMARTSTDBY;	/* enable smart standby */
>  	OTG_SYSCONFIG_REG &= ~AUTOIDLE;		/* disable auto idle */
> -- 
> 1.5.5.rc2.25.g5fbd
> 
> 
> 
> -- 
> 	- Balbi
