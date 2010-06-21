From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
Date: Mon, 21 Jun 2010 15:39:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006211130120.1550@utopia.booyaka.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com> <1274994799-30297-4-git-send-email-khilman@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB032320719C@dbde02.ent.ti.com> <87mxvebrry.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.1006210911150.1550@utopia.booyaka.com> <87hbkw1idx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41474 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758606Ab0FUVjZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 17:39:25 -0400
In-Reply-To: <87hbkw1idx.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nayak\\, Rajendra" <rnayak@ti.com>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 21 Jun 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > As far as I can tell, it's not safe for upper-layer code to idle a device 
> > like this.  The driver itself needs to be aware of the device's idle 
> > state.  
> 
> The driver is made aware using the standard dev_pm_ops callback for
> suspend and resume.

I guess the intent of your patch is to avoid having to patch in 
omap_device_{idle,enable}() into a bunch of driver DPM suspend/resume 
callbacks?  If so, some comments:

- dev_pm_ops->suspend_noirq() is intended for use on devices with
  shared interrupts.  Right now the OMAP2+ codebase doesn't use any
  shared interrupts for on-chip devices, as far as I can see.  It
  looks like you use ->suspend_noirq() to ensure your code runs after
  the existing driver suspend functions.  Using ->suspend_noirq() for
  this purpose seems like a hack.  A better place for that code would
  be in a bus->pm->suspend() callback, which will run after the
  device's dev_pm_ops->suspend() callback.

- It is not safe to call omap_device_{idle,enable}() from DPM
  callbacks as the patch does, because they will race with runtime PM
  calls to omap_device_{idle,enable}().  (This is part of the reason
  why it's important to be anal about enforcing the
  omap_device_{enable,idle,shutdown}() state transition limitations -
  so we get warned early when these types of conflicts appear.)

  omap_device*() calls should either be in runtime PM functions, or
  DPM ->suspend/resume() callbacks, but not both.  Since we've decided
  to focus on runtime PM power management as our primary driver power
  management approach, and we expect drivers to aggressively idle
  their devices, it seems best to keep the omap_device*() functions in
  runtime PM code.

  At that point, the common DPM suspend/idle callbacks that you
  propose can simply block until runtime PM indicates that the device
  is idle.  For example, you could use a per-omap_device mutex.
  A sketch of a sample implementation follows this message.


- Paul


In omap_device.c, add

int omap_device_suspend_mpu_irqs(struct omap_device *od)
{
	/*
         * For each hwmod, for each MPU IRQ, save current state,
         * disable_irq(irq)
         */
}

int omap_device_resume_mpu_irqs(struct omap_device *od)
{
	/*
         * For each hwmod, for each MPU IRQ, enable_irq(irq) if
         * it was previously
         */
}


In your bus->pm->suspend()/resume() functions:

int omap_bus_suspend(struct device *dev, pm_message_t state)
{
        dev_dbg("waiting for device %s to go idle\n", dev_name(dev));

        mutex_lock(&od->active_mutex);

        /* Device guaranteed to be idle at this point */

        /*
         * do anything else necessary to ensure that driver code is not
         * entered after the unlock()
         */
        omap_device_suspend_mpu_irqs(od);

        mutex_unlock(&od->active_mutex);

        return 0;
}

int omap_bus_resume(struct device *dev, pm_message_t state)
{
        mutex_lock(&od->active_mutex);

        /* Device guaranteed to be idle at this point */
    
        /*
         * do anything else necessary to ensure that driver code can
         * be entered after the unlock()
         */
        omap_device_resume_mpu_irqs(od);

        mutex_unlock(&od->active_mutex);

        return 0;
}


Then in the omap_device code, add a mutex active_mutex in struct
omap_device, init the mutex in omap_device_build_ss(), then:

int omap_device_enable(struct platform_device *pdev)
{
       struct omap_device *od;

       od = _find_by_pdev(pdev);

       ...
       WARN(!mutex_trylock(&od->active_mutex),
            "State transition violation - should never happen\n");
       mutex_lock(&od->active_mutex);
       ...
}
 
int omap_device_idle(struct platform_device *pdev)
{
        struct omap_device *od;

        od = _find_by_pdev(pdev);

        ...
        mutex_unlock(&od->active_mutex);
        ...
}

int omap_device_shutdown(struct platform_device *pdev)
{
        struct omap_device *od;

        od = _find_by_pdev(pdev);

        ...
        mutex_unlock(&od->active_mutex);
        ...
}


The driver needs the usual: 

- add a DPM ->suspend() function that tries to stop whatever the
  device is doing if it's in the middle of something that can be
  stopped;

- ensure all paths that start new I/O check dev->power.status, and
  return an error if it is DPM_SUSPENDING



- Paul
