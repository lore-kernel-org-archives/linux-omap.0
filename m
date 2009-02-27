From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 07/13] ARM: OMAP: No need to include
	board-omap2430sdp.h from hardware.h
Date: Fri, 27 Feb 2009 02:13:54 +0200
Message-ID: <20090227001354.GF6070@gandalf>
References: <20090226235042.20192.38338.stgit@localhost> <20090227000115.20192.14200.stgit@localhost>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59381 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbZB0AOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 19:14:12 -0500
Content-Disposition: inline
In-Reply-To: <20090227000115.20192.14200.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Nothing to do with this patch in particular, but...

On Thu, Feb 26, 2009 at 04:01:15PM -0800, Tony Lindgren wrote:
> @@ -102,8 +105,8 @@ static struct resource sdp2430_smc91x_resources[] = {
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start	= OMAP_GPIO_IRQ(OMAP24XX_ETHR_GPIO_IRQ),
> -		.end	= OMAP_GPIO_IRQ(OMAP24XX_ETHR_GPIO_IRQ),
> +		.start	= OMAP_GPIO_IRQ(SDP2430_ETHR_GPIO_IRQ),
> +		.end	= OMAP_GPIO_IRQ(SDP2430_ETHR_GPIO_IRQ),
>  		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,

normally we only pass start and this should probably be using
gpio_to_irq(), but for that...

>  	},
>  };
> @@ -170,13 +173,13 @@ static inline void __init sdp2430_init_smc91x(void)
>  	sdp2430_smc91x_resources[0].end = cs_mem_base + 0x30f;
>  	udelay(100);
>  
> -	if (gpio_request(OMAP24XX_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
> +	if (gpio_request(SDP2430_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
>  		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
> -			OMAP24XX_ETHR_GPIO_IRQ);
> +			SDP2430_ETHR_GPIO_IRQ);
>  		gpmc_cs_free(eth_cs);
>  		goto out;
>  	}
> -	gpio_direction_input(OMAP24XX_ETHR_GPIO_IRQ);
> +	gpio_direction_input(SDP2430_ETHR_GPIO_IRQ);

we should probably add:

sdp2430_scm91x_resources[1].start = gpio_to_irq(OMAP24XX_ETHER_GPIO_IRQ);

here

-- 
balbi
