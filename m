From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 20/23] twl4030-gpio: irq and other cleanup
Date: Tue, 30 Sep 2008 03:39:01 +0300
Message-ID: <20080930003900.GK2445@frodo>
References: <1222707783-18936-1-git-send-email-me@felipebalbi.com> <1222707783-18936-20-git-send-email-me@felipebalbi.com> <1222707783-18936-21-git-send-email-me@felipebalbi.com> <200809291730.46154.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58061 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbYI3AjM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 20:39:12 -0400
Content-Disposition: inline
In-Reply-To: <200809291730.46154.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Mon, Sep 29, 2008 at 05:30:45PM -0700, David Brownell wrote:
> This update (to this patch) resolves that problem ... please
> merge this into the next version.
> --- beagle.orig/drivers/gpio/twl4030-gpio.c	2008-09-29 17:19:37.000000000 -0700
> +++ beagle/drivers/gpio/twl4030-gpio.c	2008-09-29 17:16:04.000000000 -0700
> @@ -41,9 +41,22 @@
>  #include <linux/i2c/twl4030-gpio.h>
>  
>  
> +static inline void activate_irq(int irq)
> +{
> +#ifdef CONFIG_ARM
> +	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
> +	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
> +	 */
> +	set_irq_flags(irq, IRQF_VALID);
> +#else
> +	/* same effect on other architectures */
> +	set_irq_noprobe(irq);
> +#endif
> +}

couldn't this be done by set_type() so you could use
set_irq_type(irq, IRQF_VALID); ?

i'm merging this already

-- 
balbi
