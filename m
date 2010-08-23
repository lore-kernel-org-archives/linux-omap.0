From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC: PATCH] Fix to support multiple HWMODS for a single device
Date: Mon, 23 Aug 2010 16:16:43 +0530
Message-ID: <1282560403-30375-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50129 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab0HWKqx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 06:46:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, b-cousson@ti.com, paul@pwsan.com, Kishon Vijay Abraham I <kishon@ti.com>

The current HWMOD code expects multiple HWMODS to be filled in consecutive
memory location before passing to omap_device_build_ss(). Ignoring this
will result in incorrect HWMOD data being extracted. This means before calling
omap_device_build_ss() the user has to create memory chunks, copy all the HWMOD
structures to it taking care of the mutex.

This fix uses the pointer to pointer to OMAP_HWMOD structure passed to
omap_device_build_ss() to correctly extract the appropriate
OMAP_HWMOD structure.

This patch is created on top of origin/pm-wip/hwmods-omap4. 

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/plat-omap/omap_device.c |   42 +++++++++++++++++++-------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d2b1609..e94bd7a 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -257,12 +257,12 @@ static inline struct omap_device *_find_by_pdev(struct platform_device *pdev)
  */
 int omap_device_count_resources(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
+	struct omap_hwmod **oh;
 	int c = 0;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		c += omap_hwmod_count_resources(oh);
+	for (i = 0, oh = od->hwmods; i < od->hwmods_cnt; i++, oh++)
+		c += omap_hwmod_count_resources(*oh);
 
 	pr_debug("omap_device: %s: counted %d total resources across %d "
 		 "hwmods\n", od->pdev.name, c, od->hwmods_cnt);
@@ -289,12 +289,12 @@ int omap_device_count_resources(struct omap_device *od)
  */
 int omap_device_fill_resources(struct omap_device *od, struct resource *res)
 {
-	struct omap_hwmod *oh;
+	struct omap_hwmod **oh;
 	int c = 0;
 	int i, r;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++) {
-		r = omap_hwmod_fill_resources(oh, res);
+	for (i = 0, oh = od->hwmods; i < od->hwmods_cnt; i++, oh++) {
+		r = omap_hwmod_fill_resources(*oh, res);
 		res += r;
 		c += r;
 	}
@@ -566,7 +566,7 @@ int omap_device_shutdown(struct platform_device *pdev)
 {
 	int ret, i;
 	struct omap_device *od;
-	struct omap_hwmod *oh;
+	struct omap_hwmod **oh;
 
 	od = _find_by_pdev(pdev);
 
@@ -579,8 +579,8 @@ int omap_device_shutdown(struct platform_device *pdev)
 
 	ret = _omap_device_deactivate(od, IGNORE_WAKEUP_LAT);
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_shutdown(oh);
+	for (i = 0, oh = od->hwmods; i < od->hwmods_cnt; i++, oh++)
+		omap_hwmod_shutdown(*oh);
 
 	od->_state = OMAP_DEVICE_STATE_SHUTDOWN;
 
@@ -692,11 +692,11 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
  */
 int omap_device_enable_hwmods(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
+	struct omap_hwmod **oh;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_enable(oh);
+	for (i = 0, oh = od->hwmods; i < od->hwmods_cnt; i++, oh++)
+		omap_hwmod_enable(*oh);
 
 	/* XXX pass along return value here? */
 	return 0;
@@ -710,11 +710,11 @@ int omap_device_enable_hwmods(struct omap_device *od)
  */
 int omap_device_idle_hwmods(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
+	struct omap_hwmod **oh;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_idle(oh);
+	for (i = 0, oh = od->hwmods; i < od->hwmods_cnt; i++, oh++)
+		omap_hwmod_idle(*oh);
 
 	/* XXX pass along return value here? */
 	return 0;
@@ -729,11 +729,11 @@ int omap_device_idle_hwmods(struct omap_device *od)
  */
 int omap_device_disable_clocks(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
+	struct omap_hwmod **oh;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_disable_clocks(oh);
+	for (i = 0, oh = od->hwmods; i < od->hwmods_cnt; i++, oh++)
+		omap_hwmod_disable_clocks(*oh);
 
 	/* XXX pass along return value here? */
 	return 0;
@@ -748,11 +748,11 @@ int omap_device_disable_clocks(struct omap_device *od)
  */
 int omap_device_enable_clocks(struct omap_device *od)
 {
-	struct omap_hwmod *oh;
+	struct omap_hwmod **oh;
 	int i;
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_enable_clocks(oh);
+	for (i = 0, oh = od->hwmods; i < od->hwmods_cnt; i++, oh++)
+		omap_hwmod_enable_clocks(*oh);
 
 	/* XXX pass along return value here? */
 	return 0;
-- 
1.7.0.4

