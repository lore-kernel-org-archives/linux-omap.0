From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] Export notifier register functions for kernel module
 building
Date: Tue, 24 Mar 2009 03:28:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903240326330.8255@utopia.booyaka.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C1020@dbde02.ent.ti.com> <878wobpmwb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59207 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868AbZCXJ2P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 05:28:15 -0400
In-Reply-To: <878wobpmwb.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Kevin, Ramesh,

On Thu, 12 Feb 2009, Kevin Hilman wrote:

> "Gupta, Ramesh" <grgupta@ti.com> writes:
> 
> > This Patch exports symbols clk_notifier_register/unregister
> > function for other kernel modules usage.
> >
> > Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> 
> Thanks, pushed to PM branch.

As an aside, this patch should be reverted.  DSPBridge and other drivers 
needing clock notifiers should pass function pointers to 
clk_notifier_{register,unregister}() in their struct platform_data, rather 
than exporting those symbols.  This will keep the drivers 
platform-agnostic, since system-wide clock notifiers are not yet upstream.

regards,

- Paul

> > ---
> >  arch/arm/plat-omap/clock.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> > index e0940a1..c8d9e96 100644
> > --- a/arch/arm/plat-omap/clock.c
> > +++ b/arch/arm/plat-omap/clock.c
> > @@ -680,6 +680,7 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb)
> >  
> >  	return r;
> >  }
> > +EXPORT_SYMBOL(clk_notifier_register);
> >  
> >  /**
> >   * clk_notifier_unregister - remove a clock change notifier
> > @@ -735,6 +736,7 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
> >  
> >  	return r;
> >  }
> > +EXPORT_SYMBOL(clk_notifier_unregister);
> >  
> >  
> >  
> > -- 
> > 1.5.3.2
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


