From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 17 Jun 2011 00:30:26 +0200
Message-ID: <201106170030.26261.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106111227580.3439-100000@netrider.rowland.org> <201106160201.47123.rjw@sisk.pl> <87boxytw05.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35314 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256Ab1FPWaA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 18:30:00 -0400
In-Reply-To: <87boxytw05.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Thursday, June 16, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Wednesday, June 15, 2011, Kevin Hilman wrote:
> 
> [...]
> 
> >>
> >> From a device driver perspective, system PM is just runtime
> >> PM where the "idleness" was forced and only a subset of possible wakeup
> >> sources are enabled.
> >
> > Oh well, I wonder how much of a difference would make you think those things
> > are really different. ;-)
> 
> Seeing a description of the differences would help.  So far the list is
> rather short: wakeups and forcibly quieting the hardware.

Alan has given some more examples in his reply already, I don't think
I'd do it better. :-)

> I guess I still don't see why system PM cannot be viewed as a special
> case of runtime PM, so how about a specific question: From a device
> driver perspective, how is system PM anything other than
> manually/forcibly creating the right conditions for a runtime PM
> transition to happen?

Because it doesn't create those conditions?  It doesn't make runtime PM
usage counters magically drop to zero, for one example, and it can't do
that because of the user space part.

Still, I'm not saying you can't use the same _code_ for both runtime PM
and system suspend.  In the majority of cases this really is necessary to
avoid code duplication.  However, you really need not use the same callback
pointers to that code in both cases.  You may use common functions that will
be called by your .suspend() or .suspend_noirq() callbacks and by your
.runtime_suspend().  You may make .suspend_norq() and .runtime_suspend()
point to the same routine if that's suitable.  You don't necessarily have
to call pm_runtime_suspend() from your .suspend() callback to make that
code run and that applies to subsystems too.

As I said before, at one point we decided to use different PM callback
pointers for different purposes and that's why we have so many of them.
We could use multipurpose .suspend(dev, arg) instead, where arg would
determine the action to be taken (e.g. SYSTEM_SUSPEND, RUNTIME_SUSPEND etc.).
Now imagine we've done so and, at the subsystem level,
.suspend(dev, SYSTEM_SUSPEND) is called during system suspend by the PM core.
Suppose further that it calls a driver's .suspend(dev, SYSTEM_SUSPEND) and
that, in turn, does pm_runtime_suspend() which calls back to the very same
function it came from, but with different arg.  So we have:

subsys->suspend(dev, SYSTEM_SUSPEND)
    driver->suspend(dev, SYSTEMS_SUSPEND)
        subsys->suspend(dev, RUNTIME_SUSPEND)

So it effectively makes subsys->suspend() call itself recursively with
a different second argument without knowing that this is going to happen.
Do you still not see any problem with that?

There's more, though, because pm_runtime_suspend() not only invokes the
subsystem's callback, but also uses infrastructure that's designed to be
used in the system's working state, when user space is available and so on.
The state of the system during system suspend/resume is different however.

So, what I'm saying is that (1) calling things like pm_runtime_suspend()
from system suspend callbacks is pointless, because it doesn't guarantee
that the device will be really suspended, and unnecessary, because the
code it is supposed to invoke may be called into in a different way, and
(2) you can always design your subsystem-level code to make use of system
suspend callbacks in such a way that all of the necessary code will be
executed without calling pm_runtime_suspend() etc. from system suspend
callbacks.

It really doesn't matter that in your picture of the world system suspend
is a degenerate case of runtime PM, just because your model hardware
platform doesn't provide any "suspend the system" magic.  We have two
different frameworks for both and that's for a reason (there are platforms
where we need to use different hardware/firmware mechanisms in both cases)
and those frameworks are kind of mutually exclusive (i.e. you're not supposed
to use them both at the same time).  Nevertheless, you _can_ use the same
code, when necessary, in each case, but each case requires that code to be
called in a different way.

Thanks,
Rafael
