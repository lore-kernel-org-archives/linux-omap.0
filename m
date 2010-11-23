From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt handlers
Date: Tue, 23 Nov 2010 23:51:11 +0100
Message-ID: <201011232351.11340.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1011222204440.26293-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49265 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991Ab0KWWwC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 17:52:02 -0500
In-Reply-To: <Pine.LNX.4.44L0.1011222204440.26293-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Tuesday, November 23, 2010, Alan Stern wrote:
> On Tue, 23 Nov 2010, Rafael J. Wysocki wrote:
> 
> > > > Moreover, I'm not sure if we need an "IRQ safe" version of _idle.  Why do
> > > > we need it, exactly?
> > > 
> > > Because pm_runtime_put_sync() calls rpm_idle().  If there were no 
> > > irq-safe version of rpm_idle() then drivers wouldn't be able to call 
> > > pm_runtime_put_sync() from within an interrupt handler.
> > 
> > Right.  Which they can't do now, can they?
> 
> True.  That was the point of this patch -- to allow interrupt handlers
> to do runtime PM, which they can't do now.

The original idea was to allow suspend and resume to be carried out
with interrupts off, not necessarily by interrupt handlers.  We've never
considered doing that with _idle before.

> > Why do you think we should allow them to do that?
> 
> Are you suggesting that interrupt handlers stick to pm_runtime_suspend 
> and pm_runtime_resume, and ignore pm_runtime_get_sync and 
> pm_runtime_put_sync?

Why do they need the _sync versions?  What exactly is wrong with
calling

pm_runtime_put_noidle()
pm_runtime_suspend()

from an interrupt handler if it really wants the synchronous suspend to be
carried out at this point?

I don't really see a reason for calling pm_runtime_put_sync() by an interrupt
handler, but perhaps I'm overlooking something important.

> Recall that after probing is finished, the driver core does a
> pm_runtime_put_sync.  That might happen while an interrupt handler is
> running on another CPU.  If the interrupt handler didn't increment the
> usage_count, the driver core could cause the device to suspend while
> the interrupt handler was still using it.
> 
> Or are you suggesting that interrupt handlers use pm_runtime_get_sync 
> and implement a poor-man's version of pm_runtime_put_sync by doing:
> 
> 	pm_runtime_put_no_idle();
> 	pm_runtime_suspend();

Yes, I am.  Although simply calling pm_runtime_put() should work as well (yes,
the suspend won't occur immediately, but what's wrong with that?).

> Is there some particular reason for denying interrupt handlers the
> ability to use pm_runtime_put_sync?  It seems odd to disallow that 
> while allowing pm_runtime_get_sync.
> 
> Or maybe you think that when pm_runtime_put_sync detects the 
> usage_count has decremented to 0 and the device is irq-safe, it should 
> call rpm_suspend directly instead of calling rpm_idle?

That also would work for me, actually.

> In short, I don't see any reason not to present the same API to
> interrupt handlers for irq-safe devices as we present to
> process-context drivers for ordinary devices.
> 
> > Anyway, though, if the only reason of doing this is to allow interrupt handlers
> > to call pm_runtime_put_sync(), then I rather wouldn't do it at all.
> 
> Why not?

Because it's a fragile design with unusual behavior.  I'm pretty sure we'd see
some interesting abuse of it sooner or later. :-)

Thanks,
Rafael
