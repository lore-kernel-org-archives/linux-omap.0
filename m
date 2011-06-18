From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] calling runtime PM from system PM methods
Date: Sat, 18 Jun 2011 11:31:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106181123050.29370-100000@netrider.rowland.org>
References: <201106181308.42298.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:51690 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752351Ab1FRPbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Jun 2011 11:31:09 -0400
In-Reply-To: <201106181308.42298.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>

On Sat, 18 Jun 2011, Rafael J. Wysocki wrote:

> On Friday, June 17, 2011, Rafael J. Wysocki wrote:
> > On Friday, June 17, 2011, Alan Stern wrote:
> > > On Fri, 17 Jun 2011, Rafael J. Wysocki wrote:
> > > 
> > > > Having considered that a bit more I see that, in fact, commit
> > > > e8665002477f0278f84f898145b1f141ba26ee26 (PM: Allow pm_runtime_suspend() to
> > > > succeed during system suspend) has introduced at least one regression.
> > > > Namely, the PCI bus type runs pm_runtime_resume() in its .prepare()
> > > > callback to guarantee that devices will be in a well known state before
> > > > the PCI .suspend() and .suspend_noirq() callbacks are executed.
> > > > Unfortunately, after commit e8665002477f0278f84f898145b1f141ba26ee26 this
> > > > isn't valid any more, because devices can be runtime-suspend after the
> > > > pm_runtime_resume() in .prepare() has run.
> > > > 
> > > > USB seems to do something similar in choose_wakeup().
> > > > 
> > > > So, either the both of these subsystems should be modified to use
> > > > pm_runtime_get_sync() and then pm_runtime_put_<something>() some time
> > > > during resume, or we should revert commit e8665002477f0278f84f898145b1f141ba26ee26.
> > > 
> > > pm_runtime_put_noidle would be appropriate.
> > > 
> > > > Quite frankly, which shouldn't be a surprise to anyone at this point, I'd
> > > > prefer to revert that commit for 3.0.
> > > 
> > > Maybe we can compromise.  Instead of reverting that commit outright,
> > > put the get_noresume just before the suspend callback and put the
> > > put_sync just after the resume callback.
> > 
> > That wouldn't fix the PCI problem, though, because it would leave a small
> > window in which the device could be suspended after the pm_runtime_resume()
> > in pci_pm_prepare() had run.
> 
> That said, the PCI case can be solved with a separate patch and if the other
> subsystems are not affected, perhaps that's the best approach.

Yes, it would be a simple change.

> Still, I'd like to make sure that there won't be any races between runtime
> PM and .suspend_noirq() and .resume_noirq() callbacks, so I'd like to apply
> the patch below.
> 
> Thanks,
> Rafael
> 
> ---
>  drivers/base/power/main.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/base/power/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/main.c
> +++ linux-2.6/drivers/base/power/main.c
> @@ -591,6 +591,8 @@ void dpm_resume(pm_message_t state)
>  	async_error = 0;
>  
>  	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
> +		pm_runtime_get_noresume(dev);
> +		pm_runtime_enable(dev);
>  		INIT_COMPLETION(dev->power.completion);
>  		if (is_async(dev)) {
>  			get_device(dev);
> @@ -614,6 +616,7 @@ void dpm_resume(pm_message_t state)
>  		}
>  		if (!list_empty(&dev->power.entry))
>  			list_move_tail(&dev->power.entry, &dpm_prepared_list);
> +		pm_runtime_put_noidle(dev);
>  		put_device(dev);
>  	}
>  	mutex_unlock(&dpm_list_mtx);
> @@ -939,8 +942,10 @@ int dpm_suspend(pm_message_t state)
>  			put_device(dev);
>  			break;
>  		}
> -		if (!list_empty(&dev->power.entry))
> +		if (!list_empty(&dev->power.entry)) {
>  			list_move(&dev->power.entry, &dpm_suspended_list);
> +			pm_runtime_disable(dev);
> +		}

The put_noidle is in the wrong place for async resumes.  Likewise for
the pm_runtime_disable() and async suspends.  Also this runs into
problems if a device is never suspended (i.e., if the sleep transition
aborts before suspending that device).

I have been working on a similar patch to do these things.  But it got
derailed by the problems mentioned earlier in the other email thread
(and the bug fix I posted yesterday).  Maybe I can send it in early
next week.

Alan Stern

