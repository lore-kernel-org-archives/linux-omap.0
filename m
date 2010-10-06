From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt
 handlers
Date: Wed, 6 Oct 2010 16:28:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010061609060.2047-100000@iolanthe.rowland.org>
References: <8739sjktbd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35031 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752260Ab0JFU2V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 16:28:21 -0400
In-Reply-To: <8739sjktbd.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Wed, 6 Oct 2010, Kevin Hilman wrote:

> >> I think I can live with the above restrictions (the _irq methods failing
> >> unless they can immediately run.)  For the rare corner cases I've
> >> currently run into, this will work fine as they happen because of a
> >> wakeup IRQ, where we know the device is RPM_SUSPENDED.
> >
> > Then what will the driver do if it gets a wakeup IRQ but it can't
> > resume the device because some other thread is in the middle of a
> > suspend or resume?
> 
> In those cases, I guess it will have to return IRQ_NONE, and print some
> sort of error.

Without handling the IRQ?  I guess if the transient state (SUSPENDING
or RESUMING) ends quickly enough then the kernel won't permanently
disable the IRQ line (although getting hundreds of repeated error
messages in the system log might prove daunting).  Would you want to 
rely on that?

>  Alternatively, it could fall back to the high-latency
> case of masking the IRQ and doing an asynchronous call then call the ISR
> in the runtime_resume callback.

Yes, this probably would be acceptable since it wouldn't happen very 
often.  Still, having two different pathways (one of which is very low 
probability) usually isn't a good idea.

> For the corner cases that I've run into, other transitions will not be
> in progress because system has just woken up (so no threads are in the
> middle of suspends or resumes) and the IRQ fires as soon as pm_idle
> enables interrupts, and before there's a chance to schedule anything
> else.

Ah, but once you integrate the runtime PM framework into your driver, 
you run the risk of resumes occurring for reasons that aren't under 
your control.  For example, the user can force a runtime-suspended 
device to resume by writing "on" to the device's power/control sysfs 
attribute.  What would happen if a wakeup IRQ arrived just as the 
resume was starting?

(Actually, this particular failure mode shouldn't concern you very much
since it applies only to SMP systems.  But it's important to think of
the future -- I can imagine SMP OMAPs coming out before too long.)

On the whole, I don't see any striking reason for the PM core not to 
busy-wait during a concurrent state change.  Refusing to wake up a 
suspended parent ... okay, maybe that's a little more defensible.  
Especially since in many or most cases the parent (if there is one) 
will probably be runtime-PM-disabled anyway.

Alan Stern

