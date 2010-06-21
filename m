From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
Date: Mon, 21 Jun 2010 16:59:32 -0700
Message-ID: <87fx0gos2j.fsf@deeprootsystems.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
	<1274994799-30297-4-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032320719C@dbde02.ent.ti.com>
	<87mxvebrry.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1006210911150.1550@utopia.booyaka.com>
	<87hbkw1idx.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1006211130120.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57213 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424Ab0FUX7g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 19:59:36 -0400
Received: by pxi12 with SMTP id 12so1629763pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 16:59:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006211130120.1550@utopia.booyaka.com> (Paul Walmsley's message of "Mon\, 21 Jun 2010 15\:39\:24 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley <paul@pwsan.com> writes:

> On Mon, 21 Jun 2010, Kevin Hilman wrote:
>
>> Paul Walmsley <paul@pwsan.com> writes:
>> 
>> > As far as I can tell, it's not safe for upper-layer code to idle a device 
>> > like this.  The driver itself needs to be aware of the device's idle 
>> > state.  
>> 
>> The driver is made aware using the standard dev_pm_ops callback for
>> suspend and resume.
>
> I guess the intent of your patch is to avoid having to patch in 
> omap_device_{idle,enable}() into a bunch of driver DPM suspend/resume 
> callbacks?  

Partially.  Actually, I think many (most?) drivers can get rid of
static suspend/resume paths all together and just use runtime PM.

There are some cases though (MMC comes to mind, more on that below)
where static suspend has some extra steps necessary and behaves
differently than runtime PM.

For those cases, the goal is as you stated.  Basically, to avoid having
all the drivers having to call omap_device_idle().

> If so, some comments:
> - dev_pm_ops->suspend_noirq() is intended for use on devices with
>   shared interrupts.  

Just to clarify.  The functions I'm overriding here is the bus
functions (bus->pm->[suspend|resume]_noirq(), not any driver functions

Indeed, shared IRQs were an intended usage, but I don't see that as a
requirement.  Indeed, Documentation/power/devices.txt even seems to
suggest that the _noirq version is the place to turn the device "as
off as possible:

    "For simple drivers, suspend might quiesce the device using class code
    and then turn its hardware as "off" as possible during suspend_noirq"

>   Right now the OMAP2+ codebase doesn't use any
>   shared interrupts for on-chip devices, as far as I can see.  It
>   looks like you use ->suspend_noirq() to ensure your code runs after
>   the existing driver suspend functions.  

No. The primary reason for using _noirq() is that if any driver ever
did use the _noirq() hooks (for any atomic activity, or late wakeup
detection, etc.)  the device will still be accessible.

>   Using ->suspend_noirq() for this purpose seems like a hack.  
>   A better place for that code would be in a bus->pm->suspend()
>   callback, which will run after the device's dev_pm_ops->suspend()
>   callback.

I originally put it in bus->pm->suspend, but moved it to
bus->pm->suspend_noirq() since I didn't do a full audit so see
if anything was using the _noirq hooks.

If we want to have a requirement that no on-chip devices can use the
_noirq hooks (or at least they can't touch hardware in those hooks)
then I can move it back to bus->pm->suspend().  But personally, I
would see that as an artificial requirement based on a very
restrictive definiton of the _noirq() methods.

> - It is not safe to call omap_device_{idle,enable}() from DPM
>   callbacks as the patch does, because they will race with runtime PM
>   calls to omap_device_{idle,enable}().  

No, they cannot race.  

Runtime PM transitions are prevented by the system PM core during a
system PM transition.  The system suspend path does a pm_runtime_get()
for each device being suspended, and then does a _put() upon resume.
(see drivers/base/power/main.c, grep for pm_runtime_)

>   (This is part of the reason
>   why it's important to be anal about enforcing the
>   omap_device_{enable,idle,shutdown}() state transition limitations -
>   so we get warned early when these types of conflicts appear.)
>
>   omap_device*() calls should either be in runtime PM functions, or
>   DPM ->suspend/resume() callbacks, but not both.  

Why not both?  I don't follow the reason for this restriction.  We
certainly did the equivalent clock enable/disable calls in both cases
in the past.

>   Since we've decided
>   to focus on runtime PM power management as our primary driver power
>   management approach, and we expect drivers to aggressively idle
>   their devices, it seems best to keep the omap_device*() functions in
>   runtime PM code.

I agree, mostly.

As I mentioned above, I expect most drivers not to even have system PM
methods implemented.  They should implement everything as runtime PM.
However, there will be some exceptions.

The use case that brought this patch into existence was the MMC driver
where the suspend hook had to do some extra "stuff" before suspending.
Even if already runtime suspended, the MMC suspend hook has to
re-enable the device do "stuff" and then re-idle the device.

Initially, I tried to just use the same runtime PM calls in the
suspend hook, but that doesn't work since runtime PM transitions are
prevented during system PM.  So, I was forced to call
omap_device_idle() in the suspend path, which led to the decision to
move that into common code.

>   At that point, the common DPM suspend/idle callbacks that you
>   propose can simply block until runtime PM indicates that the device
>   is idle.  
>
>   For example, you could use a per-omap_device mutex.
>   A sketch of a sample implementation follows this message.

That is an option, but since there is no potential racing between
runtime PM and system PM, I don't see the need for extra locking.

Also, in your example, by manually [dis|en]abling IRQs, you're
re-inventing the _noirq versions of the hooks, even though the DPM
core is going to do it (again) soon.  

I'd rather just use the noirq hooks that are already in place, and let
the driver manage IRQs itself.  Especially when it comes to wakeup
IRQs, I think it problematic to start managing IRQs in common code.

Kevin


>
>
> - Paul
>
>
> In omap_device.c, add
>
> int omap_device_suspend_mpu_irqs(struct omap_device *od)
> {
> 	/*
>          * For each hwmod, for each MPU IRQ, save current state,
>          * disable_irq(irq)
>          */
> }
>
> int omap_device_resume_mpu_irqs(struct omap_device *od)
> {
> 	/*
>          * For each hwmod, for each MPU IRQ, enable_irq(irq) if
>          * it was previously
>          */
> }
>
>
> In your bus->pm->suspend()/resume() functions:
>
> int omap_bus_suspend(struct device *dev, pm_message_t state)
> {
>         dev_dbg("waiting for device %s to go idle\n", dev_name(dev));
>
>         mutex_lock(&od->active_mutex);
>
>         /* Device guaranteed to be idle at this point */
>
>         /*
>          * do anything else necessary to ensure that driver code is not
>          * entered after the unlock()
>          */
>         omap_device_suspend_mpu_irqs(od);
>
>         mutex_unlock(&od->active_mutex);
>
>         return 0;
> }
>
> int omap_bus_resume(struct device *dev, pm_message_t state)
> {
>         mutex_lock(&od->active_mutex);
>
>         /* Device guaranteed to be idle at this point */
>     
>         /*
>          * do anything else necessary to ensure that driver code can
>          * be entered after the unlock()
>          */
>         omap_device_resume_mpu_irqs(od);
>
>         mutex_unlock(&od->active_mutex);
>
>         return 0;
> }
>
>
> Then in the omap_device code, add a mutex active_mutex in struct
> omap_device, init the mutex in omap_device_build_ss(), then:
>
> int omap_device_enable(struct platform_device *pdev)
> {
>        struct omap_device *od;
>
>        od = _find_by_pdev(pdev);
>
>        ...
>        WARN(!mutex_trylock(&od->active_mutex),
>             "State transition violation - should never happen\n");
>        mutex_lock(&od->active_mutex);
>        ...
> }
>  
> int omap_device_idle(struct platform_device *pdev)
> {
>         struct omap_device *od;
>
>         od = _find_by_pdev(pdev);
>
>         ...
>         mutex_unlock(&od->active_mutex);
>         ...
> }
>
> int omap_device_shutdown(struct platform_device *pdev)
> {
>         struct omap_device *od;
>
>         od = _find_by_pdev(pdev);
>
>         ...
>         mutex_unlock(&od->active_mutex);
>         ...
> }
>
>
> The driver needs the usual: 
>
> - add a DPM ->suspend() function that tries to stop whatever the
>   device is doing if it's in the middle of something that can be
>   stopped;
>
> - ensure all paths that start new I/O check dev->power.status, and
>   return an error if it is DPM_SUSPENDING
>
>
>
> - Paul

