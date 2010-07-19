From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 3/5] omap:hwspinlock-added hwspinlock driver
Date: Mon, 19 Jul 2010 11:50:19 -0500
Message-ID: <1279558221-14954-4-git-send-email-h-kanigeri2@ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52142 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936440Ab0GSQjd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 12:39:33 -0400
In-Reply-To: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Cousson Benoit <b-cousson@ti.com>, Simon Que <sque@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

From: Simon Que <sque@ti.com>

Created driver for OMAP hardware spinlock.  This driver supports:
- Reserved spinlocks for internal use
- Dynamic allocation of unreserved locks
- Lock, unlock, and trylock functions, with or without disabling irqs/preempt
- Registered as a platform device driver

The device initialization uses hwmod to configure the devices.
One device will be created for each IP.  It will pass spinlock register offset
info to the driver.  The device initialization file is:
		arch/arm/mach-omap2/hwspinlocks.c

The driver takes in register offset info passed in device initialization.
It uses hwmod to obtain the base address of the hardware spinlock module.
Then it reads info from the registers.  The function hwspinlock_probe()
initializes the array of spinlock structures, each containing a spinlock
register address calculated from the base address and lock offsets.
The device driver file is:
		arch/arm/plat-omap/hwspinlock.c

Here's an API summary:
int hwspinlock_lock(struct hwspinlock *);
	Attempt to lock a hardware spinlock.  If it is busy, the function will
	keep trying until it succeeds.  This is a blocking function.
int hwspinlock_trylock(struct hwspinlock *);
	Attempt to lock a hardware spinlock.  If it is busy, the function will
	return BUSY.  If it succeeds in locking, the function will return
	ACQUIRED.  This is a non-blocking function.
int hwspinlock_unlock(struct hwspinlock *);
	Unlock a hardware spinlock.

struct hwspinlock *hwspinlock_request(void);
	Provides for "dynamic allocation" of a hardware spinlock.  It returns
	the handle to the next available (unallocated) spinlock.  If no more
	locks are available, it returns NULL.
struct hwspinlock *hwspinlock_request_specific(unsigned int);
	Provides for "static allocation" of a specific hardware spinlock. This
	allows the system to use a specific spinlock, identified by an ID. If
	the ID is invalid or if the desired lock is already allocated, this
	will return NULL.  Otherwise it returns a spinlock handle.
int hwspinlock_free(struct hwspinlock *);
	Frees an allocated hardware spinlock (either reserved or unreserved).

Signed-off-by: Simon Que <sque@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/hwspinlocks.c            |   70 ++++++
 arch/arm/plat-omap/hwspinlock.c              |  335 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/hwspinlock.h |   29 +++
 3 files changed, 434 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hwspinlocks.c
 create mode 100644 arch/arm/plat-omap/hwspinlock.c
 create mode 100644 arch/arm/plat-omap/include/plat/hwspinlock.h

diff --git a/arch/arm/mach-omap2/hwspinlocks.c b/arch/arm/mach-omap2/hwspinlocks.c
new file mode 100644
index 0000000..f0f05e1
--- /dev/null
+++ b/arch/arm/mach-omap2/hwspinlocks.c
@@ -0,0 +1,70 @@
+/*
+ * OMAP hardware spinlock device initialization
+ *
+ * Copyright (C) 2010 Texas Instruments. All rights reserved.
+ *
+ * Contact: Simon Que <sque@ti.com>
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
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include <plat/hwspinlock.h>
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
+
+/* Spinlock register offsets */
+#define REVISION_OFFSET			0x0000
+#define SYSCONFIG_OFFSET		0x0010
+#define SYSSTATUS_OFFSET		0x0014
+#define LOCK_BASE_OFFSET		0x0800
+#define LOCK_OFFSET(i)			(LOCK_BASE_OFFSET + 0x4 * (i))
+
+/* Initialization function */
+int __init hwspinlocks_init(void)
+{
+	int retval = 0;
+
+	struct hwspinlock_plat_info *pdata;
+	struct omap_hwmod *oh;
+	char *oh_name, *pdev_name;
+
+	oh_name = "spinlock";
+	oh = omap_hwmod_lookup(oh_name);
+	if (WARN_ON(oh == NULL))
+		return -EINVAL;
+
+	pdev_name = "hwspinlock";
+
+	/* Pass data to device initialization */
+	pdata = kzalloc(sizeof(struct hwspinlock_plat_info), GFP_KERNEL);
+	if (WARN_ON(pdata == NULL))
+		return -ENOMEM;
+	pdata->sysstatus_offset = SYSSTATUS_OFFSET;
+	pdata->lock_base_offset = LOCK_BASE_OFFSET;
+
+	omap_device_build(pdev_name, 0, oh, pdata,
+			sizeof(struct hwspinlock_plat_info), NULL, 0, false);
+
+	return retval;
+}
+module_init(hwspinlocks_init);
diff --git a/arch/arm/plat-omap/hwspinlock.c b/arch/arm/plat-omap/hwspinlock.c
new file mode 100644
index 0000000..1883add
--- /dev/null
+++ b/arch/arm/plat-omap/hwspinlock.c
@@ -0,0 +1,335 @@
+/*
+ * OMAP hardware spinlock driver
+ *
+ * Copyright (C) 2010 Texas Instruments. All rights reserved.
+ *
+ * Contact: Simon Que <sque@ti.com>
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
+ * This driver supports:
+ * - Reserved spinlocks for internal use
+ * - Dynamic allocation of unreserved locks
+ * - Lock, unlock, and trylock functions, with or without disabling irqs/preempt
+ * - Registered as a platform device driver
+ *
+ * The device initialization uses hwmod to configure the devices.  One device
+ * will be created for each IP.  It will pass spinlock register offset info to
+ * the driver.  The device initialization file is:
+ *          arch/arm/mach-omap2/hwspinlocks.c
+ *
+ * The driver takes in register offset info passed in device initialization.
+ * It uses hwmod to obtain the base address of the hardware spinlock module.
+ * Then it reads info from the registers.  The function hwspinlock_probe()
+ * initializes the array of spinlock structures, each containing a spinlock
+ * register address calculated from the base address and lock offsets.
+ *
+ * Here's an API summary:
+ *
+ * int hwspinlock_lock(struct hwspinlock *);
+ *      Attempt to lock a hardware spinlock.  If it is busy, the function will
+ *      keep trying until it succeeds.  This is a blocking function.
+ * int hwspinlock_trylock(struct hwspinlock *);
+ *      Attempt to lock a hardware spinlock.  If it is busy, the function will
+ *      return BUSY.  If it succeeds in locking, the function will return
+ *      ACQUIRED.  This is a non-blocking function
+ * int hwspinlock_unlock(struct hwspinlock *);
+ *      Unlock a hardware spinlock.
+ *
+ * struct hwspinlock *hwspinlock_request(void);
+ *      Provides for "dynamic allocation" of a hardware spinlock.  It returns
+ *      the handle to the next available (unallocated) spinlock.  If no more
+ *      locks are available, it returns NULL.
+ * struct hwspinlock *hwspinlock_request_specific(unsigned int);
+ *      Provides for "static allocation" of a specific hardware spinlock. This
+ *      allows the system to use a specific spinlock, identified by an ID. If
+ *      the ID is invalid or if the desired lock is already allocated, this
+ *      will return NULL.  Otherwise it returns a spinlock handle.
+ * int hwspinlock_free(struct hwspinlock *);
+ *      Frees an allocated hardware spinlock (either reserved or unreserved).
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <plat/hwspinlock.h>
+
+/* Spinlock count code */
+#define SPINLOCK_32_REGS		1
+#define SPINLOCK_64_REGS		2
+#define SPINLOCK_128_REGS		4
+#define SPINLOCK_256_REGS		8
+#define SPINLOCK_NUMLOCKS_OFFSET	24
+
+/* for managing a hardware spinlock module */
+struct hwspinlock_state {
+	bool is_init;			/* For first-time initialization */
+	int num_locks;			/* Total number of locks in system */
+	spinlock_t local_lock;		/* Local protection */
+	void __iomem *io_base;		/* Mapped base address */
+};
+
+/* Points to the hardware spinlock module */
+static struct hwspinlock_state hwspinlock_state;
+static struct hwspinlock_state *hwspinlock_module = &hwspinlock_state;
+
+/* Spinlock object */
+struct hwspinlock {
+	bool is_init;
+	int id;
+	void __iomem *lock_reg;
+	bool is_allocated;
+	struct platform_device *pdev;
+};
+
+/* Array of spinlocks */
+static struct hwspinlock *hwspinlocks;
+
+/* API functions */
+
+/* Busy loop to acquire a spinlock */
+int hwspinlock_lock(struct hwspinlock *handle)
+{
+	int retval;
+
+	if (WARN_ON(handle == NULL))
+		return -EINVAL;
+
+	if (WARN_ON(in_irq()))
+		return -EPERM;
+
+	if (pm_runtime_get(&handle->pdev->dev) < 0)
+		return -ENODEV;
+
+	/* Attempt to acquire the lock by reading from it */
+	do {
+		retval = readl(handle->lock_reg);
+	} while (retval == HWSPINLOCK_BUSY);
+
+	return 0;
+}
+EXPORT_SYMBOL(hwspinlock_lock);
+
+/* Attempt to acquire a spinlock once */
+int hwspinlock_trylock(struct hwspinlock *handle)
+{
+	int retval = 0;
+
+	if (WARN_ON(handle == NULL))
+		return -EINVAL;
+
+	if (WARN_ON(in_irq()))
+		return -EPERM;
+
+	if (pm_runtime_get(&handle->pdev->dev) < 0)
+		return -ENODEV;
+
+	/* Attempt to acquire the lock by reading from it */
+	retval = readl(handle->lock_reg);
+
+	if (retval == HWSPINLOCK_BUSY)
+		pm_runtime_put(&handle->pdev->dev);
+
+	return retval;
+}
+EXPORT_SYMBOL(hwspinlock_trylock);
+
+/* Release a spinlock */
+int hwspinlock_unlock(struct hwspinlock *handle)
+{
+	if (WARN_ON(handle == NULL))
+		return -EINVAL;
+
+	/* Release it by writing 0 to it */
+	writel(0, handle->lock_reg);
+
+	pm_runtime_put(&handle->pdev->dev);
+
+	return 0;
+}
+EXPORT_SYMBOL(hwspinlock_unlock);
+
+/* Request an unclaimed spinlock */
+struct hwspinlock *hwspinlock_request(void)
+{
+	int i;
+	bool found = false;
+	struct hwspinlock *handle = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwspinlock_module->local_lock, flags);
+	/* Search for an unclaimed, unreserved lock */
+	for (i = 0; i < hwspinlock_module->num_locks && !found; i++) {
+		if (!hwspinlocks[i].is_allocated) {
+			found = true;
+			handle = &hwspinlocks[i];
+		}
+	}
+	spin_unlock_irqrestore(&hwspinlock_module->local_lock, flags);
+
+	/* Return error if no more locks available */
+	if (!found)
+		return NULL;
+
+	handle->is_allocated = true;
+
+	return handle;
+}
+EXPORT_SYMBOL(hwspinlock_request);
+
+/* Request an unclaimed spinlock by ID */
+struct hwspinlock *hwspinlock_request_specific(unsigned int id)
+{
+	struct hwspinlock *handle = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwspinlock_module->local_lock, flags);
+
+	if (WARN_ON(hwspinlocks[id].is_allocated))
+		goto exit;
+
+	handle = &hwspinlocks[id];
+	handle->is_allocated = true;
+
+exit:
+	spin_unlock_irqrestore(&hwspinlock_module->local_lock, flags);
+	return handle;
+}
+EXPORT_SYMBOL(hwspinlock_request_specific);
+
+/* Release a claimed spinlock */
+int hwspinlock_free(struct hwspinlock *handle)
+{
+	if (WARN_ON(handle == NULL))
+		return -EINVAL;
+
+	if (WARN_ON(!handle->is_allocated))
+		return -ENOMEM;
+
+	handle->is_allocated = false;
+
+	return 0;
+}
+EXPORT_SYMBOL(hwspinlock_free);
+
+/* Probe function */
+static int __devinit hwspinlock_probe(struct platform_device *pdev)
+{
+	struct hwspinlock_plat_info *pdata = pdev->dev.platform_data;
+	struct resource *res;
+	void __iomem *io_base;
+	int id;
+
+	void __iomem *sysstatus_reg;
+
+	/* Determine number of locks */
+	sysstatus_reg = ioremap(OMAP44XX_SPINLOCK_BASE +
+					pdata->sysstatus_offset, sizeof(u32));
+	switch (readl(sysstatus_reg) >> SPINLOCK_NUMLOCKS_OFFSET) {
+	case SPINLOCK_32_REGS:
+		hwspinlock_module->num_locks = 32;
+		break;
+	case SPINLOCK_64_REGS:
+		hwspinlock_module->num_locks = 64;
+		break;
+	case SPINLOCK_128_REGS:
+		hwspinlock_module->num_locks = 128;
+		break;
+	case SPINLOCK_256_REGS:
+		hwspinlock_module->num_locks = 256;
+		break;
+	default:
+		return -EINVAL;	/* Invalid spinlock count code */
+	}
+	iounmap(sysstatus_reg);
+
+	/* Allocate spinlock device objects */
+	hwspinlocks = kmalloc(sizeof(struct hwspinlock) *
+			hwspinlock_module->num_locks, GFP_KERNEL);
+	if (WARN_ON(hwspinlocks == NULL))
+		return -ENOMEM;
+
+	/* Initialize local lock */
+	spin_lock_init(&hwspinlock_module->local_lock);
+
+	/* Get address info */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	/* Map spinlock module address space */
+	io_base = ioremap(res->start, resource_size(res));
+	hwspinlock_module->io_base = io_base;
+
+	/* Set up each individual lock handle */
+	for (id = 0; id < hwspinlock_module->num_locks; id++) {
+		hwspinlocks[id].id		= id;
+		hwspinlocks[id].pdev		= pdev;
+
+		hwspinlocks[id].is_init		= true;
+		hwspinlocks[id].is_allocated	= false;
+
+		hwspinlocks[id].lock_reg	= io_base + pdata->
+					lock_base_offset + sizeof(u32) * id;
+	}
+
+	return 0;
+}
+
+static struct platform_driver hwspinlock_driver = {
+	.probe		= hwspinlock_probe,
+	.driver		= {
+		.name	= "hwspinlock",
+	},
+};
+
+/* Initialization function */
+static int __init hwspinlock_init(void)
+{
+	int retval = 0;
+
+	/* Register spinlock driver */
+	retval = platform_driver_register(&hwspinlock_driver);
+
+	return retval;
+}
+
+/* Cleanup function */
+static void __exit hwspinlock_exit(void)
+{
+	int id;
+
+	platform_driver_unregister(&hwspinlock_driver);
+
+	for (id = 0; id < hwspinlock_module->num_locks; id++)
+		hwspinlocks[id].is_init = false;
+	iounmap(hwspinlock_module->io_base);
+
+	/* Free spinlock device objects */
+	if (hwspinlock_module->is_init)
+		kfree(hwspinlocks);
+}
+
+module_init(hwspinlock_init);
+module_exit(hwspinlock_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Hardware spinlock driver");
+MODULE_AUTHOR("Simon Que");
+MODULE_AUTHOR("Hari Kanigeri");
diff --git a/arch/arm/plat-omap/include/plat/hwspinlock.h b/arch/arm/plat-omap/include/plat/hwspinlock.h
new file mode 100644
index 0000000..8c69ca5
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/hwspinlock.h
@@ -0,0 +1,29 @@
+/* hwspinlock.h */
+
+#ifndef HWSPINLOCK_H
+#define HWSPINLOCK_H
+
+#include <linux/platform_device.h>
+#include <plat/omap44xx.h>
+
+/* Read values from the spinlock register */
+#define HWSPINLOCK_ACQUIRED 0
+#define HWSPINLOCK_BUSY 1
+
+/* Device data */
+struct hwspinlock_plat_info {
+	u32 sysstatus_offset;		/* System status register offset */
+	u32 lock_base_offset;		/* Offset of spinlock registers */
+};
+
+struct hwspinlock;
+
+int hwspinlock_lock(struct hwspinlock *handle);
+int hwspinlock_trylock(struct hwspinlock *handle);
+int hwspinlock_unlock(struct hwspinlock *handle);
+
+struct hwspinlock *hwspinlock_request(void);
+struct hwspinlock *hwspinlock_request_specific(unsigned int id);
+int hwspinlock_free(struct hwspinlock *hwspinlock_ptr);
+
+#endif /* HWSPINLOCK_H */
-- 
1.7.0

