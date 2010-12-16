From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: RM-680: fix omap2_init_common_hw compile break
Date: Thu, 16 Dec 2010 10:27:55 -0800
Message-ID: <20101216182755.GI5941@atomide.com>
References: <1292520438-29122-1-git-send-email-omar.ramirez@ti.com>
 <20101216180514.GA31322@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:18721 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063Ab0LPS2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 13:28:07 -0500
Content-Disposition: inline
In-Reply-To: <20101216180514.GA31322@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101216 10:05]:
> On Thu, Dec 16, 2010 at 11:27:18AM -0600, Omar Ramirez Luna wrote:
> > diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
> > index 8ba4047..781ed25 100644
> > --- a/arch/arm/mach-omap2/board-am3517crane.c
> > +++ b/arch/arm/mach-omap2/board-am3517crane.c
> > @@ -47,7 +47,8 @@ static void __init am3517_crane_init_irq(void)
> >  	omap_board_config = am3517_crane_config;
> >  	omap_board_config_size = ARRAY_SIZE(am3517_crane_config);
> >  
> > -	omap2_init_common_hw(NULL, NULL);
> > +	omap2_init_common_infrastructure();
> > +	omap2_init_common_devices(NULL, NULL);
> >  	omap_init_irq();
> 
> Once I have the init_early() sorted, hopefully most of the abuse in
> these callbacks can be moved into the init_early() callback.

Sounds good to me.

Thanks,

Tony
