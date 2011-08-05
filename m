From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: use put_sync_suspend instead of put_sync
Date: Thu, 04 Aug 2011 17:18:37 -0700
Message-ID: <87fwlgww0y.fsf@ti.com>
References: <1312494011-18745-1-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312494011-18745-1-git-send-email-m-sonasath-l0cyMroinI0@public.gmane.org> (Moiz
	Sonasath's message of "Thu, 4 Aug 2011 16:40:11 -0500")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, Axel Haslam <axelhaslam-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org> writes:

> From: Axel Haslam <axelhaslam-l0cyMroinI0@public.gmane.org>
>
> As Documented in runtime documentation, drivers can call put_sync
> in contexts where sleep is allowed, in contexts where sleep is not
> possible, the drivers need to mark these as to be made interrupt
> safe and also use put_sync_suspend instead of put_sync as the idle
> callbacks will be called with interrupt enabled - which is not
> a good thing to happen in isr context.

There are several things happening in this patch, and I think this needs
to be broken into separate fixes/features.

Re: the put_sync_suspend change, for mainline, I posted a fix that
allows a "normal" _put_sync() to work from IRQ-safe context:

https://lists.linux-foundation.org/pipermail/linux-pm/2011-July/032261.html

That will be merging for v3.2, likely for v3.1-rc and possible for
v3.0.stable, so while changing the driver is harmless, it's no longer
necessary.

[...]

> A call to pm_runtime_irq_safe, will indefently prevent the parent from
> sleeping by doing a call to get-sync on the parent.  this is "to
> prevent a irq-safe child to wait for a non-irq safe parent."  For this
> reason, the parent runtime-pm suspend is blocked, and we dont let L3
> and CORE enter into low power.

First, you should describe why you need to use pm_runtime_irq_safe() in
the first place, since the rest of the "workarounds" in this patch are a
result of using that.  For those of us not intimately familar with this
driver, a description of why IRQ-safe callbacks are needed would be most
helpful.

It might be that a simpler solution would be switching to using
asynchronous runtime PM calls so that IRQ-safe mode is not required.

> As a workaround, we call the parent runtime functions on the child
> runtime hooks, for this to work, the parent has to be set to ignere
> children, otherwise, even with a "timmed" autosuspend call, will
> return BUSY, as the child is not yet suspended.

Hmm, why is the child not yet suspended when the parent's autosuspend
delay expires?

Also, It's not clear to me how the parent is eventually suspending at
all.  After pm_runtime_irq_safe() is called on the child, the parent
should *never* runtime suspend.   Not only does pm_runtime_irq_safe() do
a get_sync() on the parent, but rpm_suspend() has an explict check for
!dev->power.irq_safe before suspending the parent.

Something else must be going on (actually, going wrong) in order for the
parent device to runtime suspend.

Is the problem with L3/CORE not runtime suspending?  or is it a problem
with system suspend?  If system suspend, are you using current mainline?
There is now support at the omap_device level[1] to ensure all devices are
idled at the omap_device level during system suspend.

> This patch is based off:
> https://lkml.org/lkml/2011/7/20/357
>
> Signed-off-by: Axel Haslam <axelhaslam-l0cyMroinI0@public.gmane.org>
> Reported-by: Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c   |    9 +++++++++
>  drivers/usb/musb/musb_gadget.c |    2 +-
>  drivers/usb/musb/omap2430.c    |    4 +++-
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index c71b037..d22bc73 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1941,7 +1941,11 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  
>  	pm_runtime_use_autosuspend(musb->controller);
>  	pm_runtime_set_autosuspend_delay(musb->controller, 200);
> +	pm_runtime_use_autosuspend(musb->controller->parent);
> +	pm_runtime_set_autosuspend_delay(musb->controller->parent, 500);
> +	pm_suspend_ignore_children(musb->controller->parent,true);

Running checkpatch would have yelled at you on this line:

ERROR: space required after that ',' (ctx:VxV)

>  	pm_runtime_enable(musb->controller);
> +	pm_runtime_irq_safe(musb->controller);
>  
>  	spin_lock_init(&musb->lock);
>  	musb->board_mode = plat->mode;
> @@ -2375,6 +2379,9 @@ static int musb_runtime_suspend(struct device *dev)
>  
>  	musb_save_context(musb);
>  
> +	pm_runtime_mark_last_busy(musb->controller->parent);
> +	pm_runtime_put_autosuspend(musb->controller->parent);
> +
>  	return 0;
>  }
>  
> @@ -2392,6 +2399,8 @@ static int musb_runtime_resume(struct device *dev)
>  	 * Also context restore without save does not make
>  	 * any sense
>  	 */
> +	if (pm_runtime_suspended(dev->parent))

Why this check?

> +		pm_runtime_get_sync(dev->parent);
>  	if (!first)
>  		musb_restore_context(musb);
>  	first = 0;
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 548338c..d5d8f3a 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1710,7 +1710,7 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
>  	}
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  
> -	pm_runtime_put(musb->controller);
> +	pm_runtime_put_sync_suspend(musb->controller);
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index c5d4c44..8b6888d 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -471,6 +471,7 @@ static int __init omap2430_probe(struct platform_device *pdev)
>  	}
>  
>  	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_irq_safe(&pdev->dev);
>  
>  	return 0;
>  
> @@ -516,7 +517,8 @@ static int omap2430_runtime_resume(struct device *dev)
>  	struct musb			*musb = glue_to_musb(glue);
>  
>  	omap2430_low_level_init(musb);
> -	otg_set_suspend(musb->xceiv, 0);
> +	if (musb->xceiv)
> +		otg_set_suspend(musb->xceiv, 0);

This looks like an unrelated fix that should have it's own patch and
description.

>  
>  	return 0;
>  }

Kevin



[1] This is merged in mainline for v3.1

commit c03f007a8bf0e092caeb6856a5c8a850df10b974
Author: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Date:   Tue Jul 12 22:48:19 2011 +0200

    OMAP: PM: omap_device: add system PM methods for PM domain handling
    
    In the omap_device PM domain callbacks, use omap_device idle/enable to
    automatically manage device idle states during system suspend/resume.
    
    If an omap_device has not already been runtime suspended, the
    ->suspend_noirq() method of the PM domain will use omap_device_idle()
    to idle the HW after calling the driver's ->runtime_suspend()
    callback.  Similarily, upon resume, if the device was suspended during
    ->suspend_noirq(), the ->resume_noirq() method of the PM domain will
    use omap_device_enable() to enable the HW and then call the driver's
    ->runtime_resume() callback.
    
    If a device has already been runtime suspended, the noirq methods of
    the PM domain leave the device runtime suspended by default.
    
    However, if a driver needs to runtime resume a device during suspend
    (for example, to change its wakeup settings), it may do so using
    pm_runtime_get* in it's ->suspend() callback.
    
    Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
    Signed-off-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
