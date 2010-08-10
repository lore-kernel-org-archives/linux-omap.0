From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: Issues with calling pm_runtime functions in
 platform_pm_suspend_noirq/IRQ disabled context.
Date: Tue, 10 Aug 2010 20:29:30 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E80AC503@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED0FDF@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1008061305360.5732@utopia.booyaka.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E800BD63@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1008082350130.8958@utopia.booyaka.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E800C34D@dbde02.ent.ti.com>
 <871va7n6pe.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57366 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143Ab0HJO7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 10:59:38 -0400
In-Reply-To: <871va7n6pe.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Monday, August 09, 2010 9:01 PM
> To: Basak, Partha
> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Kalliguddi, Hema; Raja,
> Govindraj; Varadarajan, Charulatha
> Subject: Re: Issues with calling pm_runtime functions in
> platform_pm_suspend_noirq/IRQ disabled context.
> 
> "Basak, Partha" <p-basak2@ti.com> writes:
> 
> >> Finally, we have omap_sram_idle():
> >>
> >> > In particular, for USB, while executing SRAM_Idle, is we use
> pm_runtime
> >> > functions, we see spurious IO-Pad interrupts.
> >>
> >> Your message doesn't specify what PM runtime functions you are
> executing.
> >> But if those functions are calling mutex_lock(), then they obviously
> must
> >> not be called from omap_sram_idle() in interrupt context.
> >>
> >> It's not clear from your message why you need to call PM runtime
> functions
> >> from the idle loop.  I'd suggest that you post the problematic code in
> >> question to the list.
> >>
> >
> > USB issue:
> >
> > Please refer to the USB patch attached (will be sent to the list as well
> in a few minutes)
> > As I mentioned previously, few drivers like GPIO, USB & UART have clock-
> disable/enable + context save/restore in Idle path(omap_sram_idle()).
> >
> > In particular, I am referring to calling of the functions
> pm_runtime_put_sync() & pm_runtime_get_sync() for USB around wfi.
> >
> > Now, the following call sequence from omap_sram_idle()will enable IRQs:
> > pm_runtime_put_sync-->
> > 	__pm_runtime_put-->
> > 		pm_runtime_idle-->
> > 			spin_unlock_irq(),
> > 			__pm_runtime_idle(),-->
> > 			 spin_unlock_irq,
> > 				spin_unlock_irq
> >
> > The functions pm_runtime_idle() & __ pm_runtime_idle() do not use
> > spin_lock_irqsave & spin_unlock_irqrestore. This leads to enabling of
> > the interrupts in omap_sram_idle unconditionally, which for USB in
> > particular is leading to IO-pad interrupt being triggered which does
> > not come otherwise.
> 
> You seem to have correctly identified the problem.  Can you try the
> patch below (untested) which attempts to address the root cause you've
> identified?
> 
> Kevin
> 
> > To work around this problem, instead of using Runtime APIs, we are using
> omap_device_enable/disable, which in-turn call to __omap_hwmod_enable/idle
> >
> > Simply put, I am not talking about grabbing a mutex when interrupts are
> disabled, rather of a scenario where interrupts are getting enabled as a
> side-effect of calling these functions in   omap_sram_idle().
> 
> From be3aeea5f8d29c8ce2fa278f48aef849eb682282 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@deeprootsystems.com>
> Date: Mon, 9 Aug 2010 08:12:39 -0700
> Subject: [PATCH] PM: allow runtime PM get/put from interrupts-disabled
> context
> 
> When using runtime PM in combination with CPUidle, the runtime PM
> transtions of some devices may be triggered during the idle path.
> Late in the idle sequence, interrupts may already be disabled when
> runtime PM for these devices is initiated (using the _sync versions of
> the runtime PM API.)
> 
> Currently, the runtime PM core assumes methods are called with
> interrupts enabled.  However, if it is called with interrupts
> disabled, the internal locking unconditionally enables interrupts, for
> example:
> 
> pm_runtime_put_sync()
>     __pm_runtime_put()
>         pm_runtime_idle()
>             spin_lock_irq()
>             __pm_runtime_idle()
>                 spin_unlock_irq()   <--- interrupts unconditionally
> enabled
>                 dev->bus->pm->runtime_idle()
>                 spin_lock_irq()
>              spin_unlock_irq()
> 
> To fix, use the save/restore versions of the spinlock API.
> 
> Reported-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  drivers/base/power/runtime.c |   68 ++++++++++++++++++++++---------------
> ----
>  include/linux/pm.h           |    1 +
>  2 files changed, 37 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index b0ec0e9..b02ef35 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -80,24 +80,24 @@ static int __pm_runtime_idle(struct device *dev)
>  	dev->power.idle_notification = true;
> 
>  	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_idle) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		dev->bus->pm->runtime_idle(dev);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  	} else if (dev->type && dev->type->pm && dev->type->pm-
> >runtime_idle) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		dev->type->pm->runtime_idle(dev);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  	} else if (dev->class && dev->class->pm
>  	    && dev->class->pm->runtime_idle) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		dev->class->pm->runtime_idle(dev);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  	}
> 
>  	dev->power.idle_notification = false;
> @@ -115,9 +115,9 @@ int pm_runtime_idle(struct device *dev)
>  {
>  	int retval;
> 
> -	spin_lock_irq(&dev->power.lock);
> +	spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  	retval = __pm_runtime_idle(dev);
> -	spin_unlock_irq(&dev->power.lock);
> +	spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
> 
>  	return retval;
>  }
> @@ -187,11 +187,13 @@ int __pm_runtime_suspend(struct device *dev, bool
> from_wq)
>  			if (dev->power.runtime_status != RPM_SUSPENDING)
>  				break;
> 
> -			spin_unlock_irq(&dev->power.lock);
> +			spin_unlock_irqrestore(&dev->power.lock,
> +					       dev->power.lock_flags);
> 
>  			schedule();
> 
> -			spin_lock_irq(&dev->power.lock);
> +			spin_lock_irqsave(&dev->power.lock,
> +					  dev->power.lock_flags);
>  		}
>  		finish_wait(&dev->power.wait_queue, &wait);
>  		goto repeat;
> @@ -201,27 +203,27 @@ int __pm_runtime_suspend(struct device *dev, bool
> from_wq)
>  	dev->power.deferred_resume = false;
> 
>  	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		retval = dev->bus->pm->runtime_suspend(dev);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  		dev->power.runtime_error = retval;
>  	} else if (dev->type && dev->type->pm
>  	    && dev->type->pm->runtime_suspend) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		retval = dev->type->pm->runtime_suspend(dev);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  		dev->power.runtime_error = retval;
>  	} else if (dev->class && dev->class->pm
>  	    && dev->class->pm->runtime_suspend) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		retval = dev->class->pm->runtime_suspend(dev);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  		dev->power.runtime_error = retval;
>  	} else {
>  		retval = -ENOSYS;
> @@ -257,11 +259,11 @@ int __pm_runtime_suspend(struct device *dev, bool
> from_wq)
>  		__pm_runtime_idle(dev);
> 
>  	if (parent && !parent->power.ignore_children) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		pm_request_idle(parent);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  	}
> 
>   out:
> @@ -278,9 +280,9 @@ int pm_runtime_suspend(struct device *dev)
>  {
>  	int retval;
> 
> -	spin_lock_irq(&dev->power.lock);
> +	spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  	retval = __pm_runtime_suspend(dev, false);
> -	spin_unlock_irq(&dev->power.lock);
> +	spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
> 
>  	return retval;
>  }
> @@ -342,11 +344,13 @@ int __pm_runtime_resume(struct device *dev, bool
> from_wq)
>  			    && dev->power.runtime_status != RPM_SUSPENDING)
>  				break;
> 
> -			spin_unlock_irq(&dev->power.lock);
> +			spin_unlock_irqrestore(&dev->power.lock,
> +					       dev->power.lock_flags);
> 
>  			schedule();
> 
> -			spin_lock_irq(&dev->power.lock);
> +			spin_lock_irqsave(&dev->power.lock,
> +					  dev->power.lock_flags);
>  		}
>  		finish_wait(&dev->power.wait_queue, &wait);
>  		goto repeat;
> @@ -384,27 +388,27 @@ int __pm_runtime_resume(struct device *dev, bool
> from_wq)
>  	dev->power.runtime_status = RPM_RESUMING;
> 
>  	if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		retval = dev->bus->pm->runtime_resume(dev);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  		dev->power.runtime_error = retval;
>  	} else if (dev->type && dev->type->pm
>  	    && dev->type->pm->runtime_resume) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		retval = dev->type->pm->runtime_resume(dev);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  		dev->power.runtime_error = retval;
>  	} else if (dev->class && dev->class->pm
>  	    && dev->class->pm->runtime_resume) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		retval = dev->class->pm->runtime_resume(dev);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  		dev->power.runtime_error = retval;
>  	} else {
>  		retval = -ENOSYS;
> @@ -425,11 +429,11 @@ int __pm_runtime_resume(struct device *dev, bool
> from_wq)
> 
>   out:
>  	if (parent) {
> -		spin_unlock_irq(&dev->power.lock);
> +		spin_unlock_irqrestore(&dev->power.lock, dev-
> >power.lock_flags);
> 
>  		pm_runtime_put(parent);
> 
> -		spin_lock_irq(&dev->power.lock);
> +		spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  	}
> 
>  	dev_dbg(dev, "__pm_runtime_resume() returns %d!\n", retval);
> @@ -445,9 +449,9 @@ int pm_runtime_resume(struct device *dev)
>  {
>  	int retval;
> 
> -	spin_lock_irq(&dev->power.lock);
> +	spin_lock_irqsave(&dev->power.lock, dev->power.lock_flags);
>  	retval = __pm_runtime_resume(dev, false);
> -	spin_unlock_irq(&dev->power.lock);
> +	spin_unlock_irqrestore(&dev->power.lock, dev->power.lock_flags);
> 
>  	return retval;
>  }
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 8e258c7..1a3d514 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -464,6 +464,7 @@ struct dev_pm_info {
>  	struct work_struct	work;
>  	wait_queue_head_t	wait_queue;
>  	spinlock_t		lock;
> +	unsigned long           lock_flags;
>  	atomic_t		usage_count;
>  	atomic_t		child_count;
>  	unsigned int		disable_depth:3;
> --
> 1.7.2.1

Thanks Kevin. This looks good from interrupt locking standpoint. We will test this patch on GPIO and USB and revert back. 

One question. Is it OK to call Schedule() with interrupts disabled?
