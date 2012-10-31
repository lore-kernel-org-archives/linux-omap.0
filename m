From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] ARM: OMAP: Move omap-pm-noop.c local to
 mach-omap2
Date: Wed, 31 Oct 2012 16:11:15 -0700
Message-ID: <20121031231115.GG15766@atomide.com>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
 <20121030235255.25936.36727.stgit@muffinssi.local>
 <20121031205850.GO12739@atomide.com>
 <1654531.W5JISgHidu@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:55410 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753705Ab2JaXLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 19:11:23 -0400
Content-Disposition: inline
In-Reply-To: <1654531.W5JISgHidu@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, Mauro Carvalho Chehab <mchehab@infradead.org>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121031 16:03]:
> Hi Tony,
> 
> On Wednesday 31 October 2012 13:58:50 Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [121030 16:55]:
> > > This code should be private to mach-omap2.
> > > 
> > > The only use for it in for omap1 has been in dmtimer.c
> > > to check for context loss. However, omap1 does not
> > > lose context during idle, so the code is not needed.
> > > Further, omap1 timer has OMAP_TIMER_ALWON set, so omap1
> > > was not hitting omap_pm_get_dev_context_loss_count()
> > > test.
> > 
> > Noticed one issue with my test compiles in the
> > omap-for-v3.8/cleanup-headers branch that can be
> > fixed along with this patch.
> > 
> > --- a/drivers/media/platform/omap3isp/ispvideo.c
> > +++ b/drivers/media/platform/omap3isp/ispvideo.c
> > @@ -36,7 +36,6 @@
> >  #include <media/v4l2-ioctl.h>
> >  #include <plat/iommu.h>
> >  #include <plat/iovmm.h>
> > -#include <plat/omap-pm.h>
> 
> The reason this was included was to call omap_pm_set_min_bus_tput() in earlier 
> versions of the driver. We'll have to discuss what to replace that with, but 
> that's another topic.

OK thanks.

> > > @@ -730,6 +732,7 @@ static int __devinit omap_dm_timer_probe(struct
> > > platform_device *pdev)> 
> > >  	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
> > >  	timer->pdev = pdev;
> > >  	timer->capability = pdata->timer_capability;
> > > 
> > > +	timer->get_context_loss_count = pdata->get_context_loss_count;
> > > 
> > >  	/* Skip pm_runtime_enable for OMAP1 */
> > >  	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
> > > 
> > > diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h
> > > b/arch/arm/plat-omap/include/plat/dmtimer.h index 85868e9..3f5b9cf 100644
> > > --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> > > +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> > > @@ -94,6 +94,7 @@ struct dmtimer_platform_data {
> > > 
> > >  	/* set_timer_src - Only used for OMAP1 devices */
> > >  	int (*set_timer_src)(struct platform_device *pdev, int source);
> > >  	u32 timer_capability;
> > > 
> > > +	int (*get_context_loss_count)(struct device *);
> 
> That's a step forward for the common zImage, but one step backward for DT 
> support :-) I'm fine with this for now, but do you already have an idea on how 
> to solve that ?

When it's converted to be a device driver, it can do it
using runtime PM calls.

Regards,

Tony
