From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 3] PM: add synchronous runtime interface for interrupt handlers
Date: Fri, 26 Nov 2010 23:23:55 +0100
Message-ID: <201011262323.55655.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1011251052010.22247-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33310 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab0KZWYo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Nov 2010 17:24:44 -0500
In-Reply-To: <Pine.LNX.4.44L0.1011251052010.22247-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Thursday, November 25, 2010, Alan Stern wrote:
> This patch (as1431c) makes the synchronous runtime-PM interface
> suitable for use in interrupt handlers.  Subsystems can call the new
> pm_runtime_irq_safe() function to tell the PM core that a device's
> runtime_suspend and runtime_resume callbacks should be invoked with
> interrupts disabled and the spinlock held.  This permits the
> pm_runtime_get_sync() and the new pm_runtime_put_sync_suspend()
> routines to be called from within interrupt handlers.
> 
> When a device is declared irq-safe in this way, the PM core increments
> the parent's usage count, so the parent will never be runtime
> suspended.  This prevents difficult situations in which an irq-safe
> device can't resume because it is forced to wait for its non-irq-safe
> parent.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Applied to suspend-2.6/linux-next.

Thanks,
Rafael


> ---
> 
> Index: usb-2.6/include/linux/pm.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm.h
> +++ usb-2.6/include/linux/pm.h
> @@ -486,6 +486,7 @@ struct dev_pm_info {
>  	unsigned int		run_wake:1;
>  	unsigned int		runtime_auto:1;
>  	unsigned int		no_callbacks:1;
> +	unsigned int		irq_safe:1;
>  	unsigned int		use_autosuspend:1;
>  	unsigned int		timer_autosuspends:1;
>  	enum rpm_request	request;
> Index: usb-2.6/include/linux/pm_runtime.h
> ===================================================================
> --- usb-2.6.orig/include/linux/pm_runtime.h
> +++ usb-2.6/include/linux/pm_runtime.h
> @@ -40,6 +40,7 @@ extern int pm_generic_runtime_idle(struc
>  extern int pm_generic_runtime_suspend(struct device *dev);
>  extern int pm_generic_runtime_resume(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
> +extern void pm_runtime_irq_safe(struct device *dev);
>  extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
>  extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
>  extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
> @@ -123,6 +124,7 @@ static inline int pm_generic_runtime_idl
>  static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
>  static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
>  static inline void pm_runtime_no_callbacks(struct device *dev) {}
> +static inline void pm_runtime_irq_safe(struct device *dev) {}
>  
>  static inline void pm_runtime_mark_last_busy(struct device *dev) {}
>  static inline void __pm_runtime_use_autosuspend(struct device *dev,
> @@ -195,6 +197,11 @@ static inline int pm_runtime_put_sync(st
>  	return __pm_runtime_idle(dev, RPM_GET_PUT);
>  }
>  
> +static inline int pm_runtime_put_sync_suspend(struct device *dev)
> +{
> +	return __pm_runtime_suspend(dev, RPM_GET_PUT);
> +}
> +
>  static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
>  {
>  	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_AUTO);
> Index: usb-2.6/drivers/base/power/runtime.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/power/runtime.c
> +++ usb-2.6/drivers/base/power/runtime.c
> @@ -250,13 +250,16 @@ static int rpm_callback(int (*cb)(struct
>  	if (!cb)
>  		return -ENOSYS;
>  
> -	spin_unlock_irq(&dev->power.lock);
> +	if (dev->power.irq_safe) {
> +		retval = cb(dev);
> +	} else {
> +		spin_unlock_irq(&dev->power.lock);
>  
> -	retval = cb(dev);
> +		retval = cb(dev);
>  
> -	spin_lock_irq(&dev->power.lock);
> +		spin_lock_irq(&dev->power.lock);
> +	}
>  	dev->power.runtime_error = retval;
> -
>  	return retval;
>  }
>  
> @@ -404,7 +407,7 @@ static int rpm_suspend(struct device *de
>  		goto out;
>  	}
>  
> -	if (parent && !parent->power.ignore_children) {
> +	if (parent && !parent->power.ignore_children && !dev->power.irq_safe) {
>  		spin_unlock_irq(&dev->power.lock);
>  
>  		pm_request_idle(parent);
> @@ -527,10 +530,13 @@ static int rpm_resume(struct device *dev
>  
>  	if (!parent && dev->parent) {
>  		/*
> -		 * Increment the parent's resume counter and resume it if
> -		 * necessary.
> +		 * Increment the parent's usage counter and resume it if
> +		 * necessary.  Not needed if dev is irq-safe; then the
> +		 * parent is permanently resumed.
>  		 */
>  		parent = dev->parent;
> +		if (dev->power.irq_safe)
> +			goto skip_parent;
>  		spin_unlock(&dev->power.lock);
>  
>  		pm_runtime_get_noresume(parent);
> @@ -553,6 +559,7 @@ static int rpm_resume(struct device *dev
>  			goto out;
>  		goto repeat;
>  	}
> + skip_parent:
>  
>  	if (dev->power.no_callbacks)
>  		goto no_callback;	/* Assume success. */
> @@ -584,7 +591,7 @@ static int rpm_resume(struct device *dev
>  		rpm_idle(dev, RPM_ASYNC);
>  
>   out:
> -	if (parent) {
> +	if (parent && !dev->power.irq_safe) {
>  		spin_unlock_irq(&dev->power.lock);
>  
>  		pm_runtime_put(parent);
> @@ -1065,7 +1072,6 @@ EXPORT_SYMBOL_GPL(pm_runtime_allow);
>   * Set the power.no_callbacks flag, which tells the PM core that this
>   * device is power-managed through its parent and has no run-time PM
>   * callbacks of its own.  The run-time sysfs attributes will be removed.
> - *
>   */
>  void pm_runtime_no_callbacks(struct device *dev)
>  {
> @@ -1078,6 +1084,27 @@ void pm_runtime_no_callbacks(struct devi
>  EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
>  
>  /**
> + * pm_runtime_irq_safe - Leave interrupts disabled during callbacks.
> + * @dev: Device to handle
> + *
> + * Set the power.irq_safe flag, which tells the PM core that the
> + * ->runtime_suspend() and ->runtime_resume() callbacks for this device should
> + * always be invoked with the spinlock held and interrupts disabled.  It also
> + * causes the parent's usage counter to be permanently incremented, preventing
> + * the parent from runtime suspending -- otherwise an irq-safe child might have
> + * to wait for a non-irq-safe parent.
> + */
> +void pm_runtime_irq_safe(struct device *dev)
> +{
> +	if (dev->parent)
> +		pm_runtime_get_sync(dev->parent);
> +	spin_lock_irq(&dev->power.lock);
> +	dev->power.irq_safe = 1;
> +	spin_unlock_irq(&dev->power.lock);
> +}
> +EXPORT_SYMBOL_GPL(pm_runtime_irq_safe);
> +
> +/**
>   * update_autosuspend - Handle a change to a device's autosuspend settings.
>   * @dev: Device to handle.
>   * @old_delay: The former autosuspend_delay value.
> @@ -1199,4 +1226,6 @@ void pm_runtime_remove(struct device *de
>  	/* Change the status back to 'suspended' to match the initial status. */
>  	if (dev->power.runtime_status == RPM_ACTIVE)
>  		pm_runtime_set_suspended(dev);
> +	if (dev->power.irq_safe && dev->parent)
> +		pm_runtime_put_sync(dev->parent);
>  }
> Index: usb-2.6/Documentation/power/runtime_pm.txt
> ===================================================================
> --- usb-2.6.orig/Documentation/power/runtime_pm.txt
> +++ usb-2.6/Documentation/power/runtime_pm.txt
> @@ -50,6 +50,15 @@ type's callbacks are not defined) of giv
>  and device class callbacks are referred to as subsystem-level callbacks in what
>  follows.
>  
> +By default, the callbacks are always invoked in process context with interrupts
> +enabled.  However, subsystems can use the pm_runtime_irq_safe() helper function
> +to tell the PM core that a device's ->runtime_suspend() and ->runtime_resume()
> +callbacks should be invoked in atomic context with interrupts disabled
> +(->runtime_idle() is still invoked the default way).  This implies that these
> +callback routines must not block or sleep, but it also means that the
> +synchronous helper functions listed at the end of Section 4 can be used within
> +an interrupt handler or in an atomic context.
> +
>  The subsystem-level suspend callback is _entirely_ _responsible_ for handling
>  the suspend of the device as appropriate, which may, but need not include
>  executing the device driver's own ->runtime_suspend() callback (from the
> @@ -237,6 +246,10 @@ defined in include/linux/pm.h:
>        Section 8); it may be modified only by the pm_runtime_no_callbacks()
>        helper function
>  
> +  unsigned int irq_safe;
> +    - indicates that the ->runtime_suspend() and ->runtime_resume() callbacks
> +      will be invoked with the spinlock held and interrupts disabled
> +
>    unsigned int use_autosuspend;
>      - indicates that the device's driver supports delayed autosuspend (see
>        Section 9); it may be modified only by the
> @@ -344,6 +357,10 @@ drivers/base/power/runtime.c and include
>      - decrement the device's usage counter; if the result is 0 then run
>        pm_runtime_idle(dev) and return its result
>  
> +  int pm_runtime_put_sync_suspend(struct device *dev);
> +    - decrement the device's usage counter; if the result is 0 then run
> +      pm_runtime_suspend(dev) and return its result
> +
>    int pm_runtime_put_sync_autosuspend(struct device *dev);
>      - decrement the device's usage counter; if the result is 0 then run
>        pm_runtime_autosuspend(dev) and return its result
> @@ -397,6 +414,11 @@ drivers/base/power/runtime.c and include
>        PM attributes from /sys/devices/.../power (or prevent them from being
>        added when the device is registered)
>  
> +  void pm_runtime_irq_safe(struct device *dev);
> +    - set the power.irq_safe flag for the device, causing the runtime-PM
> +      suspend and resume callbacks (but not the idle callback) to be invoked
> +      with interrupts disabled
> +
>    void pm_runtime_mark_last_busy(struct device *dev);
>      - set the power.last_busy field to the current time
>  
> @@ -438,6 +460,15 @@ pm_runtime_suspended()
>  pm_runtime_mark_last_busy()
>  pm_runtime_autosuspend_expiration()
>  
> +If pm_runtime_irq_safe() has been called for a device then the following helper
> +functions may also be used in interrupt context:
> +
> +pm_runtime_suspend()
> +pm_runtime_autosuspend()
> +pm_runtime_resume()
> +pm_runtime_get_sync()
> +pm_runtime_put_sync_suspend()
> +
>  5. Run-time PM Initialization, Device Probing and Removal
>  
>  Initially, the run-time PM is disabled for all devices, which means that the
> 
> 
> 

