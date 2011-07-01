From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 02:33:12 +0200
Message-ID: <201107010233.12377.rjw@sisk.pl>
References: <87k4c3dktm.fsf@ti.com> <87vcvmaml6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44984 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754473Ab1GAAcX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 20:32:23 -0400
In-Reply-To: <87vcvmaml6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Kevin Hilman <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

On Friday, July 01, 2011, Kevin Hilman wrote:
> Kevin Hilman <khilman@ti.com> writes:
> 
> > Continuing on the theme of runtime PM interactions with other parts of
> > the driver core...
> >
> > In drivers/base/dd.c:driver_probe_device(), the driver core increments
> > the usage count around ->probe():
> >
> >         [...]
> > 	pm_runtime_get_noresume(dev);
> > 	pm_runtime_barrier(dev);
> > 	ret = really_probe(dev, drv);
> > 	pm_runtime_put_sync(dev);
> >
> > I'm not following the reason for this.  On driver's I'm familar with,
> > it's not until ->probe where pm_runtime_enable() is called.  What is
> > being protected against here?
> >
> > These seem to exist since the introduction of the runtime PM core, but I
> > can't find any explanation.
> >
> > The documentation refers to the increment by the core, but not the
> > reasons why:
> >
> >     If the device bus type's or driver's ->probe() or ->remove()
> >     callback runs pm_runtime_suspend() or pm_runtime_idle() or their
> >     asynchronous counterparts, they will fail returning -EAGAIN, because
> >     the device's usage counter is incremented by the core before
> >     executing ->probe() and ->remove().  Still, it may be desirable to
> >     suspend the device as soon as ->probe() or ->remove() has finished,
> >     so the PM core uses pm_runtime_idle_sync() to invoke the
> >     subsystem-level idle callback for the device at that time.
> >
> > On a side note, the bit about -EAGAIN above is not accurate with today's
> > code.  For example, __pm_runtime_suspend() returns zero when the usage
> > count decrement is non-zero, so callers can't currently know that doing
> > a pm_runtime_suspend() or pm_runtime_put_sync() in their ->probe()
> > actually didn't happen.
> 
> Oops, I'm not quite right here. 
> 
> The doc is actually right here if the driver uses pm_runtime_suspend()
> or pm_runtime_idle() in ->probe().  It's only when drivers use
> pm_runtime_put_sync() where there wouldn't be an -EAGAIN, but that seems
> correct.  Sorry for the noise.
> 
> I'm still confused about the usage_count increment around ->probe
> though.

In theory it is possible that a subsystem (e.g. bus type) will enable
runtime PM for devices without drivers and will (for example) put them
into low power states until the drivers are loaded.  Then, it makes
sense for the core to prevent such transitions from racing with .probe().

I'm not sure if this happens in practice, though, but also I'm not sure
whether or not that's used by USB.  Moreover, even if that doesn't happen
right now, it may start to happen at one point.

Thanks,
Rafael
