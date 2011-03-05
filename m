From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v11 6/8] dmtimer: switch-over to platform device driver
Date: Sat, 5 Mar 2011 13:24:50 +0530
Message-ID: <8580fc0ccffe9e8da3c13fd89ba1c9df@mail.gmail.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-7-git-send-email-tarun.kanti@ti.com> <20110304172320.GY20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605AB@dbde02.ent.ti.com> <20110304193706.GF20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:59561 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750982Ab1CEHyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 02:54:52 -0500
Received: by qyk32 with SMTP id 32so1082856qyk.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 23:54:51 -0800 (PST)
In-Reply-To: <20110304193706.GF20560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Saturday, March 05, 2011 1:07 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v11 6/8] dmtimer: switch-over to platform device
> driver
>
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110304 10:50]:
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > Sent: Friday, March 04, 2011 10:53 PM
> > > To: DebBarma, Tarun Kanti
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH v11 6/8] dmtimer: switch-over to platform
> device
> > > driver
> > >
> > > * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110224 03:23]:
> > > > --- a/arch/arm/mach-omap2/dmtimer.c
> > > > +++ b/arch/arm/mach-omap2/dmtimer.c
> > > > @@ -197,3 +197,64 @@ static int __init omap_timer_init(struct
> omap_hwmod
> > > *oh, void *unused)
> > > >
> > > >  	return ret;
> > > >  }
> > > > +
> > > > +/**
> > > > + * omap2_dm_timer_early_init - top level early timer
> initialization
> > > > + * called in the last part of omap2_init_common_hw
> > > > + *
> > > > + * Uses dedicated hwmod api to parse through hwmod database
> for
> > > > + * given class name and then build and register the timer
> device.
> > > > + * At the end driver is registered and early probe initiated.
> > > > + */
> > > > +void __init omap2_dm_timer_early_init(void)
> > > > +{
> > > > +	int ret = omap_hwmod_for_each_by_class("timer",
> > > > +			omap_timer_init, NULL);
> > >
> > > Here we really only want to initialize the system timer. The
> rest we
> > > want to do later, so let's not init all of them early.
> > So, that is how it was at the beginning.
> > Later we realized different platforms can use different timers for
> this.
> > For example, beagle uses GPT12. Therefore, as part of one of the
> comments,
> > We decided to provide flexibility so that any of the timers could
> be used.
>
> You can still do it, just register the one that's being used and
> mark it reserved so it won't get initialized again later on.
>

I agree with Tony. We can still registers only the system
timer because the timer ID is known well before we do
initialization.
