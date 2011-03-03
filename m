From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 07/17] omap4: pm: CPU1 wakeup workaround form Low power modes
Date: Thu, 3 Mar 2011 21:45:02 +0530
Message-ID: <2438425cddc1f413357129985562ec74@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-8-git-send-email-santosh.shilimkar@ti.com>
 <87ipw15fh0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57538 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758292Ab1CCQPG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:15:06 -0500
Received: by qyk7 with SMTP id 7so1025522qyk.3
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 08:15:05 -0800 (PST)
In-reply-to: <87ipw15fh0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 3:54 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 07/17] omap4: pm: CPU1 wakeup workaround form
> Low power modes
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > The SGI(Software Generated Interrupts) are not wakeup capable from
> > low power states. This is known limitation on OMAP4 and needs to
> be
> > worked around by using software forced clockdomain wake-up. CPU0
> forces
> > the CPU1 clockdomain to software force wakeup. After the wakeup,
> CPU1
> > restores its clockdomain hardware supervised mode.
> >
> > More details can be found in OMAP4430 TRM - Version J
> > Section :
> > 	4.3.4.2 Power States of CPU0 and CPU1
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap-hotplug.c |    9 +++++++++
> >  arch/arm/mach-omap2/omap-smp.c     |   27
> ++++++++++++++++++++++++++-
> >  2 files changed, 35 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-
> omap2/omap-hotplug.c
> > index 9f8f097..cf4ab15 100644
> > --- a/arch/arm/mach-omap2/omap-hotplug.c
> > +++ b/arch/arm/mach-omap2/omap-hotplug.c
> > @@ -23,6 +23,7 @@
> >  #include <mach/omap-wakeupgen.h>
> >
> >  #include "powerdomain.h"
> > +#include "clockdomain.h"
> >
> >  int platform_cpu_kill(unsigned int cpu)
> >  {
> > @@ -36,6 +37,11 @@ int platform_cpu_kill(unsigned int cpu)
> >  void platform_cpu_die(unsigned int cpu)
> >  {
> >  	unsigned int this_cpu;
> > +	static struct clockdomain *cpu1_clkdm;
> > +
> > +	/* To avoid cpu1 clockdomain lookup every time */
>
> minor: comment doesn't really match code and could just be removed
>
Fixed
