From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch 2/3] sti: make it a bus driver
Date: Thu, 11 Jun 2009 11:46:58 +0300
Message-ID: <1244710019-14564-3-git-send-email-felipe.balbi@nokia.com>
References: <1244710019-14564-1-git-send-email-felipe.balbi@nokia.com>
 <1244710019-14564-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35318 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZFKIuC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 04:50:02 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n5B8nd86032630
	for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 11:49:58 +0300
In-Reply-To: <1244710019-14564-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

Make sti a bus driver so sti-netlink and sti-console can
register to it.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/mach/sti.h |   57 +++++++++++
 drivers/misc/sti/sdti.c               |  178 ++++++++++++++++++++++++++++++++-
 2 files changed, 234 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/sti.h b/arch/arm/plat-omap/include/mach/sti.h
index f4cbd8f..da7ca49 100644
--- a/arch/arm/plat-omap/include/mach/sti.h
+++ b/arch/arm/plat-omap/include/mach/sti.h
@@ -1,8 +1,65 @@
 #ifndef __ASM_ARCH_OMAP_STI_H
 #define __ASM_ARCH_OMAP_STI_H
 
+#include <linux/device.h>
+#include <linux/bitops.h>
+#include <linux/pm.h>
 #include <asm/io.h>
 
+/* -------------------------------------------------------------------------- */
+
+extern struct bus_type sti_bus_type;
+
+#define STI_NAME_SIZE	20
+
+struct sti_client;
+
+struct sti_driver {
+	int id;
+	unsigned int class;
+	char name[STI_NAME_SIZE];
+
+	int (*probe)(struct sti_client *);
+	int (*remove)(struct sti_client *);
+	void (*shutdown)(struct sti_client *);
+	int (*suspend)(struct sti_client *, pm_message_t mesg);
+	int (*resume)(struct sti_client *);
+
+	struct device_driver driver;
+	struct list_head clients;
+};
+#define to_sti_driver(d) container_of(d, struct sti_driver, driver)
+
+struct sti_client {
+	unsigned short flags;		/* div., see below		*/
+	char name[STI_NAME_SIZE];
+	struct sti_driver *driver;	/* and our access routines	*/
+	struct device dev;		/* the device structure		*/
+	int irq;			/* irq issued by device		*/
+};
+#define to_sti_client(d) container_of(d, struct sti_client, dev)
+
+#define STI_CLIENT_WAKE		BIT(0)
+
+static inline void sti_set_clientdata(struct sti_client *client, void *data)
+{
+	dev_set_drvdata(&client->dev, data);
+}
+
+static inline void *sti_get_clientdata(const struct sti_client *client)
+{
+	return dev_get_drvdata(&client->dev);
+}
+
+extern int sti_register_driver(struct module *, struct sti_driver *);
+
+static inline int sti_add_driver(struct sti_driver *driver)
+{
+	return sti_register_driver(THIS_MODULE, driver);
+}
+
+/* -------------------------------------------------------------------------- */
+
 /*
  * STI/SDTI
  */
diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
index 4f4fcef..7563a67 100644
--- a/drivers/misc/sti/sdti.c
+++ b/drivers/misc/sti/sdti.c
@@ -270,6 +270,173 @@ fail1:
 	return ret;
 }
 
+#define STI_MODULE_PREFIX	"sti:"
+
+static ssize_t sti_name_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct sti_client	*client = to_sti_client(dev);
+	return sprintf(buf, "%s\n", client->name);
+}
+
+static ssize_t sti_modalias_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct sti_client	*client = to_sti_client(dev);
+	return sprintf(buf, "%s%s\n", STI_MODULE_PREFIX, client->name);
+}
+
+static struct device_attribute sti_dev_attrs[] = {
+	__ATTR(name, S_IRUGO, sti_name_show, NULL),
+	__ATTR(modalias, S_IRUGO, sti_modalias_show, NULL),
+	__ATTR_NULL,
+};
+
+static int sti_dev_match(struct device *dev, struct device_driver *drv)
+{
+	struct sti_client		*client = to_sti_client(dev);
+	struct sti_driver		*driver = to_sti_driver(drv);
+
+	return !strcmp(client->name, driver->driver.name);
+}
+
+static int sti_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct sti_client		*client = to_sti_client(dev);
+
+	dev_dbg(dev, "uevent\n");
+
+	if (add_uevent_var(env, "MODALIAS=%s%s", STI_MODULE_PREFIX,
+				client->name))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int sti_dev_probe(struct device *dev)
+{
+	struct sti_driver		*driver = to_sti_driver(dev->driver);
+	struct sti_client		*client = to_sti_client(dev);
+	int				status;
+
+	dev_dbg(dev, "probe\n");
+
+	if (!driver->probe)
+		return -ENODEV;
+
+	client->driver = driver;
+	if (!device_can_wakeup(&client->dev))
+		device_init_wakeup(&client->dev,
+				client->flags & STI_CLIENT_WAKE);
+
+	status = driver->probe(client);
+	if (status)
+		client->driver = NULL;
+
+	return status;
+}
+
+static int sti_dev_remove(struct device *dev)
+{
+	struct sti_client		*client = to_sti_client(dev);
+	struct sti_driver		*driver;
+	int				status;
+
+	dev_dbg(dev, "remove\n");
+
+	if (!dev->driver)
+		return 0;
+
+	driver = to_sti_driver(dev->driver);
+	if (driver->remove) {
+		status = driver->remove(client);
+	} else {
+		dev->driver = NULL;
+		status = 0;
+	}
+
+	if (status == 0)
+		client->driver = NULL;
+
+	return status;
+}
+
+static void sti_dev_shutdown(struct device *dev)
+{
+	struct sti_driver		*driver;
+
+	dev_dbg(dev, "shutdown\n");
+
+	if (dev->driver)
+		return;
+
+	driver = to_sti_driver(dev->driver);
+	if (driver->shutdown)
+		driver->shutdown(to_sti_client(dev));
+}
+
+static int sti_dev_suspend(struct device *dev, pm_message_t msg)
+{
+	struct sti_driver		*driver;
+
+	if (!dev->driver)
+		return 0;
+
+	driver = to_sti_driver(dev->driver);
+
+	if (!driver->suspend)
+		return 0;
+
+	return driver->suspend(to_sti_client(dev), msg);
+}
+
+static int sti_dev_resume(struct device *dev)
+{
+	struct sti_driver		*driver;
+
+	if (!dev->driver)
+		return 0;
+
+	driver = to_sti_driver(dev->driver);
+
+	if (!driver->resume)
+		return 0;
+
+	return driver->resume(to_sti_client(dev));
+}
+
+struct bus_type sti_bus_type = {
+	.name		= "sti",
+	.dev_attrs	= sti_dev_attrs,
+	.match		= sti_dev_match,
+	.uevent		= sti_dev_uevent,
+	.probe		= sti_dev_probe,
+	.remove		= sti_dev_remove,
+	.shutdown	= sti_dev_shutdown,
+	.suspend	= sti_dev_suspend,
+	.resume		= sti_dev_resume,
+};
+EXPORT_SYMBOL_GPL(sti_bus_type);
+
+int sti_register_driver(struct module *owner, struct sti_driver *driver)
+{
+	int			status;
+
+	driver->driver.owner = owner;
+	driver->driver.bus = &sti_bus_type;
+
+	status = driver_register(&driver->driver);
+	if (status)
+		return status;
+
+	pr_debug("sti: driver [%s] registered\n", driver->driver.name);
+
+	INIT_LIST_HEAD(&driver->clients);
+
+	return 0;
+}
+EXPORT_SYMBOL(sti_register_driver);
+
 static int __devexit omap_sdti_remove(struct platform_device *pdev)
 {
 	struct sti *sti = platform_get_drvdata(pdev);
@@ -294,15 +461,24 @@ static struct platform_driver omap_sdti_driver = {
 
 static int __init omap_sdti_module_init(void)
 {
+	int			status;
+
+	status = bus_register(&sti_bus_type);
+	if (status)
+		return status;
+
 	return platform_driver_register(&omap_sdti_driver);
 }
+subsys_initcall(omap_sdti_module_init);
 
 static void __exit omap_sdti_module_exit(void)
 {
 	platform_driver_unregister(&omap_sdti_driver);
+	bus_unregister(&sti_bus_type);
 }
-subsys_initcall(omap_sdti_module_init);
 module_exit(omap_sdti_module_exit);
 
 MODULE_AUTHOR("Roman Tereshonkov");
+MODULE_AUTHOR("Felipe Balbi");
 MODULE_LICENSE("GPL");
+
-- 
1.6.3.1.244.gf9275

