From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Thu, 17 Mar 2011 15:00:53 -0700
Message-ID: <8762rhtnje.fsf@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
	<1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
	<87oc5ifu12.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037A4DD948@dbde02.ent.ti.com>
	<20110311191324.GE10079@atomide.com> <87d3lx5hoo.fsf@ti.com>
	<20110314171240.GB7258@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39496 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755682Ab1CQWA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 18:00:58 -0400
Received: by gxk23 with SMTP id 23so1730661gxk.14
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 15:00:57 -0700 (PDT)
In-Reply-To: <20110314171240.GB7258@atomide.com> (Tony Lindgren's message of
	"Mon, 14 Mar 2011 10:12:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110311 16:00]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110310 20:18]:
>> >> > From: Hilman, Kevin
>> >> > 
>> >> > I guess Tony has the final say here, but personally, I don't really like
>> >> > the special treatment of a system timer, unless it is an init-time only
>> >> > special treatment.  Since we now have dynamically configurable
>> >> > clocksources, the concept of a system timer doesn't really exist (except
>> >> > for in early boot.)  At any time during runtime, we could dynamically
>> >> > switch the clocksource to a different timer device.  At this point, one
>> >> > would expect runtime PM for the previous timer to kick in and idle the
>> >> > timer.  That cannot happen with this approach.
>> >>
>> >> I am open to suggestions.
>> >
>> > There's no need to dynamically change the clocksource. We can to set up
>> > things so we have a system timer running with minimal code and faster
>> > clock rate. Then we can use a separate timer with the 32KiHZ source
>> > just to provide wake-up events for idle modes. And this second wake-up
>> > timer can be just a regular device driver.
>> >
>> > The system timer code needs to be fast. And I don't want to add any
>> > dependencies to anything except clock framework. Like I've said, the
>> > rest of the timers can be just a regular device driver.
>> 
>> There are a couple problems with this approach.  The special case
>> handling of a "system" timer leads to duplicate code (this series is a
>> good example.)
>
> I think the related inline functions can be shared.
>  

The way it is currently coded results in duplicate code.  One of them
uses the clock API directly, the other uses runtime PM.

>> The other problem is PM.
>> 
>> If we switch away from the original system timer (for whatever reason),
>> since it is not a regular device, it will not have runtime PM We'll then
>> need special case PM code for the system timer, which I think is wasted
>> effort.
>
> This should not cause problems either, there should not be any need to
> switch the timers in the setup what I'm thinking.
>
> In the long run, think "local timer" for runtime, and then "wakeup timer"
> that gets only programmed when we enter idle. The "local timer" will
> continue operating normally after we wake-up and the "wakeup timer"
> will be just one shot event. Of course in the omap[23] case the
> "local timer" is really a faster dmtimer, but in the omap4+ case there's
> are real local timers.

>> If this can be done such that the system timer is eventually a regular
>> device driver, then that should be fine. 
>
> In this setup there should not be need to mess with the system timer
> after boot as we don't need to switch clock sources.

I think we're confusing terminology.  By system timer, I think you mean
the clockevent, right?

The situation you described above requires switching clockevents for
sure.  

In addition, we already have a usecase for switching the clocksource as
well.  We currently setup a single clocksource using the timer_32k (not
a dmtimer.)  However, we already have use-cases where we would like to
switch to a higher resolution clocksource (e.g. trace infrastructure for
PM instrumentation.)

The whole point of switching these to real drivers is so they can use
runtime PM.    Then, as soon as they are unused, runtime PM will kick in
and ensure the hardware is properly idle.

Kevin
