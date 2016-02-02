From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 13:43:10 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602021335170.1653-100000@iolanthe.rowland.org>
References: <20160202180555.GW19432@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160202180555.GW19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2 Feb 2016, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [160202 08:50]:
> > * Alan Stern <stern@rowland.harvard.edu> [160202 08:17]:
> > 
> > > ?  pm_runtime_put_sync() _already_ does not respect the autosuspend 
> > > mode.  If you want to respect it, you have to call 
> > > pm_runtime_put_sync_autosuspend() instead.
> > 
> > I think you found the real bug there. So the right fix is to
> > call pm_runtime_put_sync_autosuspend() at the end of failed
> > probe in omap_hsmmc. Let me give that a try here.
> 
> Nope that's not it but getting closer.
> 
> The following seems to make things behave for me. Now the
> question is.. Does it have some undesired side effects?

Yes, it does.

I'm still not clear on what you want to accomplish.  It sounds like you 
want to perform a runtime suspend following the last probe (if the 
probe fails), and in between probes you don't really care (although it 
would be preferable to avoid suspending).

Does pm_runtime_use_autosuspend() get called by the probe routine?  If 
it does, then perhaps you can get what you want by having the probe 
routine call pm_runtime_dont_use_autosuspend() whenever it's about to 
return an error -- particularly -EDEFER.

> > Can we add some warning to pm_runtime_put_sync() about that?
> 
> Probably no need for that, I misunderstood the meaning of
> pm_runtime_put_sync_autosuspend().
> 
> Regards,
> 
> Tony
> 
> 8< --------------
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -435,7 +435,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
>  		goto out;
>  
>  	/* If the autosuspend_delay time hasn't expired yet, reschedule. */
> -	if ((rpmflags & RPM_AUTO)
> +	if (((rpmflags & (RPM_ASYNC | RPM_AUTO)) == ((RPM_ASYNC | RPM_AUTO)))
>  	    && dev->power.runtime_status != RPM_SUSPENDING) {
>  		unsigned long expires = pm_runtime_autosuspend_expiration(dev);

This would prevent pm_runtime_autosuspend() from working correctly.

Alan Stern

