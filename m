From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH 01/14] OMAP: omap_device: replace _find_by_pdev() with to_omap_device()
Date: Tue, 09 Aug 2011 19:10:19 +0500
Message-ID: <1312897232-4792-2-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.76.145] ([117.192.76.145]:58271 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750695Ab1HINw5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 09:52:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, Kevin Hilman <khilman@ti.com>, Felipe Balbi <balbi@ti.com>


From: Kevin Hilman <khilman@ti.com>

The omap_device layer currently has two ways of getting an omap_device
pointer from a platform_device pointer.

Replace current usage of _find_by_pdev() with to_omap_device() since
to_omap_device() is more familiar to the existing to_platform_device()
used when getting a platform_device pointer from a struct device pointer.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/omap_device.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 49fc0df..c8b9cd1 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -236,11 +236,6 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 	return 0;
 }
 
-static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
-{
-	return container_of(pdev, struct omap_device, pdev);
-}
-
 /**
  * _add_optional_clock_clkdev - Add clkdev entry for hwmod optional clocks
  * @od: struct omap_device *od
@@ -316,7 +311,7 @@ u32 omap_device_get_context_loss_count(struct platform_device *pdev)
 	struct omap_device *od;
 	u32 ret = 0;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (od->hwmods_cnt)
 		ret = omap_hwmod_get_context_loss_count(od->hwmods[0]);
@@ -611,7 +606,7 @@ int omap_device_enable(struct platform_device *pdev)
 	int ret;
 	struct omap_device *od;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
 		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
@@ -650,7 +645,7 @@ int omap_device_idle(struct platform_device *pdev)
 	int ret;
 	struct omap_device *od;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
 		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
@@ -681,7 +676,7 @@ int omap_device_shutdown(struct platform_device *pdev)
 	int ret, i;
 	struct omap_device *od;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED &&
 	    od->_state != OMAP_DEVICE_STATE_IDLE) {
@@ -722,7 +717,7 @@ int omap_device_align_pm_lat(struct platform_device *pdev,
 	int ret = -EINVAL;
 	struct omap_device *od;
 
-	od = _find_by_pdev(pdev);
+	od = to_omap_device(pdev);
 
 	if (new_wakeup_lat_limit == od->dev_wakeup_lat)
 		return 0;
-- 
1.7.1

