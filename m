From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Date: Mon, 1 Oct 2018 09:32:53 -0700
Message-ID: <20181001163253.GW5662@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <e9afe736-c2f0-6182-afd0-08279e09a35e@ti.com>
 <20180925144021.GN5662@atomide.com>
 <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
 <20180926155911.GT5662@atomide.com>
 <20180926162303.GU5662@atomide.com>
 <cfc3f1db-9468-ed92-a673-882b51b4dec8@ti.com>
 <20180926233111.GY5662@atomide.com>
 <305bf1c3-915d-dac1-95e4-4d32621247e1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <305bf1c3-915d-dac1-95e4-4d32621247e1@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180927 05:00]:
> Also tested on beaglebone black DS0 works fine. Although there seems to
> be an additional warning which was not seen before:
> 
> "l4-wkup-clkctrl:0008:0: failed to disable"
> 
> log: https://pastebin.ubuntu.com/p/Ns2WRdVkXS/

Can you test the following patch applied on top of the
omap-for-v4.20/dt-ti-sysc-tmp-testing-v2 testing branch?

Based on Grygorii's i2c-omap comments, I think we should also
do the following in the ti-sysc driver becasuse the pm_runtime
use count can be whatever.

Regards,

Tony

8< ----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 1 Oct 2018 09:11:57 -0700
Subject: [PATCH] bus: ti-sysc: Just use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS

As Grygorii Strashko pointed out, the runtime PM use count of the
children can be whatever at suspend and we should not use it. So
let's just suspend ti-sysc at noirq level and get rid of some code.

Let's also remove the PM_SLEEP ifdef and use __maybe_unused as the
PM code already deals with the ifdefs.

Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 113 ++----------------------------------------
 1 file changed, 4 insertions(+), 109 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -87,7 +87,6 @@ struct sysc {
 	u32 revision;
 	bool enabled;
 	bool needs_resume;
-	unsigned int noirq_suspend:1;
 	bool child_needs_resume;
 	struct delayed_work idle_work;
 };
@@ -702,75 +701,7 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 	return error;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sysc_suspend(struct device *dev)
-{
-	struct sysc *ddata;
-	int error;
-
-	ddata = dev_get_drvdata(dev);
-
-	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
-		return 0;
-
-	if (!ddata->enabled || ddata->noirq_suspend)
-		return 0;
-
-	dev_dbg(ddata->dev, "%s %s\n", __func__,
-		ddata->name ? ddata->name : "");
-
-	error = pm_runtime_put_sync_suspend(dev);
-	if (error == -EBUSY) {
-		dev_dbg(ddata->dev, "%s busy, tagging for noirq suspend %s\n",
-			__func__, ddata->name ? ddata->name : "");
-
-		ddata->noirq_suspend = true;
-
-		return 0;
-	} else if (error < 0) {
-		dev_warn(ddata->dev, "%s cannot suspend %i %s\n",
-			 __func__, error,
-			 ddata->name ? ddata->name : "");
-
-		return 0;
-	}
-
-	ddata->needs_resume = true;
-
-	return 0;
-}
-
-static int sysc_resume(struct device *dev)
-{
-	struct sysc *ddata;
-	int error;
-
-	ddata = dev_get_drvdata(dev);
-
-	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
-		return 0;
-
-	if (!ddata->needs_resume || ddata->noirq_suspend)
-		return 0;
-
-	dev_dbg(ddata->dev, "%s %s\n", __func__,
-		ddata->name ? ddata->name : "");
-
-	error = pm_runtime_get_sync(dev);
-	if (error < 0) {
-		dev_err(ddata->dev, "%s  error %i %s\n",
-			__func__, error,
-			ddata->name ? ddata->name : "");
-
-		return error;
-	}
-
-	ddata->needs_resume = false;
-
-	return 0;
-}
-
-static int sysc_noirq_suspend(struct device *dev)
+static int __maybe_unused sysc_noirq_suspend(struct device *dev)
 {
 	struct sysc *ddata;
 	int error;
@@ -780,26 +711,10 @@ static int sysc_noirq_suspend(struct device *dev)
 	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
 		return 0;
 
-	if (!ddata->enabled || !ddata->noirq_suspend)
-		return 0;
-
-	dev_dbg(ddata->dev, "%s %s\n", __func__,
-		ddata->name ? ddata->name : "");
-
-	error = sysc_runtime_suspend(dev);
-	if (error) {
-		dev_warn(ddata->dev, "%s busy %i %s\n",
-			 __func__, error, ddata->name ? ddata->name : "");
-
-		return 0;
-	}
-
-	ddata->needs_resume = true;
-
-	return 0;
+	return pm_runtime_force_suspend(dev);
 }
 
-static int sysc_noirq_resume(struct device *dev)
+static int __maybe_unused sysc_noirq_resume(struct device *dev)
 {
 	struct sysc *ddata;
 	int error;
@@ -809,30 +724,10 @@ static int sysc_noirq_resume(struct device *dev)
 	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
 		return 0;
 
-	if (!ddata->needs_resume || !ddata->noirq_suspend)
-		return 0;
-
-	dev_dbg(ddata->dev, "%s %s\n", __func__,
-		ddata->name ? ddata->name : "");
-
-	error = sysc_runtime_resume(dev);
-	if (error) {
-		dev_warn(ddata->dev, "%s cannot resume %i %s\n",
-			 __func__, error,
-			 ddata->name ? ddata->name : "");
-
-		return error;
-	}
-
-	/* Maybe also reconsider clearing noirq_suspend at some point */
-	ddata->needs_resume = false;
-
-	return 0;
+	return pm_runtime_force_resume(dev);
 }
-#endif
 
 static const struct dev_pm_ops sysc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sysc_suspend, sysc_resume)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sysc_noirq_suspend, sysc_noirq_resume)
 	SET_RUNTIME_PM_OPS(sysc_runtime_suspend,
 			   sysc_runtime_resume,
-- 
2.19.0
