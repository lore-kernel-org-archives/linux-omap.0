From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fail to enter retention
Date: Tue, 18 Nov 2014 07:45:43 -0800
Message-ID: <20141118154543.GJ7046@atomide.com>
References: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
 <20141117162209.GE7046@atomide.com>
 <CAJ2oMh+t-Wahe=CTbrZQ=C2X-0n_x6FSzhwA6opyzhDFvJXdZg@mail.gmail.com>
 <20141117180944.GG7046@atomide.com>
 <CAJ2oMhL5x3nAxTQg36O9-DUfHK9iy-g9+qqN=bYj3Nw7HNjAnA@mail.gmail.com>
 <20141117203808.GH7046@atomide.com>
 <CAJ2oMhJxnRjb8NUz+JyYLJYiRBA+vSA3C2q7viEZf0sVXqFtqw@mail.gmail.com>
 <CAJ2oMhKPb-Hde--2WfQT=9U5r8XQUKo2UHHvsJ8D841zpMqLRA@mail.gmail.com>
 <CAJ2oMhJLo04q3Y48Q_f4VX=ew+tMJbBmY7toAODTsqbKRReHLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27519 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932123AbaKRPqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 10:46:04 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJLo04q3Y48Q_f4VX=ew+tMJbBmY7toAODTsqbKRReHLw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-omap@vger.kernel.org

* Ran Shalit <ranshalit@gmail.com> [141118 00:26]:
> 
> In coninuity to my previous message, thse is the log for time in state
> 0-state 6:
> 
> On Tue, Nov 18, 2014 at 10:21 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> >
> > When I try to do suspend from userspace, I get better results and it
> > seems that all domain been put to RET or OFF but on checking power
> > state time it still shows 0. Do you know why ?

Looks like you still have some hardware blocking off states. Maybe the
state time shows only that?

> >> Probably a dumb question... But if I try to print them won't it
> >> automatically wakes up the serial (by the way should the serial wakeup
> >> be configured to RX pin only ?)

Yes for the RX pin only as that's where the wake-up event comes from.

> >> Another thing I don't understand... Can it be that there is some
> >> ongoing kernel process that also prevent me for entering retention ?

Could be if you have something CPU intensive going on like tracing.

> >> I think maybe I should try first to suspend (instead of trying to
> >> enter retention in idle) , maybe it might bring better result ?

Yes from the hardware point of view suspend does the same thing as
the deeper idle states.

Regards,

Tony
