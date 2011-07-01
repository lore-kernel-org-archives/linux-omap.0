From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 11:59:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011154120.1988-100000@iolanthe.rowland.org>
References: <87pqlu3sy3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58214 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752666Ab1GAP7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 11:59:10 -0400
In-Reply-To: <87pqlu3sy3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 1 Jul 2011, Kevin Hilman wrote:

> >> --- a/drivers/base/dd.c
> >> +++ b/drivers/base/dd.c
> >> @@ -329,13 +329,13 @@ static void __device_release_driver(struct device *dev)
> >>  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> >>  						     BUS_NOTIFY_UNBIND_DRIVER,
> >>  						     dev);
> >> -
> >> -		pm_runtime_put_sync(dev);
> >> -
> >>  		if (dev->bus && dev->bus->remove)
> >>  			dev->bus->remove(dev);
> >>  		else if (drv->remove)
> >>  			drv->remove(dev);
> >> +
> >> +		pm_runtime_put_sync(dev);
> >> +
> >>  		devres_release_all(dev);
> >>  		dev->driver = NULL;
> >>  		klist_remove(&dev->p->knode_driver);
> >
> > To be safer, the put_sync() call should be moved down here.  Or maybe 
> > even after the blocking_notifier_call_chain() that occurs here.
> 
> I was actually thinking about the other direction: moving the get_sync
> after the first notifier chain.  IOW, the get_sync/put_sync only
> protects the ->remove() calls, not the notifiers.
> 
> The protection around the notifiers doesn't make sense to me, at least
> in the context of driver runtime PM racing with the subsystem.
> Especially since these notifiers are likely how the
> subsystem/bus/pm_domain code getting notified that there may be a device
> to manage in the first place.

The get_sync part doesn't matter so much.  Moving it past the notifier 
call would probably be okay -- unless one of the listeners on the 
notifier chain expects the device to be active.  Changing the get_sync 
to get_noresume would probably also be okay -- subject to a similar 
reservation.

The problem with the put_sync isn't the notifier.  If you leave it
where you've got it now, you'll end up invoking a callback at a time
when the driver thinks it no longer controls the device but the
driver-model core still thinks it does.  You certainly want to do the

	dev->driver = NULL;

first.

Alan Stern

