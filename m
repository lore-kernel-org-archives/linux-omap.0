From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt
 handlers
Date: Thu, 7 Oct 2010 13:35:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010071318570.1753-100000@iolanthe.rowland.org>
References: <87aamqaqt9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51705 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751309Ab0JGRfU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 13:35:20 -0400
In-Reply-To: <87aamqaqt9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Thu, 7 Oct 2010, Kevin Hilman wrote:

> My confusion is not about the use of spinlocks, it's a question of what
> is being busy-waited for, and the thread that is being waited for is
> going to complete when interrupts are disabled.
> 
> Sorry to be dense, but can you (re)summarize what you're proposing as I
> think I'm getting mixed up with all the various options we've been
> tossing around.
> 
> If it can work, I'm certainly in favor of a busy-wait approach as it 
> really ensures that sync requests are handled quickly.

Okay, here's the story in a nutshell.  Allowing a subsystem's or
driver's runtime-PM callbacks to run with interrupts disabled faces two
obstacles:

   (1): We don't want two different CPUs to run callbacks for the
	same device at the same time.  So if a callback is already
	running on one CPU (i.e., if the device's runtime status is
	either SUSPENDING or RESUMING) then another CPU can't be
	allowed to invoke a callback.

	Thus, you can't do a synchronous pm_runtime_resume_irq()
	if the device is in the middle of a suspend or resume
	operation.  We're left with two choices: Fail the synchronous
	call and force the driver to defer matters to a workqueue
	(possibly masking an IRQ line in the meantime), or busy-wait
	until the concurrent operation finishes.

	If the PM core simply avoids releasing dev->power.lock before
	invoking the runtime_suspend or runtime_resume callback, the
	end result is almost the same as with busy-waiting.

   (2): In general we can't resume a device if its parent is suspended.
	If the parent's runtime_resume routine needs to run with
	interrupts enabled then there's no way to resume the device
	while keeping interrupts disabled.

	Possible solutions involve, again, deferring matters to a
	workqueue, or else simply not allowing the situation to arise
	in the first place (forbid a device to have interrupt-disabled 
	callbacks unless its parent does too or the parent doesn't use 
	runtime PM at all).

In general I'm against the solutions that require a workqueue.  Raphael 
appears to favor workqueues for (1) and be against them for (2).

Alan Stern

