From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Wed, 08 Jun 2011 15:50:03 -0700
Message-ID: <87hb80546c.fsf@ti.com>
References: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org>
	<201106062029.36389.rjw@sisk.pl> <87zkluwqab.fsf@ti.com>
	<201106072332.30464.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:44286 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752090Ab1FHWuG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 18:50:06 -0400
Received: by pxi20 with SMTP id 20so618126pxi.41
        for <linux-omap@vger.kernel.org>; Wed, 08 Jun 2011 15:50:05 -0700 (PDT)
In-Reply-To: <201106072332.30464.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 7 Jun 2011 23:32:30 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[...]

> you need to separate the system suspend handling from runtime PM.

/me risks getting yelled at again and jumps back in ;)

> Each of them requires a different approach, because the goal is really
> different in both cases (basically, runtime PM triggers when the
> device is _known_ to be idle, while system suspend may trigger while
> it's actually being used).

OK, but from the driver's perspective, the goals do not seem all that
different to me:

Runtime suspend
1. activity
2. activity finishes
3. device is _known_ to be idle
4. trigger device low-power transition 

system suspend [echo mem > /sys/power/state]
1. activity
2. prevent future activity, halt/wait for current activity
3. device is _known_ to be idle
4. trigger device low-power transition

The only difference is step 2.  In runtime suspend, the activity
finishes on its own, in system suspend, the activity is forcibly
stopped.  In either case, after that point the device is known to be
idle, and proceeding from there is identical.  IOW, based on the above,
another way of looking at system PM is forcing idle so that runtime PM
can happen.

I think it's important to note the similarities as well as the
differences.  Maybe I'm still really blind here, but I cannot see how
they can be completely decoupled.

More specifically, what should be the approach in system suspend when a
device is already runtime suspended?  If you treat runtime and system PM
as completely independent, you would have to runtime resume the device
so that it can then be immediately system suspended.

For many (if not all) devices though, what I suspect we would want is
for devices that are runtime suspended to stay runtime suspended across
a system suspend *and* resume.  That would mean that the device power
domain would not call system PM callbacks on devices that are runtime
suspended.

At least for device power domains where the low-power state is identical
between runtime suspend and system suspend, this makes a lot of sense
(to me.)  Device power domain ->suspend might look something like this
(obviously not tested):

    if (pm_runtime_suspended(dev))
        return;

    pm_generic_suspend(dev);       
    magic_device_idle(dev); /* HW-specific, shared with runtime PM */
    priv->flags |= MY_DEVICE_SYS_SUSPENDED;

and ->resume():

   if (priv->flags & MY_DEVICE_SYS_SUSPENDED) {
       magic_device_enable(dev);
       pm_generic_resume(dev);    
  }

Kevin
