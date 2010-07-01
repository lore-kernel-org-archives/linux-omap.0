From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC 4/6] omap: introduce common remoteproc module
Date: Fri,  2 Jul 2010 01:23:12 +0300
Message-ID: <1278022994-28476-5-git-send-email-ohad@wizery.com>
References: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39213 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab0GAWXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 18:23:40 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so1212641bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Jul 2010 15:23:39 -0700 (PDT)
In-Reply-To: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohadb@ti.com>

From: Ohad Ben-Cohen <ohadb@ti.com>

The OMAP remote processor module decouples
machine-specific code from TI's IPC
drivers (e.g. dspbridge and syslink).

While dspbridge calls the remoteproc handlers
from the kernel, syslink calls them from
user space. Hence remoteproc supports both
interfaces.

Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/include/plat/remoteproc.h |   75 ++++++
 arch/arm/plat-omap/remoteproc.c              |  316 ++++++++++++++++++++++++++
 2 files changed, 391 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/remoteproc.h
 create mode 100644 arch/arm/plat-omap/remoteproc.c

diff --git a/arch/arm/plat-omap/include/plat/remoteproc.h b/arch/arm/plat-omap/include/plat/remoteproc.h
new file mode 100644
index 0000000..1cedd08
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/remoteproc.h
@@ -0,0 +1,75 @@
+/*
+ * OMAP Remote Processor driver
+ *
+ * Copyright (C) 2010 Texas Instruments Inc.
+ *
+ * Written by Ohad Ben-Cohen <ohad@wizery.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef REMOTEPROC_H
+#define REMOTEPROC_H
+
+#include <linux/ioctl.h>
+#include <linux/cdev.h>
+
+#define RPROC_IOC_MAGIC		'P'
+
+#define RPROC_IOCSTART		_IOW(RPROC_IOC_MAGIC, 1, int)
+#define RPROC_IOCSTOP		_IO(RPROC_IOC_MAGIC, 2)
+#define RPROC_IOCGETSTATE	_IOR(RPROC_IOC_MAGIC, 3, int)
+
+#define RPROC_IOC_MAXNR		(3)
+
+struct omap_rproc;
+
+struct omap_rproc_ops {
+	int (*start)(struct device *dev, u32 start_addr);
+	int (*stop)(struct device *dev);
+	int (*get_state)(struct device *dev);
+};
+
+struct omap_rproc_clk_t {
+	void *clk_handle;
+	const char *dev_id;
+	const char *con_id;
+};
+
+struct omap_rproc_platform_data {
+	struct omap_rproc_ops *ops;
+	char *name;
+	char *oh_name;
+};
+
+struct omap_rproc {
+	struct device *dev;
+	struct cdev cdev;
+	atomic_t count;
+	int minor;
+};
+
+struct omap_rproc_start_args {
+	u32 start_addr;
+};
+
+struct omap_rproc_platform_data *omap3_get_rproc_data(void);
+int omap3_get_rproc_data_size(void);
+struct omap_rproc_platform_data *omap4_get_rproc_data(void);
+int omap4_get_rproc_data_size(void);
+int omap_get_num_of_remoteproc(void);
+
+#endif /* REMOTEPROC_H */
diff --git a/arch/arm/plat-omap/remoteproc.c b/arch/arm/plat-omap/remoteproc.c
new file mode 100644
index 0000000..7a9862e
--- /dev/null
+++ b/arch/arm/plat-omap/remoteproc.c
@@ -0,0 +1,316 @@
+/*
+ * OMAP Remote Processor driver
+ *
+ * Copyright (C) 2010 Texas Instruments Inc.
+ *
+ * Authors:
+ * Ohad Ben-Cohen <ohad@wizery.com>
+ * Hari Kanigeri <h-kanigeri2@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+
+#include <plat/remoteproc.h>
+
+#define OMAP_RPROC_NAME "omap-rproc"
+
+static struct class *omap_rproc_class;
+static dev_t omap_rproc_dev;
+static atomic_t num_of_rprocs;
+
+static inline int rproc_start(struct omap_rproc *rproc, const void __user *arg)
+{
+	struct omap_rproc_platform_data *pdata;
+	struct omap_rproc_start_args start_args;
+
+	if (!rproc->dev)
+		return -EINVAL;
+
+	pdata = rproc->dev->platform_data;
+	if (!pdata->ops)
+		return -EINVAL;
+
+	if (copy_from_user(&start_args, arg, sizeof(start_args)))
+		return -EFAULT;
+
+	return pdata->ops->start(rproc->dev, start_args.start_addr);
+}
+
+static inline int rproc_stop(struct omap_rproc *rproc)
+{
+	struct omap_rproc_platform_data *pdata;
+	if (!rproc->dev)
+		return -EINVAL;
+
+	pdata = rproc->dev->platform_data;
+	if (!pdata->ops)
+		return -EINVAL;
+
+	return pdata->ops->stop(rproc->dev);
+}
+
+static inline int rproc_get_state(struct omap_rproc *rproc)
+{
+	struct omap_rproc_platform_data *pdata;
+	if (!rproc->dev)
+		return -EINVAL;
+
+	pdata = rproc->dev->platform_data;
+	if (!pdata->ops)
+		return -EINVAL;
+
+	return pdata->ops->get_state(rproc->dev);
+}
+
+static int omap_rproc_open(struct inode *inode, struct file *filp)
+{
+	unsigned int count, dev_num = iminor(inode);
+	struct omap_rproc *rproc;
+	struct omap_rproc_platform_data *pdata;
+
+	rproc = container_of(inode->i_cdev, struct omap_rproc, cdev);
+	if (!rproc->dev)
+		return -EINVAL;
+
+	pdata = rproc->dev->platform_data;
+
+	count = atomic_inc_return(&rproc->count);
+	dev_info(rproc->dev, "%s: dev num %d, name %s, count %d\n", __func__,
+							dev_num,
+							pdata->name,
+							count);
+	if (count > 1) {
+		dev_err(rproc->dev, "%s failed: remoteproc already in use\n",
+								__func__);
+		atomic_dec(&rproc->count);
+		return -EBUSY;
+	}
+
+	filp->private_data = rproc;
+
+	return 0;
+}
+
+static int omap_rproc_release(struct inode *inode, struct file *filp)
+{
+	struct omap_rproc_platform_data *pdata;
+	struct omap_rproc *rproc = filp->private_data;
+	if (!rproc || !rproc->dev)
+		return -EINVAL;
+
+	pdata = rproc->dev->platform_data;
+
+	atomic_dec(&rproc->count);
+
+	return 0;
+}
+
+static int omap_rproc_ioctl(struct inode *inode, struct file *filp,
+					unsigned int cmd, unsigned long arg)
+{
+	int rc = 0;
+	struct omap_rproc *rproc = filp->private_data;
+
+	dev_info(rproc->dev, "%s\n", __func__);
+
+	if (!rproc)
+		return -EINVAL;
+
+	if (_IOC_TYPE(cmd) != RPROC_IOC_MAGIC)
+		return -ENOTTY;
+	if (_IOC_NR(cmd) > RPROC_IOC_MAXNR)
+		return -ENOTTY;
+
+	switch (cmd) {
+	case RPROC_IOCSTART:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		rc = rproc_start(rproc, (const void __user *) arg);
+		break;
+	case RPROC_IOCSTOP:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		rc = rproc_stop(rproc);
+		break;
+	case RPROC_IOCGETSTATE:
+		rc = rproc_get_state(rproc);
+		break;
+
+	default:
+		return -ENOTTY;
+	}
+
+	return rc;
+}
+
+static const struct file_operations omap_rproc_fops = {
+	.open		=	omap_rproc_open,
+	.release	=	omap_rproc_release,
+	.ioctl		=	omap_rproc_ioctl,
+	.owner		=	THIS_MODULE,
+};
+
+static int omap_rproc_probe(struct platform_device *pdev)
+{
+	int ret = 0, major, minor;
+	struct device *tmpdev;
+	struct device *dev = &pdev->dev;
+	struct omap_rproc_platform_data *pdata = dev->platform_data;
+	struct omap_rproc *rproc;
+
+	if (!pdata || !pdata->name || !pdata->oh_name || !pdata->ops)
+		return -EINVAL;
+
+	dev_info(dev, "%s: adding rproc %s\n", __func__, pdata->name);
+
+	rproc = kzalloc(sizeof(struct omap_rproc), GFP_KERNEL);
+	if (!rproc) {
+		dev_err(dev, "%s: kzalloc failed\n", __func__);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	platform_set_drvdata(pdev, rproc);
+	major = MAJOR(omap_rproc_dev);
+	minor = atomic_read(&num_of_rprocs);
+	atomic_inc(&num_of_rprocs);
+
+	rproc->dev = dev;
+	rproc->minor = minor;
+	atomic_set(&rproc->count, 0);
+	cdev_init(&rproc->cdev, &omap_rproc_fops);
+	rproc->cdev.owner = THIS_MODULE;
+	ret = cdev_add(&rproc->cdev, MKDEV(major, minor), 1);
+	if (ret) {
+		dev_err(dev, "%s: cdev_add failed: %d\n", __func__, ret);
+		goto free_rproc;
+	}
+
+	tmpdev = device_create(omap_rproc_class, NULL,
+				MKDEV(major, minor),
+				NULL,
+				OMAP_RPROC_NAME "%d", minor);
+	if (IS_ERR(tmpdev)) {
+		ret = PTR_ERR(tmpdev);
+		dev_err(dev, "%s: device_create failed: %d\n", __func__, ret);
+		goto clean_cdev;
+	}
+
+	dev_info(dev, "%s initialized %s, major: %d, base-minor: %d\n",
+			OMAP_RPROC_NAME,
+			pdata->name,
+			MAJOR(omap_rproc_dev),
+			minor);
+	return 0;
+
+clean_cdev:
+	cdev_del(&rproc->cdev);
+free_rproc:
+	kfree(rproc);
+out:
+	return ret;
+}
+
+static int __devexit omap_rproc_remove(struct platform_device *pdev)
+{
+	int major = MAJOR(omap_rproc_dev);
+	struct device *dev = &pdev->dev;
+	struct omap_rproc_platform_data *pdata = dev->platform_data;
+	struct omap_rproc *rproc = platform_get_drvdata(pdev);
+
+	if (!pdata || !rproc)
+		return -EINVAL;
+
+	dev_info(dev, "%s removing %s, major: %d, base-minor: %d\n",
+			OMAP_RPROC_NAME,
+			pdata->name,
+			major,
+			rproc->minor);
+
+	device_destroy(omap_rproc_class, MKDEV(major, rproc->minor));
+	cdev_del(&rproc->cdev);
+
+	return 0;
+}
+
+static struct platform_driver omap_rproc_driver = {
+	.probe = omap_rproc_probe,
+	.remove = __devexit_p(omap_rproc_remove),
+	.driver = {
+		.name = OMAP_RPROC_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init omap_rproc_init(void)
+{
+	int num = omap_get_num_of_remoteproc();
+	int ret;
+
+	ret = alloc_chrdev_region(&omap_rproc_dev, 0, num, OMAP_RPROC_NAME);
+	if (ret) {
+		pr_err("%s: alloc_chrdev_region failed: %d\n", __func__, ret);
+		goto out;
+	}
+
+	omap_rproc_class = class_create(THIS_MODULE, OMAP_RPROC_NAME);
+	if (IS_ERR(omap_rproc_class)) {
+		ret = PTR_ERR(omap_rproc_class);
+		pr_err("%s: class_create failed: %d\n", __func__, ret);
+		goto unreg_region;
+	}
+
+	atomic_set(&num_of_rprocs, 0);
+
+	ret = platform_driver_register(&omap_rproc_driver);
+	if (ret) {
+		pr_err("%s: platform_driver_register failed: %d\n", __func__,
+									ret);
+		goto out;
+	}
+
+	return 0;
+
+unreg_region:
+	unregister_chrdev_region(omap_rproc_dev, num);
+out:
+	return ret;
+}
+module_init(omap_rproc_init);
+
+static void __exit omap_rproc_exit(void)
+{
+	int num = omap_get_num_of_remoteproc();
+
+	class_destroy(omap_rproc_class);
+	unregister_chrdev_region(omap_rproc_dev, num);
+}
+module_exit(omap_rproc_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("OMAP Remote Processor driver");
+MODULE_AUTHOR("Ohad Ben-Cohen <ohad@wizery.com>");
+MODULE_AUTHOR("Hari Kanigeri <h-kanigeri2@ti.com>");
-- 
1.7.0.4

