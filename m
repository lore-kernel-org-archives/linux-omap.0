From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 33/33] add bq27000 1-wire slave driver
Date: Sat, 30 Aug 2008 20:16:33 +0300
Message-ID: <1220116593-862-34-git-send-email-me@felipebalbi.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
 <1220116593-862-2-git-send-email-me@felipebalbi.com>
 <1220116593-862-3-git-send-email-me@felipebalbi.com>
 <1220116593-862-4-git-send-email-me@felipebalbi.com>
 <1220116593-862-5-git-send-email-me@felipebalbi.com>
 <1220116593-862-6-git-send-email-me@felipebalbi.com>
 <1220116593-862-7-git-send-email-me@felipebalbi.com>
 <1220116593-862-8-git-send-email-me@felipebalbi.com>
 <1220116593-862-9-git-send-email-me@felipebalbi.com>
 <1220116593-862-10-git-send-email-me@felipebalbi.com>
 <1220116593-862-11-git-send-email-me@felipebalbi.com>
 <1220116593-862-12-git-send-email-me@felipebalbi.com>
 <1220116593-862-13-git-send-email-me@felipebalbi.com>
 <1220116593-862-14-git-send-email-me@felipebalbi.com>
 <1220116593-862-15-git-send-email-me@felipebalbi.com>
 <1220116593-862-16-git-send-email-me@felipebalbi.com>
 <1220116593-862-17-git-send-email-me@felipebalbi.com>
 <1220116593-862-18-git-send-email-me@felipebalbi.com>
 <1220116593-862-19-git-send-email-me@felipebalbi.com>
 <1220116593-862-20-git-send-email-me@felipebalbi.com>
 <1220116593-862-21-git-send-email-me@felipebalbi.com>
 <1220116593-862-22-git-send-email-me@felipebalbi.com>
 <1220116593-862-23-git-send-email-me@felipebalbi.com>
 <1220116593-862-24-git-send-email-me@felipebalbi.com>
 <1220116593-862-25-git-send-email-me@felipebalbi.com>
 <1220116593-862-26-git-send-email-me@felipebalbi.com>
 <1220116593-862-27-git-send-email-me@felipebalbi.com>
 <1220116593-862-28-git-send-email-me@felipebalbi.com>
 <1220116593-862-29-git-send-email-me@felipebalbi.com>
 <1220116593-862-30-git-send-email-me@felipebalbi.com>
 <1220116593-862-31-git-send-email-me@felipebalbi.com>
 <1220116593-862-32-git-send-email-me@felipebalbi.com>
 <1220116593-862-33-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36891 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbYH3RYD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:24:03 -0400
In-Reply-To: <1220116593-862-33-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/w1/slaves/Kconfig      |    8 +++
 drivers/w1/slaves/Makefile     |    2 +-
 drivers/w1/slaves/w1_bq27000.c |  120 ++++++++++++++++++++++++++++++++++++++++
 drivers/w1/w1.h                |    1 +
 drivers/w1/w1_io.c             |    3 +-
 5 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 drivers/w1/slaves/w1_bq27000.c

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index 3df29a1..8960fe4 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -44,4 +44,12 @@ config W1_SLAVE_DS2760
 
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
diff --git a/drivers/w1/slaves/Makefile b/drivers/w1/slaves/Makefile
index a8eb752..990f400 100644
--- a/drivers/w1/slaves/Makefile
+++ b/drivers/w1/slaves/Makefile
@@ -6,4 +6,4 @@ obj-$(CONFIG_W1_SLAVE_THERM)	+= w1_therm.o
 obj-$(CONFIG_W1_SLAVE_SMEM)	+= w1_smem.o
 obj-$(CONFIG_W1_SLAVE_DS2433)	+= w1_ds2433.o
 obj-$(CONFIG_W1_SLAVE_DS2760)	+= w1_ds2760.o
-
+obj-$(CONFIG_W1_SLAVE_BQ27000)	+= w1_bq27000.o
diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/w1/slaves/w1_bq27000.c
new file mode 100644
index 0000000..0e8a3f3
--- /dev/null
+++ b/drivers/w1/slaves/w1_bq27000.c
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
+#define HDQ_CMD_READ	(0)
+#define HDQ_CMD_WRITE	(1<<7)
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
+	pdev = platform_device_alloc("bq27000-battery", id);
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
+	.add_slave	= w1_bq27000_add_slave,
+	.remove_slave	= w1_bq27000_remove_slave,
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
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index f1df534..b8189e8 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -189,6 +189,7 @@ struct w1_master *w1_search_master_id(u32 id);
 
 u8 w1_triplet(struct w1_master *dev, int bdir);
 void w1_write_8(struct w1_master *, u8);
+u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, const u8 *, int);
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index 30b6fbf..da08537 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -177,7 +177,7 @@ u8 w1_triplet(struct w1_master *dev, int bdir)
  * @param dev     the master device
  * @return        the byte read
  */
-static u8 w1_read_8(struct w1_master * dev)
+u8 w1_read_8(struct w1_master *dev)
 {
 	int i;
 	u8 res = 0;
@@ -190,6 +190,7 @@ static u8 w1_read_8(struct w1_master * dev)
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(w1_read_8);
 
 /**
  * Writes a series of bytes.
-- 
1.6.0.1.141.g445ca

