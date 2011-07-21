From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP: omap_device: replace _find_by_pdev() with to_omap_device()
Date: Thu, 21 Jul 2011 16:52:11 -0700
Message-ID: <1311292338-11830-2-git-send-email-khilman@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40800 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753160Ab1GUXwI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 19:52:08 -0400
Received: by mail-iy0-f179.google.com with SMTP id 35so1808744iyn.24
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 16:52:07 -0700 (PDT)
In-Reply-To: <1311292338-11830-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Felipe Balbi <balbi@ti.com>

The omap_device layer currently has two ways of getting an omap_device
pointer from a platform_device pointer.

Replace current usage of _find_by_pdev() with to_omap_device() since
to_omap_device() is more familiar to the existing to_platform_device()
used when getting a platform_device pointer from a struct device pointer.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Paul, please consider this minor cleanup for the v3.1 merge window.
Applies to v3.0-c6.

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
1.7.6

