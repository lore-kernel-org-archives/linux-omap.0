From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 7/8] OMAP: omap_device: warn about expected latencies only if non-zero
Date: Tue, 17 Nov 2009 17:05:12 -0800
Message-ID: <1258506313-17115-8-git-send-email-khilman@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-6-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:36162 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756493AbZKRBFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:05:36 -0500
Received: by ywh6 with SMTP id 6so621640ywh.4
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 17:05:42 -0800 (PST)
In-Reply-To: <1258506313-17115-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When checking measured [de]activate latencies against expected
latencies, only print warning if driver has provided a non-zero
latency.

This allows drivers to set their [de]activate latencies to zero when
they are not known, or are don't care, and the omap_device core will
not complain about unexpected latencies.

RFC: Maybe the measuring of latency should also avoided all together
     in this case?

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index f6cdf1a..83bee1c 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -148,10 +148,12 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
 			 act_lat);
 
-		WARN(act_lat > odpl->activate_lat, "omap_device: %s.%d: "
-		     "activate step %d took longer than expected (%llu > %d)\n",
-		     od->pdev.name, od->pdev.id, od->pm_lat_level,
-		     act_lat, odpl->activate_lat);
+		if (odpl->activate_lat)
+			WARN(act_lat > odpl->activate_lat,
+			     "omap_device: %s.%d: activate step %d "
+			     "took longer than expected (%llu > %d)\n",
+			     od->pdev.name, od->pdev.id, od->pm_lat_level,
+			     act_lat, odpl->activate_lat);
 
 		od->dev_wakeup_lat -= odpl->activate_lat;
 	}
@@ -204,10 +206,12 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
 			 deact_lat);
 
-		WARN(deact_lat > odpl->deactivate_lat, "omap_device: %s.%d: "
-		     "deactivate step %d took longer than expected "
-		     "(%llu > %d)\n", od->pdev.name, od->pdev.id,
-		     od->pm_lat_level, deact_lat, odpl->deactivate_lat);
+		if (odpl->deactivate_lat)
+			WARN(deact_lat > odpl->deactivate_lat,
+			     "omap_device: %s.%d: "
+			     "deactivate step %d took longer than expected "
+			     "(%llu > %d)\n", od->pdev.name, od->pdev.id,
+			     od->pm_lat_level, deact_lat, odpl->deactivate_lat);
 
 		od->dev_wakeup_lat += odpl->deactivate_lat;
 
-- 
1.6.5.1

