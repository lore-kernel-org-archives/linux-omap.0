From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module support
Date: Tue, 29 Mar 2011 11:19:07 +0530
Message-ID: <b2526277c81138b59e885999e2a91e1d@mail.gmail.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
 <1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com> <20110328205027.GC30616@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35451 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751598Ab1C2Fz0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 01:55:26 -0400
Received: by mail-gw0-f50.google.com with SMTP id 16so1448591gwj.9
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 22:55:25 -0700 (PDT)
In-Reply-To: <20110328205027.GC30616@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, March 29, 2011 2:20 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; rnayak@ti.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen
> module support
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110328 02:20]:
> > --- a/arch/arm/mach-omap2/omap4-common.c
> > +++ b/arch/arm/mach-omap2/omap4-common.c
> > @@ -21,6 +21,7 @@
> >
> >  #include <mach/hardware.h>
> >  #include <mach/omap4-common.h>
> > +#include <mach/omap-wakeupgen.h>
> >
> >  #ifdef CONFIG_CACHE_L2X0
> >  void __iomem *l2cache_base;
> > @@ -41,6 +42,8 @@ void __init gic_init_irq(void)
> >  	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
> >  	BUG_ON(!gic_cpu_base);
> >
> > +	omap_wakeupgen_init();
> > +
> >  	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
> >  }
>
> Do you really need to initialize all of this that early?
>
Yes. It's a interrupt controller extension and needs to work
together with GIC.
