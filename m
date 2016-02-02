From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Tue, 2 Feb 2016 11:07:00 +0100
Message-ID: <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
References: <20160201232833.GR19432@atomide.com>
	<Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
	<20160202030533.GT19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160202030533.GT19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 2 February 2016 at 04:05, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Alan Stern <stern@rowland.harvard.edu> [160201 15:50]:
>>
>> You get here only if runtime PM is disabled, right?  So the rpm_idle
>> call won't do anything -- "disabled" means don't make any callbacks.
>
> Hmm sorry yes I'm confused again. Yeah it looks like calling rpm_idle
> just has a side effect that makes a difference here.
>
>> Tony, exactly what are you trying to do here?  Do you want this to
>> invoke a runtime-PM callback in the subsystem, power domain, or driver?
>> (Is there even a driver bound to the device when this function runs?)
>
> I guess I need to add more printks to figure out what's going on here.
> But yeah, I'm not seeing the callback happening at the interconnect
> level so hardware and PM runtime states won't match on the following
> probe after -EPROBE_DEFER.
>
>> The function's name suggests that it merely resets the data stored in
>> dev->power without actually touching the hardware.  Is that what you
>> really want?
>
> I guess you mean pm_runtime_set_suspended() above? I'm seeing a state
> where we now set pm_runtime_set_suspended() between failed device
> probes and the device is still active in hardware.
>
> The patch below also helps with the problem and leaves out the
> rpm_suspend() call from loop so it might give more hints.
>
> The difference here from what Rafael suggested earlier is calling
> __pm_runtime_use_autosuspend() and then not calling
> pm_runtime_set_suspended().
>
> However, it seems the below patch keeps hardware active in the
> autoidle case though, so chances are there is more that needs to
> be done here. Anyways, I'll try to debug it more tomorrow.
>

Your observations is correct. The hardware will be kept active
in-between the probe attempts (and thus also if probing fails).
Although, that's not a regression as that's the behaviour you get from
runtime PM, when drivers are implemented like omap_hsmmc.

Instead of the suggested approaches, I think the regression should be
fixed at the PM domain level (omap hwmod). I have attached a patch
below, please give it try as it's untested.

To solve the other problem (allowing devices to become inactive
in-between at probe failures), I see two options (not treated as
regressions).
1)
Change the behaviour of pm_runtime_put_sync(), to *not* respect the
autosuspend mode.
I think I prefer this option, as it seems like autosuspend should be
respected only via the asynchronous runtime PM APIs.

2)
Change the failing drivers, to before calling pm_runtime_put_sync()
also invoke pm_runtime_dont_use_autosusend(). Or other similar
approach.

Kind regards
Uffe

[...]

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Feb 2016 10:05:39 +0100
Subject: [PATCH] ARM: OMAP2+: omap-device: Allow devices to be pre-enabled

Commit 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
error and driver unbind") may re-initialize the runtime PM status of the
device to RPM_SUSPENDED at driver probe failures.

For the omap_hsmmc and likely also other omap drivers, which needs more
than one attempt to ->probe() (returning -EPROBE_DEFER), this commit
causes a regression at the PM domain level (omap hwmod).

The reason is that the drivers don't put back the device into low power
state while bailing out in ->probe to return -EPROBE_DEFER. This leads to
that pm_runtime_reinit() in driver core, is re-initializing the runtime PM
status from RPM_ACTIVE to RPM_SUSPENDED.

The next ->probe() attempt then triggers the ->runtime_resume() callback
to be invoked, which means this happens two times in a row. At the PM
domain level (omap hwmod) this is being treated as an error and thus the
runtime PM status of the device isn't correctly synchronized with the
runtime PM core.

In the end, ->probe() anyway succeeds (as the driver don't checks the
error code from the runtime PM APIs), but results in that the PM domain
always stays powered on. This because of the runtime PM core believes the
device is RPM_SUSPENDED.

Fix this regression by allowing devices to be pre-enabled when the PM
domain's (omap hwmod) ->runtime_resume() callback is requested to enable
the device. In such cases, return zero to synchronize the runtime PM
status with the runtime PM core.

Fixes: 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
error and driver unbind")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-omap2/omap_device.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c
b/arch/arm/mach-omap2/omap_device.c
index 0437537..851767f 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -717,7 +717,7 @@ int omap_device_register(struct platform_device *pdev)
  * to be accessible and ready to operate.  This generally involves
  * enabling clocks, setting SYSCONFIG registers; and in the future may
  * involve remuxing pins.  Device drivers should call this function
- * indirectly via pm_runtime_get*().  Returns -EINVAL if called when
+ * indirectly via pm_runtime_get*().  Returns zero if called when
  * the omap_device is already enabled, or passes along the return
  * value of _omap_device_enable_hwmods().
  */
@@ -728,12 +728,13 @@ int omap_device_enable(struct platform_device *pdev)

        od = to_omap_device(pdev);

-       if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
-               dev_warn(&pdev->dev,
-                        "omap_device: %s() called from invalid state %d\n",
-                        __func__, od->_state);
-               return -EINVAL;
-       }
+       /*
+        * From the PM domain perspective the device may already be enabled.
+        * In such case, let's return zero to synchronize the state with the
+        * runtime PM core.
+       */
+       if (od->_state == OMAP_DEVICE_STATE_ENABLED)
+               return 0;

        ret = _omap_device_enable_hwmods(od);

-- 
1.9.1
