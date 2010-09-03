From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
 testing
Date: Fri, 3 Sep 2010 18:01:19 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75CA@dbde02.ent.ti.com>
References: <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com> <20100902161846.GK11597@atomide.com>
 <20100902170830.GW26319@n2100.arm.linux.org.uk>
 <20100902174244.GU11597@atomide.com> <20100902192659.GW11597@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A8@dbde02.ent.ti.com>
 <004d01cb4b62$d49c91a0$7dd5b4e0$@deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52717 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756446Ab0ICMbs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 08:31:48 -0400
In-Reply-To: <004d01cb4b62$d49c91a0$7dd5b4e0$@deacon@arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: Friday, September 03, 2010 5:54 PM
> To: Shilimkar, Santosh; Tony Lindgren; Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Bryan Wu
> Subject: RE: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
> testing
> 
> Santosh,
> 
> > diff --git a/arch/arm/include/asm/smp_plat.h
> b/arch/arm/include/asm/smp_plat.h
> > index 8db3512..82bc488 100644
> > --- a/arch/arm/include/asm/smp_plat.h
> > +++ b/arch/arm/include/asm/smp_plat.h
> > @@ -39,4 +39,11 @@ static inline int cache_ops_need_broadcast(void)
> >  #define UP(instr...)	_str(instr)
> >  #endif
> >
> > +static inline int smp_cpu(void)
> > +{
> > +        u32 mpidr;
> > +        asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
> > +        return (mpidr >> 31) ? !(mpidr >> 30) : 0;
> > +}
> > +
> > Will this be called on UP machines ?? if yes, then mpidr register is not
> > available on those
> 
> The multiprocessor affinity register (MPIDR) is defined as part of ARMv7.
> ARM recommends that it returns 0 on UP systems. If bit 31 is set, then the
> multiprocessing extensions are available.
> 
I might be wrong but  didn't find this register on Cortex-A8(ARMv7).

> The quirk (as discussed early) is that that 11MPCore has the CPUID
> register
> at this location in the coprocessor space, with bit 31 set to 0. This
> means
> that we have to check for it explicitly otherwise we will identify it as a
> UP machine.
> 
> Will
> 

