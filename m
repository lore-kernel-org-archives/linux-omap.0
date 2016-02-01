From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Mon, 1 Feb 2016 18:49:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
References: <20160201232833.GR19432@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160201232833.GR19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 1 Feb 2016, Tony Lindgren wrote:

> Does the patch below make more sense to you where we call rpm_idle?
> That seems to make things behave here also.
> 
> > > What else does __pm_runtime_use_autosuspend() set initially
> > > that changes things here?
> > 
> > The usage counter, if the delay is negative.
> 
> Yeah I don't see any difference with those.
> 
> > I'll look at this in detail, but not right now, sorry.  I'm working on
> > something else ATM and I was hoping that Ulf would be able to figure
> > out what's going on here.
> 
> Yeah we need to understand what's going on here. Having the PM runtime
> framework out of sync with the hardare is not good.. If we can't
> figure this out we should probably revert the patch until we understand
> it.
> 
> Regards,
> 
> Tony
> 
> 8< ------------
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1419,17 +1419,28 @@ void pm_runtime_init(struct device *dev)
>   */
>  void pm_runtime_reinit(struct device *dev)
>  {
> -	if (!pm_runtime_enabled(dev)) {
> -		if (dev->power.runtime_status == RPM_ACTIVE)
> +	int (*callback)(struct device *);
> +	int err;
> +
> +	if (pm_runtime_enabled(dev))
> +		return;
> +
> +	if (dev->power.runtime_status == RPM_ACTIVE) {
> +		if (dev->power.use_autosuspend) {
> +			__pm_runtime_use_autosuspend(dev, false);
> +			rpm_idle(dev, RPM_AUTO);

You get here only if runtime PM is disabled, right?  So the rpm_idle 
call won't do anything -- "disabled" means don't make any callbacks.

Tony, exactly what are you trying to do here?  Do you want this to 
invoke a runtime-PM callback in the subsystem, power domain, or driver?  
(Is there even a driver bound to the device when this function runs?)

The function's name suggests that it merely resets the data stored in 
dev->power without actually touching the hardware.  Is that what you 
really want?

Alan Stern

