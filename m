From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Fri, 11 Mar 2011 11:13:24 -0800
Message-ID: <20110311191324.GE10079@atomide.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
 <87oc5ifu12.fsf@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD948@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11359 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab1CKTNZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 14:13:25 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD948@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110310 20:18]:
> > From: Hilman, Kevin
> > 
> > I guess Tony has the final say here, but personally, I don't really like
> > the special treatment of a system timer, unless it is an init-time only
> > special treatment.  Since we now have dynamically configurable
> > clocksources, the concept of a system timer doesn't really exist (except
> > for in early boot.)  At any time during runtime, we could dynamically
> > switch the clocksource to a different timer device.  At this point, one
> > would expect runtime PM for the previous timer to kick in and idle the
> > timer.  That cannot happen with this approach.
>
> I am open to suggestions.

There's no need to dynamically change the clocksource. We can to set up
things so we have a system timer running with minimal code and faster
clock rate. Then we can use a separate timer with the 32KiHZ source
just to provide wake-up events for idle modes. And this second wake-up
timer can be just a regular device driver.

The system timer code needs to be fast. And I don't want to add any
dependencies to anything except clock framework. Like I've said, the
rest of the timers can be just a regular device driver.

I'll post some patches after the merge window for the system timer
related code.

Regards,

Tony
