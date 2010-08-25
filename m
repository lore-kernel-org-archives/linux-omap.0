From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] OMAP: omap_device: Fix to support multiple hwmods for a single device
Date: Wed, 25 Aug 2010 16:03:23 +0530
Message-ID: <1282732403-32227-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55234 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab0HYKdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 06:33:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, b-cousson@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>, Charulatha V <charu@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Currently there is a bug in the existing omap_device core code when
extracting the hwmod structures passed to omap_device_build_ss(). This bug
gets exposed only when passing multiple hwmod structures to
omap_device_build_ss() resulting in incorrect extraction from second hwmod
structure.

This fix uses the pointer to pointer to omap_hwmod structure (array of 
pointers to omap_hwmod structure) passed to omap_device_build_ss() to 
correctly extract the appropriate omap_hwmod structure.

This patch has been created and tested on lo/master and mainline.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Cc: Paul Walmsley<paul@pwsan.com>
Cc: Benoit Cousson<b-cousson@ti.com>
Cc: Kevin Hilman<khilman@deeprootsystems.com>
Cc: Charulatha V<charu@ti.com>
Cc: Shubhrajyoti D<shubhrajyoti@ti.com>

---
 arch/arm/plat-omap/omap_device.c |   35 ++++++++++++++---------------------
 1 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d2b1609..2dd2a46 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -257,12 +257,11 @@ static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
  */
 int omap_device_count_resources(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
 	int c = 0;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		c += omap_hwmod_count_resources(oh);
+	for (i = 0; i < od->hwmods_cnt; i++)
+		c += omap_hwmod_count_resources(od->hwmods[i]);
 
 	pr_debug("omap_device: %s: counted %d total resources across %d "
 		 "hwmods\n", od->pdev.name, c, od->hwmods_cnt);
@@ -289,12 +288,11 @@ int omap_device_count_resources(struct omap_device *od)
  */
 int omap_device_fill_resources(struct omap_device *od, struct resource *res)
 {
-	struct omap_hwmod *oh;
 	int c = 0;
 	int i, r;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++) {
-		r = omap_hwmod_fill_resources(oh, res);
+	for (i = 0; i < od->hwmods_cnt; i++) {
+		r = omap_hwmod_fill_resources(od->hwmods[i], res);
 		res += r;
 		c += r;
 	}
@@ -566,7 +564,6 @@ int omap_device_shutdown(struct platform_device *pdev)
 {
 	int ret, i;
 	struct omap_device *od;
-	struct omap_hwmod *oh;
 
 	od = _find_by_pdev(pdev);
 
@@ -579,8 +576,8 @@ int omap_device_shutdown(struct platform_device *pdev)
 
 	ret = _omap_device_deactivate(od, IGNORE_WAKEUP_LAT);
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_shutdown(oh);
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_shutdown(od->hwmods[i]);
 
 	od->_state = OMAP_DEVICE_STATE_SHUTDOWN;
 
@@ -692,11 +689,10 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
  */
 int omap_device_enable_hwmods(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_enable(oh);
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_enable(od->hwmods[i]);
 
 	/* XXX pass along return value here? */
 	return 0;
@@ -710,11 +706,10 @@ int omap_device_enable_hwmods(struct omap_device *od)
  */
 int omap_device_idle_hwmods(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_idle(oh);
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_idle(od->hwmods[i]);
 
 	/* XXX pass along return value here? */
 	return 0;
@@ -729,11 +724,10 @@ int omap_device_idle_hwmods(struct omap_device *od)
  */
 int omap_device_disable_clocks(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_disable_clocks(oh);
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_disable_clocks(od->hwmods[i]);
 
 	/* XXX pass along return value here? */
 	return 0;
@@ -748,11 +742,10 @@ int omap_device_disable_clocks(struct omap_device *od)
  */
 int omap_device_enable_clocks(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_enable_clocks(oh);
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_enable_clocks(od->hwmods[i]);
 
 	/* XXX pass along return value here? */
 	return 0;
-- 
1.7.0.4

