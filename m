From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 06/28] mtd: Add support for reading MTD devices via the nvmem API
Date: Wed,  8 Aug 2018 17:31:28 +0200
Message-ID: <20180808153150.23444-7-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Alban Bedel <albeu@free.fr>

Allow drivers that use the nvmem API to read data stored on MTD devices.
For this the mtd devices are registered as read-only NVMEM providers.
On OF systems only devices that have the 'nvmem-provider' property
are registered, on non-OF system all MTD devices are registered.

Signed-off-by: Alban Bedel <albeu@free.fr>
[Bartosz:
  - use the managed variant of nvmem_register(),
  - set the nvmem name]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mtd/Kconfig     |  1 +
 drivers/mtd/mtdcore.c   | 50 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  2 ++
 3 files changed, 53 insertions(+)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 46ab7feec6b6..f5549482d0df 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -1,5 +1,6 @@
 menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
+	imply NVMEM
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
 	  used for solid state file systems on embedded devices. This option
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 42395df06be9..a57302eaceb5 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -488,6 +488,49 @@ int mtd_pairing_groups(struct mtd_info *mtd)
 }
 EXPORT_SYMBOL_GPL(mtd_pairing_groups);
 
+static int mtd_nvmem_reg_read(void *priv, unsigned int offset,
+			      void *val, size_t bytes)
+{
+	struct mtd_info *mtd = priv;
+	size_t retlen;
+	int err;
+
+	err = mtd_read(mtd, offset, bytes, &retlen, val);
+	if (err && err != -EUCLEAN)
+		return err;
+
+	return retlen == bytes ? 0 : -EIO;
+}
+
+static int mtd_nvmem_add(struct mtd_info *mtd)
+{
+	struct nvmem_config config = { };
+
+	config.dev = &mtd->dev;
+	config.owner = THIS_MODULE;
+	config.name = mtd->name;
+	config.reg_read = mtd_nvmem_reg_read;
+	config.size = mtd->size;
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.priv = mtd;
+
+	mtd->nvmem = devm_nvmem_register(&mtd->dev, &config);
+	if (IS_ERR(mtd->nvmem)) {
+		/* Just ignore if there is no NVMEM support in the kernel */
+		if (PTR_ERR(mtd->nvmem) == -ENOSYS) {
+			mtd->nvmem = NULL;
+		} else {
+			dev_err(&mtd->dev, "Failed to register NVMEM device\n");
+			return PTR_ERR(mtd->nvmem);
+		}
+	}
+
+	return 0;
+}
+
 static struct dentry *dfs_dir_mtd;
 
 /**
@@ -570,6 +613,11 @@ int add_mtd_device(struct mtd_info *mtd)
 	if (error)
 		goto fail_added;
 
+	/* Add the nvmem provider */
+	error = mtd_nvmem_add(mtd);
+	if (error)
+		goto fail_nvmem_add;
+
 	if (!IS_ERR_OR_NULL(dfs_dir_mtd)) {
 		mtd->dbg.dfs_dir = debugfs_create_dir(dev_name(&mtd->dev), dfs_dir_mtd);
 		if (IS_ERR_OR_NULL(mtd->dbg.dfs_dir)) {
@@ -595,6 +643,8 @@ int add_mtd_device(struct mtd_info *mtd)
 	__module_get(THIS_MODULE);
 	return 0;
 
+fail_nvmem_add:
+	device_unregister(&mtd->dev);
 fail_added:
 	of_node_put(mtd_get_of_node(mtd));
 	idr_remove(&mtd_idr, i);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index a86c4fa93115..8121c6582285 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include <linux/device.h>
 #include <linux/of.h>
+#include <linux/nvmem-provider.h>
 
 #include <mtd/mtd-abi.h>
 
@@ -339,6 +340,7 @@ struct mtd_info {
 	struct device dev;
 	int usecount;
 	struct mtd_debug_info dbg;
+	struct nvmem_device *nvmem;
 };
 
 int mtd_ooblayout_ecc(struct mtd_info *mtd, int section,
-- 
2.18.0
