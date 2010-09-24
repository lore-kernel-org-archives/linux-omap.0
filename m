From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Fri, 24 Sep 2010 16:27:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009241547010.1287-100000@iolanthe.rowland.org>
References: <87ocbnas5v.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59419 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754970Ab0IXU11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 16:27:27 -0400
In-Reply-To: <87ocbnas5v.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Fri, 24 Sep 2010, Kevin Hilman wrote:

> >> So, what is the "right" thing to do here?
> >
> > You should call pm_runtime_get(), turn off the interrupt source, and
> > return.  Then your resume routine should check for an outstanding
> > interrupt or wakeup request and handle it (the easiest way may be 
> > simply to call the ISR).
> 
> For a "normal" device driver, your solution makes complete sense.  The
> only catch is that it introduces potentically significant latency in the
> interrupt handling and it requires the interrupt source to be masked,
> potentially loosing other interrupts, while waiting for the runtime PM
> workqueue to schedule.  For chained handlers in particular, this means
> that *all* interrupts managed by the chained handler would be masked for
> this additional time.  Not good.

Masking an interrupt source doesn't cause any interrupts to be lost, if 
you mask it at a time when you couldn't handle the interrupts anyway.

> The problematic device for me as an on-chip GPIO controller, and the ISR
> in question is a chained handler (run with interrupts disabled) which
> does the GPIO demux and then dispatches to the actual ISR.  Following the
> above approach means that all GPIO interrupts (in that bank) would be
> masked until ->runtime_resume() is called.  For a GPIO bank with
> multiple edge-triggered IRQs, masked IRQs for that amount of time could
> mean several missed interrupts while waiting.

Wait a minute, you're confusing me.  I take it that the GPIO controller
is the device being runtime suspended, right?  And you said that while
it is suspended you can't access its registers.  So then how can you
mask it?  

Do you mean that you have to mask the entire IRQ line because there's
no way to turn off the interrupt-request source in the GPIO controller?  
That's different from what you wrote above.

>  Hoever, this isn't a
> major concern as we don't (currently) have IRQF_DISABLED handlers hooked
> up to GPIO IRQs (that I know of.)

Isn't IRQF_DISABLED on its way out, anyway?

> It may seem like I'm trying to fight the design, but I'm actually trying
> to find ways to use it.  I want to use the API (and we're using it
> successfully in most of our drivers now.)  The problem is only in a few
> of these corner cases where using it introduces significant changes from
> previous behavior like introducing long, unbounded windows for missed
> interrupts.

Assuming the problem of missed interrupts didn't exist, would you still 
be unhappy about the latency issue?

In the general case there's no way to avoid it.  Even though a device
like your GPIO controller may be able to return to full power very
quickly, the fact that it was suspended may have led the PM core to
suspend its parent as well.  And the parent may be slow to resume,
requiring a full process context.

It seems as though what you really need is a way to tell the PM core 
that your device can change its power state quickly with no need for a 
process context.  Given that, pm_runtime_get() could invoke your 
runtime_resume callback directly; you wouldn't have to wait for the 
workqueue.  (Unless your device had a suspended parent that _did_ need 
a long time to resume.)

Would that solve your problem?  It seems like a reasonable sort of 
feature to add.

Alan Stern

