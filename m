From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP: omap_device: Fix to support multiple hwmods for a
	single device
Date: Fri, 24 Sep 2010 10:40:12 -0600
Message-ID: <20100924164011.19418.20378.stgit@twilight.localdomain>
References: <20100924163936.19418.47065.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56376 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932956Ab0IXQlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 12:41:21 -0400
In-Reply-To: <20100924163936.19418.47065.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Charulatha V <charu@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>

From: Kishon Vijay Abraham I <kishon@ti.com>

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
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Charulatha V <charu@ti.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/omap_device.c |   35 ++++++++++++++---------------------
 1 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index ceba58a..533ad13 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -296,12 +296,11 @@ static void _add_optional_clock_alias(struct omap_device *od,
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
@@ -328,12 +327,11 @@ int omap_device_count_resources(struct omap_device *od)
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
@@ -607,7 +605,6 @@ int omap_device_shutdown(struct platform_device *pdev)
 {
 	int ret, i;
 	struct omap_device *od;
-	struct omap_hwmod *oh;
 
 	od = _find_by_pdev(pdev);
 
@@ -620,8 +617,8 @@ int omap_device_shutdown(struct platform_device *pdev)
 
 	ret = _omap_device_deactivate(od, IGNORE_WAKEUP_LAT);
 
-	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
-		omap_hwmod_shutdown(oh);
+	for (i = 0; i < od->hwmods_cnt; i++)
+		omap_hwmod_shutdown(od->hwmods[i]);
 
 	od->_state = OMAP_DEVICE_STATE_SHUTDOWN;
 
@@ -733,11 +730,10 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
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
@@ -751,11 +747,10 @@ int omap_device_enable_hwmods(struct omap_device *od)
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
@@ -770,11 +765,10 @@ int omap_device_idle_hwmods(struct omap_device *od)
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
@@ -789,11 +783,10 @@ int omap_device_disable_clocks(struct omap_device *od)
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


