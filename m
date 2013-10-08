From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V4] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ
 register
Date: Tue, 8 Oct 2013 14:45:23 -0700
Message-ID: <20131008214523.GU8313@atomide.com>
References: <1379520162-31932-1-git-send-email-r.sricharan@ti.com>
 <524D44B9.30208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34917 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755498Ab3JHVp3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 17:45:29 -0400
Content-Disposition: inline
In-Reply-To: <524D44B9.30208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, rnayak@ti.com, nm@ti.com, marc.zyngier@arm.com, mark.rutland@arm.com

* Sricharan R <r.sricharan@ti.com> [131003 03:27]:
> On Wednesday 18 September 2013 09:32 PM, Sricharan R wrote:
> > --- a/arch/arm/boot/dts/omap5.dtsi
> > +++ b/arch/arm/boot/dts/omap5.dtsi
> > @@ -52,7 +52,6 @@
> >  			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
> >  			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
> >  			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
> > -		clock-frequency = <6144000>;
> >  	};
> >  
> >  	gic: interrupt-controller@48211000 {

Can the above be done later on in a separate clean-up patch?
If so I can drop that part as that removes a dependency to the
.dts patches queued by Benoit.

> > --- a/arch/arm/mach-omap2/omap-smp.c
> > +++ b/arch/arm/mach-omap2/omap-smp.c
> > @@ -41,6 +41,8 @@
> >  
> >  u16 pm44xx_errata;
> >  
> > +extern unsigned long arch_timer_freq;
> > +
> >  /* SCU base address */
> >  static void __iomem *scu_base;
> >  

No externs in *.c files please, checkpatch.pl and sparse should warn
about this.

>  Are you planning to pull this patch and the below $subject patch as well? They are
>  acked and tested.
> 
>  ARM: DRA7: realtime_counter: Add ratio registers for 20MHZ sys-clk frequency
> 
>   http://www.spinics.net/lists/linux-omap/msg97281.html

The 20MHz patch I've applied, just noticed the above things
when was about to apply this.

Regards,

Tony
