From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Mon, 6 Jun 2011 20:29:36 +0200
Message-ID: <201106062029.36389.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106021010360.1913-100000@iolanthe.rowland.org> <87lixkyxa8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60390 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab1FFS2y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jun 2011 14:28:54 -0400
In-Reply-To: <87lixkyxa8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>

Hi,

Sorry for the delay.  After returning from Japan I found my cable modem
basically dead, so I have no Internet access from home at the moment, which is
a bit inconvenient, so to speak.

On Thursday, June 02, 2011, Kevin Hilman wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Wed, 1 Jun 2011, Kevin Hilman wrote:
> >
> >> In the process of experimenting with other solutions, I found an
> >> interesting discovery:
> >> 
> >> In the driver's ->suspend() hook, I did something like this:
> >> 
> >> 	priv->forced_suspend = false;
> >> 	if (!pm_runtime_suspended(dev)) {
> >> 		pm_runtime_put_sync(dev);
> >> 		priv->forced_suspend = true;
> >> 	}
> >> 
> >> and in the resume hook I did this:
> >> 
> >> 	if (priv->forced_suspend)
> >> 		pm_runtime_get_sync(dev);
> >> 
> >> Even after disabling runtime PM from userspace via
> >> /sys/devices/.../power/control, the ->suspend() hook triggered an actual
> >> transition.  This is because pm_runtime_forbid() just uses the usage
> >> counter, so the _put_sync() in the ->suspend callback decrements the
> >> counter and triggers an rpm_idle().   Is this expected behavior?
> >
> > Not really.  In fact it is a bug in your experimental code -- you are
> > decrementing the usage counter in a context where you did not
> > previously increment it.  In principle, the counter might already be 0
> > when the suspend hook runs.
> >
> > Yes, it is indeed possible for a device to be active while the usage
> > counter is 0.  For example (assuming the counter is initially 0), this
> > will happen if you call
> >
> > 	pm_runtime_get_sync(dev);
> > 	pm_runtime_put_noidle(dev);
> >
> > or even if you simply call
> >
> > 	pm_runtime_resume(dev);
> >
> > Of course, the drivers you're talking about may never do this.  Still, 
> > it's a logical mistake to do a *_put without previously doing a *_get.
> 
> OK.  I was trying to catch that by checking pm_runtime_suspended(), but
> now see that that cannot work in general.
> 
> The problem I'm trying to solve is how (or whether) I can use runtime PM
> from the system PM methods, specifically in the case where runtime PM
> has been disabled from userspace (or pm_runtime_forbid() has been
> called.)  

We discussed this exact issue with Magnus and Paul during LinuxCon Japan
and the answer to it is that you can't.

Apart from the problem with user space disabling runtime PM, there is
a problem with subsystem callbacks, which accidentally doesn't apply to
the platform bus type.  Namely, calling pm_runtime_suspend() or
pm_runtime_put_sync() from a driver's .suspend() routine will result in
the subsystem's .runtime_suspend() routine being called, which is incorrect,
because the driver's .suspend() routine itself is called by the subsystem's
.suspend() routine.  So, if one attempted to call pm_runtime_suspend() from
a driver's .suspend(), we'd get:

(subsystem)->suspend() => (driver)->suspend() => pm_runtime_suspend() =>
(subsystem)->runtime_suspend() ...

However, the driver cannot assume that the subsystem's .runtime_suspend()
may always be called from withing its .suspend().  In fact, for many subsystems
this will cause interesting breakage to occur.

> In a nutshell, what I'm after is for any pm_runtime_forbid() calls to be
> cancelled during system PM, thus allowing pending runtime PM events to
> occur during system PM.
> 
> Basically, what I have is several drivers who don't really need suspend
> hooks if runtime PM is enabled, because they use runtime PM on a per
> transaction basis, handle all the HW stuff in the runtime PM callbacks,
> and from a HW perspective, there is no difference in power state between
> runtime and static suspend.  These devices are already runtime suspended
> when the system PM callbacks run, so there is nothing for the system PM
> callbacks to do.

Well, I'm not quite sure this is the case.  You have to remember that
system suspend can happen at any time, so even if your runtime PM is used
around transactions, it theoretically is possible for system suspend to
happen while one of the transactions is in progress (unless you can guarantee
that the transactions can't be preempted).

> If pm_runtime_forbid() has been called, but then a system suspend is
> initiated, we'd like these devices to actually suspend, meaning allowing
> any pending runtime PM transitions to happen during system suspend.
> In order to force/trick/pursuade the device to to this, something like
> this works:
> 
> static int omap_i2c_suspend(struct device *dev)
> {
> 	if (dev->power.runtime_auto == false)
> 		pm_runtime_put_sync(dev);

This is incorrect (see above).

> 	return 0;
> }
> 
> static int omap_i2c_resume(struct device *dev)
> {
> 	if (dev->power.runtime_auto == false)
> 		pm_runtime_get_sync(dev);

Likewise.

> 	return 0;
> }
> 
> Yes, this does a put without a get, but when runtime_auto == true,
> there was an implicit _get_noresume() done by the runtime PM core.
> 
> Possibly a cleaner way, but one that would force the driver to keep
> addiional state would be something like
> 
> suspend (or prepare):
> 
> 	if (dev->power.runtime_auto == false) {
> 		priv->rpm_forced = true;
> 		pm_runtime_allow(dev);
> 	}
> 
> resume (or complete):
> 
>        	if (priv->rpm_forced)
> 		pm_runtime_forbid(dev);
> 
> If this is acceptable, I'd probably implement this at the device power
> domain level instead of having to have every driver do this.

While it is tempting to try to get away with only two PM callbacks per
driver instead of four (or even more), it generally is not doable, simply
because driver callbacks are not executed directly by the core.

The only way to address the problem of code duplication between .suspend()
and .runtime_suspend() callbacks (and analogously for resume) I see at the
moment is to make those callbacks execute common routines.

Thanks,
Rafael
