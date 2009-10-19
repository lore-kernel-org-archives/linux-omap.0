From: Tony Lindgren <tony@atomide.com>
Subject: Re: Bug on "omap: ioremap fixes for omap4"
Date: Mon, 19 Oct 2009 10:12:59 -0700
Message-ID: <20091019171259.GQ12576@atomide.com>
References: <A24693684029E5489D1D202277BE89444CEFF1AE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60941 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbZJSRM5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 13:12:57 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89444CEFF1AE@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [091019 08:54]:
> Tony, Santosh,
> 
> I think there's a missing fix in this commit:
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=041b80d9a00ab741ce50db92c84b6bed554fc3b6
> 
> Here:
> 
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> > index 50a62f2..4b644a9 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -60,9 +60,9 @@ static void __init gic_init_irq(void)
> >  	gic_dist_init(0, base, 29);
> >  
> >  	/* Static mapping, never released */
> > -	base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_256);
> > +	gic_cpu_base_addr = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
> >  	BUG_ON(!base);
> 
> Shouldn't it be:
> 
> 	BUG_ON(!gic_cpu_base_addr);
> 
> Instead?
> 
> > -	gic_cpu_init(0, OMAP44XX_GIC_CPU_BASE);
> > +	gic_cpu_init(0, gic_cpu_base_addr);
> >  }
> >  
> >  static void __init omap_4430sdp_init_irq(void)

Yeah thanks, I've posted a refreshed patch for that
and pushed the fix to linux-omap master and for-next
branches.

Regards,

Tony
