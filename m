From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Fri, 18 Mar 2011 17:27:19 -0700
Message-ID: <20110319002719.GF18583@atomide.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
 <87oc5ifu12.fsf@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD948@dbde02.ent.ti.com>
 <20110311191324.GE10079@atomide.com>
 <87d3lx5hoo.fsf@ti.com>
 <20110314171240.GB7258@atomide.com>
 <8762rhtnje.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28269 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1CSA1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 20:27:22 -0400
Content-Disposition: inline
In-Reply-To: <8762rhtnje.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

* Kevin Hilman <khilman@ti.com> [110317 14:58]:
> Tony Lindgren <tony@atomide.com> writes:
> >
> > In the long run, think "local timer" for runtime, and then "wakeup timer"
> > that gets only programmed when we enter idle. The "local timer" will
> > continue operating normally after we wake-up and the "wakeup timer"
> > will be just one shot event. Of course in the omap[23] case the
> > "local timer" is really a faster dmtimer, but in the omap4+ case there's
> > are real local timers.
> 
> >> If this can be done such that the system timer is eventually a regular
> >> device driver, then that should be fine. 
> >
> > In this setup there should not be need to mess with the system timer
> > after boot as we don't need to switch clock sources.
> 
> I think we're confusing terminology.  By system timer, I think you mean
> the clockevent, right?

Yes.
 
> The situation you described above requires switching clockevents for
> sure.  

No it won't, because we can use a separate physical timer for runtime and
wake-up events.
 
> In addition, we already have a usecase for switching the clocksource as
> well.  We currently setup a single clocksource using the timer_32k (not
> a dmtimer.)  However, we already have use-cases where we would like to
> switch to a higher resolution clocksource (e.g. trace infrastructure for
> PM instrumentation.)

Again that can be done with a separate physical timer, no need to switch
and reprogram the clocksource.
 
> The whole point of switching these to real drivers is so they can use
> runtime PM.    Then, as soon as they are unused, runtime PM will kick in
> and ensure the hardware is properly idle.

Yes that makes sense for the device driver used timers and for the
wake-up timer.

Tony
