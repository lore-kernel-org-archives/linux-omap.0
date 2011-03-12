From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Fri, 11 Mar 2011 16:03:03 -0800
Message-ID: <87d3lx5hoo.fsf@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
	<1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
	<87oc5ifu12.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037A4DD948@dbde02.ent.ti.com>
	<20110311191324.GE10079@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49647 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269Ab1CLADH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 19:03:07 -0500
Received: by mail-yw0-f45.google.com with SMTP id 41so1653659ywl.4
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 16:03:06 -0800 (PST)
In-Reply-To: <20110311191324.GE10079@atomide.com> (Tony Lindgren's message of
	"Fri, 11 Mar 2011 11:13:24 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110310 20:18]:
>> > From: Hilman, Kevin
>> > 
>> > I guess Tony has the final say here, but personally, I don't really like
>> > the special treatment of a system timer, unless it is an init-time only
>> > special treatment.  Since we now have dynamically configurable
>> > clocksources, the concept of a system timer doesn't really exist (except
>> > for in early boot.)  At any time during runtime, we could dynamically
>> > switch the clocksource to a different timer device.  At this point, one
>> > would expect runtime PM for the previous timer to kick in and idle the
>> > timer.  That cannot happen with this approach.
>>
>> I am open to suggestions.
>
> There's no need to dynamically change the clocksource. We can to set up
> things so we have a system timer running with minimal code and faster
> clock rate. Then we can use a separate timer with the 32KiHZ source
> just to provide wake-up events for idle modes. And this second wake-up
> timer can be just a regular device driver.
>
> The system timer code needs to be fast. And I don't want to add any
> dependencies to anything except clock framework. Like I've said, the
> rest of the timers can be just a regular device driver.

There are a couple problems with this approach.  The special case
handling of a "system" timer leads to duplicate code (this series is a
good example.)

The other problem is PM.

If we switch away from the original system timer (for whatever reason),
since it is not a regular device, it will not have runtime PM We'll then
need special case PM code for the system timer, which I think is wasted
effort.

If this can be done such that the system timer is eventually a regular
device driver, then that should be fine. 

Kevin

> I'll post some patches after the merge window for the system timer
> related code.
>
> Regards,
>
> Tony
