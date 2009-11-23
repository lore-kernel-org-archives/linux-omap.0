From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/3] OMAP: omap_device: optionally auto-adjust device activate/deactivate latencies
Date: Mon, 23 Nov 2009 09:33:42 -0800
Message-ID: <1258997622-13923-3-git-send-email-khilman@deeprootsystems.com>
References: <1258997622-13923-1-git-send-email-khilman@deeprootsystems.com>
 <1258997622-13923-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:39401 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZKWRdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 12:33:42 -0500
Received: by pwi3 with SMTP id 3so3558124pwi.21
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 09:33:48 -0800 (PST)
In-Reply-To: <1258997622-13923-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

First, this patch adds new worst-case latency values to the
omap_device_pm_latency struct.  Here the worst-case measured latencies
for the activate and deactivate hooks are stored.

In addition, add an option to auto-adjust the latency values used for
device activate/deactivate.

By setting a new 'OMAP_DEVICE_LATENCY_AUTO_ADJUST' flag in the
omap_device_pm_latency struct, the omap_device layer automatically
adjusts the activate/deactivate latencies to the worst-case measured
values.

Anytime a new worst-case value is found, it is printed to the console.
Here is an example log during boot using UART2 s an example.  After
boot, the OPP is manually changed to the 125MHz OPP:

[...]
Freeing init memory: 128K
omap_device: serial8250.2: new worst case deactivate latency 0: 30517
omap_device: serial8250.2: new worst case activate latency 0: 30517
omap_device: serial8250.2: new worst case activate latency 0: 218139648
omap_device: serial8250.2: new worst case deactivate latency 0: 61035
omap_device: serial8250.2: new worst case activate latency 0: 278076171
omap_device: serial8250.2: new worst case activate latency 0: 298614501
omap_device: serial8250.2: new worst case activate latency 0: 327331542

/ # echo 125000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed

omap_device: serial8250.2: new worst case deactivate latency 0: 91552

Motivation: this can be used as a technique to automatically determine
the worst case latency values.  The current method of printing a
warning on every violation is too noisy to actually interact the
console in order to set low OPP to discover latencies.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    4 ++
 arch/arm/plat-omap/omap_device.c              |   41 ++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 3b2f3a6..e0634fe 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -132,11 +132,15 @@ int omap_device_enable_clocks(struct omap_device *od);
  */
 struct omap_device_pm_latency {
 	u32 deactivate_lat;
+	u32 deactivate_lat_worst;
 	int (*deactivate_func)(struct omap_device *od);
 	u32 activate_lat;
+	u32 activate_lat_worst;
 	int (*activate_func)(struct omap_device *od);
+	u32 flags;
 };
 
+#define OMAP_DEVICE_LATENCY_AUTO_ADJUST BIT(1)
 
 /* Get omap_device pointer from platform_device pointer */
 #define to_omap_device(x) container_of((x), struct omap_device, pdev)
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 7bf665c..8ba12a6 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -148,10 +148,22 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
 			 act_lat);
 
-		WARN(act_lat > odpl->activate_lat, "omap_device: %s.%d: "
-		     "activate step %d took longer than expected (%llu > %d)\n",
-		     od->pdev.name, od->pdev.id, od->pm_lat_level,
-		     act_lat, odpl->activate_lat);
+		if (act_lat > odpl->activate_lat) {
+			odpl->activate_lat_worst = act_lat;
+			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
+				odpl->activate_lat = act_lat;
+				pr_warning("omap_device: %s.%d: new worst case "
+					   "activate latency %d: %llu\n",
+					   od->pdev.name, od->pdev.id, 
+					   od->pm_lat_level, act_lat);
+			} else
+				pr_warning("omap_device: %s.%d: activate "
+					   "latency %d higher than exptected. "
+					   "(%llu > %d)\n",
+					   od->pdev.name, od->pdev.id, 
+					   od->pm_lat_level, act_lat,
+					   odpl->activate_lat);
+		}
 
 		od->dev_wakeup_lat -= odpl->activate_lat;
 	}
@@ -204,10 +216,23 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
 			 deact_lat);
 
-		WARN(deact_lat > odpl->deactivate_lat, "omap_device: %s.%d: "
-		     "deactivate step %d took longer than expected "
-		     "(%llu > %d)\n", od->pdev.name, od->pdev.id,
-		     od->pm_lat_level, deact_lat, odpl->deactivate_lat);
+		if (deact_lat > odpl->deactivate_lat) {
+			odpl->deactivate_lat_worst = deact_lat;
+			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
+				odpl->deactivate_lat = deact_lat;
+				pr_warning("omap_device: %s.%d: new worst case "
+					   "deactivate latency %d: %llu\n",
+					   od->pdev.name, od->pdev.id,
+					   od->pm_lat_level, deact_lat);
+			} else
+				pr_warning("omap_device: %s.%d: deactivate "
+					   "latency %d higher than exptected. "
+					   "(%llu > %d)\n",
+					   od->pdev.name, od->pdev.id, 
+					   od->pm_lat_level, deact_lat,
+					   odpl->deactivate_lat);
+		}
+ 
 
 		od->dev_wakeup_lat += odpl->activate_lat;
 
-- 
1.6.5.1

