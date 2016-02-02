From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Tue, 2 Feb 2016 11:42:51 +0100
Message-ID: <CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
References: <20160201232833.GR19432@atomide.com>
	<Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
	<20160202030533.GT19432@atomide.com>
	<CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

>
> Instead of the suggested approaches, I think the regression should be
> fixed at the PM domain level (omap hwmod). I have attached a patch
> below, please give it try as it's untested.

Realized that version 1 would actually *only* make the PM domain code
to deal with pre-enabled devices. It would still invoke the driver's
->runtime_resume() callbacks (via pm_generic_runtime_resume())  for
these scenarios.

That's not what we want. So I moved the checks to the actual
->runtime_resume() callback in the PM domain, instead of in the
omap_device_enable() function. A version 2 is attached. Please give it
at try.

[...]

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Feb 2016 10:05:39 +0100
Subject: [PATCH V2] ARM: OMAP2+: omap-device: Allow devices to be pre-enabled

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

Changes in v2:
        -Prevent a driver's ->runtime_resume() callbacks from being invoked for
        a pre-enabled device.

---
 arch/arm/mach-omap2/omap_device.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c
b/arch/arm/mach-omap2/omap_device.c
index 0437537..1ad390b 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -599,8 +599,17 @@ static int _od_runtime_suspend(struct device *dev)
 static int _od_runtime_resume(struct device *dev)
 {
        struct platform_device *pdev = to_platform_device(dev);
+       struct omap_device *od = to_omap_device(pdev);
        int ret;

+       /*
+        * From the PM domain perspective the device may already be enabled.
+        * In such case, let's return zero to synchronize the state with the
+        * runtime PM core.
+       */
+       if (od->_state == OMAP_DEVICE_STATE_ENABLED)
+               return 0;
+
        ret = omap_device_enable(pdev);
        if (ret)
                return ret;
-- 
1.9.1
