From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 13:39:17 -0800
Message-ID: <20160202213916.GA19432@atomide.com>
References: <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602021112320.1653-100000@iolanthe.rowland.org>
 <CAPDyKFokWcLSCAh_TX-j-df_M1hN8Qw1gbQt--SyWccGCPiN5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFokWcLSCAh_TX-j-df_M1hN8Qw1gbQt--SyWccGCPiN5Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [160202 12:25]:
> >
> > ?  pm_runtime_put_sync() _already_ does not respect the autosuspend
> > mode.  If you want to respect it, you have to call
> > pm_runtime_put_sync_autosuspend() instead.
> 
> Then there's a bug in the runtime PM core.
> 
> From Tony's regression report and from mine own local runtime PM test
> driver, I can see that the device doesn't get RPM_SUSPENDED (the
> ->runtime_suspend() callback isn't called), even when the usage count
> is zero - when pm_runtime_put_sync() is called.
...
> Okay, so you are saying that the pm_runtime_put_sync() should idle the
> device even if autosuspend is in use. That seems reasonable, I will
> look into this problem.

The patch below fixes pm_runtime_put_sync() to not respect the
autosuspend mode to match what Alan is saying above. Seems to also
fixes the $subject issue for me. And seems to behave for PM runtime
for other devices during runtime too based on light testing here.

Regards,

Tony

8< ---------------
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -353,7 +353,9 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
  out:
 	trace_rpm_return_int(dev, _THIS_IP_, retval);
-	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
+	if (!(rpmflags & RPM_IGNORE_AUTO))
+		rpmflags |= RPM_AUTO;
+	return retval ? retval : rpm_suspend(dev, rpmflags);
 }
 
 /**
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -23,6 +23,8 @@
 					    usage_count */
 #define RPM_AUTO		0x08	/* Use autosuspend_delay */
 
+#define RPM_IGNORE_AUTO		0x10	/* Ignore autosuspend */
+
 #ifdef CONFIG_PM
 extern struct workqueue_struct *pm_wq;
 
@@ -241,7 +243,7 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
 
 static inline int pm_runtime_put_sync(struct device *dev)
 {
-	return __pm_runtime_idle(dev, RPM_GET_PUT);
+	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_IGNORE_AUTO);
 }
 
 static inline int pm_runtime_put_sync_suspend(struct device *dev)
