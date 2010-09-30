From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Thu, 30 Sep 2010 22:15:59 +0200
Message-ID: <201009302215.59937.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009301420520.1314-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33502 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab0I3URI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 16:17:08 -0400
In-Reply-To: <Pine.LNX.4.44L0.1009301420520.1314-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

Hi,

On Thursday, September 30, 2010, Alan Stern wrote:
> This patch (as1431) adds a synchronous runtime-PM interface suitable
> for use in interrupt handlers.  Four new helper functions are defined:
> 
> 	pm_runtime_suspend_irq(), pm_runtime_resume_irq(),
> 	pm_runtime_get_sync_irq(), pm_runtime_put_sync_irq(),
> 
> together with pm_runtime_callbacks_in_irq(), which subsystems use to
> tell the PM core that the runtime callbacks should be invoked with
> interrupts disabled.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> In the end it turned out that a new RPM_IRQ call flag was needed along
> with the callbacks_in_irq flag in dev_pm_info.  The latter is required
> for the reasons I explained before, and RPM_IRQ tells the core whether
> or not it must leave interrupts disabled while waiting for a concurrent
> state change.
> 
> Kevin, this should be good enough to satisfy all your needs.  How does 
> it look?
> 
> Alan Stern
> 
> 
> Index: usb-2.6/include/linux/pm.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm.h
> +++ usb-2.6/include/linux/pm.h
> @@ -485,6 +485,7 @@ struct dev_pm_info {
>  	unsigned int		run_wake:1;
>  	unsigned int		runtime_auto:1;
>  	unsigned int		no_callbacks:1;
> +	unsigned int		callbacks_in_irq:1;

I kind of don't like this name.  What about irq_safe ?

>  	unsigned int		use_autosuspend:1;
>  	unsigned int		timer_autosuspends:1;
>  	enum rpm_request	request;
> Index: usb-2.6/include/linux/pm_runtime.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm_runtime.h
> +++ usb-2.6/include/linux/pm_runtime.h
> @@ -21,6 +21,7 @@
>  #define RPM_GET_PUT		0x04	/* Increment/decrement the
>  					    usage_count */
>  #define RPM_AUTO		0x08	/* Use autosuspend_delay */
> +#define RPM_IRQ			0x10	/* Don't enable interrupts */
>  
>  #ifdef CONFIG_PM_RUNTIME
>  
> @@ -40,6 +41,7 @@ extern int pm_generic_runtime_idle(struc
>  extern int pm_generic_runtime_suspend(struct device *dev);
>  extern int pm_generic_runtime_resume(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
> +extern void pm_runtime_callbacks_in_irq(struct device *dev);

Perhaps this one can be called pm_runtime_irq_safe() in analogy to the struct
member?

>  extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
>  extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
>  extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
> @@ -123,6 +125,7 @@ static inline int pm_generic_runtime_idl
>  static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
>  static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
>  static inline void pm_runtime_no_callbacks(struct device *dev) {}
> +static inline void pm_runtime_callbacks_in_irq(struct device *dev) {}
>  
>  static inline void pm_runtime_mark_last_busy(struct device *dev) {}
>  static inline void __pm_runtime_use_autosuspend(struct device *dev,
> @@ -144,6 +147,11 @@ static inline int pm_runtime_suspend(str
>  	return __pm_runtime_suspend(dev, 0);
>  }
>  
> +static inline int pm_runtime_suspend_irq(struct device *dev)
> +{
> +	return __pm_runtime_suspend(dev, RPM_IRQ);
> +}
> +
>  static inline int pm_runtime_autosuspend(struct device *dev)
>  {
>  	return __pm_runtime_suspend(dev, RPM_AUTO);
> @@ -154,6 +162,11 @@ static inline int pm_runtime_resume(stru
>  	return __pm_runtime_resume(dev, 0);
>  }
>  
> +static inline int pm_runtime_resume_irq(struct device *dev)
> +{
> +	return __pm_runtime_resume(dev, RPM_IRQ);
> +}
> +
>  static inline int pm_request_idle(struct device *dev)
>  {
>  	return __pm_runtime_idle(dev, RPM_ASYNC);
> @@ -179,6 +192,11 @@ static inline int pm_runtime_get_sync(st
>  	return __pm_runtime_resume(dev, RPM_GET_PUT);
>  }
>  
> +static inline int pm_runtime_get_sync_irq(struct device *dev)
> +{
> +	return __pm_runtime_resume(dev, RPM_GET_PUT | RPM_IRQ);
> +}
> +
>  static inline int pm_runtime_put(struct device *dev)
>  {
>  	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
> @@ -195,6 +213,11 @@ static inline int pm_runtime_put_sync(st
>  	return __pm_runtime_idle(dev, RPM_GET_PUT);
>  }
>  
> +static inline int pm_runtime_put_sync_irq(struct device *dev)
> +{
> +	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_IRQ);
> +}
> +
>  static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
>  {
>  	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_AUTO);
> Index: usb-2.6/drivers/base/power/runtime.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/runtime.c
> +++ usb-2.6/drivers/base/power/runtime.c
> @@ -170,10 +170,13 @@ static int rpm_idle(struct device *dev, 
>  	__releases(&dev->power.lock) __acquires(&dev->power.lock)
>  {
>  	int retval;
> +	int (*func)(struct device *dev);
>  
>  	retval = rpm_check_suspend_allowed(dev);
>  	if (retval < 0)
>  		;	/* Conditions are wrong. */
> +	else if ((rpmflags & RPM_IRQ) && !dev->power.callbacks_in_irq)
> +		retval = -EWOULDBLOCK;
>  
>  	/* Idle notifications are allowed only in the RPM_ACTIVE state. */
>  	else if (dev->power.runtime_status != RPM_ACTIVE)
> @@ -214,25 +217,27 @@ static int rpm_idle(struct device *dev, 
>  
>  	dev->power.idle_notification = true;
>  
> -	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle) {
> -		spin_unlock_irq(&dev->power.lock);
> -
> -		dev->bus->pm->runtime_idle(dev);
> -
> -		spin_lock_irq(&dev->power.lock);
> -	} else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle) {
> -		spin_unlock_irq(&dev->power.lock);
> +	func = NULL;
> +	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle)
> +		func = dev->bus->pm->runtime_idle;
> +	else if (dev->type && dev->type->pm && dev->type->pm->runtime_idle)
> +		func = dev->type->pm->runtime_idle;
> +	else if (dev->class && dev->class->pm && dev->class->pm->runtime_idle)
> +		func = dev->class->pm->runtime_idle;
> +	if (func) {
> +		if (dev->power.callbacks_in_irq) {
> +			spin_unlock(&dev->power.lock);

Hmm.  This looks rather complicated.  I don't really feel good about this
change.  It seems to me that it might be better to actually implement
the _irq() helpers from scratch.  I think I'll try to do that.

Overall, it looks like there's some overlap between RPM_IRQ and
power.callbacks_in_irq, where the latter may influence the behavior of the
helpers even if RPM_IRQ is unset.

I think we should return error code if RPM_IRQ is used, but 
power.callbacks_in_irq is not set.  If RPM_IRQ is not set, but
power.callbacks_in_irq is set, we should fall back to the normal behavior
(ie. do not avoid sleeping).

That's why I think it's better to change the name of power.callbacks_in_irq
to power.irq_safe.

Also I think we should refuse to set power.callbacks_in_irq for a device
whose partent (1) doesn't have power.callbacks_in_irq and (2) doesn't
have power.ignore_children set , and (3) doesn't have power.disable_depth > 0.
Then, once we've set power.callbacks_in_irq for a device, we should take
this into consideration when trying to change the parent's settings.

There probably is more subtelties like this, but I can't see them at the moment.

Thanks,
Rafael
