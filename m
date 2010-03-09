From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC part1/2 merge v3][PATCH 01/10] OMAP3: serial: Check for
 zero-based physical addr
Date: Tue, 9 Mar 2010 18:21:16 +0200
Message-ID: <20100309162115.GJ3851@gandalf>
References: <1268151414-17071-1-git-send-email-saaguirre@ti.com>
 <1268151414-17071-2-git-send-email-saaguirre@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39418 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899Ab0CIQVE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 11:21:04 -0500
Content-Disposition: inline
In-Reply-To: <1268151414-17071-2-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>

On Tue, Mar 09, 2010 at 10:16:45AM -0600, Sergio Aguirre wrote:
> @@ -664,6 +664,12 @@ void __init omap_serial_early_init(void)
>  		struct device *dev = &pdev->dev;
>  		struct plat_serial8250_port *p = dev->platform_data;
>  
> +		/* Don't map zero-based physical address */
> +		if (p->mapbase == 0) {
> +			printk(KERN_WARNING "omap serial: No physical address"
> +			       " for uart#%d, so skipping early_init...\n", i);
> +			continue;

you have a *dev available, could you use some of the dev_* macros ? Then
it's easy to know from where the message come from.

> @@ -727,6 +733,14 @@ void __init omap_serial_init_port(int port)
>  	pdev = &uart->pdev;
>  	dev = &pdev->dev;
>  
> +	/* Don't proceed if there's no clocks available */
> +	if (unlikely(!uart->ick || !uart->fck)) {
> +		printk(KERN_ERR "Can't init uart%d, no clocks available\n",
> +		       port);
> +		WARN_ON(1);

change printk() + WARN_ON() into:

WARN(1, "%s: can't init uart%d, no clocks available\n",
	koject_name(&dev->kobj), port);

-- 
balbi
