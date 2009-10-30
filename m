From: Sebastien Jan <s-jan@ti.com>
Subject: [RFC PATCH 6/9] HSI: character driver interface
Date: Fri, 30 Oct 2009 11:00:05 +0100
Message-ID: <1256896808-20152-7-git-send-email-s-jan@ti.com>
References: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45882 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773AbZJ3J7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 05:59:06 -0400
In-Reply-To: <1256896808-20152-1-git-send-email-s-jan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sebastien Jan <s-jan@ti.com>, Andras Domokos <andras.domokos@nokia.com>

Character driver header and interface implementation
Integration in the build and configuration

Signed-off-by: Sebastien Jan <s-jan@ti.com>
Signed-off-by: Andras Domokos <andras.domokos@nokia.com>
---
 drivers/Kconfig          |    2 +
 drivers/hsi/Kconfig      |   14 ++
 drivers/hsi/Makefile     |    3 +
 drivers/hsi/hsi-char.c   |  526 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hsi/hsi-char.h   |   31 +++
 include/linux/hsi_char.h |   71 +++++++
 6 files changed, 647 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hsi/hsi-char.c
 create mode 100644 drivers/hsi/hsi-char.h
 create mode 100644 include/linux/hsi_char.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 48bbdbe..8fc1c36 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -52,6 +52,8 @@ source "drivers/i2c/Kconfig"
 
 source "drivers/spi/Kconfig"
 
+source "drivers/hsi/Kconfig"
+
 source "drivers/pps/Kconfig"
 
 source "drivers/gpio/Kconfig"
diff --git a/drivers/hsi/Kconfig b/drivers/hsi/Kconfig
index e10b522..79e0e02 100644
--- a/drivers/hsi/Kconfig
+++ b/drivers/hsi/Kconfig
@@ -42,3 +42,17 @@ config OMAP_SSI_DEVICE
 	bool "SSI (OMAP SSI)"
 
 endchoice
+
+#
+# OMAP HSI char device kernel configuration
+#
+
+config HSI_CHAR
+	tristate "HSI character driver"
+	depends on OMAP_HSI
+	---help---
+	  If you say Y here, you will enable the HSI character driver.
+	  This driver provides a simple character device interface for
+	  serial communication over the HSI bus.
+
+endif # HSI
diff --git a/drivers/hsi/Makefile b/drivers/hsi/Makefile
index a7f579b..81270ec 100644
--- a/drivers/hsi/Makefile
+++ b/drivers/hsi/Makefile
@@ -11,4 +11,7 @@ ifeq ($(CONFIG_DEBUG_FS), y)
 	omap_hsi-objs += hsi_driver_debugfs.o
 endif
 
+hsi_char-objs	:=	hsi-char.o hsi-if.o
+
 obj-$(CONFIG_OMAP_HSI)	+= omap_hsi.o
+obj-$(CONFIG_HSI_CHAR)	+= hsi_char.o
diff --git a/drivers/hsi/hsi-char.c b/drivers/hsi/hsi-char.c
new file mode 100644
index 0000000..29fbd73
--- /dev/null
+++ b/drivers/hsi/hsi-char.c
@@ -0,0 +1,526 @@
+/*
+ * hsi-char.c
+ *
+ * HSI character device driver, implements the character device
+ * interface.
+ *
+ * Copyright (C) 2009 Nokia Corporation. All rights reserved.
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author: Andras Domokos <andras.domokos@nokia.com>
+ * Author: Sebastien JAN <s-jan@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/miscdevice.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/poll.h>
+#include <asm/mach-types.h>
+#include <linux/ioctl.h>
+#include <linux/uaccess.h>
+
+#include <mach/hsi.h>
+#include <linux/hsi_driver_if.h>
+#include <linux/hsi_char.h>
+
+#include "hsi-char.h"
+
+#define DRIVER_VERSION  "0.1.0"
+
+static unsigned int port = 1;
+module_param(port, uint, 1);
+MODULE_PARM_DESC(port, "HSI port to be probed");
+
+static unsigned int channels_map[HSI_MAX_CHAR_DEVS] = {1};
+module_param_array(channels_map, uint, NULL, 0);
+MODULE_PARM_DESC(channels_map, "HSI channels to be probed");
+
+dev_t hsi_char_dev;
+
+struct char_queue {
+	struct list_head list;
+	u32 *data;
+	unsigned int count;
+};
+
+struct hsi_char {
+	unsigned int opened;
+	int poll_event;
+	struct list_head rx_queue;
+	struct list_head tx_queue;
+	spinlock_t lock; /* Serialize access to driver data and API */
+	struct fasync_struct *async_queue;
+	wait_queue_head_t rx_wait;
+	wait_queue_head_t tx_wait;
+	wait_queue_head_t poll_wait;
+};
+
+static struct hsi_char hsi_char_data[HSI_MAX_CHAR_DEVS];
+
+void if_notify(int ch, struct hsi_event *ev)
+{
+	struct char_queue *entry;
+
+	pr_debug("%s, ev = {0x%x, 0x%p, %u}\n", __func__, ev->event, ev->data,
+								ev->count);
+
+	spin_lock(&hsi_char_data[ch].lock);
+
+	if (!hsi_char_data[ch].opened) {
+		pr_debug("%s, device not opened\n!", __func__);
+		spin_unlock(&hsi_char_data[ch].lock);
+		return;
+	}
+
+	switch (HSI_EV_TYPE(ev->event)) {
+	case HSI_EV_IN:
+		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+		if (!entry) {
+			pr_err("HSI-CHAR: entry allocation failed.\n");
+			spin_unlock(&hsi_char_data[ch].lock);
+			return;
+		}
+		entry->data = ev->data;
+		entry->count = ev->count;
+		list_add_tail(&entry->list, &hsi_char_data[ch].rx_queue);
+		spin_unlock(&hsi_char_data[ch].lock);
+		pr_debug("%s, HSI_EV_IN\n", __func__);
+		wake_up_interruptible(&hsi_char_data[ch].rx_wait);
+		break;
+	case HSI_EV_OUT:
+		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+		if (!entry) {
+			pr_err("HSI-CHAR: entry allocation failed.\n");
+			spin_unlock(&hsi_char_data[ch].lock);
+			return;
+		}
+		entry->data = ev->data;
+		entry->count = ev->count;
+		hsi_char_data[ch].poll_event |= (POLLOUT | POLLWRNORM);
+		list_add_tail(&entry->list, &hsi_char_data[ch].tx_queue);
+		spin_unlock(&hsi_char_data[ch].lock);
+		pr_debug("%s, HSI_EV_OUT\n", __func__);
+		wake_up_interruptible(&hsi_char_data[ch].tx_wait);
+		break;
+	case HSI_EV_EXCEP:
+		hsi_char_data[ch].poll_event |= POLLPRI;
+		spin_unlock(&hsi_char_data[ch].lock);
+		pr_debug("%s, HSI_EV_EXCEP\n", __func__);
+		wake_up_interruptible(&hsi_char_data[ch].poll_wait);
+		break;
+	case HSI_EV_AVAIL:
+		hsi_char_data[ch].poll_event |= (POLLIN | POLLRDNORM);
+		spin_unlock(&hsi_char_data[ch].lock);
+		pr_debug("%s, HSI_EV_AVAIL\n", __func__);
+		wake_up_interruptible(&hsi_char_data[ch].poll_wait);
+		break;
+	default:
+		spin_unlock(&hsi_char_data[ch].lock);
+		break;
+	}
+}
+
+
+static int hsi_char_fasync(int fd, struct file *file, int on)
+{
+	int ch = (int)file->private_data;
+	if (fasync_helper(fd, file, on, &hsi_char_data[ch].async_queue) >= 0)
+		return 0;
+	else
+		return -EIO;
+}
+
+
+static unsigned int hsi_char_poll(struct file *file, poll_table *wait)
+{
+	int ch = (int)file->private_data;
+	unsigned int ret = 0;
+
+	/*printk(KERN_DEBUG "%s\n", __func__);*/
+
+	poll_wait(file, &hsi_char_data[ch].poll_wait, wait);
+	poll_wait(file, &hsi_char_data[ch].tx_wait, wait);
+	spin_lock_bh(&hsi_char_data[ch].lock);
+	ret = hsi_char_data[ch].poll_event;
+	spin_unlock_bh(&hsi_char_data[ch].lock);
+
+	pr_debug("%s, ret = 0x%x\n", __func__, ret);
+	return ret;
+}
+
+
+static ssize_t hsi_char_read(struct file *file, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	int ch = (int)file->private_data;
+	DECLARE_WAITQUEUE(wait, current);
+	u32	*data;
+	unsigned int data_len;
+	struct char_queue *entry;
+	ssize_t ret;
+
+	/*printk(KERN_DEBUG "%s, count = %d\n", __func__, count);*/
+
+	/* only 32bit data is supported for now */
+	if ((count < 4) || (count & 3))
+		return -EINVAL;
+
+	data = kmalloc(count, GFP_ATOMIC);
+
+	ret = if_hsi_read(ch, data, count);
+	if (ret < 0) {
+		kfree(data);
+		goto out2;
+	}
+
+	add_wait_queue(&hsi_char_data[ch].rx_wait, &wait);
+
+	for ( ; ; ) {
+		data = NULL;
+		data_len = 0;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_bh(&hsi_char_data[ch].lock);
+		if (!list_empty(&hsi_char_data[ch].rx_queue)) {
+			entry = list_entry(hsi_char_data[ch].rx_queue.next,
+						struct char_queue, list);
+			data = entry->data;
+			data_len = entry->count;
+			list_del(&entry->list);
+			kfree(entry);
+		}
+		spin_unlock_bh(&hsi_char_data[ch].lock);
+
+		pr_debug("%s, data = 0x%p, data_len = %d\n",
+						__func__, data, data_len);
+
+		if (data_len) {
+			pr_debug("%s, RX finished\n", __func__);
+			spin_lock_bh(&hsi_char_data[ch].lock);
+			hsi_char_data[ch].poll_event &= ~(POLLIN | POLLRDNORM);
+			if_hsi_poll(ch);
+			spin_unlock_bh(&hsi_char_data[ch].lock);
+			break;
+		} else if (file->f_flags & O_NONBLOCK) {
+			pr_debug("%s, O_NONBLOCK\n", __func__);
+			ret = -EAGAIN;
+			goto out;
+		} else if (signal_pending(current)) {
+			pr_debug("%s, ERESTARTSYS\n", __func__);
+			ret = -EAGAIN;
+			if_hsi_cancel_read(ch);
+			/* goto out; */
+		break;
+	}
+
+	/*printk(KERN_DEBUG "%s, going to sleep...\n", __func__);*/
+		schedule();
+	/*printk(KERN_DEBUG "%s, woke up\n", __func__);*/
+	}
+
+	if (data_len) {
+		ret = copy_to_user((void __user *)buf, data, data_len);
+		if (!ret)
+			ret = data_len;
+	}
+
+	kfree(data);
+
+out:
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&hsi_char_data[ch].rx_wait, &wait);
+
+out2:
+	/*printk(KERN_DEBUG "%s, ret = %d\n", __func__, ret);*/
+	return ret;
+}
+
+static ssize_t hsi_char_write(struct file *file, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	int ch = (int)file->private_data;
+	DECLARE_WAITQUEUE(wait, current);
+	u32	*data;
+	unsigned int data_len = 0;
+	struct char_queue *entry;
+	ssize_t	ret;
+
+	/*printk(KERN_DEBUG "%s, count = %d\n", __func__, count);*/
+
+	/* only 32bit data is supported for now */
+	if ((count < 4) || (count & 3))
+		return -EINVAL;
+
+	data = kmalloc(count, GFP_ATOMIC);
+
+	if (copy_from_user(data, (void __user *)buf, count)) {
+		ret = -EFAULT;
+		kfree(data);
+	} else {
+		ret = count;
+	}
+
+	spin_lock_bh(&hsi_char_data[ch].lock);
+	ret = if_hsi_write(ch, data, count);
+	if (ret < 0) {
+		spin_unlock_bh(&hsi_char_data[ch].lock);
+		kfree(data);
+		goto out2;
+	}
+	hsi_char_data[ch].poll_event &= ~(POLLOUT | POLLWRNORM);
+	spin_unlock_bh(&hsi_char_data[ch].lock);
+
+	add_wait_queue(&hsi_char_data[ch].tx_wait, &wait);
+
+	for ( ; ; ) {
+		data = NULL;
+		data_len = 0;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_bh(&hsi_char_data[ch].lock);
+		if (!list_empty(&hsi_char_data[ch].tx_queue)) {
+			entry = list_entry(hsi_char_data[ch].tx_queue.next,
+					struct char_queue, list);
+			data = entry->data;
+			data_len = entry->count;
+			list_del(&entry->list);
+			kfree(entry);
+		}
+		spin_unlock_bh(&hsi_char_data[ch].lock);
+
+		if (data_len) {
+			pr_debug("%s, TX finished\n", __func__);
+			ret = data_len;
+			break;
+		} else if (file->f_flags & O_NONBLOCK) {
+			pr_debug("%s, O_NONBLOCK\n", __func__);
+			ret = -EAGAIN;
+			goto out;
+		} else if (signal_pending(current)) {
+			pr_debug("%s, ERESTARTSYS\n", __func__);
+			ret = -ERESTARTSYS;
+			goto out;
+		}
+
+		/*printk(KERN_DEBUG "%s, going to sleep...\n", __func__);*/
+		schedule();
+		/*printk(KERN_DEBUG "%s, woke up\n", __func__);*/
+	}
+
+    kfree(data);
+
+out:
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&hsi_char_data[ch].tx_wait, &wait);
+
+out2:
+	/*printk(KERN_DEBUG "%s, ret = %d\n", __func__, ret);*/
+	return ret;
+}
+
+static int hsi_char_ioctl(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	int ch = (int)file->private_data;
+	unsigned int state;
+	struct hsi_rx_config rx_cfg;
+	struct hsi_tx_config tx_cfg;
+	int ret = 0;
+
+	pr_debug("%s, ch = %d, cmd = 0x%08x\n", __func__, ch, cmd);
+
+	switch (cmd) {
+	case CS_SEND_BREAK:
+		if_hsi_send_break(ch);
+		break;
+	case CS_FLUSH_RX:
+		if_hsi_flush_rx(ch);
+		break;
+	case CS_FLUSH_TX:
+		if_hsi_flush_tx(ch);
+		break;
+	case CS_SET_WAKELINE:
+		if (copy_from_user(&state, (void __user *)arg,
+				sizeof(state)))
+			ret = -EFAULT;
+		else
+			if_hsi_set_wakeline(ch, state);
+		break;
+	case CS_GET_WAKELINE:
+		if_hsi_get_wakeline(ch, &state);
+		if (copy_to_user((void __user *)arg, &state, sizeof(state)))
+			ret = -EFAULT;
+		break;
+	case CS_SET_RX:
+		if (copy_from_user(&rx_cfg, (void __user *)arg,
+				sizeof(rx_cfg)))
+			ret = -EFAULT;
+		else
+			ret = if_hsi_set_rx(ch, &rx_cfg);
+		break;
+	case CS_GET_RX:
+		if_hsi_get_rx(ch, &rx_cfg);
+		if (copy_to_user((void __user *)arg, &rx_cfg, sizeof(rx_cfg)))
+			ret = -EFAULT;
+		break;
+	case CS_SET_TX:
+		if (copy_from_user(&tx_cfg, (void __user *)arg,
+				sizeof(tx_cfg)))
+			ret = -EFAULT;
+		else
+			ret = if_hsi_set_tx(ch, &tx_cfg);
+		break;
+	case CS_GET_TX:
+		if_hsi_get_tx(ch, &tx_cfg);
+		if (copy_to_user((void __user *)arg, &tx_cfg, sizeof(tx_cfg)))
+			ret = -EFAULT;
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	return ret;
+}
+
+static int hsi_char_open(struct inode *inode, struct file *file)
+{
+	int ret = 0, ch = iminor(inode);
+
+	pr_debug("%s, ch = %d, channels_map[%d] = %d\n", __func__, ch, ch,
+							channels_map[ch]);
+
+	if (!channels_map[ch])
+		return -ENODEV;
+
+	spin_lock_bh(&hsi_char_data[ch].lock);
+
+	if (hsi_char_data[ch].opened) {
+		spin_unlock_bh(&hsi_char_data[ch].lock);
+		return -EBUSY;
+	}
+
+	file->private_data = (void *)ch;
+	hsi_char_data[ch].opened++;
+	hsi_char_data[ch].poll_event = (POLLOUT | POLLWRNORM);
+	spin_unlock_bh(&hsi_char_data[ch].lock);
+
+	ret = if_hsi_start(ch);
+
+	return ret;
+}
+
+static int hsi_char_release(struct inode *inode, struct file *file)
+{
+	int ch = (int)file->private_data;
+	struct char_queue	*entry;
+	struct list_head	*cursor, *next;
+
+	pr_debug("%s, ch = %d\n", __func__, ch);
+
+	if_hsi_stop(ch);
+	spin_lock_bh(&hsi_char_data[ch].lock);
+	hsi_char_data[ch].opened--;
+
+	if (!list_empty(&hsi_char_data[ch].rx_queue)) {
+		list_for_each_safe(cursor, next, &hsi_char_data[ch].rx_queue) {
+			entry = list_entry(cursor, struct char_queue, list);
+			list_del(&entry->list);
+			kfree(entry);
+		}
+	}
+
+	if (!list_empty(&hsi_char_data[ch].tx_queue)) {
+		list_for_each_safe(cursor, next, &hsi_char_data[ch].tx_queue) {
+			entry = list_entry(cursor, struct char_queue, list);
+			list_del(&entry->list);
+			kfree(entry);
+		}
+	}
+
+	spin_unlock_bh(&hsi_char_data[ch].lock);
+
+	return 0;
+}
+
+static const struct file_operations hsi_char_fops = {
+	.owner = THIS_MODULE,
+	.read = hsi_char_read,
+	.write = hsi_char_write,
+	.poll = hsi_char_poll,
+	.ioctl = hsi_char_ioctl,
+	.open = hsi_char_open,
+	.release = hsi_char_release,
+	.fasync = hsi_char_fasync,
+};
+
+static struct cdev hsi_char_cdev;
+
+static int __init hsi_char_init(void)
+{
+	char devname[] = "hsi_char";
+	int ret, i;
+
+	pr_info("HSI character device version " DRIVER_VERSION "\n");
+
+	for (i = 0; i < HSI_MAX_CHAR_DEVS; i++) {
+		init_waitqueue_head(&hsi_char_data[i].rx_wait);
+		init_waitqueue_head(&hsi_char_data[i].tx_wait);
+		init_waitqueue_head(&hsi_char_data[i].poll_wait);
+		spin_lock_init(&hsi_char_data[i].lock);
+		hsi_char_data[i].opened = 0;
+		INIT_LIST_HEAD(&hsi_char_data[i].rx_queue);
+		INIT_LIST_HEAD(&hsi_char_data[i].tx_queue);
+	}
+
+	/*printk(KERN_DEBUG "%s, devname = %s\n", __func__, devname);*/
+
+	ret = if_hsi_init(port, channels_map);
+	if (ret)
+		return ret;
+
+	ret = alloc_chrdev_region(&hsi_char_dev, 0, HSI_MAX_CHAR_DEVS, devname);
+	if (ret < 0) {
+		pr_err("HSI character driver: Failed to register\n");
+		return ret;
+	}
+
+	cdev_init(&hsi_char_cdev, &hsi_char_fops);
+	cdev_add(&hsi_char_cdev, hsi_char_dev, HSI_MAX_CHAR_DEVS);
+
+	return 0;
+}
+
+static void __exit hsi_char_exit(void)
+{
+	cdev_del(&hsi_char_cdev);
+	unregister_chrdev_region(hsi_char_dev, HSI_MAX_CHAR_DEVS);
+	if_hsi_exit();
+}
+
+MODULE_AUTHOR("Andras Domokos <andras.domokos@nokia.com>");
+MODULE_AUTHOR("Sebatien Jan <s-jan@ti.com> / Texas Instruments");
+MODULE_DESCRIPTION("HSI character device");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRIVER_VERSION);
+
+module_init(hsi_char_init);
+module_exit(hsi_char_exit);
diff --git a/drivers/hsi/hsi-char.h b/drivers/hsi/hsi-char.h
new file mode 100644
index 0000000..d37018f
--- /dev/null
+++ b/drivers/hsi/hsi-char.h
@@ -0,0 +1,31 @@
+/*
+ * hsi-char.h
+ *
+ * HSI character driver private declaration header file.
+ *
+ * Copyright (C) 2009 Nokia Corporation. All rights reserved.
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author: Andras Domokos <andras.domokos@nokia.com>
+ * Author: Sebastien JAN <s-jan@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef _HSI_CHAR_H
+#define _HSI_CHAR_H
+
+#include "hsi-if.h"
+
+/* how many char devices would be created at most */
+#define HSI_MAX_CHAR_DEVS	8
+
+void if_notify(int ch, struct hsi_event *ev);
+
+#endif /* _HSI_CHAR_H */
diff --git a/include/linux/hsi_char.h b/include/linux/hsi_char.h
new file mode 100644
index 0000000..de42c6c
--- /dev/null
+++ b/include/linux/hsi_char.h
@@ -0,0 +1,71 @@
+/*
+ * hsi_char.h
+ *
+ * HSI character driver public declaration header file.
+ *
+ * Copyright (C) 2009 Nokia Corporation. All rights reserved.
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author: Andras Domokos <andras.domokos@nokia.com>
+ * Author: Sebastien JAN <s-jan@ti.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef HSI_CHAR_H
+#define HSI_CHAR_H
+
+#define HSI_CHAR_BASE		'S'
+#define CS_IOW(num, dtype)	_IOW(HSI_CHAR_BASE, num, dtype)
+#define CS_IOR(num, dtype)	_IOR(HSI_CHAR_BASE, num, dtype)
+#define CS_IOWR(num, dtype)	_IOWR(HSI_CHAR_BASE, num, dtype)
+#define CS_IO(num)		_IO(HSI_CHAR_BASE, num)
+
+#define CS_SEND_BREAK		CS_IO(1)
+#define CS_FLUSH_RX		CS_IO(2)
+#define CS_FLUSH_TX		CS_IO(3)
+#define CS_BOOTSTRAP		CS_IO(4)
+#define CS_SET_WAKELINE		CS_IOW(5, unsigned int)
+#define CS_GET_WAKELINE		CS_IOR(6, unsigned int)
+#define CS_SET_RX		CS_IOW(7, struct hsi_rx_config)
+#define CS_GET_RX		CS_IOW(8, struct hsi_rx_config)
+#define CS_SET_TX		CS_IOW(9, struct hsi_tx_config)
+#define CS_GET_TX		CS_IOW(10, struct hsi_tx_config)
+
+#define HSI_MODE_SLEEP		0
+#define HSI_MODE_STREAM		1
+#define HSI_MODE_FRAME		2
+
+#define HSI_FLOW_SYNCHRONIZED	(0 << 2)
+#define HSI_FLOW_PIPELINED	(1 << 2)	/* only for HSI */
+
+#define HSI_ARBMODE_RR		0
+#define HSI_ARBMODE_PRIO	1
+
+#define WAKE_UP			0
+#define WAKE_DOWN		1
+
+struct hsi_tx_config {
+	u32 mode;
+	u32 flow;
+	u32 frame_size;
+	u32 channels;
+	u32 divisor;
+	u32 arb_mode;
+};
+
+struct hsi_rx_config {
+	u32 mode;
+	u32 flow;
+	u32 frame_size;
+	u32 channels;
+	u32 divisor;	/* not used for SSI */
+};
+
+#endif /* HSI_CHAR_H */
-- 
1.6.0.4

