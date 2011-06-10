From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 16:52:33 -0700
Message-ID: <87ipsdnt1a.fsf@ti.com>
References: <Pine.LNX.4.44L0.1106090945490.2081-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33343 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758249Ab1FJXw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 19:52:57 -0400
Received: by pwj8 with SMTP id 8so1840486pwj.41
        for <linux-omap@vger.kernel.org>; Fri, 10 Jun 2011 16:52:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

Alan Stern <stern@rowland.harvard.edu> writes:

[...]

>> More specifically, what should be the approach in system suspend when a
>> device is already runtime suspended?  If you treat runtime and system PM
>> as completely independent, you would have to runtime resume the device
>> so that it can then be immediately system suspended.
>
> Assuming the wakeup setting is correct, and assuming you use the same 
> power level for runtime suspend and system suspend, then nothing needs 
> to be done.
>
> If the wakeup setting is not correct, it has to be changed.  That 
> often implies going back to full power in order to change the 
> wakeup setting, then going to low power again.

OK, but how should this be implemented?  

If the device is runtime suspended at system suspend time, it implies
that somwhere in the system suspend path, the device has to be powered
on and enabled (a.k.a. runtime resumed.)

>From a driver writer's perspective, doing a pm_runtime_get_sync() would
be the obvious choice, but that causes nesting of ->runtime_resume
callbacks within ->suspend callbacks which is apparently forbidden (or
rather strongly recommended against :)

Now, assuming the driver's suspend can't do a pm_runtime_get()...

In order to power on & enable the device, the driver has to essentially
duplicate everything that would be done by a runtime resume.

The problem comes because this work is shared between the driver and the
subsystem.  IOW, it's the driver's ->suspend() callback that decides
whether or not the device needs to be powered-on/enabled (e.g. to
enable/disable wakeups), but it might be the subsystem that actually has
does the magic_device_set_full_power(), magic_device_enable().

So once the driver's ->suspend() realizes it needs to power on & enable
the device, it has no way to tell the subsystem to do so, wait for it to
happen, and then enable/disable its wakeups.

Maybe I'm being really dense, really blind, or really stubborn (or all
three), but it seems to be that using runtime PM calls to implement
these things would be the most obvious and the most readable.

Kevin
