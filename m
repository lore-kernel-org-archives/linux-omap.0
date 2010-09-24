From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [linux-pm] runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Fri, 24 Sep 2010 14:52:44 -0700
Message-ID: <87lj6q3j2r.fsf@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1009241547010.1287-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:38589 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758163Ab0IXVwr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 17:52:47 -0400
Received: by pxi10 with SMTP id 10so926074pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 14:52:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1009241547010.1287-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri, 24 Sep 2010 16:27:25 -0400 (EDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 24 Sep 2010, Kevin Hilman wrote:
>
>> >> So, what is the "right" thing to do here?
>> >
>> > You should call pm_runtime_get(), turn off the interrupt source, and
>> > return.  Then your resume routine should check for an outstanding
>> > interrupt or wakeup request and handle it (the easiest way may be 
>> > simply to call the ISR).
>> 
>> For a "normal" device driver, your solution makes complete sense.  The
>> only catch is that it introduces potentically significant latency in the
>> interrupt handling and it requires the interrupt source to be masked,
>> potentially loosing other interrupts, while waiting for the runtime PM
>> workqueue to schedule.  For chained handlers in particular, this means
>> that *all* interrupts managed by the chained handler would be masked for
>> this additional time.  Not good.
>
> Masking an interrupt source doesn't cause any interrupts to be lost, if 
> you mask it at a time when you couldn't handle the interrupts anyway.

Sure, but the "mask in ISR, handle in ->runtime_resume()" proposal
would keeping them masked while we actually could be handling them.

Even in our current GPIO code, we have a tiny (but bounded) window where
we might miss an edge-triggered GPIO interrupt while we're still
detecting the previous one.  However, this is a very small window in an
interrupts-disabled chained handler.  

>> The problematic device for me as an on-chip GPIO controller, and the ISR
>> in question is a chained handler (run with interrupts disabled) which
>> does the GPIO demux and then dispatches to the actual ISR.  Following the
>> above approach means that all GPIO interrupts (in that bank) would be
>> masked until ->runtime_resume() is called.  For a GPIO bank with
>> multiple edge-triggered IRQs, masked IRQs for that amount of time could
>> mean several missed interrupts while waiting.
>
> Wait a minute, you're confusing me.  I take it that the GPIO controller
> is the device being runtime suspended, right?  

Right.

> And you said that while it is suspended you can't access its
> registers.  So then how can you mask it?

The interrupt to be masked would be the main GPIO bank IRQ (for the
chained handler) and it would be masked at the IRQ controller, which
is not (yet) suspended.

> Do you mean that you have to mask the entire IRQ line because there's
> no way to turn off the interrupt-request source in the GPIO controller?  

Right. Because in order to determine the exact interrupt source, you
have to access the GPIO controller registers and figure out which GPIO
in the GPIO bank was the source.  And then, the only way to turn off the
source is to know which device is connected to that IRQ, and disable it
via the driver for that device (e.g. network driver using a GPIO IRQ.)

IOW, When the bank IRQ fires, all we know is that (at least) one of the 32
GPIOs in the GPIO bank has an interrupt pending.  In order to determine
which one it was, we have to read GPIO controller registers, but we
can't do that until ->runtime_resume().  In order for the bank IRQ not
to continually re-fire, it would have to be kept masked until
the ISR is triggered from ->runtime_resume().

> That's different from what you wrote above.

Right, I should have said the GPIO bank IRQ needs to be masked instead
of all GPIOs in the bank need to be masked.

>>  Hoever, this isn't a
>> major concern as we don't (currently) have IRQF_DISABLED handlers hooked
>> up to GPIO IRQs (that I know of.)
>
> Isn't IRQF_DISABLED on its way out, anyway?

Yes, that's why it's not really a concern.

>> It may seem like I'm trying to fight the design, but I'm actually trying
>> to find ways to use it.  I want to use the API (and we're using it
>> successfully in most of our drivers now.)  The problem is only in a few
>> of these corner cases where using it introduces significant changes from
>> previous behavior like introducing long, unbounded windows for missed
>> interrupts.
>
> Assuming the problem of missed interrupts didn't exist, would you still 
> be unhappy about the latency issue?

Yes.

> In the general case there's no way to avoid it.  Even though a device
> like your GPIO controller may be able to return to full power very
> quickly, the fact that it was suspended may have led the PM core to
> suspend its parent as well.  And the parent may be slow to resume,
> requiring a full process context.

In the general case, I agree.

> It seems as though what you really need is a way to tell the PM core 
> that your device can change its power state quickly with no need for a 
> process context.  Given that, pm_runtime_get() could invoke your 
> runtime_resume callback directly; you wouldn't have to wait for the 
> workqueue.  (Unless your device had a suspended parent that _did_ need 
> a long time to resume.)
>
> Would that solve your problem?  It seems like a reasonable sort of 
> feature to add.

Yes, that would definitely solve the problem, and is basically the
hack/workaround I'm using locally:

  pm_runtime_get_noresume()
  dev->pm->runtime_resume()
  /* handle IRQ */
  pm_runtime_put();

because I know this on-chip device is 1) already suspended, 2) has no
runtime PM capable parents and 3) not runtime_resume'd elsewhere.

Kevin
