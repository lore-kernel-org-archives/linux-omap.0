From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface for interrupt handlers
Date: Tue, 23 Nov 2010 00:01:20 +0100
Message-ID: <201011230001.20241.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1011221027120.1758-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45835 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932166Ab0KVXCV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 18:02:21 -0500
In-Reply-To: <Pine.LNX.4.44L0.1011221027120.1758-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Monday, November 22, 2010, Alan Stern wrote:
> On Mon, 22 Nov 2010, Rafael J. Wysocki wrote:
> 
> > > > I didn't like this change before and I still don't like it.  Quite frankly, I'm
> > > > not sure I can convince Linus to pull it. :-)
> > > > 
> > > > Why don't we simply execute the callback under the spinlock in the
> > > > IRQ safe case?
> > > 
> > > Because it wouldn't work.  The job of the runtime_idle callback is to
> > > call pm_runtime_suspend when needed.  But if the callback runs under
> > > the spinlock then pm_runtime_suspend would hang when it tries to grab
> > > the lock.
> > 
> > Yes, in the _idle case.  I actually should have put my comment under
> > the change in rpm_callback(), which is what I really meant.
> 
> But the new rpm_callback() _does_ simply execute the callback under the
> spinlock in the irq-safe case.  So I don't understand what you mean
> here.

OK, sorry, I confused things.  I have no objections to this part, then, let's
focus on the _idle case.

> > Moreover, I'm not sure if we need an "IRQ safe" version of _idle.  Why do
> > we need it, exactly?
> 
> Because pm_runtime_put_sync() calls rpm_idle().  If there were no 
> irq-safe version of rpm_idle() then drivers wouldn't be able to call 
> pm_runtime_put_sync() from within an interrupt handler.

Right.  Which they can't do now, can they?

Why do you think we should allow them to do that?

> > The problem I have with this change is that switching interrupts off really is
> > a part of the locking operation, so using spin_unlock() after spin_lock_irq...()
> > is kind of like releasing the lock partially, which I don't think is valid
> > (even if we're going to reacquire the lock immediately).
> 
> On the contrary; spin_unlock() after spin_lock_irq() doesn't partially
> release the lock -- it releases the lock _entirely_!  :-)

Well, not really, as far as I understand it.  The semantics of spin_lock_irq()
is "turn interrupts off to prevent interrupt handlers running on _this_ CPU
from racing with us and acquire the lock to prevent _other_ CPUs from racing
with us".  If you build the code for non-SMP it becomes the first part only.
So IMO the "turn interrupts on/off" thing is a part of the full synchronization
mechanism in this case.

Anyway, though, if the only reason of doing this is to allow interrupt handlers
to call pm_runtime_put_sync(), then I rather wouldn't do it at all.

Thanks,
Rafael
