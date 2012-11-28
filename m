From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [try#1 PATCH 2/7] regulator: core: add default device asset handlers
Date: Wed, 28 Nov 2012 12:59:39 +0000
Message-ID: <20121128125939.29569.72105.stgit@build.warmcat.com>
References: <20121128124744.29569.52739.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121128124744.29569.52739.stgit-Ak/hGR4SqtBG2qbu2SEcwgC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This adds default device_asset handlers for struct regulator.  If you
want an associated regulator asset of a device to be powered before
probe, and depowered after removal, these callbacks will take care of
everything including get and put.

By defining them here in regulator core, code duplication at the usages
is nipped in the bud.

Signed-off-by: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/regulator/core.c          |   34 ++++++++++++++++++++++++++++++++++
 include/linux/regulator/machine.h |   30 ++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e872c8b..1834e41 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3495,6 +3495,40 @@ void regulator_unregister(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
+/*
+ * Default handlers for regulator asset preprobe and postremoval
+ */
+int regulator_asset_default_preprobe(struct device *device,
+						struct device_asset *asset)
+{
+	struct regulator **reg = (struct regulator **)&asset->asset;
+	int n;
+
+	*reg = regulator_get(device, asset->name);
+	if (IS_ERR(*reg))
+		return PTR_ERR(*reg);
+	n = regulator_enable(*reg);
+	if (n < 0)
+		regulator_put(*reg);
+
+	dev_info(device, "Enabled regulator asset %s\n", asset->name);
+
+	return n;
+}
+EXPORT_SYMBOL_GPL(regulator_asset_default_preprobe);
+
+void regulator_asset_default_postremove(struct device *device,
+						struct device_asset *asset)
+{
+	struct regulator *reg = asset->asset;
+
+	dev_info(device, "Disabling post-remove asset %s\n", asset->name);
+
+	regulator_disable(reg);
+	regulator_put(reg);
+}
+EXPORT_SYMBOL_GPL(regulator_asset_default_postremove);
+
 /**
  * regulator_suspend_prepare - prepare regulators for system wide suspend
  * @state: system suspend state
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 36adbc8..151a330 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -191,9 +191,39 @@ int regulator_suspend_prepare(suspend_state_t state);
 int regulator_suspend_finish(void);
 
 #ifdef CONFIG_REGULATOR
+/**
+ * regulator_asset_default_preprobe: default probe handler for regulator assets
+ * @device:	the device whose assets we are enabling just before probing it
+ * @asset: the named regulator asset we are going to get and enable
+ *
+ * You can give this as the handler for .pre_probe callback in device_asset to
+ * deal with pre-enabling/get of a device's named regulator assets
+ */
+int regulator_asset_default_preprobe(struct device *device,
+						struct device_asset *asset);
+/**
+ * regulator_asset_default_postremove: default remove handler for reg assets
+ * @device:	the device whose assets we are disabling just after removing it
+ * @asset: the regulator asset we are going to disable and put
+ *
+ * You can give this as the handler for .post_remove callback in device_asset
+ * to deal with post-disabling/put of a device's regulator assets
+ */
+void regulator_asset_default_postremove(struct device *device,
+						struct device_asset *asset);
+
 void regulator_has_full_constraints(void);
 void regulator_use_dummy_regulator(void);
 #else
+static inline int regulator_asset_default_preprobe(struct device *device,
+						    struct device_asset *asset)
+{
+	return 0;
+}
+static inline void regulator_asset_default_postremove(struct device *device,
+						    struct device_asset *asset)
+{
+}
 static inline void regulator_has_full_constraints(void)
 {
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
