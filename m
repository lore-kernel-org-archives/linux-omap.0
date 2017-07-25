From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: drop broken RPM status update
 from suspend_noirq
Date: Tue, 25 Jul 2017 10:24:44 +0200
Message-ID: <20170725082444.GL2729@localhost>
References: <20170724095201.21601-1-johan@kernel.org>
 <05ae4585-8da0-6fb1-8cfd-6b236ec3a8a2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <05ae4585-8da0-6fb1-8cfd-6b236ec3a8a2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Johan Hovold <johan@kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Dave Gerlach <d-gerlach@ti.com>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 24, 2017 at 05:16:02PM -0500, Grygorii Strashko wrote:
> On 07/24/2017 04:52 AM, Johan Hovold wrote:
> > Since commit a8636c89648a ("PM / Runtime: Don't allow to suspend a
> > device with an active child"), which went into 4.10, it is no longer
> > permitted to set RPM_SUSPENDED state for a device with active children
> > (unless power.ignore_children is set).
> > 
> > This specifically means that the attempts to do just that from the omap
> > pm-domain suspend_noirq callback have since been failing whenever a
> > child is active, for example:
> > 
> >    am335x-usb-childs 47400000.usb: runtime PM trying to suspend
> >      device but active child
> > 
> > Silence this warning by dropping the broken pm_runtime_set_suspended()
> > call from the omap suspend_noirq callback along with the redundant
> > pm_runtime_set_active() in resume_noirq.
> > 
> > This effectively reverts commit 3522bf7bfa24 ("ARM: OMAP2+: omap_device:
> > maintain sane runtime pm status around suspend/resume"), which started
> > updating the RPM state after the runtime_suspend callback (!) for active
> > omap devices had been called during system suspend. The rationale was
> > that a later pm_runtime_get_sync() would then fail (even after runtime
> > pm had been disabled) and that this in turn would avoid any external
> > aborts when accessing registers with clocks disabled. (See also commit
> > 6f3c77b040fc ("PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE,
> > even when disabled, v2").
> > 
> > But during the suspend_noirq phase all children would already have been
> > suspended and their drivers would specifically not attempt any further
> > register accesses. And if this was all just a workaround for random
> > device drivers doing cross-tree calls during system suspend, those
> > drivers should be fixed and updated to explicitly model such
> > dependencies using device-links instead (and either way, any such calls
> > have been causing crashes since 4.10).
> 
> I'd like to provide some background and comments here.
> 
> 1) OMAP platform is PM runtime centric - in other words all device's
> PM operations (power on/off) are done through PM runtime calls and
> devices drivers do not really change device's Power states during
> suspend/resume - just do preparation for suspend. The final disabling
> of devices is done form _od_suspend_noirq() or if device driver calls
> pm_runtime_force_suspend() directly during suspend.
> 
> 2) Initially all this suspend_noirq code was introduced due to commit
> 
> commit 1e2ef05bb8cf851a694d38e9170c89e7ff052741
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Wed Jul 6 10:51:58 2011 +0200
> 
>     PM: Limit race conditions between runtime PM and system sleep (v2)
> 
> which blocks PM runtime during suspend resume. And, at that time,
> there were no pm_runtime_force_suspend/resume() neither proper support
> for power domains.
> 
> As result, below two calls really switch OFF device and its state
> should be RPM_SUSPENDED as it will reflect real PM state of HW:
> 	m_generic_runtime_suspend(dev)
> 	omap_device_idle(pdev);

That's the point to be discussed; does the runtime status really need to
reflect the hardware state *during* suspend?

As you've noticed, not all subsystems enforce that, even if omap seems
to have been expecting it.

And as I mentioned in the commit message, at least the point about
wanting to have late pm_runtime_get_sync() fail during suspend appears
to be moot.

> In general, now the code in _od_resume/resume_noirq() callback is
> equivalent to pm_runtime_force_suspend/resume().
> 
> 3) It's expected to ignore -EBUSY return code from
> pm_generic_runtime_suspend(dev) in _od_suspend_noirq(), as such code
> (-EBUSY) tells OMAP device framework that device should be kept active
> during suspend (for example serial device in case of
> "no_console_suspend").
> 
> commit 4b7ec5accecdb136c7afaf8739a06d5335cc05aa
> Author: Sourav Poddar <sourav.poddar@ti.com>
> Date:   Sat Apr 27 01:55:34 2013 +0530
> 
>     arm: omap2+: omap_device: remove no_idle_on_suspend
> 
> As result, when "runtime PM trying to suspend device but active child"
> happens the OMAP device framework will ignore it and gracefully
> continue to suspend where target device will finally powered off
> (depending on suspend mode and device).  On resume, target device will
> not be powered on, because its state was not marked as
> OMAP_DEVICE_SUSPENDED, so further attempts to power on device with
> pm_runtime_get_sync() will be a NOP (because device state is
> RPM_ACTIVE) and any access to the device will fail (system crash).

I believe you're mistaken here; _od_suspend_noirq() will continue to
power-off *and* set OMAP_DEVICE_SUSPENDED, so that device is again
powered during resume_noirq also after this patch has been applied.

Specifically, note that the return value of pm_runtime_set_suspended()
was never checked, so the only difference here would be that the error
message is suppressed.

> 4) Unfortunately, commit a8636c89648a ("PM / Runtime: Don't allow to
> suspend a device with an active child") "breaks" OMAP suspend
> functionality (or makes visible more fundamental issues of PM runtime
> vs Sys suspend), because not all Kernel subsystem (especially USB)
> maintain their devices PM runtime state properly during suspend, which
> cause pm_runtime_set_suspended() (or pm_runtime_force_suspend()) to
> return -EBUSY and, as result, misbehave of OMAP device framework.

Again, the return value of pm_runtime_set_suspended() was never checked
so the only thing commit a8636c89648a ("PM / Runtime: Don't allow to
suspend a device with an active child") did was to trigger those error
messages and leave the runtime PM state at RPM_ACTIVE. The latter does
not seems to have any other side effects, and specifically, the device
would still be powered off.

> My personal thought here is that removing of pm_runtime_set_active()
> will not fix root cause of the problem, but rather hide it :( and,
> probably, real fix will be to update USB framework to ensure that all
> suspend devices are also PM runtime suspend (not sure how) or add few
> more pm_suspend_ignore_children() calls (for example as I've tried to
> do in [2], but this was unfinished).
> 
> I've found very simple steps to reproduce suspend failure on
> am335x-evm (should also > work on BBB) -  do below sequence with USB
> device plugged:
> 
>    echo platform > /sys/power/pm_test 
>    echo 1 > /sys/power/pm_print_times 
>    [ echo 0 > /sys/module/printk/parameters/console_suspend ]
>    echo mem > /sys/power/state 
> 
> [   95.499685] calling  47400000.usb+ @ 733, parent: ocp
> [   95.504818] am335x-usb-childs 47400000.usb: runtime PM trying to suspend device but active child
> [   95.513750] am335x-usb-childs 47400000.usb: omap device suspend failure 0
> 
> Below I've attached possible patch which converts OMAP device to
> use pm_runtime_force_suspend/resume().

What code are you running above? The OMAP PM code should not be failing
due to that error message at least (as mentioned twice above).

I have musb suspend working on BBB with the patch I posted yesterday
which keeps the controller at RPM_ACTIVE during suspend:

	https://marc.info/?i=20170724094939.21477-1-johan%40kernel.org

Thanks,
Johan
