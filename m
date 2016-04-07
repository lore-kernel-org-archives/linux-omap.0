From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 01/20] mfd: Add resource managed apis for mfd_add_devices
Date: Fri, 8 Apr 2016 00:12:55 +0530
Message-ID: <1460054594-32325-2-git-send-email-ldewangan@nvidia.com>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Add resource managed API devm_mfd_add_devices() for the mfd_add_devices().

This helps in reducing code in error path as it is not required
to call mfd_remove_devices() explicitly to remove all child-devices.
In some cases, it also helps not to implement .remove() callback
which get called during driver unbind.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V1:
- Reformat the commit message.
- Run checkpatch with --strict option and fix warning.
- Remove devm_ for mfd_remove_devices() as this is not used.
- Consider V1 review comment on error handling.

 drivers/mfd/mfd-core.c   | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/core.h |  4 ++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 409da01..4b4c1d4 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -334,6 +334,44 @@ void mfd_remove_devices(struct device *parent)
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
+ * Returns 0 on success or an appropriate negative error number on failure.
+ * All child-devices of the MFD will automatically be removed when it gets
+ * unbinded.
+ */
+int devm_mfd_add_devices(struct device *dev, int id,
+			 const struct mfd_cell *cells, int n_devs,
+			 struct resource *mem_base,
+			 int irq_base, struct irq_domain *domain)
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
+	if (ret < 0) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = dev;
+	devres_add(dev, ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL(devm_mfd_add_devices);
+
 int mfd_clone_cell(const char *cell, const char **clones, size_t n_clones)
 {
 	struct mfd_cell cell_entry;
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index bc6f7e0..4a0268a 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -131,4 +131,8 @@ static inline int mfd_add_hotplug_devices(struct device *parent,
 
 extern void mfd_remove_devices(struct device *parent);
 
+extern int devm_mfd_add_devices(struct device *dev, int id,
+				const struct mfd_cell *cells, int n_devs,
+				struct resource *mem_base,
+				int irq_base, struct irq_domain *irq_domain);
 #endif
-- 
2.1.4
