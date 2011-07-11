From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM domain using _noirq methods to "finish" pending runtime PM transistions
Date: Mon, 11 Jul 2011 12:24:36 -0700
Message-ID: <87aacky617.fsf@ti.com>
References: <87iprc2t34.fsf@ti.com> <201107092302.06618.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38069 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754114Ab1GKTYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 15:24:41 -0400
Received: by mail-gw0-f42.google.com with SMTP id 17so2323965gwb.15
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 12:24:40 -0700 (PDT)
In-Reply-To: <201107092302.06618.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 9 Jul 2011 23:02:06 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Hi,
>
> On Saturday, July 09, 2011, Kevin Hilman wrote:
>> Hi Rafael,
>> 
>> So I'm now experimenting with your suggestion of using the noirq
>> callbacks of the PM domain to ensure device low-power state transitions
>> for the cases where runtime PM has been disabled from userspace (or a
>> driver has used runtime PM calls in it's suspend/resume path but they
>> have no effect since runtime PM is disabled.)
>> 
>> Before I get too far, I want to be sure I understood your suggestion
>> correctly, and run my current implemtation past you.
>> 
>> For starters, I just set the driver's noirq callbacks to point to the
>> runtime PM callbacks.
>> 
>> Then, in the PM domain's suspend_noirq, I basically do
>> 
>> 	ret = pm_generic_suspend_noirq(dev);
>> 	if (!ret && !(dev->power.runtime_status == RPM_SUSPENDED))
>> 		magic_device_power_down(dev); /* shared with pm_domain runtime PM methods */
>>                 priv->flags |= MAGIC_DEVICE_SUSPENDED;
>> 	}
>> 	return ret;
>> 
>> and in the PM domain's resume_norq, I basically do:
>> 
>> 	if ((priv->flags & MAGIC_DEVICE_SUSPENDED) &&
>> 	    !(dev->power.runtime_status == RPM_SUSPENDED)) {
>> 		priv->flags &= ~OMAP_DEVICE_SUSPENDED;
>> 		magic_device_power_up(dev);
>> 	}
>> 	return pm_generic_resume_noirq(dev);
>> 
>> Note: The MAGIC_DEVICE_SUSPENDED flag is used so resume_noirq only
>> reenables devices that were disabled by suspend_noirq so that devices
>> which were disabled by runtime PM are left untouched (similar to how
>> you've implmented generic PM domains.)
>> 
>> Since the driver's noirq callbacks point to the runtime PM callbacks
>> this all works quite well. 
>> 
>> I believe this was basically the suggestion you were recommending, right?
>
> That's correct.
>
>> However, what I need is for the driver's runtime PM callbacks not to be
>> called unconditionally, but only if the PM domain's noirq methods are
>> actually going to disable/power-down the device (e.g. it's not already
>> runtime suspended.)
>> 
>> The first obvious solution is to create new driver noirq methods that
>> check if the device is not already RPM_SUSPENDED and only then call the
>> runtime PM callbacks.   That works, but hey, it's a Friday night so I
>> decided to take it to the next level...
>> 
>> Instead of making all the drivers add new noirq methods that just
>> conditionally call the runtime PM methods, what if I just handle it in
>> the PM domain?  IOW, what if I just call pm_generic_runtime_* from the
>> PM domain's noirq methods?  e.g. call pm_generic_runtime_suspend() just
>> before magic_device_power_down() and call pm_generic_runtime_resume()
>> just after magic_device_power_up()?
>
> That should be fine.
>
>> I tested this today with a handful of our drivers that do all their PM
>> in terms of the runtime PM API (including get_sync/put_sync in their
>> suspend path) and they all work as expected without modification.
>> 
>> I know it's not much to add a couple new callbacks to each of these
>> drivers, but if I can handle it at the PM domain level, I'd rather allow
>> the drivers to stay simple.
>> 
>> What do you think?
>
> I don't see anything wrong with your approach. :-)

Thanks.

> PS
> I wonder what you think about this patch:
> https://patchwork.kernel.org/patch/959672/

I responded to that thread.

Kevin
