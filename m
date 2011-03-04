From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 12/17] omap4: pm-debug: Add wakeup timer and debug counters
Date: Fri, 4 Mar 2011 11:56:14 +0530
Message-ID: <1c3ccfb8a595872402365368986e03ea@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-13-git-send-email-santosh.shilimkar@ti.com><87hbbl2l1y.fsf@ti.com><ff69224b634bfd89405d29a720755b64@mail.gmail.com>
 <87r5aoqgls.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54593 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751411Ab1CDG0Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 01:26:16 -0500
Received: by mail-qy0-f169.google.com with SMTP id 2so630723qyk.14
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 22:26:15 -0800 (PST)
In-reply-to: <87r5aoqgls.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 10:36 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 12/17] omap4: pm-debug: Add wakeup timer and
> debug counters
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@ti.com]
> >> Sent: Thursday, March 03, 2011 4:21 AM
> >> To: Santosh Shilimkar
> >> Cc: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> >> Subject: Re: [PATCH 12/17] omap4: pm-debug: Add wakeup timer and
> >> debug counters
> >>
> >> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> >>
> >> > This patch adds configurable wakeup timer support in suspend.
> Also
> >> > for statistics pm counter support is added.
> >> >
> >> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> >> > ---
> >> >  arch/arm/mach-omap2/omap4-mpuss-lowpower.c |    8 ++++++++
> >> >  arch/arm/mach-omap2/pm-debug.c             |    6 ++++--
> >> >  arch/arm/mach-omap2/pm44xx.c               |    5 +++++
> >> >  3 files changed, 17 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> >> b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> >> > index ab2e101..5e0141e 100644
> >> > --- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> >> > +++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> >> > @@ -287,6 +287,10 @@ int omap4_enter_lowpower(unsigned int cpu,
> >> unsigned int power_state)
> >> >  	if (cpu)
> >> >  		goto cpu_prepare;
> >> >
> >> > +#ifdef CONFIG_PM_DEBUG
> >> > +	pwrdm_pre_transition();
> >> > +#endif
> >>
> >> Why the #ifdef?
> >>
> > Because these stats updates are quite expensive
> > in low power code and for the production kernel
> > you don't need this extra penalty.
>
> OK, then please fix this in the powerdomain code (or header.)
>
The trace framework also plan to use it so putting power
domain APIs under PM_DEBUG won't be good idea. So I will drop
the #ifdef from this code then
