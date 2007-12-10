From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [RFC/PATCH 3/5] HDQ/1-wire support for OMAP2430/3430
Date: Mon, 10 Dec 2007 15:47:59 +0530
Message-ID: <005b01c83b15$f0547d00$fe8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Evgeniy Polyakov' <johnpol@2ka.mipt.ru>, linux-omap-open-source@linux.omap.com
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch adds bq27000 battery moniter HDQ slave driver support.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>

---
 drivers/w1/slaves/Kconfig      |    8 ++
 drivers/w1/slaves/Makefile     |    2 
 drivers/w1/slaves/w1_bq27000.c |  112 +++++++++++++++++++++++++++++++++++++++++
 drivers/w1/w1.h                |    1 
 drivers/w1/w1_io.c             |    3 -
 5 files changed, 124 insertions(+), 2 deletions(-)

Index: linux-omap-hdq-new/drivers/w1/slaves/w1_bq27000.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-hdq-new/drivers/w1/slaves/w1_bq27000.c	2007-12-04 17:22:06.753770324 +0530
@@ -0,0 +1,120 @@
+/*
+ * drivers/w1/slaves/w1_bq27000.c
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+
+#include "../w1.h"
+#include "../w1_int.h"
+#include "../w1_family.h"
+
+#define HDQ_CMD_READ                    (0)
+#define HDQ_CMD_WRITE                   (1<<7)
+
+int F_ID;
+int family_id;
+
+void w1_bq27000_write(struct device *dev, u8 buf, u8 reg)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	if (!dev) {
+		pr_info("Could not obtain slave dev ptr\n");
+		return;
+	}
+
+	w1_write_8(sl->master, HDQ_CMD_WRITE | reg);
+	w1_write_8(sl->master, buf);
+}
+EXPORT_SYMBOL(w1_bq27000_write);
+
+int w1_bq27000_read(struct device *dev, u8 reg)
+{
+	u8 val;
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	if (!dev)
+		return 0;
+
+	w1_write_8(sl->master, HDQ_CMD_READ | reg);
+	val = w1_read_8(sl->master);
+
+	return val;
+}
+EXPORT_SYMBOL(w1_bq27000_read);
+
+static int w1_bq27000_add_slave(struct w1_slave *sl)
+{
+	int ret;
+	int id = 1;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc("omap-bq2700-battery", id);
+	if (!pdev) {
+		ret = -ENOMEM;
+		return ret;
+	}
+	pdev->dev.parent = &sl->dev;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto pdev_add_failed;
+
+	dev_set_drvdata(&sl->dev, pdev);
+
+	goto success;
+
+pdev_add_failed:
+	platform_device_unregister(pdev);
+success:
+	return ret;
+}
+
+static void w1_bq27000_remove_slave(struct w1_slave *sl)
+{
+	struct platform_device *pdev = dev_get_drvdata(&sl->dev);
+	platform_device_unregister(pdev);
+}
+
+static struct w1_family_ops w1_bq27000_fops = {
+	.add_slave    = w1_bq27000_add_slave,
+	.remove_slave = w1_bq27000_remove_slave,
+};
+
+static struct w1_family w1_bq27000_family = {
+	.fid = 1,
+	.fops = &w1_bq27000_fops,
+};
+
+static int __init w1_bq27000_init(void)
+{
+	if (F_ID)
+		w1_bq27000_family.fid = F_ID;
+
+	return w1_register_family(&w1_bq27000_family);
+}
+
+static void __exit w1_bq27000_exit(void)
+{
+	w1_unregister_family(&w1_bq27000_family);
+}
+
+
+module_init(w1_bq27000_init);
+module_exit(w1_bq27000_exit);
+
+module_param(F_ID, int, S_IRUSR);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Texas Instruments Ltd");
+MODULE_DESCRIPTION("HDQ/1-wire slave driver bq27000 battery monitor chip");
Index: linux-omap-hdq-new/drivers/w1/slaves/Kconfig
===================================================================
--- linux-omap-hdq-new.orig/drivers/w1/slaves/Kconfig	2007-11-27 20:04:44.000000000 +0530
+++ linux-omap-hdq-new/drivers/w1/slaves/Kconfig	2007-12-04 08:55:45.476110134 +0530
@@ -44,4 +44,12 @@
 
 	  If you are unsure, say N.
 
+config W1_SLAVE_BQ27000
+	tristate "BQ27000 slave support"
+	depends on W1
+	help
+	  Say Y here if you want to use a hdq
+	  bq27000 slave support.
+
+
 endmenu
Index: linux-omap-hdq-new/drivers/w1/slaves/Makefile
===================================================================
--- linux-omap-hdq-new.orig/drivers/w1/slaves/Makefile	2007-11-27 20:04:44.000000000 +0530
+++ linux-omap-hdq-new/drivers/w1/slaves/Makefile	2007-12-04 08:55:45.476110134 +0530
@@ -6,4 +6,4 @@
 obj-$(CONFIG_W1_SLAVE_SMEM)	+= w1_smem.o
 obj-$(CONFIG_W1_SLAVE_DS2433)	+= w1_ds2433.o
 obj-$(CONFIG_W1_SLAVE_DS2760)	+= w1_ds2760.o
-
+obj-$(CONFIG_W1_SLAVE_BQ27000)	+= w1_bq27000.o
Index: linux-omap-hdq-new/drivers/w1/w1_io.c
===================================================================
--- linux-omap-hdq-new.orig/drivers/w1/w1_io.c	2007-11-27 20:04:44.000000000 +0530
+++ linux-omap-hdq-new/drivers/w1/w1_io.c	2007-12-04 08:55:45.477110102 +0530
@@ -177,7 +177,7 @@
  * @param dev     the master device
  * @return        the byte read
  */
-static u8 w1_read_8(struct w1_master * dev)
+u8 w1_read_8(struct w1_master *dev)
 {
 	int i;
 	u8 res = 0;
@@ -190,6 +190,7 @@
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(w1_read_8);
 
 /**
  * Writes a series of bytes.
Index: linux-omap-hdq-new/drivers/w1/w1.h
===================================================================
--- linux-omap-hdq-new.orig/drivers/w1/w1.h	2007-11-27 20:04:44.000000000 +0530
+++ linux-omap-hdq-new/drivers/w1/w1.h	2007-12-04 08:55:45.477110102 +0530
@@ -189,6 +189,7 @@
 
 u8 w1_triplet(struct w1_master *dev, int bdir);
 void w1_write_8(struct w1_master *, u8);
+u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, const u8 *, int);
