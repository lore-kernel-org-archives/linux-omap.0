From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARM: smp: Allow real broadcast device selection
 instead of always dummy
Date: Wed, 13 Mar 2013 10:16:41 +0000
Message-ID: <20130313101641.GA13483@e106331-lin.cambridge.arm.com>
References: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com>
 <514046B6.9020005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42815 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755457Ab3CMKRJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 06:17:09 -0400
Content-Disposition: inline
In-Reply-To: <514046B6.9020005@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>

Hi Santosh,

On Wed, Mar 13, 2013 at 09:28:22AM +0000, Santosh Shilimkar wrote:
> (Forgot to CC Thomas)
> 
> On Wednesday 13 March 2013 02:36 PM, Santosh Shilimkar wrote:
> > With recent arm broadcast time clean-up from Mark Rutland, the dummy
> > broadcast device is always registered with timer subsystem. And since
> > the rating of the dummy clock event is very high, it is preferred
> > over a real broad-cast clock event.
> > 
> > This is a change in behavior from past and not an intended
> > one. So reduce the rating of the dummy clockevent so that
> > real broadcast device is selected when available.
> > 
> > Without this all the C states with C3STOP won't work since
> > the broad cast notifier will take an abort.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > Its a regression so hopefully can get into the 3.9-rcx. Noticed
> > this one on A15 platform. A9 platform the issue may not be seen
> > since the local timer check avoids dummy timer registration.
> > 
> Some one pointed me to a fix made by Mark which was discussed
> under '[BUG] ARM Architected timers appear broken in 3.9-rc1' subject.
> That patch seems to be more of work around since the root of the
> problem is incorrect dummy timer rating. Either way, both patches
> fix the issue.

Is the problem that the dummy timer is being registered as the broadcast
source, or that it is selected as a local timer in preference of real timers?

If it is the former, Then I believe my patch solve the issue more generally -
if you happen to register a dummy timer before other timers, it will become the
broadcast source. Regardless of how temporary this is, it should never happen,
and lowering the rating of the dummy won't fix this.

If it is the latter, then this patch would ensure that a real timer with a
rating over 100 is selected in preference to the dummy, which is certainly what
we want. The proposed generic dummy timer in Stephen Boyd's local timer API
removal series [1] similarly uses a low rating to ensure that real timers are
selected in preference to an always-registered dummy. I note that the
architected timer has a higher rating (450) than the dummy (400), so this
shouldn't currently be a problem.

Have I missed something?

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/153208.html

Thanks,
Mark.
