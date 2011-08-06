From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 4/9] OMAP: omap_device: remove internal functions from omap_device.h
Date: Fri,  5 Aug 2011 17:19:20 -0700
Message-ID: <1312589965-19416-5-git-send-email-khilman@ti.com>
References: <1312589965-19416-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:60027 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932308Ab1HFATe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 20:19:34 -0400
Received: by iyf13 with SMTP id 13so6068185iyf.16
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 17:19:33 -0700 (PDT)
In-Reply-To: <1312589965-19416-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org

The *_device_register() functions and the count/fill resources functions
are internal to omap_device and do not need to be in the header.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    6 ------
 arch/arm/plat-omap/omap_device.c              |   12 ++++++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index ee405b36..61d14b3 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -88,9 +88,6 @@ int omap_device_shutdown(struct platform_device *pdev);
 
 /* Core code interface */
 
-int omap_device_count_resources(struct omap_device *od);
-int omap_device_fill_resources(struct omap_device *od, struct resource *res);
-
 struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
@@ -103,9 +100,6 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_device_pm_latency *pm_lats,
 					 int pm_lats_cnt, int is_early_device);
 
-int omap_device_register(struct omap_device *od);
-int omap_early_device_register(struct omap_device *od);
-
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
 
 /* OMAP PM interface */
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 14c5363..b49a8f3 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -94,6 +94,9 @@
 #define USE_WAKEUP_LAT			0
 #define IGNORE_WAKEUP_LAT		1
 
+static int omap_device_register(struct omap_device *od);
+static int omap_early_device_register(struct omap_device *od);
+
 /* Private functions */
 
 /**
@@ -339,7 +342,7 @@ u32 omap_device_get_context_loss_count(struct platform_device *pdev)
  * much memory to allocate before calling
  * omap_device_fill_resources().  Returns the count.
  */
-int omap_device_count_resources(struct omap_device *od)
+static int omap_device_count_resources(struct omap_device *od)
 {
 	int c = 0;
 	int i;
@@ -370,7 +373,8 @@ int omap_device_count_resources(struct omap_device *od)
  * functions to get device resources.  Hacking around the existing
  * platform_device code wastes memory.  Returns 0.
  */
-int omap_device_fill_resources(struct omap_device *od, struct resource *res)
+static int omap_device_fill_resources(struct omap_device *od,
+				      struct resource *res)
 {
 	int c = 0;
 	int i, r;
@@ -534,7 +538,7 @@ odbs_exit1:
  * platform_early_add_device() on the underlying platform_device.
  * Returns 0 by default.
  */
-int omap_early_device_register(struct omap_device *od)
+static int omap_early_device_register(struct omap_device *od)
 {
 	struct platform_device *devices[1];
 
@@ -630,7 +634,7 @@ static struct dev_pm_domain omap_device_pm_domain = {
  * platform_device_register() on the underlying platform_device.
  * Returns the return value of platform_device_register().
  */
-int omap_device_register(struct omap_device *od)
+static int omap_device_register(struct omap_device *od)
 {
 	pr_debug("omap_device: %s: registering\n", od->pdev.name);
 
-- 
1.7.6

