From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 01 Jul 2011 09:54:32 -0700
Message-ID: <87vcvm0wmv.fsf@ti.com>
References: <Pine.LNX.4.44L0.1107011154120.1988-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54690 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403Ab1GAQyh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 12:54:37 -0400
Received: by mail-iw0-f169.google.com with SMTP id 8so3238877iwn.28
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 09:54:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1107011154120.1988-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri, 1 Jul 2011 11:59:09 -0400 (EDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 1 Jul 2011, Kevin Hilman wrote:
>
>> >> --- a/drivers/base/dd.c
>> >> +++ b/drivers/base/dd.c
>> >> @@ -329,13 +329,13 @@ static void __device_release_driver(struct device *dev)
>> >>  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>> >>  						     BUS_NOTIFY_UNBIND_DRIVER,
>> >>  						     dev);
>> >> -
>> >> -		pm_runtime_put_sync(dev);
>> >> -
>> >>  		if (dev->bus && dev->bus->remove)
>> >>  			dev->bus->remove(dev);
>> >>  		else if (drv->remove)
>> >>  			drv->remove(dev);
>> >> +
>> >> +		pm_runtime_put_sync(dev);
>> >> +
>> >>  		devres_release_all(dev);
>> >>  		dev->driver = NULL;
>> >>  		klist_remove(&dev->p->knode_driver);
>> >
>> > To be safer, the put_sync() call should be moved down here.  Or maybe 
>> > even after the blocking_notifier_call_chain() that occurs here.
>> 
>> I was actually thinking about the other direction: moving the get_sync
>> after the first notifier chain.  IOW, the get_sync/put_sync only
>> protects the ->remove() calls, not the notifiers.
>> 
>> The protection around the notifiers doesn't make sense to me, at least
>> in the context of driver runtime PM racing with the subsystem.
>> Especially since these notifiers are likely how the
>> subsystem/bus/pm_domain code getting notified that there may be a device
>> to manage in the first place.
>
> The get_sync part doesn't matter so much.  Moving it past the notifier 
> call would probably be okay -- unless one of the listeners on the 
> notifier chain expects the device to be active.  Changing the get_sync 
> to get_noresume would probably also be okay -- subject to a similar 
> reservation.

There are enough "probably"s in the above to make me a bit uncomfortable
making this change.  Maybe you can take this patch forward?

Kevin

> The problem with the put_sync isn't the notifier.  If you leave it
> where you've got it now, you'll end up invoking a callback at a time
> when the driver thinks it no longer controls the device but the
> driver-model core still thinks it does.  You certainly want to do the
>
> 	dev->driver = NULL;
>
> first.
>
> Alan Stern
