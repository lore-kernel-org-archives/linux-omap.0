From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/8] OMAP: omap_device: deactivate latency typo
Date: Tue, 17 Nov 2009 17:05:09 -0800
Message-ID: <1258506313-17115-5-git-send-email-khilman@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
 <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:45572 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721AbZKRBFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 20:05:24 -0500
Received: by gxk26 with SMTP id 26so630093gxk.1
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 17:05:30 -0800 (PST)
In-Reply-To: <1258506313-17115-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The deactivate hook should use 'deactivate_lat' instead of
'activate_lat' when doing checking on expected latency values.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index bb16e62..da649f2 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -186,7 +186,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		odpl = od->pm_lats + od->pm_lat_level;
 
 		if (!ignore_lat &&
-		    ((od->dev_wakeup_lat + odpl->activate_lat) >
+		    ((od->dev_wakeup_lat + odpl->deactivate_lat) >
 		     od->_dev_wakeup_lat_limit))
 			break;
 
@@ -209,7 +209,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		     "(%llu > %d)\n", od->pdev.name, od->pdev.id,
 		     od->pm_lat_level, deact_lat, odpl->deactivate_lat);
 
-		od->dev_wakeup_lat += odpl->activate_lat;
+		od->dev_wakeup_lat += odpl->deactivate_lat;
 
 		od->pm_lat_level++;
 	}
-- 
1.6.5.1

