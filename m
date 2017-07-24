From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: drop broken RPM status update
 from suspend_noirq
Date: Mon, 24 Jul 2017 17:16:02 -0500
Message-ID: <05ae4585-8da0-6fb1-8cfd-6b236ec3a8a2@ti.com>
References: <20170724095201.21601-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170724095201.21601-1-johan@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 07/24/2017 04:52 AM, Johan Hovold wrote:
> Since commit a8636c89648a ("PM / Runtime: Don't allow to suspend a
> device with an active child"), which went into 4.10, it is no longer
> permitted to set RPM_SUSPENDED state for a device with active children
> (unless power.ignore_children is set).
> 
> This specifically means that the attempts to do just that from the omap
> pm-domain suspend_noirq callback have since been failing whenever a
> child is active, for example:
> 
>    am335x-usb-childs 47400000.usb: runtime PM trying to suspend
>      device but active child
> 
> Silence this warning by dropping the broken pm_runtime_set_suspended()
> call from the omap suspend_noirq callback along with the redundant
> pm_runtime_set_active() in resume_noirq.
> 
> This effectively reverts commit 3522bf7bfa24 ("ARM: OMAP2+: omap_device:
> maintain sane runtime pm status around suspend/resume"), which started
> updating the RPM state after the runtime_suspend callback (!) for active
> omap devices had been called during system suspend. The rationale was
> that a later pm_runtime_get_sync() would then fail (even after runtime
> pm had been disabled) and that this in turn would avoid any external
> aborts when accessing registers with clocks disabled. (See also commit
> 6f3c77b040fc ("PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE,
> even when disabled, v2").
> 
> But during the suspend_noirq phase all children would already have been
> suspended and their drivers would specifically not attempt any further
> register accesses. And if this was all just a workaround for random
> device drivers doing cross-tree calls during system suspend, those
> drivers should be fixed and updated to explicitly model such
> dependencies using device-links instead (and either way, any such calls
> have been causing crashes since 4.10).

I'd like to provide some background and comments here.

1) OMAP platform is PM runtime centric - in other words all device's
PM operations (power on/off) are done through PM runtime calls and devices
drivers do not really change device's Power states during suspend/resume
- just do preparation for suspend. The final disabling of devices is done
form _od_suspend_noirq() or if device driver calls pm_runtime_force_suspend()
directly during suspend.

2) Initially all this suspend_noirq code was introduced due to commit

commit 1e2ef05bb8cf851a694d38e9170c89e7ff052741
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Wed Jul 6 10:51:58 2011 +0200

    PM: Limit race conditions between runtime PM and system sleep (v2)

which blocks PM runtime during suspend resume. And, at that time, there were
no pm_runtime_force_suspend/resume() neither proper support for power domains.

As result, below two calls really switch OFF device and its state should be 
RPM_SUSPENDED as it will reflect real PM state of HW:
	m_generic_runtime_suspend(dev)
	omap_device_idle(pdev);

In general, now the code in _od_resume/resume_noirq() callback is
equivalent to pm_runtime_force_suspend/resume().

3) It's expected to ignore -EBUSY return code from pm_generic_runtime_suspend(dev)
in _od_suspend_noirq(), as such code (-EBUSY) tells OMAP device framework that 
device should be kept active during suspend (for example 
serial device in case of "no_console_suspend").

commit 4b7ec5accecdb136c7afaf8739a06d5335cc05aa
Author: Sourav Poddar <sourav.poddar@ti.com>
Date:   Sat Apr 27 01:55:34 2013 +0530

    arm: omap2+: omap_device: remove no_idle_on_suspend

As result, when "runtime PM trying to suspend device but active child" happens
the OMAP device framework will ignore it and gracefully continue to suspend where
target device will finally powered off (depending on suspend mode and device). 
On resume, target device will not be powered on, because its state was not marked as
OMAP_DEVICE_SUSPENDED, so further attempts to power on device with pm_runtime_get_sync()
will be a NOP (because device state is RPM_ACTIVE) and any access to the device will fail
(system crash).

4) Unfortunately, commit a8636c89648a ("PM / Runtime: Don't allow to suspend a
 device with an active child") "breaks" OMAP suspend functionality (or
 makes visible more fundamental issues of PM runtime vs Sys suspend), because
 not all Kernel subsystem (especially USB) maintain their devices PM runtime
 state properly during suspend, which cause pm_runtime_set_suspended() (or
 pm_runtime_force_suspend()) to return -EBUSY and, as result, misbehave of
 OMAP device framework. 


My personal thought here is that removing of pm_runtime_set_active() will not fix
root cause of the problem, but rather hide it :( and, probably, real fix will be 
to update USB framework to ensure that all suspend devices are also PM runtime suspend
(not sure how) or add few more pm_suspend_ignore_children() calls 
 (for example as I've tried to do in [2], but this was unfinished).

I've found very simple steps to reproduce suspend failure on am335x-evm (should also
work on BBB) -  do below sequence with USB device plugged:

   echo platform > /sys/power/pm_test 
   echo 1 > /sys/power/pm_print_times 
   [ echo 0 > /sys/module/printk/parameters/console_suspend ]
   echo mem > /sys/power/state 

[   95.499685] calling  47400000.usb+ @ 733, parent: ocp
[   95.504818] am335x-usb-childs 47400000.usb: runtime PM trying to suspend device but active child
[   95.513750] am335x-usb-childs 47400000.usb: omap device suspend failure 0

Below I've attached possible patch which converts OMAP device to
use pm_runtime_force_suspend/resume().


Related discussion:
[1] https://patchwork.kernel.org/patch/9642979/
[2] https://patchwork.kernel.org/patch/9660517/

regards,
-grygorii

----
>From 05cd6c19f898ca28480b9ca8dca5b987190351d9 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Mon, 24 Jul 2017 16:54:48 -0500
Subject: [PATCH] ARM: OMAP2+: omap_device: use pm runtime force api in noirq
 callbacks

The current implementation of _od_suspend_noirq and _od_resume_noirq
callbacks is duing actually the same things as
pm_runtime_force_suspend/resume() when it disables currently active
devices, so convert those callbacks to use
pm_runtime_force_suspend/resume().

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/mach-omap2/omap_device.c | 41 +++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index ef9ffb8..b91b0cd 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -670,12 +670,21 @@ static int _od_suspend_noirq(struct device *dev)
 
 	ret = pm_generic_suspend_noirq(dev);
 
-	if (!ret && !pm_runtime_status_suspended(dev)) {
-		if (pm_generic_runtime_suspend(dev) == 0) {
-			pm_runtime_set_suspended(dev);
-			omap_device_idle(pdev);
-			od->flags |= OMAP_DEVICE_SUSPENDED;
+	if (!ret) {
+		ret = pm_runtime_force_suspend(dev);
+		if (ret == -EBUSY) {
+			/*
+			 * In case of error pm_runtime_force_suspend will
+			 * not call pm_runtime_disable() and it's required to
+			 * make additional call to pm_runtime_disable() here
+			 * to balance it with pm_runtime_enable() call in
+			 * pm_runtime_force_resume()
+			 */
+			pm_runtime_disable(dev);
+			return 0;
 		}
+		if (ret)
+			dev_err(dev, "omap device suspend failure %d", ret);
 	}
 
 	return ret;
@@ -685,21 +694,15 @@ static int _od_resume_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od = to_omap_device(pdev);
+	int ret;
 
-	if (od->flags & OMAP_DEVICE_SUSPENDED) {
-		od->flags &= ~OMAP_DEVICE_SUSPENDED;
-		omap_device_enable(pdev);
-		/*
-		 * XXX: we run before core runtime pm has resumed itself. At
-		 * this point in time, we just restore the runtime pm state and
-		 * considering symmetric operations in resume, we donot expect
-		 * to fail. If we failed, something changed in core runtime_pm
-		 * framework OR some device driver messed things up, hence, WARN
-		 */
-		WARN(pm_runtime_set_active(dev),
-		     "Could not set %s runtime state active\n", dev_name(dev));
-		pm_generic_runtime_resume(dev);
-	}
+	/* Don't attempt late suspend on a driver that is not bound */
+	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
+		return 0;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		dev_err(dev, "omap device resume failure %d", ret);
 
 	return pm_generic_resume_noirq(dev);
 }
-- 
2.10.1
