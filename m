From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 03/29] nvmem: add a notifier chain
Date: Fri, 10 Aug 2018 10:05:00 +0200
Message-ID: <20180810080526.27207-4-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a blocking notifier chain with two events (add and remove) so that
users can get notified about the addition of nvmem devices they're
waiting for.

We'll use this instead of the at24 setup callback in the mityomapl138
board file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 20 ++++++++++++++++++++
 include/linux/nvmem-consumer.h | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 329ea5b8f809..128c8e51bff2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -65,6 +65,8 @@ static DEFINE_MUTEX(nvmem_cells_mutex);
 static LIST_HEAD(nvmem_cell_lookups);
 static DEFINE_MUTEX(nvmem_lookup_mutex);
 
+static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -479,6 +481,18 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
 	return 0;
 }
 
+int nvmem_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&nvmem_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(nvmem_register_notifier);
+
+int nvmem_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&nvmem_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
+
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -559,6 +573,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (config->cells)
 		nvmem_add_cells(nvmem, config->cells, config->ncells);
 
+	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
+	if (rval)
+		goto err_device_del;
+
 	return nvmem;
 
 err_device_del:
@@ -586,6 +604,8 @@ int nvmem_unregister(struct nvmem_device *nvmem)
 	}
 	mutex_unlock(&nvmem_mutex);
 
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_REMOVE, nvmem);
+
 	if (nvmem->flags & FLAG_COMPAT)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index f4b5d3186e94..ae4d30347602 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -14,6 +14,7 @@
 
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
 
 struct device;
 struct device_node;
@@ -35,6 +36,11 @@ struct nvmem_cell_lookup {
 	const char		*nvmem_name;
 };
 
+enum {
+	NVMEM_ADD = 1,
+	NVMEM_REMOVE,
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
@@ -61,6 +67,8 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
+int nvmem_register_notifier(struct notifier_block *nb);
+int nvmem_unregister_notifier(struct notifier_block *nb);
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -149,6 +157,16 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
 {
 	return -ENOSYS;
 }
+
+static inline int nvmem_register_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
+
+static inline int int nvmem_unregister_notifier(struct notifier_block *nb)
+{
+	return -ENOSYS;
+}
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.18.0
