From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/21] drm/omap: fix TILER on OMAP5
Date: Thu, 26 Feb 2015 15:20:18 +0200
Message-ID: <1424956829-22892-11-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38327 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbbBZNVO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:14 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On OMAP5 it is not possible to use TILER buffer with CPU when caching or
write-combining is used. Doing so leads to errors from the memory
manager.

However, on OMAP4, write-combining works fine.

This patch adds platform specific data for the TILER, and a function
tiler_get_cpu_cache_flags() which can be used to get the caching mode to
be used.

Note that without write-combining the use of the TILER buffer with CPU
is unusably slow. It's still good to have it operational for testing
purposes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_priv.h  |  6 +++++
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 39 ++++++++++++++++++++++++++++++--
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.h |  1 +
 drivers/gpu/drm/omapdrm/omap_gem.c       |  4 ++--
 4 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_priv.h b/drivers/gpu/drm/omapdrm/omap_dmm_priv.h
index 58bcd6ae0255..d96660573076 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_priv.h
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_priv.h
@@ -153,6 +153,10 @@ struct refill_engine {
 	struct list_head idle_node;
 };
 
+struct dmm_platform_data {
+	uint32_t cpu_cache_flags;
+};
+
 struct dmm {
 	struct device *dev;
 	void __iomem *base;
@@ -183,6 +187,8 @@ struct dmm {
 
 	/* allocation list and lock */
 	struct list_head alloc_head;
+
+	const struct dmm_platform_data *plat_data;
 };
 
 #endif
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 56c60552abba..ef3d14d9cfa1 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -39,6 +39,10 @@
 static struct tcm *containers[TILFMT_NFORMATS];
 static struct dmm *omap_dmm;
 
+#if defined(CONFIG_OF)
+static const struct of_device_id dmm_of_match[];
+#endif
+
 /* global spinlock for protecting lists */
 static DEFINE_SPINLOCK(list_lock);
 
@@ -529,6 +533,11 @@ size_t tiler_vsize(enum tiler_fmt fmt, uint16_t w, uint16_t h)
 	return round_up(geom[fmt].cpp * w, PAGE_SIZE) * h;
 }
 
+uint32_t tiler_get_cpu_cache_flags(void)
+{
+	return omap_dmm->plat_data->cpu_cache_flags;
+}
+
 bool dmm_is_available(void)
 {
 	return omap_dmm ? true : false;
@@ -592,6 +601,18 @@ static int omap_dmm_probe(struct platform_device *dev)
 
 	init_waitqueue_head(&omap_dmm->engine_queue);
 
+	if (dev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_node(dmm_of_match, dev->dev.of_node);
+		if (!match) {
+			dev_err(&dev->dev, "failed to find matching device node\n");
+			return -ENODEV;
+		}
+
+		omap_dmm->plat_data = match->data;
+	}
+
 	/* lookup hwmod data - base address and irq */
 	mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -972,9 +993,23 @@ static const struct dev_pm_ops omap_dmm_pm_ops = {
 #endif
 
 #if defined(CONFIG_OF)
+static const struct dmm_platform_data dmm_omap4_platform_data = {
+	.cpu_cache_flags = OMAP_BO_WC,
+};
+
+static const struct dmm_platform_data dmm_omap5_platform_data = {
+	.cpu_cache_flags = OMAP_BO_UNCACHED,
+};
+
 static const struct of_device_id dmm_of_match[] = {
-	{ .compatible = "ti,omap4-dmm", },
-	{ .compatible = "ti,omap5-dmm", },
+	{
+		.compatible = "ti,omap4-dmm",
+		.data = &dmm_omap4_platform_data,
+	},
+	{
+		.compatible = "ti,omap5-dmm",
+		.data = &dmm_omap5_platform_data,
+	},
 	{},
 };
 #endif
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.h b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.h
index 4fdd61e54bd2..e83c78372db8 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.h
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.h
@@ -106,6 +106,7 @@ uint32_t tiler_stride(enum tiler_fmt fmt, uint32_t orient);
 size_t tiler_size(enum tiler_fmt fmt, uint16_t w, uint16_t h);
 size_t tiler_vsize(enum tiler_fmt fmt, uint16_t w, uint16_t h);
 void tiler_align(enum tiler_fmt fmt, uint16_t *w, uint16_t *h);
+uint32_t tiler_get_cpu_cache_flags(void);
 bool dmm_is_available(void);
 
 extern struct platform_driver omap_dmm_driver;
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 9b250c93b046..d37ee756a0b1 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1359,8 +1359,8 @@ struct drm_gem_object *omap_gem_new(struct drm_device *dev,
 		/* currently don't allow cached buffers.. there is some caching
 		 * stuff that needs to be handled better
 		 */
-		flags &= ~(OMAP_BO_CACHED|OMAP_BO_UNCACHED);
-		flags |= OMAP_BO_WC;
+		flags &= ~(OMAP_BO_CACHED|OMAP_BO_WC|OMAP_BO_UNCACHED);
+		flags |= tiler_get_cpu_cache_flags();
 
 		/* align dimensions to slot boundaries... */
 		tiler_align(gem2fmt(flags),
-- 
2.3.0

