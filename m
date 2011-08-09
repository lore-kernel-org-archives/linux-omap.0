From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH 02/14] OMAP: omap_device: replace debug/warning/error prints with dev_* macros
Date: Tue, 09 Aug 2011 19:10:20 +0500
Message-ID: <1312897232-4792-3-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.76.145] ([117.192.76.145]:33694 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751122Ab1HINxK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 09:53:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, Kevin Hilman <khilman@ti.com>


From: Kevin Hilman <khilman@ti.com>

For consistency in kernel printk output for devices, use dev_dbg(),
dev_warn(), dev_err() instead of pr_debug(), pr_warning() and
pr_err(), some of which currently use direct access of name from
platform_device and others of which use dev_name().  Using the dev_*
versions uses the standard device naming from the driver core.

Some pr_* prints were not converted with this patch since they are
used before the platform_device and struct device are created so
neither the dev_* prints or dev_name() is valid.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |   70 +++++++++++++++++++-------------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index c8b9cd1..1d69596 100644
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
@@ -609,8 +606,9 @@ int omap_device_enable(struct platform_device *pdev)
 	od = to_omap_device(pdev);
 
 	if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
-		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
-		     od->pdev.name, od->pdev.id, __func__, od->_state);
+		dev_warn(&pdev->dev,
+			 "omap_device: %s() called from invalid state %d\n",
+			 __func__, od->_state);
 		return -EINVAL;
 	}
 
@@ -648,8 +646,9 @@ int omap_device_idle(struct platform_device *pdev)
 	od = to_omap_device(pdev);
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
-		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
-		     od->pdev.name, od->pdev.id, __func__, od->_state);
+		dev_warn(&pdev->dev,
+			 "omap_device: %s() called from invalid state %d\n",
+			 __func__, od->_state);
 		return -EINVAL;
 	}
 
@@ -680,8 +679,9 @@ int omap_device_shutdown(struct platform_device *pdev)
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED &&
 	    od->_state != OMAP_DEVICE_STATE_IDLE) {
-		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
-		     od->pdev.name, od->pdev.id, __func__, od->_state);
+		dev_warn(&pdev->dev,
+			 "omap_device: %s() called from invalid state %d\n",
+			 __func__, od->_state);
 		return -EINVAL;
 	}
 
-- 
1.7.1

