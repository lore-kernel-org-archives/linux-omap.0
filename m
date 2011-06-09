From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Thu, 9 Jun 2011 09:56:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106090945490.2081-100000@iolanthe.rowland.org>
References: <87hb80546c.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49451 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757584Ab1FIN4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:56:49 -0400
In-Reply-To: <87hb80546c.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Wed, 8 Jun 2011, Kevin Hilman wrote:

> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> [...]
> 
> > you need to separate the system suspend handling from runtime PM.
> 
> /me risks getting yelled at again and jumps back in ;)
> 
> > Each of them requires a different approach, because the goal is really
> > different in both cases (basically, runtime PM triggers when the
> > device is _known_ to be idle, while system suspend may trigger while
> > it's actually being used).
> 
> OK, but from the driver's perspective, the goals do not seem all that
> different to me:
> 
> Runtime suspend
> 1. activity
> 2. activity finishes
> 3. device is _known_ to be idle
> 4. trigger device low-power transition 
> 
> system suspend [echo mem > /sys/power/state]
> 1. activity
> 2. prevent future activity, halt/wait for current activity
> 3. device is _known_ to be idle
> 4. trigger device low-power transition
> 
> The only difference is step 2.

That _is_ the main difference, and it's a big one.  (As Magnus pointed 
out, wakeup-enabling is another difference).

>  In runtime suspend, the activity
> finishes on its own, in system suspend, the activity is forcibly
> stopped.  In either case, after that point the device is known to be
> idle, and proceeding from there is identical.  IOW, based on the above,
> another way of looking at system PM is forcing idle so that runtime PM
> can happen.
> 
> I think it's important to note the similarities as well as the
> differences.  Maybe I'm still really blind here, but I cannot see how
> they can be completely decoupled.

They don't have to be decoupled, and indeed they can share code.  The 
point Rafael and I are making is that they have to use different 
callback pointers, which gives you a chance to handle the differences 
as well as the similarities.

> More specifically, what should be the approach in system suspend when a
> device is already runtime suspended?  If you treat runtime and system PM
> as completely independent, you would have to runtime resume the device
> so that it can then be immediately system suspended.

Assuming the wakeup setting is correct, and assuming you use the same 
power level for runtime suspend and system suspend, then nothing needs 
to be done.

If the wakeup setting is not correct, it has to be changed.  That 
often implies going back to full power in order to change the 
wakeup setting, then going to low power again.

This is all described in various files under Documentation/power/, in 
particular, devices.txt and runtime_pm.txt.

> For many (if not all) devices though, what I suspect we would want is
> for devices that are runtime suspended to stay runtime suspended across
> a system suspend *and* resume.  That would mean that the device power
> domain would not call system PM callbacks on devices that are runtime
> suspended.

No, it's generally agreed that _all_ devices should return to full 
power during system resume -- even if they were runtime suspended 
before the system sleep.  This also is explained in the Documentation 
files.

> At least for device power domains where the low-power state is identical
> between runtime suspend and system suspend, this makes a lot of sense
> (to me.)  Device power domain ->suspend might look something like this
> (obviously not tested):
> 
>     if (pm_runtime_suspended(dev))
>         return;

You could test priv->flags here instead.  But I suppose this would
work.

>     pm_generic_suspend(dev);       

No, you shouldn't call the PM core here.

>     magic_device_idle(dev); /* HW-specific, shared with runtime PM */

At this point you should call magic_device_set_low_power(dev).  That
routine can also be shared with runtime PM.

>     priv->flags |= MY_DEVICE_SYS_SUSPENDED;

I don't see any point in having separate flags for system suspend and 
runtime suspend.  Just use MY_DEVICE_IS_SUSPENDED, and set it in the 
magic_device_set_low_power routine.

> and ->resume():
> 
>    if (priv->flags & MY_DEVICE_SYS_SUSPENDED) {
>        magic_device_enable(dev);
>        pm_generic_resume(dev);    
>   }

This should simply be:

	magic_device_set_full_power(dev);  // clears MY_DEVICE_IS_SUSPENDED
	magic_device_enable(dev);

Alan Stern

