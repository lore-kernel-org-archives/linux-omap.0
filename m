From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP: omap_device: replace pr_* prints with dev_*
Date: Thu, 21 Jul 2011 10:39:36 -0700
Message-ID: <1311269976-4035-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36840 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751469Ab1GURjZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 13:39:25 -0400
Received: by mail-pv0-f175.google.com with SMTP id 24so1500504pvf.20
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 10:39:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

For consistency in kernel printk output for devices, use dev_dbg(),
dev_warn(), dev_err() instead of pr_debug(), pr_warning() and
pr_err(), some of which currently use direct access of name from
platform_device and others of which use dev_name().  Using the dev_*
versions uses the standard device naming from the driver core.

Some pr_* prints were not converted with this patch since they are
used before the platform_device and struct device are created so
neither the dev_* prints or dev_name() is valid.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Unless there are objections, I'll queue this as a fix for the v3.1-rc cycle.

 arch/arm/plat-omap/omap_device.c |   70 ++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index be45147..1914d7e 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -114,7 +114,7 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 {
 	struct timespec a, b, c;
 
-	pr_debug("omap_device: %s: activating\n", od->pdev.name);
+	dev_dbg(&od->pdev.dev, "omap_device: activating\n");
 
 	while (od->pm_lat_level > 0) {
 		struct omap_device_pm_latency *odpl;
@@ -138,25 +138,24 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		c = timespec_sub(b, a);
 		act_lat = timespec_to_ns(&c);
 
-		pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
-			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
-			 act_lat);
+		dev_dbg(&od->pdev.dev,
+			"omap_device: pm_lat %d: activate: elapsed time "
+			"%llu nsec\n", od->pm_lat_level, act_lat);
 
 		if (act_lat > odpl->activate_lat) {
 			odpl->activate_lat_worst = act_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->activate_lat = act_lat;
-				pr_warning("omap_device: %s.%d: new worst case "
-					   "activate latency %d: %llu\n",
-					   od->pdev.name, od->pdev.id,
-					   od->pm_lat_level, act_lat);
+				dev_warn(&od->pdev.dev,
+					 "new worst case activate latency "
+					 "%d: %llu\n",
+					 od->pm_lat_level, act_lat);
 			} else
-				pr_warning("omap_device: %s.%d: activate "
-					   "latency %d higher than exptected. "
-					   "(%llu > %d)\n",
-					   od->pdev.name, od->pdev.id,
-					   od->pm_lat_level, act_lat,
-					   odpl->activate_lat);
+				dev_warn(&od->pdev.dev,
+					 "activate latency %d "
+					 "higher than exptected. (%llu > %d)\n",
+					 od->pm_lat_level, act_lat,
+					 odpl->activate_lat);
 		}
 
 		od->dev_wakeup_lat -= odpl->activate_lat;
@@ -183,7 +182,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 {
 	struct timespec a, b, c;
 
-	pr_debug("omap_device: %s: deactivating\n", od->pdev.name);
+	dev_dbg(&od->pdev.dev, "omap_device: deactivating\n");
 
 	while (od->pm_lat_level < od->pm_lats_cnt) {
 		struct omap_device_pm_latency *odpl;
@@ -206,28 +205,26 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		c = timespec_sub(b, a);
 		deact_lat = timespec_to_ns(&c);
 
-		pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
-			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
-			 deact_lat);
+		dev_dbg(&od->pdev.dev,
+			"omap_device: pm_lat %d: deactivate: elapsed time "
+			"%llu nsec\n", od->pm_lat_level, deact_lat);
 
 		if (deact_lat > odpl->deactivate_lat) {
 			odpl->deactivate_lat_worst = deact_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->deactivate_lat = deact_lat;
-				pr_warning("omap_device: %s.%d: new worst case "
-					   "deactivate latency %d: %llu\n",
-					   od->pdev.name, od->pdev.id,
-					   od->pm_lat_level, deact_lat);
+				dev_warn(&od->pdev.dev,
+					 "new worst case deactivate latency "
+					 "%d: %llu\n",
+					 od->pm_lat_level, deact_lat);
 			} else
-				pr_warning("omap_device: %s.%d: deactivate "
-					   "latency %d higher than exptected. "
-					   "(%llu > %d)\n",
-					   od->pdev.name, od->pdev.id,
-					   od->pm_lat_level, deact_lat,
-					   odpl->deactivate_lat);
+				dev_warn(&od->pdev.dev,
+					 "deactivate latency %d "
+					 "higher than exptected. (%llu > %d)\n",
+					 od->pm_lat_level, deact_lat,
+					 odpl->deactivate_lat);
 		}
 
-
 		od->dev_wakeup_lat += odpl->activate_lat;
 
 		od->pm_lat_level++;
@@ -245,28 +242,27 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 	if (!clk_alias || !clk_name)
 		return;
 
-	pr_debug("omap_device: %s: Creating %s -> %s\n",
-		 dev_name(&od->pdev.dev), clk_alias, clk_name);
+	dev_dbg(&od->pdev.dev, "Creating %s -> %s\n", clk_alias, clk_name);
 
 	r = clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
 	if (!IS_ERR(r)) {
-		pr_warning("omap_device: %s: alias %s already exists\n",
-			   dev_name(&od->pdev.dev), clk_alias);
+		dev_warn(&od->pdev.dev,
+			 "alias %s already exists\n", clk_alias);
 		clk_put(r);
 		return;
 	}
 
 	r = omap_clk_get_by_name(clk_name);
 	if (IS_ERR(r)) {
-		pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
-		       dev_name(&od->pdev.dev), clk_name);
+		dev_err(&od->pdev.dev,
+			"omap_clk_get_by_name for %s failed\n", clk_name);
 		return;
 	}
 
 	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
 	if (!l) {
-		pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
-		       dev_name(&od->pdev.dev), clk_alias);
+		dev_err(&od->pdev.dev,
+			"clkdev_alloc for %s failed\n", clk_alias);
 		return;
 	}
 
-- 
1.7.6

