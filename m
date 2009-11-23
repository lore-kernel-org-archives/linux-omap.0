From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/3] OMAP: omap_device: track latency in nanoseconds
Date: Mon, 23 Nov 2009 09:33:41 -0800
Message-ID: <1258997622-13923-2-git-send-email-khilman@deeprootsystems.com>
References: <1258997622-13923-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:46131 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZKWRdk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 12:33:40 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so4102157pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 09:33:46 -0800 (PST)
In-Reply-To: <1258997622-13923-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Rather than having to do a usecs = nsecs / NSECS_PER_USEC to
track latency in usecs, just track it in nanoseconds.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    4 ++--
 arch/arm/plat-omap/omap_device.c              |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index c504780..3b2f3a6 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -50,8 +50,8 @@
  * @pm_lats: ptr to an omap_device_pm_latency table
  * @pm_lats_cnt: ARRAY_SIZE() of what is passed to @pm_lats
  * @pm_lat_level: array index of the last odpl entry executed - -1 if never
- * @dev_wakeup_lat: dev wakeup latency in microseconds
- * @_dev_wakeup_lat_limit: dev wakeup latency limit in usec - set by OMAP PM
+ * @dev_wakeup_lat: dev wakeup latency in nanoseconds
+ * @_dev_wakeup_lat_limit: dev wakeup latency limit in nsec - set by OMAP PM
  * @_state: one of OMAP_DEVICE_STATE_* (see above)
  * @flags: device flags
  *
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 722f2c8..7bf665c 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -142,10 +142,10 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
-		act_lat = timespec_to_ns(&c) / NSEC_PER_USEC;
+		act_lat = timespec_to_ns(&c);
 
 		pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
-			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
+			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
 			 act_lat);
 
 		WARN(act_lat > odpl->activate_lat, "omap_device: %s.%d: "
@@ -198,10 +198,10 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
-		deact_lat = timespec_to_ns(&c) / NSEC_PER_USEC;
+		deact_lat = timespec_to_ns(&c);
 
 		pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
-			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
+			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
 			 deact_lat);
 
 		WARN(deact_lat > odpl->deactivate_lat, "omap_device: %s.%d: "
-- 
1.6.5.1

