From: Andy Green <andy.green@linaro.org>
Subject: [try#1 PATCH 3/7] clk: add default device asset handlers
Date: Wed, 28 Nov 2012 12:59:44 +0000
Message-ID: <20121128125944.29569.98017.stgit@build.warmcat.com>
References: <20121128124744.29569.52739.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:59177 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754896Ab2K1M7t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 07:59:49 -0500
In-Reply-To: <20121128124744.29569.52739.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rogerq@ti.com, keshava_mgowda@ti.com, balbi@ti.com, stern@rowland.harvard.edu

This adds default device_asset handlers for struct clk.  If you
want an associated clk asset of a device to be optionally set, and
enabled  before probe, and disabled after removal, these callbacks
will take care of everything including get and put.

By defining them here in regulator core, code duplication at the usages
is nipped in the bud.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 drivers/clk/clkdev.c |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h  |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..01d3fcd 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -327,3 +327,42 @@ int clk_register_clkdevs(struct clk *clk, struct clk_lookup *cl, size_t num)
 	return 0;
 }
 EXPORT_SYMBOL(clk_register_clkdevs);
+
+/*
+ * Default handlers for clock asset preprobe and postremoval
+ */
+int clk_asset_default_preprobe(struct device *device,
+						struct device_asset *asset)
+{
+	struct clk **clk = (struct clk **)&asset->asset;
+	int n;
+
+	*clk = clk_get(device, asset->name);
+	if (IS_ERR(*clk))
+		return PTR_ERR(*clk);
+	if (asset->data) {
+		n = clk_set_rate(*clk, (unsigned long)asset->data);
+		if (n < 0)
+			goto bail;
+	}
+	n = clk_prepare_enable(*clk);
+	if (n < 0)
+		goto bail;
+
+	return 0;
+bail:
+	clk_put(*clk);
+
+	return n;
+}
+EXPORT_SYMBOL_GPL(clk_asset_default_preprobe);
+
+void clk_asset_default_postremove(struct device *device,
+						struct device_asset *asset)
+{
+	struct clk **clk = (struct clk **)&asset->asset;
+
+	clk_disable_unprepare(*clk);
+	clk_put(*clk);
+}
+EXPORT_SYMBOL_GPL(clk_asset_default_postremove);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index b3ac22d..3956675 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -17,6 +17,7 @@
 #include <linux/notifier.h>
 
 struct device;
+struct device_asset;
 
 struct clk;
 
@@ -276,6 +277,27 @@ struct clk *clk_get_parent(struct clk *clk);
  */
 struct clk *clk_get_sys(const char *dev_id, const char *con_id);
 
+/**
+ * clk_asset_default_preprobe: default probe handler for clock device assets
+ * @device:	the device whose assets we are enabling just before probing it
+ * @asset: the clock asset we are going to get and enable
+ *
+ * You can give this as the handler for .pre_probe callback in device_asset to
+ * deal with pre-enabling/get of a device's clock assets
+ */
+int clk_asset_default_preprobe(struct device *device,
+						struct device_asset *asset);
+/**
+ * clk_asset_default_postremove: default remove handler for clock device assets
+ * @device:	the device whose assets we are disabling just after removing it
+ * @asset: the clock asset we are going to disable and put
+ *
+ * You can give this as the handler for .post_remove callback in device_asset
+ * to deal with post-disabling/put of a device's clock assets
+ */
+void clk_asset_default_postremove(struct device *device,
+						struct device_asset *asset);
+
 #else /* !CONFIG_HAVE_CLK */
 
 static inline struct clk *clk_get(struct device *dev, const char *id)
@@ -323,7 +345,16 @@ static inline struct clk *clk_get_parent(struct clk *clk)
 {
 	return NULL;
 }
-
+static inline int clk_asset_default_preprobe(struct device *device,
+						    struct device_asset *asset)
+{
+	return 0;
+}
+static inline void clk_asset_default_postremove(struct device *device,
+						    struct device_asset *asset)
+{
+}
+s
 #endif
 
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */

