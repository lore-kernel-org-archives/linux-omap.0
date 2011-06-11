From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Sat, 11 Jun 2011 12:42:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106111227580.3439-100000@netrider.rowland.org>
References: <87ipsdnt1a.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:44261 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751032Ab1FKQmc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Jun 2011 12:42:32 -0400
In-Reply-To: <87ipsdnt1a.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

On Fri, 10 Jun 2011, Kevin Hilman wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> [...]

> > If the wakeup setting is not correct, it has to be changed.  That 
> > often implies going back to full power in order to change the 
> > wakeup setting, then going to low power again.
> 
> OK, but how should this be implemented?  
> 
> If the device is runtime suspended at system suspend time, it implies
> that somwhere in the system suspend path, the device has to be powered
> on and enabled (a.k.a. runtime resumed.)
> 
> From a driver writer's perspective, doing a pm_runtime_get_sync() would
> be the obvious choice, but that causes nesting of ->runtime_resume
> callbacks within ->suspend callbacks which is apparently forbidden (or
> rather strongly recommended against :)
> 
> Now, assuming the driver's suspend can't do a pm_runtime_get()...
> 
> In order to power on & enable the device, the driver has to essentially
> duplicate everything that would be done by a runtime resume.

Again, this depends on the subsystem and the driver.  For example, the
USB subsystem does call pm_runtime_resume() in order to bring a device
back to full power if the wakeup setting needs to be changed.  This is
done in the subsystem code, and the subsystem is designed to allow it.

(Actually, it could be improved.  In theory the driver doesn't need to
be involved at all; a USB device's wakeup setting can be changed purely
by the subsystem.  Nevertheless, the pm_runtime_resume call does wake
up the driver, which then needs to be quiesced again shortly thereafter
-- overall a waste of time.  This was the easiest approach.)

> The problem comes because this work is shared between the driver and the
> subsystem.  IOW, it's the driver's ->suspend() callback that decides
> whether or not the device needs to be powered-on/enabled (e.g. to
> enable/disable wakeups), but it might be the subsystem that actually has
> does the magic_device_set_full_power(), magic_device_enable().
> 
> So once the driver's ->suspend() realizes it needs to power on & enable
> the device, it has no way to tell the subsystem to do so, wait for it to
> happen, and then enable/disable its wakeups.

Then the subsystem should _provide_ a way, if that's how you decide to
handle things.

> Maybe I'm being really dense, really blind, or really stubborn (or all
> three), but it seems to be that using runtime PM calls to implement
> these things would be the most obvious and the most readable.

Have you tried actually doing it in a situation where you control both
the driver and the subsystem?

Basically, I think what Rafael was saying before referred to the 
general case, where you don't know anything about the subsystem and 
can't afford to make assumptions.  But in the real world you'll be 
writing a driver for a particular subsystem and you'll know how that 
subsystem works.  If the subsystem permits runtime PM calls to be 
nested within the system PM routines, feel free to go ahead and use 
them.

Alan Stern

