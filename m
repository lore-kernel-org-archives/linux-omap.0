From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Sat, 19 Mar 2011 10:04:04 +0530
Message-ID: <b65bf7960033964fba8f03e774b46905@mail.gmail.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-5-git-send-email-tarun.kanti@ti.com> <87oc5ifu12.fsf@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD948@dbde02.ent.ti.com>
 <20110311191324.GE10079@atomide.com> <87d3lx5hoo.fsf@ti.com>
 <20110314171240.GB7258@atomide.com> <8762rhtnje.fsf@ti.com> <20110319002719.GF18583@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:58029 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183Ab1CSEeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Mar 2011 00:34:09 -0400
Received: by mail-yx0-f182.google.com with SMTP id 31so2502151yxl.27
        for <linux-omap@vger.kernel.org>; Fri, 18 Mar 2011 21:34:07 -0700 (PDT)
In-Reply-To: <20110319002719.GF18583@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Saturday, March 19, 2011 5:57 AM
> To: Kevin Hilman
> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org; Gopinath,
> Thara
> Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform
> devices
>
> * Kevin Hilman <khilman@ti.com> [110317 14:58]:
> > Tony Lindgren <tony@atomide.com> writes:
> > >
> > > In the long run, think "local timer" for runtime, and then
> > > "wakeup timer" that gets only programmed when we enter idle.
> > >  The "local timer" will continue operating normally after we
> > > wake-up and the "wakeuptimer" will be just one shot event.
> > > Of course in the omap[23] case the "local timer" is really a
> > > there's are real local timers.

This is already the case for OMAP4 with PM series. But it doesn't
work the way it is stated above. Wakeup timer is always programmed
and kept handy by the timer framework because switching of
clock event happened dynamically and it's too late to reprogram
the next timer expiry etc. What framework does, is just switch
the clock-event to wakeup capable clock-event.

> > >> If this can be done such that the system timer is eventually a
> > >> regular device driver, then that should be fine.
> > >
> > > In this setup there should not be need to mess with the system
> > > timer  after boot as we don't need to switch clock sources.
> >
> > I think we're confusing terminology.  By system timer, I think you
> > mean the clockevent, right?
>
> Yes.
>
> > The situation you described above requires switching clockevents
> > for sure.
>
> No it won't, because we can use a separate physical timer for
> runtime and wake-up events.
>
Why do you want to waste one timer hardware for this purpose
alone especially when generic framework has a support?

> > In addition, we already have a usecase for switching the
> > clocksource as well.  We currently setup a single clocksource
> > (not using the timer_32ka dmtimer.)  However, we already have
> > use-cases where we would like to switch to a higher resolution
> > clocksource (e.g. trace infrastructure for PM instrumentation.)
>
I agree with Kevin. Infact I tried prototyping this one. Clock-event
switching works seamlessly. Clock-source switching though isn't
supported yet by generic timer framework.

> Again that can be done with a separate physical timer, no need to
> switch and reprogram the clocksource.
>
If this can done via existing timer framework, I don't see point
wasting another physical timer for this.

I agree your basic point of making clock-source and clock-event
not depend on any frameworks. This is probably essential
considering any generic kernel changes can impact these. Recent
early_init() was a good example. May be I hold on my comments
since you plan to do some patches for system timer handling.

Regards,
Santosh
