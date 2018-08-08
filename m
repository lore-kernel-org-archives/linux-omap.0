From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 01/28] nvmem: add support for cell lookups
Date: Wed,  8 Aug 2018 17:31:23 +0200
Message-ID: <20180808153150.23444-2-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>, Florian Fainelli <f.fainelli@gmail.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Sven Van Asbroeck <svendev@a>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can currently only register nvmem cells from device tree or by
manually calling nvmem_add_cells(). The latter options however forces
users to make sure that the nvmem provider with which the cells are
associated is registered before the call.

This patch proposes a new solution inspired by other frameworks that
offer resource lookups (GPIO, PWM etc.). It adds functions that allow
machine code to register nvmem lookup which are later lazily used to
add corresponding nvmem cells and remove them if no longer needed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 77 +++++++++++++++++++++++++++++++++-
 include/linux/nvmem-consumer.h |  6 +++
 include/linux/nvmem-provider.h | 10 +++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 514d1dfc5630..329ea5b8f809 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
 static LIST_HEAD(nvmem_cells);
 static DEFINE_MUTEX(nvmem_cells_mutex);
 
+static LIST_HEAD(nvmem_cell_lookups);
+static DEFINE_MUTEX(nvmem_lookup_mutex);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -247,6 +250,41 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
 	NULL,
 };
 
+/**
+ * nvmem_add_lookup_table() - register a number of nvmem cell lookup entries
+ *
+ * @lookup: array of nvmem cell lookup entries
+ * @nentries: number of lookup entries in the array
+ */
+void nvmem_add_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries)
+{
+	int i;
+
+	mutex_lock(&nvmem_lookup_mutex);
+	for (i = 0; i < nentries; i++)
+		list_add_tail(&lookup[i].list, &nvmem_cell_lookups);
+	mutex_unlock(&nvmem_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_add_lookup_table);
+
+/**
+ * nvmem_del_lookup_table() - unregister a set of previously added nvmem cell
+ *                            lookup entries
+ *
+ * @lookup: array of nvmem cell lookup entries
+ * @nentries: number of lookup entries in the array
+ */
+void nvmem_del_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries)
+{
+	int i;
+
+	mutex_lock(&nvmem_lookup_mutex);
+	for (i = 0; i < nentries; i++)
+		list_del(&lookup[i].list);
+	mutex_unlock(&nvmem_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_del_lookup_table);
+
 static void nvmem_release(struct device *dev)
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
@@ -916,6 +954,39 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
 #endif
 
+static struct nvmem_cell *nvmem_cell_from_lookup(const char *cell_id)
+{
+	struct nvmem_cell *cell = ERR_PTR(-ENOENT);
+	struct nvmem_cell_lookup *lookup;
+	struct nvmem_device *nvmem;
+	int rc;
+
+	mutex_lock(&nvmem_lookup_mutex);
+
+	list_for_each_entry(lookup, &nvmem_cell_lookups, list) {
+		if (strcmp(cell_id, lookup->info.name) == 0) {
+			nvmem = nvmem_find(lookup->nvmem_name);
+			if (!nvmem) {
+				cell = ERR_PTR(-EPROBE_DEFER);
+				goto out;
+			}
+
+			rc = nvmem_add_cells(nvmem, &lookup->info, 1);
+			if (rc) {
+				cell = ERR_PTR(rc);
+				goto out;
+			}
+
+			cell = nvmem_cell_get_from_list(cell_id);
+			break;
+		}
+	}
+
+out:
+	mutex_unlock(&nvmem_lookup_mutex);
+	return cell;
+}
+
 /**
  * nvmem_cell_get() - Get nvmem cell of device form a given cell name
  *
@@ -940,7 +1011,11 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 	if (!cell_id)
 		return ERR_PTR(-EINVAL);
 
-	return nvmem_cell_get_from_list(cell_id);
+	cell = nvmem_cell_get_from_list(cell_id);
+	if (!IS_ERR(cell) || PTR_ERR(cell) == -EPROBE_DEFER)
+		return cell;
+
+	return nvmem_cell_from_lookup(cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 4e85447f7860..f4b5d3186e94 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -29,6 +29,12 @@ struct nvmem_cell_info {
 	unsigned int		nbits;
 };
 
+struct nvmem_cell_lookup {
+	struct nvmem_cell_info	info;
+	struct list_head	list;
+	const char		*nvmem_name;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 24def6ad09bb..6a17d722062b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -17,6 +17,7 @@
 
 struct nvmem_device;
 struct nvmem_cell_info;
+struct nvmem_cell_lookup;
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
@@ -72,6 +73,9 @@ struct nvmem_config {
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
 int nvmem_unregister(struct nvmem_device *nvmem);
 
+void nvmem_add_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries);
+void nvmem_del_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries);
+
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
 
@@ -92,6 +96,12 @@ static inline int nvmem_unregister(struct nvmem_device *nvmem)
 	return -ENOSYS;
 }
 
+static inline void
+nvmem_add_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries) {}
+
+static inline void
+nvmem_del_lookup_table(struct nvmem_cell_lookup *lookup, size_t nentries) {}
+
 static inline struct nvmem_device *
 devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 {
-- 
2.18.0
