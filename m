From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/10] OMAP: omap_device: track latency in nanoseconds
Date: Thu, 03 Dec 2009 06:49:59 -0700
Message-ID: <20091203134957.17146.62589.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49070 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbZLCNyi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:54:38 -0500
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

Rather than having to do a usecs = nsecs / NSECS_PER_USEC to
track latency in usecs, just track it in nanoseconds.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    4 ++--
 arch/arm/plat-omap/omap_device.c              |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index d939246..dc1fac1 100644
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
index 51c9d56..1e5648d 100644
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


