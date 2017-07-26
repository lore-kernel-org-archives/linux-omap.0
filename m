From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: drop broken RPM status update
 from suspend_noirq
Date: Wed, 26 Jul 2017 09:50:04 +0200
Message-ID: <20170726075004.GD27516@localhost>
References: <20170724095201.21601-1-johan@kernel.org>
 <05ae4585-8da0-6fb1-8cfd-6b236ec3a8a2@ti.com>
 <20170725082444.GL2729@localhost>
 <3f0f8ed2-9466-d5c9-10e4-de95e5155653@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f0f8ed2-9466-d5c9-10e4-de95e5155653@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Johan Hovold <johan@kernel.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Dave Gerlach <d-gerlach@ti.com>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 25, 2017 at 12:48:40PM -0500, Grygorii Strashko wrote:
> Hi Johan,
> 
> On 07/25/2017 03:24 AM, Johan Hovold wrote:
> > On Mon, Jul 24, 2017 at 05:16:02PM -0500, Grygorii Strashko wrote:
> >> On 07/24/2017 04:52 AM, Johan Hovold wrote:
> >>> Since commit a8636c89648a ("PM / Runtime: Don't allow to suspend a
> >>> device with an active child"), which went into 4.10, it is no longer
> >>> permitted to set RPM_SUSPENDED state for a device with active children
> >>> (unless power.ignore_children is set).
> >>>
> >>> This specifically means that the attempts to do just that from the omap
> >>> pm-domain suspend_noirq callback have since been failing whenever a
> >>> child is active, for example:
> >>>
> >>>     am335x-usb-childs 47400000.usb: runtime PM trying to suspend
> >>>       device but active child
> >>>
> >>> Silence this warning by dropping the broken pm_runtime_set_suspended()
> >>> call from the omap suspend_noirq callback along with the redundant
> >>> pm_runtime_set_active() in resume_noirq.
> >>>
> >>> This effectively reverts commit 3522bf7bfa24 ("ARM: OMAP2+: omap_device:
> >>> maintain sane runtime pm status around suspend/resume"), which started
> >>> updating the RPM state after the runtime_suspend callback (!) for active
> >>> omap devices had been called during system suspend. The rationale was
> >>> that a later pm_runtime_get_sync() would then fail (even after runtime
> >>> pm had been disabled) and that this in turn would avoid any external
> >>> aborts when accessing registers with clocks disabled. (See also commit
> >>> 6f3c77b040fc ("PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE,
> >>> even when disabled, v2").
> >>>
> >>> But during the suspend_noirq phase all children would already have been
> >>> suspended and their drivers would specifically not attempt any further
> >>> register accesses. And if this was all just a workaround for random
> >>> device drivers doing cross-tree calls during system suspend, those
> >>> drivers should be fixed and updated to explicitly model such
> >>> dependencies using device-links instead (and either way, any such calls
> >>> have been causing crashes since 4.10).
> >>
> >> I'd like to provide some background and comments here.

> >> As result, below two calls really switch OFF device and its state
> >> should be RPM_SUSPENDED as it will reflect real PM state of HW:
> >> 	m_generic_runtime_suspend(dev)
> >> 	omap_device_idle(pdev);
> > 
> > That's the point to be discussed; does the runtime status really need to
> > reflect the hardware state *during* suspend?
> 
> At least there are no restriction, as I know.
> 
> > As you've noticed, not all subsystems enforce that, even if omap seems
> > to have been expecting it.
> 
> True.
> 
> > And as I mentioned in the commit message, at least the point about
> > wanting to have late pm_runtime_get_sync() fail during suspend appears
> > to be moot.
> 
> Correct. It was introduced long time ago (before device-links).

Yeah, and I'm sure there were good reasons at the time.

> >> As result, when "runtime PM trying to suspend device but active child"
> >> happens the OMAP device framework will ignore it and gracefully
> >> continue to suspend where target device will finally powered off
> >> (depending on suspend mode and device).  On resume, target device will
> >> not be powered on, because its state was not marked as
> >> OMAP_DEVICE_SUSPENDED, so further attempts to power on device with
> >> pm_runtime_get_sync() will be a NOP (because device state is
> >> RPM_ACTIVE) and any access to the device will fail (system crash).
> > 
> > I believe you're mistaken here; _od_suspend_noirq() will continue to
> > power-off *and* set OMAP_DEVICE_SUSPENDED, so that device is again
> > powered during resume_noirq also after this patch has been applied.
> > 
> > Specifically, note that the return value of pm_runtime_set_suspended()
> > was never checked, so the only difference here would be that the error
> > message is suppressed.
> 
> Correct. Sorry. My bad - it was Monday. 

Heh, no worries.

> >> My personal thought here is that removing of pm_runtime_set_active()
> >> will not fix root cause of the problem, but rather hide it :( and,
> >> probably, real fix will be to update USB framework to ensure that all
> >> suspend devices are also PM runtime suspend (not sure how) or add few
> >> more pm_suspend_ignore_children() calls (for example as I've tried to
> >> do in [2], but this was unfinished).
> >>
> >> I've found very simple steps to reproduce suspend failure on
> >> am335x-evm (should also > work on BBB) -  do below sequence with USB
> >> device plugged:
> >>
> >>     echo platform > /sys/power/pm_test
> >>     echo 1 > /sys/power/pm_print_times
> >>     [ echo 0 > /sys/module/printk/parameters/console_suspend ]
> >>     echo mem > /sys/power/state
> >>
> >> [   95.499685] calling  47400000.usb+ @ 733, parent: ocp
> >> [   95.504818] am335x-usb-childs 47400000.usb: runtime PM trying to suspend device but active child
> >> [   95.513750] am335x-usb-childs 47400000.usb: omap device suspend failure 0
> >>
> >> Below I've attached possible patch which converts OMAP device to
> >> use pm_runtime_force_suspend/resume().
> > 
> > What code are you running above? The OMAP PM code should not be failing
> > due to that error message at least (as mentioned twice above).
> > 
> > I have musb suspend working on BBB with the patch I posted yesterday
> > which keeps the controller at RPM_ACTIVE during suspend:
> > 
> > 	https://marc.info/?i=20170724094939.21477-1-johan%40kernel.org
> 
> I re-checked it on clean master (Linux 4.13-rc2) with and without your
> patches and see no issues, just "runtime PM trying to suspend device
> but active child" message is gone. Above test sequence still can be
> used without any additional patches.

Yes, the musb patch I mentioned is only needed when the ancestor device
controlling the clock is runtime suspended when going into system
suspend. With an active port, suspend works without it also on BBB.

> So, thank you for your patches and sorry for the noise.
> 
> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>

Thanks for testing.

Johan
