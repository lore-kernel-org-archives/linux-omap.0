From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: OMAP: Change MMU to use sysdev_class?
Date: Mon, 3 Dec 2007 14:40:29 -0800
Message-ID: <20071203224029.GF4105@atomide.com>
References: <20071203222651.GE4105@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071203222651.GE4105@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <lethal@linux-sh.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We could optionally change to use sysdev_class. But that changes the
sysfs path to /sys/devices/system/mmu/mempool.

What do you guys think? Should we change it, or keep using class device?

Regards,

Tony

--1LKvkjL3sHcu1TtY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mmu-sysdev.patch"

>From 0ca34f3a9f9e6859e8fbe6d206188b33f1f49c2a Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 3 Dec 2007 14:33:39 -0800
Subject: [PATCH] ARM: OMAP: Change MMU to use sysdev_class

ARM: OMAP: Change MMU to use sysdev_class.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index b7ae3d2..9f05d5a 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/sysdev.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <asm/uaccess.h>
@@ -1429,7 +1430,7 @@ static ssize_t exmap_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(exmap, S_IRUGO | S_IWUSR, exmap_show, exmap_store);
 
-static ssize_t mempool_show(struct class *class, char *buf)
+static ssize_t mempool_show(struct sysdev_class *class, char *buf)
 {
 	int min_nr_1M = 0, curr_nr_1M = 0;
 	int min_nr_64K = 0, curr_nr_64K = 0;
@@ -1454,17 +1455,16 @@ static ssize_t mempool_show(struct class *class, char *buf)
 }
 
 
-static CLASS_ATTR(mempool, S_IRUGO, mempool_show, NULL);
+static SYSDEV_CLASS_ATTR(mempool, S_IRUGO, mempool_show, NULL);
 
-static struct class omap_mmu_class = {
-	.name		= "mmu",
+static struct sysdev_class omap_mmu = {
+	set_kset_name("mmu"),
 };
 
 int omap_mmu_register(struct omap_mmu *mmu)
 {
 	int ret;
 
-	mmu->dev.class = &omap_mmu_class;
 	strlcpy(mmu->dev.bus_id, mmu->name, KOBJ_NAME_LEN);
 	dev_set_drvdata(&mmu->dev, mmu);
 
@@ -1548,22 +1548,22 @@ void omap_mmu_unregister(struct omap_mmu *mmu)
 }
 EXPORT_SYMBOL_GPL(omap_mmu_unregister);
 
-static int __init omap_mmu_class_init(void)
+static int __init omap_mmu_sysdev_init(void)
 {
-	int ret = class_register(&omap_mmu_class);
+	int ret = sysdev_class_register(&omap_mmu);
 	if (!ret)
-		ret = class_create_file(&omap_mmu_class, &class_attr_mempool);
+		ret = sysdev_class_create_file(&omap_mmu, &attr_mempool);
 
 	return ret;
 }
 
-static void __exit omap_mmu_class_exit(void)
+static void __exit omap_mmu_sysdev_exit(void)
 {
-	class_remove_file(&omap_mmu_class, &class_attr_mempool);
-	class_unregister(&omap_mmu_class);
+	sysdev_class_remove_file(&omap_mmu, &attr_mempool);
+	sysdev_class_unregister(&omap_mmu);
 }
 
-subsys_initcall(omap_mmu_class_init);
-module_exit(omap_mmu_class_exit);
+subsys_initcall(omap_mmu_sysdev_init);
+module_exit(omap_mmu_sysdev_exit);
 
 MODULE_LICENSE("GPL");

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--1LKvkjL3sHcu1TtY--
