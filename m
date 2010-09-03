From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init
 testing
Date: Fri, 3 Sep 2010 17:39:52 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A2@dbde02.ent.ti.com>
References: <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com> <20100902161846.GK11597@atomide.com>
 <20100902170830.GW26319@n2100.arm.linux.org.uk>
 <20100902174244.GU11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43559 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab0ICMKs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 08:10:48 -0400
In-Reply-To: <20100902174244.GU11597@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, September 02, 2010 11:13 PM
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Bryan Wu; Will Deacon
> Subject: Re: [PATCH 1/6] ARM: Add inline function smp_on_up() for early
> init testing
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 10:00]:
> > On Thu, Sep 02, 2010 at 09:18:47AM -0700, Tony Lindgren wrote:
> >
> > > --- a/arch/arm/include/asm/smp_plat.h
> > > +++ b/arch/arm/include/asm/smp_plat.h
> > > @@ -39,4 +39,20 @@ static inline int cache_ops_need_broadcast(void)
> > >  #define UP(instr...)	_str(instr)
> > >  #endif
> > >
> > > +static inline int smp_on_up(void)
> > > +{
> > > +#ifdef CONFIG_SMP_ON_UP
> > > +	int smp_on_up;
> > > +
> > > +	asm(							\
> > > +		SMP(mov	%0, #0)					\
> > > +		UP(mov	%0, #1)					\
> > > +		: "=r" (smp_on_up));
> > > +
> > > +	return smp_on_up;
> > > +#else
> > > +	return 0;
> > > +#endif
> >
> > I think this is the wrong approach - rather than a function which tells
> us
> > just if we are a SMP kernel running on UP, why not something which
> returns
> > whether we're running on SMP and use that to eliminate some of these
> ifdefs?
> 
> Sure. Will has something like this in his patches:
> 
> static inline int cpu_is_part_of_mp_system(void)
> {
> 	u32 mpidr;
> 	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
> 	return (mpidr >> 31) ? !(mpidr >> 30) : 0;
> }

I guess this register is only available on MP Core extensions.

Regards,
Santosh
