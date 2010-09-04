From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for
	multi-omap
Date: Sat, 4 Sep 2010 16:52:02 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE77A6@dbde02.ent.ti.com>
References: <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com> <20100902162337.GP11597@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE759D@dbde02.ent.ti.com>
 <20100904110512.GD12674@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45399 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab0IDLWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Sep 2010 07:22:25 -0400
In-Reply-To: <20100904110512.GD12674@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Saturday, September 04, 2010 4:35 PM
> To: Shilimkar, Santosh
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Bryan Wu; Will Deacon
> Subject: Re: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-
> omap
> 
> On Fri, Sep 03, 2010 at 05:36:27PM +0530, Shilimkar, Santosh wrote:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > > Sent: Thursday, September 02, 2010 9:54 PM
> > > To: Russell King - ARM Linux
> > > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > Bryan Wu; Will Deacon
> > > Subject: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-
> omap
> > >
> > > From c04a57fc3b41d886f56ccdc27cf9758de0c95202 Mon Sep 17 00:00:00 2001
> > > From: Tony Lindgren <tony@atomide.com>
> > > Date: Tue, 17 Aug 2010 13:33:23 +0300
> > > Subject: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-
> omap
> > >
> > > Fix SMP on UP interrupt handling for multi-omap
> > >
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  arch/arm/mach-omap2/omap-smp.c |   13 +++++++++----
> > >  arch/arm/mach-omap2/timer-gp.c |    7 +++++--
> > >  2 files changed, 14 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-
> omap2/omap-
> > > smp.c
> > > index 9e9f70e..a8bb49c 100644
> > > --- a/arch/arm/mach-omap2/omap-smp.c
> > > +++ b/arch/arm/mach-omap2/omap-smp.c
> > > @@ -22,6 +22,7 @@
> > >
> > >  #include <asm/cacheflush.h>
> > >  #include <asm/localtimer.h>
> > > +#include <asm/smp_plat.h>
> > >  #include <asm/smp_scu.h>
> > >  #include <mach/hardware.h>
> > >  #include <mach/omap4-common.h>
> > > @@ -114,11 +115,15 @@ void __init smp_init_cpus(void)
> > >  {
> > >  	unsigned int i, ncores;
> > >
> > > -	/* Never released */
> > > -	scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
> > > -	BUG_ON(!scu_base);
> > > +	if (smp_on_up()) {
> > > +		ncores = 1;
> > I am not sure if this is the correct approach. The SCU
> > hardware is not present other than OMAP4. So we should
> > just return here when the silicon is not omap4.
> > 	if (!cpu_is_omap44xx())
> > 		return -ENODEV;
> 
> void function returning a value?  Just a simple return statement will do.
Oh yes.
