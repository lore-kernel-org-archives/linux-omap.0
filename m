From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Mon, 21 Mar 2011 11:33:56 -0700
Message-ID: <87sjuge31n.fsf@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
	<1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
	<87oc5ifu12.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037A4DD948@dbde02.ent.ti.com>
	<20110311191324.GE10079@atomide.com> <87d3lx5hoo.fsf@ti.com>
	<20110314171240.GB7258@atomide.com> <8762rhtnje.fsf@ti.com>
	<20110319002719.GF18583@atomide.com>
	<b65bf7960033964fba8f03e774b46905@mail.gmail.com>
	<20110321170758.GF2811@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53078 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754202Ab1CUSeE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 14:34:04 -0400
Received: by mail-iy0-f181.google.com with SMTP id 26so7433551iyb.12
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 11:34:02 -0700 (PDT)
In-Reply-To: <20110321170758.GF2811@atomide.com> (Tony Lindgren's message of
	"Mon, 21 Mar 2011 10:07:58 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110318 21:31]:
>> > * Kevin Hilman <khilman@ti.com> [110317 14:58]:
>> > > Tony Lindgren <tony@atomide.com> writes:
>> > > >
>> > > > In the long run, think "local timer" for runtime, and then
>> > > > "wakeup timer" that gets only programmed when we enter idle.
>> > > >  The "local timer" will continue operating normally after we
>> > > > wake-up and the "wakeuptimer" will be just one shot event.
>> > > > Of course in the omap[23] case the "local timer" is really a
>> > > > there's are real local timers.
>> 
>> This is already the case for OMAP4 with PM series. But it doesn't
>> work the way it is stated above. Wakeup timer is always programmed
>> and kept handy by the timer framework because switching of
>> clock event happened dynamically and it's too late to reprogram
>> the next timer expiry etc. What framework does, is just switch
>> the clock-event to wakeup capable clock-event.
>
> Hmm, the next_timer_interrupt gets called before we enter idle, is
> that what you mean maybe?
>
> Assuming so, to set up the wake-up timer we can read the programmed
> value from hardware to program the wake-up timer when entering
> suspend-idle or off-idle. That part can be done just fine with
> dmtimer framework.
>
> But in general, we don't really want to start changing the physical
> clock for WFI idle because of the time it takes to lock it. For
> retention-idle and off-idle, we have much more time. But in these
> case there's really no need to change the sources, all we care
> about is the physical timer wake-up event and can then restore the
> "local timer".
>  
>> Why do you want to waste one timer hardware for this purpose
>> alone especially when generic framework has a support?
>
> In this setup the additional wake-up timer is "only" needed in the
> retention-idle and off-idle cases.
>
> For keeping the wake-up timer separate, there are at least three
> reasons that I can think of:
>
> 1. We don't need to touch the clockevent and clocksource code
>    after init except to restore them when waking from retention-idle
>    or off-idle.
>
> 2. We don't need to initialize anything early for omaps except
>    clock framework to set up the clockevent and clocksource.
>
> 3. We can avoid switching the physical clock for the timer which
>    cuts down latencies at least for the basic WFI case.
>

Not sure I fully understand what you're proposing.  Maybe it's time to
see some patches.

What it sounds like you're proposing is to to have up to 3 physical
timers "reserved" and not managed by the dmtimer driver 1) clocksource
2) clockevent and 3) wakeup timer.

This sounds fine in theory, but I suspect it will lead to a couple
things that I don't like.  1) duplicated code that managages these
"reserved" timers and the dmtimer driver: init, read, (re)program,
reset, etc.  And 2) the "reserved" timers will have no PM, again, unless
the code is duplicated from the dmtimer driver.

Maybe I'm not fully understanding your proposal.  I'll wait until I see
patches.  The one thing I do like with the above approach, assuming I
understood it, is that the dmtimer driver would not need the support for
the "early" platform devices.  That is hacky, but frankly I prefer early
platform devices to what I understand above.


>> > > In addition, we already have a usecase for switching the
>> > > clocksource as well.  We currently setup a single clocksource
>> > > (not using the timer_32ka dmtimer.)  However, we already have
>> > > use-cases where we would like to switch to a higher resolution
>> > > clocksource (e.g. trace infrastructure for PM instrumentation.)
>> >
>> I agree with Kevin. Infact I tried prototyping this one. Clock-event
>> switching works seamlessly. Clock-source switching though isn't
>> supported yet by generic timer framework.
>
> Sure. We need to be able to change between the local timer and
> the dmtimer also, and I don't see how the current dmtimer series
> would make that any easier.
>  
>> > Again that can be done with a separate physical timer, no need to
>> > switch and reprogram the clocksource.
>> >
>> If this can done via existing timer framework, I don't see point
>> wasting another physical timer for this.
>
> In this setup we don't really need to do anything via existing timer
> framework, except to restore the clockevent and clocksource when
> waking up from retention-idle or off-idle.
>  
>> I agree your basic point of making clock-source and clock-event
>> not depend on any frameworks. This is probably essential
>> considering any generic kernel changes can impact these. Recent
>> early_init() was a good example. May be I hold on my comments
>> since you plan to do some patches for system timer handling.
>
> Yes, we need to cut down the early_init dependencies to minimum.
>
> The reason for that is that then we can initialize everything else
> that's omap specific in normal way much later than we do currently.
>
> For the timer, clock framework is essential to init early, but
> hwmod is not.

IMO, the hwmod for a given timer should be considered lower
level framework than the clock framework, and the hwmod for a timer
should be initialized before a timer is used for anything, including a
clocksource, clockevent etc.

Kevin

