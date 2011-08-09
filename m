From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 05/14] OMAP: omap_device: remove internal functions from
	omap_device.h
Date: Tue, 09 Aug 2011 19:10:23 +0500
Message-ID: <1312897232-4792-6-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>

The *_device_register() functions and the count/fill resources functions
are internal to omap_device and do not need to be in the header.

Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    6 ------
 arch/arm/plat-omap/omap_device.c              |   12 ++++++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..0a53a0a 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -83,9 +83,6 @@ int omap_device_shutdown(struct platform_device *pdev);
 
 /* Core code interface */
 
-int omap_device_count_resources(struct omap_device *od);
-int omap_device_fill_resources(struct omap_device *od, struct resource *res);
-
 struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
 				      struct omap_hwmod *oh, void *pdata,
 				      int pdata_len,
@@ -98,9 +95,6 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_device_pm_latency *pm_lats,
 					 int pm_lats_cnt, int is_early_device);
 
-int omap_device_register(struct omap_device *od);
-int omap_early_device_register(struct omap_device *od);
-
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
 
 /* OMAP PM interface */
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 1d69596..4737b60 100644
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
@@ -325,7 +328,7 @@ u32 omap_device_get_context_loss_count(struct platform_device *pdev)
  * much memory to allocate before calling
  * omap_device_fill_resources().  Returns the count.
  */
-int omap_device_count_resources(struct omap_device *od)
+static int omap_device_count_resources(struct omap_device *od)
 {
 	int c = 0;
 	int i;
@@ -356,7 +359,8 @@ int omap_device_count_resources(struct omap_device *od)
  * functions to get device resources.  Hacking around the existing
  * platform_device code wastes memory.  Returns 0.
  */
-int omap_device_fill_resources(struct omap_device *od, struct resource *res)
+static int omap_device_fill_resources(struct omap_device *od,
+				      struct resource *res)
 {
 	int c = 0;
 	int i, r;
@@ -520,7 +524,7 @@ odbs_exit1:
  * platform_early_add_device() on the underlying platform_device.
  * Returns 0 by default.
  */
-int omap_early_device_register(struct omap_device *od)
+static int omap_early_device_register(struct omap_device *od)
 {
 	struct platform_device *devices[1];
 
@@ -573,7 +577,7 @@ static struct dev_power_domain omap_device_power_domain = {
  * platform_device_register() on the underlying platform_device.
  * Returns the return value of platform_device_register().
  */
-int omap_device_register(struct omap_device *od)
+static int omap_device_register(struct omap_device *od)
 {
 	pr_debug("omap_device: %s: registering\n", od->pdev.name);
 
-- 
1.7.1
