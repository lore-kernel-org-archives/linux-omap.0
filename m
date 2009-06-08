From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP2+: omap_device: bug fix patch for
 omap_device_idle()/omap_device_shutdown()
Date: Sun, 7 Jun 2009 22:13:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906072212300.25987@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52106 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbZFHENj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 00:13:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


This patch fixes a crash in the _omap_device_deactivate().  It will be
rolled into the next omap_device patch series posting.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index a992b88..0c54892 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -127,10 +127,12 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 
 	pr_debug("omap_device: %s: activating\n", od->pdev.name);
 
-	while (od->pm_lat_level >= 0) {
+	while (od->pm_lat_level > 0) {
 		struct omap_device_pm_latency *odpl;
 		int act_lat = 0;
 
+		od->pm_lat_level--;
+
 		odpl = od->pm_lats + od->pm_lat_level;
 
 		if (!ignore_lat &&
@@ -155,7 +157,6 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		     act_lat, odpl->activate_lat);
 
 		od->dev_wakeup_lat -= odpl->activate_lat;
-		od->pm_lat_level--;
 	}
 
 	return 0;
@@ -181,7 +182,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 
 	pr_debug("omap_device: %s: deactivating\n", od->pdev.name);
 
-	while (od->pm_lat_level < (od->pm_lats_cnt - 1)) {
+	while (od->pm_lat_level < od->pm_lats_cnt) {
 		struct omap_device_pm_latency *odpl;
 		int deact_lat = 0;
 
@@ -454,7 +455,7 @@ int omap_device_enable(struct platform_device *pdev)
 
 	/* Enable everything if we're enabling this device from scratch */
 	if (od->_state == OMAP_DEVICE_STATE_UNKNOWN)
-		od->pm_lat_level = od->pm_lats_cnt - 1;
+		od->pm_lat_level = od->pm_lats_cnt;
 
 	ret = _omap_device_activate(od, IGNORE_WAKEUP_LAT);
 
-- 
1.6.3.2.202.g26c11

