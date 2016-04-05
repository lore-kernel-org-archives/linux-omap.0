From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 01/20] mfd: Add devm_ apis for mfd_add_devices and mfd_release_devices
Date: Tue, 5 Apr 2016 17:18:13 +0530
Message-ID: <1459856912-17859-2-git-send-email-ldewangan@nvidia.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net
Cc: andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Add device managed APIs devm_mfd_add_devices() and
devm_mfd_remove_devices() for the APIs mfd_add_devices()
and mfd_remove_devices().

This helps in reducing code in error path and sometimes
removal of .remove callback for driver unbind.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/mfd/mfd-core.c   | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/core.h |  7 ++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 409da01..145712e 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -334,6 +334,68 @@ void mfd_remove_devices(struct device *parent)
 }
 EXPORT_SYMBOL(mfd_remove_devices);
 
+static void devm_mfd_dev_release(struct device *dev, void *res)
+{
+	mfd_remove_devices(dev);
+}
+
+/**
+ * devm_mfd_add_devices - Resource managed version of mfd_add_devices()
+ *
+ * This returns the 0 on success otherwise error number in the failure.
+ * The allocated mfd devices will automatically be released when the
+ * device is unbound.
+ */
+int devm_mfd_add_devices(struct device *dev, int id,
+		    const struct mfd_cell *cells, int n_devs,
+		    struct resource *mem_base,
+		    int irq_base, struct irq_domain *domain)
+{
+	struct device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_mfd_dev_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = mfd_add_devices(dev, id, cells, n_devs, mem_base,
+			      irq_base, domain);
+	if (!ret) {
+		*ptr = dev;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(devm_mfd_add_devices);
+
+static int devm_mfd_devs_match(struct device *dev, void *res, void *data)
+{
+	struct device **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+/**
+ * devm_mfd_remove_device - Resource managed version of mfd_remove_devices()
+ * @dev: Device for which which resource was allocated.
+ *
+ * Remove all mfd devices added on the device.
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_mfd_remove_devices(struct device *dev)
+{
+	WARN_ON(devres_release(dev, devm_mfd_dev_release,
+			       devm_mfd_devs_match, dev));
+}
+EXPORT_SYMBOL(devm_mfd_remove_devices);
+
 int mfd_clone_cell(const char *cell, const char **clones, size_t n_clones)
 {
 	struct mfd_cell cell_entry;
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index bc6f7e0..d658d7f 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -131,4 +131,11 @@ static inline int mfd_add_hotplug_devices(struct device *parent,
 
 extern void mfd_remove_devices(struct device *parent);
 
+extern int devm_mfd_add_devices(struct device *dev, int id,
+			   const struct mfd_cell *cells, int n_devs,
+			   struct resource *mem_base,
+			   int irq_base, struct irq_domain *irq_domain);
+
+extern void devm_mfd_remove_devices(struct device *dev);
+
 #endif
-- 
2.1.4
