From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] runtime PM usage_count during driver_probe_device()?
Date: Fri, 01 Jul 2011 08:45:56 -0700
Message-ID: <87pqlu3sy3.fsf@ti.com>
References: <Pine.LNX.4.44L0.1107011123590.1988-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39898 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751523Ab1GAPqA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 11:46:00 -0400
Received: by mail-pz0-f41.google.com with SMTP id 4so3653149pzk.0
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 08:45:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1107011123590.1988-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri, 1 Jul 2011 11:25:56 -0400 (EDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 1 Jul 2011, Kevin Hilman wrote:
>
>> OK, so the ->probe() part has been explained and makes sense, but I
>> would expect ->remove() to be similarily protected (as the documentation
>> states.)  But that is not the case.  Is that a bug?  If so, patch below
>> makes the code match the documentation.
>
> I suspect it is a bug, but it's hard to be sure.  It's so _blatantly_ 
> wrong that it looks like it was done deliberately.

heh

>> Kevin
>> 
>> From eef73ab2feb203bacb57dc35862f2a9969b61593 Mon Sep 17 00:00:00 2001
>> From: Kevin Hilman <khilman@ti.com>
>> Date: Fri, 1 Jul 2011 07:37:47 -0700
>> Subject: [PATCH] driver core: prevent runtime PM races with ->remove()
>> 
>> Runtime PM Documentation states that the runtime PM usage count is
>> incremented during driver ->probe() and ->remove().  This is designed
>> to prevent driver runtime PM races with subsystems which may initiate
>> runtime PM transitions before during and after drivers are loaded.
>> 
>> Current code increments the usage_count during ->probe() but not
>> during ->remove().  This patch fixes the ->remove() part and makes the
>> code match the documentation.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>>  drivers/base/dd.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 6658da7..47e079d 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -329,13 +329,13 @@ static void __device_release_driver(struct device *dev)
>>  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>>  						     BUS_NOTIFY_UNBIND_DRIVER,
>>  						     dev);
>> -
>> -		pm_runtime_put_sync(dev);
>> -
>>  		if (dev->bus && dev->bus->remove)
>>  			dev->bus->remove(dev);
>>  		else if (drv->remove)
>>  			drv->remove(dev);
>> +
>> +		pm_runtime_put_sync(dev);
>> +
>>  		devres_release_all(dev);
>>  		dev->driver = NULL;
>>  		klist_remove(&dev->p->knode_driver);
>
> To be safer, the put_sync() call should be moved down here.  Or maybe 
> even after the blocking_notifier_call_chain() that occurs here.

I was actually thinking about the other direction: moving the get_sync
after the first notifier chain.  IOW, the get_sync/put_sync only
protects the ->remove() calls, not the notifiers.

The protection around the notifiers doesn't make sense to me, at least
in the context of driver runtime PM racing with the subsystem.
Especially since these notifiers are likely how the
subsystem/bus/pm_domain code getting notified that there may be a device
to manage in the first place.

Kevin
