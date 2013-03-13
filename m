From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: smp: Allow real broadcast device selection
 instead of always dummy
Date: Wed, 13 Mar 2013 12:25:50 +0000
Message-ID: <20130313122550.GD13483@e106331-lin.cambridge.arm.com>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com>
 <514046B6.9020005@ti.com>
 <20130313101641.GA13483@e106331-lin.cambridge.arm.com>
 <514061D1.20603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:45654 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751901Ab3CMM0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 08:26:13 -0400
Content-Disposition: inline
In-Reply-To: <514061D1.20603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On Wed, Mar 13, 2013 at 11:24:01AM +0000, Santosh Shilimkar wrote:
> On Wednesday 13 March 2013 03:46 PM, Mark Rutland wrote:
> > Hi Santosh,
> > 
> > On Wed, Mar 13, 2013 at 09:28:22AM +0000, Santosh Shilimkar wrote:
> >> (Forgot to CC Thomas)
> >>
> >> On Wednesday 13 March 2013 02:36 PM, Santosh Shilimkar wrote:
> >>> With recent arm broadcast time clean-up from Mark Rutland, the dummy
> >>> broadcast device is always registered with timer subsystem. And since
> >>> the rating of the dummy clock event is very high, it is preferred
> >>> over a real broad-cast clock event.
> >>>
> >>> This is a change in behavior from past and not an intended
> >>> one. So reduce the rating of the dummy clockevent so that
> >>> real broadcast device is selected when available.
> >>>
> >>> Without this all the C states with C3STOP won't work since
> >>> the broad cast notifier will take an abort.
> >>>
> >>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> Cc: Russell King <linux@arm.linux.org.uk>
> >>>
> >>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>> ---
> >>> Its a regression so hopefully can get into the 3.9-rcx. Noticed
> >>> this one on A15 platform. A9 platform the issue may not be seen
> >>> since the local timer check avoids dummy timer registration.
> >>>
> >> Some one pointed me to a fix made by Mark which was discussed
> >> under '[BUG] ARM Architected timers appear broken in 3.9-rc1' subject.
> >> That patch seems to be more of work around since the root of the
> >> problem is incorrect dummy timer rating. Either way, both patches
> >> fix the issue.
> > 
> > Is the problem that the dummy timer is being registered as the broadcast
> > source, or that it is selected as a local timer in preference of real timers?
> >
> Dummy timer is preferred over real broadcast timer.

Ok.

>  
> > If it is the former, Then I believe my patch solve the issue more generally -
> > if you happen to register a dummy timer before other timers, it will become the
> > broadcast source. Regardless of how temporary this is, it should never happen,
> > and lowering the rating of the dummy won't fix this.
> > 
> Well by the time we need active broadcast functionality, clock-events are
> already chosen if the ratings are appropriate.

That's a fair point. I still think it's worth having the check in the core
broadcast code - rejecting dummy timers is always a sensible thing to do, and
it prevents future crashes if new timers are added without sensible rating
values.

> 
> > If it is the latter, then this patch would ensure that a real timer with a
> > rating over 100 is selected in preference to the dummy, which is certainly what
> > we want. The proposed generic dummy timer in Stephen Boyd's local timer API
> > removal series [1] similarly uses a low rating to ensure that real timers are
> > selected in preference to an always-registered dummy. I note that the
> > architected timer has a higher rating (450) than the dummy (400), so this
> > shouldn't currently be a problem.
> > 
> Because we always register dummy broadcast on ARM now 
> and with higher rating, it is picked as broadcast source. We definitely don't
> want such a behavior when we have real broadcast device is available.

Agreed. We *never* want to pick a dummy timer as a broadcast source, as this
never makes sense.

> With your patch, we are trying to avoid the registration which goes
> against the the whole idea of registering it always and picking
> the right clock-event based on rating by clock-event core.
> The clock-event core except the proper ratings to be provided based on
> the capability of the timer source and its resolution and in that case
> dummy should have the lowest rating which is what I tried to patch.
> 
> > Have I missed something?
> > 
> Not much. I was just looking at x86 code as well after your email
> to see how the LAPIC issue is handled. They seems to also have
> correct rating to take care of the selection.
> 
> Probably we can merge both the fixes but from clock-event core
> code perspective, the ratings fix is more than enough.

I do agree it'd be worth lowering the dummy timer's rating to ensure it doesn't
override a real timer elsewhere. 

Thomas has already pulled my fix into tip timers/urgent [1].

[1] https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/urgent&id=a7dc19b8652c862d5b7c4d2339bd3c428bd29c4a

Thanks,
Mark.
