From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt
 handlers
Date: Mon, 22 Nov 2010 10:38:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011221027120.1758-100000@iolanthe.rowland.org>
References: <201011220041.06440.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34961 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751402Ab0KVPiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 10:38:14 -0500
In-Reply-To: <201011220041.06440.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Mon, 22 Nov 2010, Rafael J. Wysocki wrote:

> > > I didn't like this change before and I still don't like it.  Quite frankly, I'm
> > > not sure I can convince Linus to pull it. :-)
> > > 
> > > Why don't we simply execute the callback under the spinlock in the
> > > IRQ safe case?
> > 
> > Because it wouldn't work.  The job of the runtime_idle callback is to
> > call pm_runtime_suspend when needed.  But if the callback runs under
> > the spinlock then pm_runtime_suspend would hang when it tries to grab
> > the lock.
> 
> Yes, in the _idle case.  I actually should have put my comment under
> the change in rpm_callback(), which is what I really meant.

But the new rpm_callback() _does_ simply execute the callback under the
spinlock in the irq-safe case.  So I don't understand what you mean
here.

> Moreover, I'm not sure if we need an "IRQ safe" version of _idle.  Why do
> we need it, exactly?

Because pm_runtime_put_sync() calls rpm_idle().  If there were no 
irq-safe version of rpm_idle() then drivers wouldn't be able to call 
pm_runtime_put_sync() from within an interrupt handler.


> The problem I have with this change is that switching interrupts off really is
> a part of the locking operation, so using spin_unlock() after spin_lock_irq...()
> is kind of like releasing the lock partially, which I don't think is valid
> (even if we're going to reacquire the lock immediately).

On the contrary; spin_unlock() after spin_lock_irq() doesn't partially
release the lock -- it releases the lock _entirely_!  :-)

Besides which, the existing code already releases the spinlock before 
making callbacks, so there should be no reason to worry about that 
issue.  The new code either:

	releases the spinlock but keeps interrupts disabled (in
	rpm_idle), or

	doesn't release the spinlock (in rpm_callback).

Either way, I should think you'd find the new code _less_ objectionable 
than the existing code, not _more_ objectionable.

Alan Stern

