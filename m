From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt
 handlers
Date: Thu, 7 Oct 2010 11:26:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010071048100.1753-100000@iolanthe.rowland.org>
References: <201010062347.18232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40303 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751172Ab0JGP04 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 11:26:56 -0400
In-Reply-To: <201010062347.18232.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Wed, 6 Oct 2010, Rafael J. Wysocki wrote:

> Defer the resume.  That's the only thing you can do in any case, whether you're
> going to busy loop or just use a workqueue.

They are not the same.  With a busy-wait you handle the device as soon
as possible, before the interrupt routine returns.  With a workqueue
you have to mask the entire IRQ line, possibly losing interrupt
requests from other devices, until the workqueue routine can run.

> > On the whole, I don't see any striking reason for the PM core not to 
> > busy-wait during a concurrent state change.
> 
> I do.  That shouldn't happen in a fast path and we're talking about one,
> aren't we?  Besides, I don't like busy waiting as a rule.

On Wed, 6 Oct 2010, Kevin Hilman wrote:

> Not sure I follow where you're going with this last paragraph.  Of
> course, calls from ISR context cannot busy wait.

What do you guys think spin_lock() does?  It busy-waits until the lock 
is free!  If you don't like busy-waiting then you don't like spinlocks, 
and if you believe ISR's can't busy-wait then you believe they can't 
acquire spinlocks.  :-)

Really, what I'm talking about is not much different from continuing to
hold dev->power.lock across the runtime_resume and runtime_suspend
callbacks.  Would you prefer to do that instead of explicitly
busy-waiting?  There would be two disadvantages.  First, the
runtime_suspend routine would not be able to call pm_request_idle() or
pm_schedule_suspend() and then return -EBUSY.  Second, if the driver
uses a private lock then the callback routines might not be able to
acquire it.

On Wed, 6 Oct 2010, Rafael J. Wysocki wrote:

> Overall, we seem to have a corner case to cover and we're considering doing
> intrusive changes to the framework because of that, even though that changes
> may not be really necessary in practice.  I think we should focus more on the
> corner case instead.

I'm not sure what you mean.

Alan Stern

