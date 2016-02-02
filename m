From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Mon, 1 Feb 2016 19:05:34 -0800
Message-ID: <20160202030533.GT19432@atomide.com>
References: <20160201232833.GR19432@atomide.com>
 <Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Alan Stern <stern@rowland.harvard.edu> [160201 15:50]:
> 
> You get here only if runtime PM is disabled, right?  So the rpm_idle 
> call won't do anything -- "disabled" means don't make any callbacks.

Hmm sorry yes I'm confused again. Yeah it looks like calling rpm_idle
just has a side effect that makes a difference here.

> Tony, exactly what are you trying to do here?  Do you want this to 
> invoke a runtime-PM callback in the subsystem, power domain, or driver?  
> (Is there even a driver bound to the device when this function runs?)

I guess I need to add more printks to figure out what's going on here.
But yeah, I'm not seeing the callback happening at the interconnect
level so hardware and PM runtime states won't match on the following
probe after -EPROBE_DEFER.

> The function's name suggests that it merely resets the data stored in 
> dev->power without actually touching the hardware.  Is that what you 
> really want?

I guess you mean pm_runtime_set_suspended() above? I'm seeing a state
where we now set pm_runtime_set_suspended() between failed device
probes and the device is still active in hardware.

The patch below also helps with the problem and leaves out the
rpm_suspend() call from loop so it might give more hints.

The difference here from what Rafael suggested earlier is calling
__pm_runtime_use_autosuspend() and then not calling
pm_runtime_set_suspended().

However, it seems the below patch keeps hardware active in the
autoidle case though, so chances are there is more that needs to
be done here. Anyways, I'll try to debug it more tomorrow.

Regards,

Tony

8< ------------------
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1425,17 +1425,25 @@ void pm_runtime_init(struct device *dev)
  */
 void pm_runtime_reinit(struct device *dev)
 {
-	if (!pm_runtime_enabled(dev)) {
-		if (dev->power.runtime_status == RPM_ACTIVE)
+	if (pm_runtime_enabled(dev))
+		return;
+
+	if (dev->power.runtime_status == RPM_ACTIVE) {
+		if (dev->power.use_autosuspend) {
+			pm_runtime_set_autosuspend_delay(dev, 0);
+			__pm_runtime_use_autosuspend(dev, false);
+		} else {
 			pm_runtime_set_suspended(dev);
-		if (dev->power.irq_safe) {
-			spin_lock_irq(&dev->power.lock);
-			dev->power.irq_safe = 0;
-			spin_unlock_irq(&dev->power.lock);
-			if (dev->parent)
-				pm_runtime_put(dev->parent);
 		}
 	}
+
+	if (dev->power.irq_safe) {
+		spin_lock_irq(&dev->power.lock);
+		dev->power.irq_safe = 0;
+		spin_unlock_irq(&dev->power.lock);
+		if (dev->parent)
+			pm_runtime_put(dev->parent);
+	}
 }
 
 /**
