From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 05/17] omap4: pm: Initialise all the clockdomains to
 supported states
Date: Thu, 3 Mar 2011 21:44:43 +0530
Message-ID: <e3449fa0a9fb4909fbfcc3a2ff57802d@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-6-git-send-email-santosh.shilimkar@ti.com>
 <87r5ap5fqg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50191 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755670Ab1CCQOp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:14:45 -0500
Received: by mail-qy0-f182.google.com with SMTP id 27so1077531qyk.13
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 08:14:45 -0800 (PST)
In-reply-to: <87r5ap5fqg.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 3:48 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Rajendra Nayak
> Subject: Re: [PATCH 05/17] omap4: pm: Initialise all the
> clockdomains to supported states
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > Initialise hardware supervised mode for all clockdomains if it's
> > supported. Initiate sleep transition for other clockdomains,
> > if they are not being used.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > ---
> >  arch/arm/mach-omap2/pm44xx.c |   22 +++++++++++++++++++++-
> >  1 files changed, 21 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-
> omap2/pm44xx.c
> > index b142673..9a9dc41 100644
> > --- a/arch/arm/mach-omap2/pm44xx.c
> > +++ b/arch/arm/mach-omap2/pm44xx.c
> > @@ -17,9 +17,11 @@
> >  #include <linux/slab.h>
> >  #include <plat/clock.h>
> >
> > -#include "powerdomain.h"
> >  #include <mach/omap4-common.h>
> >
> > +#include "powerdomain.h"
> > +#include "clockdomain.h"
> > +
> >  struct power_state {
> >  	struct powerdomain *pwrdm;
> >  	u32 next_state;
> > @@ -74,6 +76,22 @@ static const struct platform_suspend_ops
> omap_pm_ops = {
> >  };
> >  #endif /* CONFIG_SUSPEND */
> >
> > +/*
> > + * Enable hardwarew supervised mode for all clockdomains if it's
>
> typo: hardware
>
Fixed
