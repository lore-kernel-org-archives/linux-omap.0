From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Fri, 24 Sep 2010 11:13:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009241104540.1744-100000@iolanthe.rowland.org>
References: <8762xwnh00.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57439 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754181Ab0IXPNW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 11:13:22 -0400
In-Reply-To: <8762xwnh00.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Thu, 23 Sep 2010, Kevin Hilman wrote:

> Hello,
> 
> Looking for advice for a little runtime PM dilemma...
> 
> After some inactivity, a driver decides to supend iteslf using
> pm_runtime_put_sync().
> 
> The device is now suspended, it's ->runtime_suspend() method has
> disabled its clock, so its registers cannot be accessed anymore.
> 
> Now, as interrupts are still enabled, an interrupt for this device might
> still arrive.  For example, if this device is a wakeup source, its
> ->runtime_suspend() method may not have masked its interrupt.

Right.

> So, the IRQ fires, and the drivers ISR is called.  The driver wants to
> access the device registers, but since it has been runtime suspended,
> it's registers are not available.
> 
> The first reflex would be to simply do a pm_runtime_get_sync() in the
> ISR, however this is not safe if the ISR is an IRQs-disabled handler (as
> is the case for me, where the problematic handler is chained handler
> used for demuxing GPIO IRQs.)

An ISR shouldn't call pm_runtime_get_sync() in any case.

> So, what is the "right" thing to do here?

You should call pm_runtime_get(), turn off the interrupt source, and
return.  Then your resume routine should check for an outstanding
interrupt or wakeup request and handle it (the easiest way may be 
simply to call the ISR).

> A quick hack would be to for the drivers ISR to do a
> pm_runtime_get_noresume() and directly call the its ->runtime_resume()
> method, then do its normal stuff, followed by a pm_runtime_put() at the
> end of the ISR.
> 
> Is this an acceptable hack given that it's only needed for the
> increasingly rare cases of ISRs with interrupts disabled?
> 
> Or should we think of making a version of _get_sync() that is safe for
> IRQs disabled contexts like this where we know the device is already
> RPM_SUSPENDED?
> 
> Any advice appreciated...

You're trying to fight the runtime-PM design instead of using it as it 
was intended.  We already have an API for starting a resume from 
interrupt context, and that's what you should use.

Alan Stern

