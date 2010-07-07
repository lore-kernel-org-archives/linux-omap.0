From: "Que, Simon" <sque@ti.com>
Subject: [PATCH] omap: hwspinlock: Added hwspinlock driver
Date: Wed, 7 Jul 2010 10:47:46 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1475D2256@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E1475D2256dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57116 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757065Ab0GGPrv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jul 2010 11:47:51 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1475D2256dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

This is the patch submission for the hardware spinlock driver.

I will not be available for the next 4 weeks.  Please contact Hari Kanigeri=
 (h-kanigeri2@ti.com) instead.

Thanks,
Simon


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>From 509bd1a2e7e5c1a6af3248742e0d53ca5f9fd066 Mon Sep 17 00:00:00 2001
From: Simon Que <sque@ti.com>
Date: Wed, 23 Jun 2010 18:40:30 -0500
Subject: [PATCH] omap: hwspinlock: Added hwspinlock driver

Created driver for OMAP hardware spinlock.  This driver supports:
- Reserved spinlocks for internal use
- Dynamic allocation of unreserved locks
- Lock, unlock, and trylock functions, with or without disabling irqs/preem=
pt
- Registered as a platform device driver

The device initialization uses hwmod to configure the devices.  One device =
will
be created for each IP.  It will pass spinlock register offset info to the
driver.  The device initialization file is:
                arch/arm/mach-omap2/hwspinlocks.c

The driver takes in register offset info passed in device initialization.  =
It
uses hwmod to obtain the base address of the hardware spinlock module.  The=
n it
reads info from the registers.  The function hwspinlock_probe() initializes=
 the
array of spinlock structures, each containing a spinlock register address
calculated from the base address and lock offsets.  The device driver file =
is:
                arch/arm/plat-omap/hwspinlock.c

Here's an API summary:
int hwspinlock_lock(struct hwspinlock *);
        Attempt to lock a hardware spinlock.  If it is busy, the function w=
ill
        keep trying until it succeeds.  This is a blocking function.
int hwspinlock_trylock(struct hwspinlock *);
        Attempt to lock a hardware spinlock.  If it is busy, the function w=
ill
        return BUSY.  If it succeeds in locking, the function will return
        ACQUIRED.  This is a non-blocking function.
int hwspinlock_unlock(struct hwspinlock *);
        Unlock a hardware spinlock.

struct hwspinlock *hwspinlock_request(void);
        Provides for "dynamic allocation" of a hardware spinlock.  It retur=
ns
        the handle to the next available (unallocated) spinlock.  If no mor=
e
        locks are available, it returns NULL.
struct hwspinlock *hwspinlock_request_specific(unsigned int);
        Provides for "static allocation" of a specific hardware spinlock. T=
his
        allows the system to use a specific spinlock, identified by an ID. =
If
        the ID is invalid or if the desired lock is already allocated, this
        will return NULL.  Otherwise it returns a spinlock handle.
int hwspinlock_free(struct hwspinlock *);
        Frees an allocated hardware spinlock (either reserved or unreserved=
).

Signed-off-by: Simon Que <sque@ti.com>
---
 arch/arm/mach-omap2/Makefile                 |    2 +
 arch/arm/mach-omap2/hwspinlocks.c            |   71 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
 arch/arm/plat-omap/Makefile                  |    3 +-
 arch/arm/plat-omap/hwspinlock.c              |  335 ++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/hwspinlock.h |   29 +++
 arch/arm/plat-omap/include/plat/omap44xx.h   |    2 +
 7 files changed, 442 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hwspinlocks.c
 create mode 100644 arch/arm/plat-omap/hwspinlock.c
 create mode 100644 arch/arm/plat-omap/include/plat/hwspinlock.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6725b3a..5f5c87b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -170,3 +170,5 @@ obj-y                                       +=3D $(nand=
-m) $(nand-y)

 smc91x-$(CONFIG_SMC91X)                        :=3D gpmc-smc91x.o
 obj-y                                  +=3D $(smc91x-m) $(smc91x-y)
+
+obj-$(CONFIG_ARCH_OMAP4)               +=3D hwspinlocks.o
\ No newline at end of file
diff --git a/arch/arm/mach-omap2/hwspinlocks.c b/arch/arm/mach-omap2/hwspin=
locks.c
new file mode 100644
index 0000000..58a6483
--- /dev/null
+++ b/arch/arm/mach-omap2/hwspinlocks.c
@@ -0,0 +1,71 @@
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
+#define REVISION_OFFSET                        0x0000
+#define SYSCONFIG_OFFSET               0x0010
+#define SYSSTATUS_OFFSET               0x0014
+#define LOCK_BASE_OFFSET               0x0800
+#define LOCK_OFFSET(i)                 (LOCK_BASE_OFFSET + 0x4 * (i))
+
+/* Initialization function */
+int __init hwspinlocks_init(void)
+{
+       int retval =3D 0;
+
+       struct hwspinlock_plat_info *pdata;
+       struct omap_hwmod *oh;
+       char *oh_name, *pdev_name;
+
+       oh_name =3D "spinlock";
+       oh =3D omap_hwmod_lookup(oh_name);
+       if (WARN_ON(oh =3D=3D NULL))
+               return -EINVAL;
+
+       pdev_name =3D "hwspinlock";
+
+       /* Pass data to device initialization */
+       pdata =3D kzalloc(sizeof(struct hwspinlock_plat_info), GFP_KERNEL);
+       if (WARN_ON(pdata =3D=3D NULL))
+               return -ENOMEM;
+       pdata->sysstatus_offset =3D SYSSTATUS_OFFSET;
+       pdata->lock_base_offset =3D LOCK_BASE_OFFSET;
+
+       omap_device_build(pdev_name, 0, oh, pdata,
+                       sizeof(struct hwspinlock_plat_info), NULL, 0, false=
);
+
+       return retval;
+}
+module_init(hwspinlocks_init);
+
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index d8d6d58..ce6c5ff 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4875,7 +4875,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[=
] =3D {
 /*     &omap44xx_smartreflex_iva_hwmod, */
 /*     &omap44xx_smartreflex_mpu_hwmod, */
        /* spinlock class */
-/*     &omap44xx_spinlock_hwmod, */
+       &omap44xx_spinlock_hwmod,
        /* timer class */
        &omap44xx_timer1_hwmod,
        &omap44xx_timer2_hwmod,
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index a37abf5..f725afc 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -32,4 +32,5 @@ obj-y +=3D $(i2c-omap-m) $(i2c-omap-y)
 obj-$(CONFIG_OMAP_MBOX_FWK) +=3D mailbox.o
 obj-$(CONFIG_OMAP_REMOTE_PROC) +=3D remoteproc.o

-obj-$(CONFIG_OMAP_PM_NOOP) +=3D omap-pm-noop.o
\ No newline at end of file
+obj-$(CONFIG_OMAP_PM_NOOP) +=3D omap-pm-noop.o
+obj-$(CONFIG_ARCH_OMAP4) +=3D hwspinlock.o
\ No newline at end of file
diff --git a/arch/arm/plat-omap/hwspinlock.c b/arch/arm/plat-omap/hwspinloc=
k.c
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
+ * - Lock, unlock, and trylock functions, with or without disabling irqs/p=
reempt
+ * - Registered as a platform device driver
+ *
+ * The device initialization uses hwmod to configure the devices.  One dev=
ice
+ * will be created for each IP.  It will pass spinlock register offset inf=
o to
+ * the driver.  The device initialization file is:
+ *          arch/arm/mach-omap2/hwspinlocks.c
+ *
+ * The driver takes in register offset info passed in device initializatio=
n.
+ * It uses hwmod to obtain the base address of the hardware spinlock modul=
e.
+ * Then it reads info from the registers.  The function hwspinlock_probe()
+ * initializes the array of spinlock structures, each containing a spinloc=
k
+ * register address calculated from the base address and lock offsets.
+ *
+ * Here's an API summary:
+ *
+ * int hwspinlock_lock(struct hwspinlock *);
+ *      Attempt to lock a hardware spinlock.  If it is busy, the function =
will
+ *      keep trying until it succeeds.  This is a blocking function.
+ * int hwspinlock_trylock(struct hwspinlock *);
+ *      Attempt to lock a hardware spinlock.  If it is busy, the function =
will
+ *      return BUSY.  If it succeeds in locking, the function will return
+ *      ACQUIRED.  This is a non-blocking function
+ * int hwspinlock_unlock(struct hwspinlock *);
+ *      Unlock a hardware spinlock.
+ *
+ * struct hwspinlock *hwspinlock_request(void);
+ *      Provides for "dynamic allocation" of a hardware spinlock.  It retu=
rns
+ *      the handle to the next available (unallocated) spinlock.  If no mo=
re
+ *      locks are available, it returns NULL.
+ * struct hwspinlock *hwspinlock_request_specific(unsigned int);
+ *      Provides for "static allocation" of a specific hardware spinlock. =
This
+ *      allows the system to use a specific spinlock, identified by an ID.=
 If
+ *      the ID is invalid or if the desired lock is already allocated, thi=
s
+ *      will return NULL.  Otherwise it returns a spinlock handle.
+ * int hwspinlock_free(struct hwspinlock *);
+ *      Frees an allocated hardware spinlock (either reserved or unreserve=
d).
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
+#define SPINLOCK_32_REGS               1
+#define SPINLOCK_64_REGS               2
+#define SPINLOCK_128_REGS              4
+#define SPINLOCK_256_REGS              8
+#define SPINLOCK_NUMLOCKS_OFFSET       24
+
+/* for managing a hardware spinlock module */
+struct hwspinlock_state {
+       bool is_init;                   /* For first-time initialization */
+       int num_locks;                  /* Total number of locks in system =
*/
+       spinlock_t local_lock;          /* Local protection */
+       void __iomem *io_base;          /* Mapped base address */
+};
+
+/* Points to the hardware spinlock module */
+static struct hwspinlock_state hwspinlock_state;
+static struct hwspinlock_state *hwspinlock_module =3D &hwspinlock_state;
+
+/* Spinlock object */
+struct hwspinlock {
+       bool is_init;
+       int id;
+       void __iomem *lock_reg;
+       bool is_allocated;
+       struct platform_device *pdev;
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
+       int retval;
+
+       if (WARN_ON(handle =3D=3D NULL))
+               return -EINVAL;
+
+       if (WARN_ON(in_irq()))
+               return -EPERM;
+
+       if (pm_runtime_get(&handle->pdev->dev) < 0)
+               return -ENODEV;
+
+       /* Attempt to acquire the lock by reading from it */
+       do {
+               retval =3D readl(handle->lock_reg);
+       } while (retval =3D=3D HWSPINLOCK_BUSY);
+
+       return 0;
+}
+EXPORT_SYMBOL(hwspinlock_lock);
+
+/* Attempt to acquire a spinlock once */
+int hwspinlock_trylock(struct hwspinlock *handle)
+{
+       int retval =3D 0;
+
+       if (WARN_ON(handle =3D=3D NULL))
+               return -EINVAL;
+
+       if (WARN_ON(in_irq()))
+               return -EPERM;
+
+       if (pm_runtime_get(&handle->pdev->dev) < 0)
+               return -ENODEV;
+
+       /* Attempt to acquire the lock by reading from it */
+       retval =3D readl(handle->lock_reg);
+
+       if (retval =3D=3D HWSPINLOCK_BUSY)
+               pm_runtime_put(&handle->pdev->dev);
+
+       return retval;
+}
+EXPORT_SYMBOL(hwspinlock_trylock);
+
+/* Release a spinlock */
+int hwspinlock_unlock(struct hwspinlock *handle)
+{
+       if (WARN_ON(handle =3D=3D NULL))
+               return -EINVAL;
+
+       /* Release it by writing 0 to it */
+       writel(0, handle->lock_reg);
+
+       pm_runtime_put(&handle->pdev->dev);
+
+       return 0;
+}
+EXPORT_SYMBOL(hwspinlock_unlock);
+
+/* Request an unclaimed spinlock */
+struct hwspinlock *hwspinlock_request(void)
+{
+       int i;
+       bool found =3D false;
+       struct hwspinlock *handle =3D NULL;
+       unsigned long flags;
+
+       spin_lock_irqsave(&hwspinlock_module->local_lock, flags);
+       /* Search for an unclaimed, unreserved lock */
+       for (i =3D 0; i < hwspinlock_module->num_locks && !found; i++) {
+               if (!hwspinlocks[i].is_allocated) {
+                       found =3D true;
+                       handle =3D &hwspinlocks[i];
+               }
+       }
+       spin_unlock_irqrestore(&hwspinlock_module->local_lock, flags);
+
+       /* Return error if no more locks available */
+       if (!found)
+               return NULL;
+
+       handle->is_allocated =3D true;
+
+       return handle;
+}
+EXPORT_SYMBOL(hwspinlock_request);
+
+/* Request an unclaimed spinlock by ID */
+struct hwspinlock *hwspinlock_request_specific(unsigned int id)
+{
+       struct hwspinlock *handle =3D NULL;
+       unsigned long flags;
+
+       spin_lock_irqsave(&hwspinlock_module->local_lock, flags);
+
+       if (WARN_ON(hwspinlocks[id].is_allocated))
+               goto exit;
+
+       handle =3D &hwspinlocks[id];
+       handle->is_allocated =3D true;
+
+exit:
+       spin_unlock_irqrestore(&hwspinlock_module->local_lock, flags);
+       return handle;
+}
+EXPORT_SYMBOL(hwspinlock_request_specific);
+
+/* Release a claimed spinlock */
+int hwspinlock_free(struct hwspinlock *handle)
+{
+       if (WARN_ON(handle =3D=3D NULL))
+               return -EINVAL;
+
+       if (WARN_ON(!handle->is_allocated))
+               return -ENOMEM;
+
+       handle->is_allocated =3D false;
+
+       return 0;
+}
+EXPORT_SYMBOL(hwspinlock_free);
+
+/* Probe function */
+static int __devinit hwspinlock_probe(struct platform_device *pdev)
+{
+       struct hwspinlock_plat_info *pdata =3D pdev->dev.platform_data;
+       struct resource *res;
+       void __iomem *io_base;
+       int id;
+
+       void __iomem *sysstatus_reg;
+
+       /* Determine number of locks */
+       sysstatus_reg =3D ioremap(OMAP44XX_SPINLOCK_BASE +
+                                       pdata->sysstatus_offset, sizeof(u32=
));
+       switch (readl(sysstatus_reg) >> SPINLOCK_NUMLOCKS_OFFSET) {
+       case SPINLOCK_32_REGS:
+               hwspinlock_module->num_locks =3D 32;
+               break;
+       case SPINLOCK_64_REGS:
+               hwspinlock_module->num_locks =3D 64;
+               break;
+       case SPINLOCK_128_REGS:
+               hwspinlock_module->num_locks =3D 128;
+               break;
+       case SPINLOCK_256_REGS:
+               hwspinlock_module->num_locks =3D 256;
+               break;
+       default:
+               return -EINVAL; /* Invalid spinlock count code */
+       }
+       iounmap(sysstatus_reg);
+
+       /* Allocate spinlock device objects */
+       hwspinlocks =3D kmalloc(sizeof(struct hwspinlock) *
+                       hwspinlock_module->num_locks, GFP_KERNEL);
+       if (WARN_ON(hwspinlocks =3D=3D NULL))
+               return -ENOMEM;
+
+       /* Initialize local lock */
+       spin_lock_init(&hwspinlock_module->local_lock);
+
+       /* Get address info */
+       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+       /* Map spinlock module address space */
+       io_base =3D ioremap(res->start, resource_size(res));
+       hwspinlock_module->io_base =3D io_base;
+
+       /* Set up each individual lock handle */
+       for (id =3D 0; id < hwspinlock_module->num_locks; id++) {
+               hwspinlocks[id].id              =3D id;
+               hwspinlocks[id].pdev            =3D pdev;
+
+               hwspinlocks[id].is_init         =3D true;
+               hwspinlocks[id].is_allocated    =3D false;
+
+               hwspinlocks[id].lock_reg        =3D io_base + pdata->
+                                       lock_base_offset + sizeof(u32) * id=
;
+       }
+
+       return 0;
+}
+
+static struct platform_driver hwspinlock_driver =3D {
+       .probe          =3D hwspinlock_probe,
+       .driver         =3D {
+               .name   =3D "hwspinlock",
+       },
+};
+
+/* Initialization function */
+static int __init hwspinlock_init(void)
+{
+       int retval =3D 0;
+
+       /* Register spinlock driver */
+       retval =3D platform_driver_register(&hwspinlock_driver);
+
+       return retval;
+}
+
+/* Cleanup function */
+static void __exit hwspinlock_exit(void)
+{
+       int id;
+
+       platform_driver_unregister(&hwspinlock_driver);
+
+       for (id =3D 0; id < hwspinlock_module->num_locks; id++)
+               hwspinlocks[id].is_init =3D false;
+       iounmap(hwspinlock_module->io_base);
+
+       /* Free spinlock device objects */
+       if (hwspinlock_module->is_init)
+               kfree(hwspinlocks);
+}
+
+module_init(hwspinlock_init);
+module_exit(hwspinlock_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Hardware spinlock driver");
+MODULE_AUTHOR("Simon Que");
+MODULE_AUTHOR("Hari Kanigeri");
diff --git a/arch/arm/plat-omap/include/plat/hwspinlock.h b/arch/arm/plat-o=
map/include/plat/hwspinlock.h
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
+       u32 sysstatus_offset;           /* System status register offset */
+       u32 lock_base_offset;           /* Offset of spinlock registers */
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
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-oma=
p/include/plat/omap44xx.h
index 8b3f12f..8016508 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -52,5 +52,7 @@
 #define OMAP4_MMU1_BASE                        0x55082000
 #define OMAP4_MMU2_BASE                        0x4A066000

+#define OMAP44XX_SPINLOCK_BASE         (L4_44XX_BASE + 0xF6000)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */

--
1.7.0


--_002_F39349C6FA641B4A831B7BF4EBF4D4E1475D2256dlee03entticom_
Content-Type: application/octet-stream;
	name="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"
Content-Description: 0001-omap-hwspinlock-Added-hwspinlock-driver.patch
Content-Disposition: attachment;
	filename="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"; size=17824;
	creation-date="Wed, 07 Jul 2010 10:29:14 GMT";
	modification-date="Wed, 07 Jul 2010 10:29:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1MDliZDFhMmU3ZTVjMWE2YWYzMjQ4NzQyZTBkNTNjYTVmOWZkMDY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgpEYXRlOiBXZWQsIDIz
IEp1biAyMDEwIDE4OjQwOjMwIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gb21hcDogaHdzcGlubG9j
azogQWRkZWQgaHdzcGlubG9jayBkcml2ZXIKCkNyZWF0ZWQgZHJpdmVyIGZvciBPTUFQIGhhcmR3
YXJlIHNwaW5sb2NrLiAgVGhpcyBkcml2ZXIgc3VwcG9ydHM6Ci0gUmVzZXJ2ZWQgc3BpbmxvY2tz
IGZvciBpbnRlcm5hbCB1c2UKLSBEeW5hbWljIGFsbG9jYXRpb24gb2YgdW5yZXNlcnZlZCBsb2Nr
cwotIExvY2ssIHVubG9jaywgYW5kIHRyeWxvY2sgZnVuY3Rpb25zLCB3aXRoIG9yIHdpdGhvdXQg
ZGlzYWJsaW5nIGlycXMvcHJlZW1wdAotIFJlZ2lzdGVyZWQgYXMgYSBwbGF0Zm9ybSBkZXZpY2Ug
ZHJpdmVyCgpUaGUgZGV2aWNlIGluaXRpYWxpemF0aW9uIHVzZXMgaHdtb2QgdG8gY29uZmlndXJl
IHRoZSBkZXZpY2VzLiAgT25lIGRldmljZSB3aWxsCmJlIGNyZWF0ZWQgZm9yIGVhY2ggSVAuICBJ
dCB3aWxsIHBhc3Mgc3BpbmxvY2sgcmVnaXN0ZXIgb2Zmc2V0IGluZm8gdG8gdGhlCmRyaXZlci4g
IFRoZSBkZXZpY2UgaW5pdGlhbGl6YXRpb24gZmlsZSBpczoKCQlhcmNoL2FybS9tYWNoLW9tYXAy
L2h3c3BpbmxvY2tzLmMKClRoZSBkcml2ZXIgdGFrZXMgaW4gcmVnaXN0ZXIgb2Zmc2V0IGluZm8g
cGFzc2VkIGluIGRldmljZSBpbml0aWFsaXphdGlvbi4gIEl0CnVzZXMgaHdtb2QgdG8gb2J0YWlu
IHRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIGhhcmR3YXJlIHNwaW5sb2NrIG1vZHVsZS4gIFRoZW4g
aXQKcmVhZHMgaW5mbyBmcm9tIHRoZSByZWdpc3RlcnMuICBUaGUgZnVuY3Rpb24gaHdzcGlubG9j
a19wcm9iZSgpIGluaXRpYWxpemVzIHRoZQphcnJheSBvZiBzcGlubG9jayBzdHJ1Y3R1cmVzLCBl
YWNoIGNvbnRhaW5pbmcgYSBzcGlubG9jayByZWdpc3RlciBhZGRyZXNzCmNhbGN1bGF0ZWQgZnJv
bSB0aGUgYmFzZSBhZGRyZXNzIGFuZCBsb2NrIG9mZnNldHMuICBUaGUgZGV2aWNlIGRyaXZlciBm
aWxlIGlzOgoJCWFyY2gvYXJtL3BsYXQtb21hcC9od3NwaW5sb2NrLmMKCkhlcmUncyBhbiBBUEkg
c3VtbWFyeToKaW50IGh3c3BpbmxvY2tfbG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqKTsKCUF0dGVt
cHQgdG8gbG9jayBhIGhhcmR3YXJlIHNwaW5sb2NrLiAgSWYgaXQgaXMgYnVzeSwgdGhlIGZ1bmN0
aW9uIHdpbGwKCWtlZXAgdHJ5aW5nIHVudGlsIGl0IHN1Y2NlZWRzLiAgVGhpcyBpcyBhIGJsb2Nr
aW5nIGZ1bmN0aW9uLgppbnQgaHdzcGlubG9ja190cnlsb2NrKHN0cnVjdCBod3NwaW5sb2NrICop
OwoJQXR0ZW1wdCB0byBsb2NrIGEgaGFyZHdhcmUgc3BpbmxvY2suICBJZiBpdCBpcyBidXN5LCB0
aGUgZnVuY3Rpb24gd2lsbAoJcmV0dXJuIEJVU1kuICBJZiBpdCBzdWNjZWVkcyBpbiBsb2NraW5n
LCB0aGUgZnVuY3Rpb24gd2lsbCByZXR1cm4KCUFDUVVJUkVELiAgVGhpcyBpcyBhIG5vbi1ibG9j
a2luZyBmdW5jdGlvbgppbnQgaHdzcGlubG9ja191bmxvY2soc3RydWN0IGh3c3BpbmxvY2sgKik7
CglVbmxvY2sgYSBoYXJkd2FyZSBzcGlubG9jay4KCnN0cnVjdCBod3NwaW5sb2NrICpod3NwaW5s
b2NrX3JlcXVlc3Qodm9pZCk7CglQcm92aWRlcyBmb3IgImR5bmFtaWMgYWxsb2NhdGlvbiIgb2Yg
YSBoYXJkd2FyZSBzcGlubG9jay4gIEl0IHJldHVybnMKCXRoZSBoYW5kbGUgdG8gdGhlIG5leHQg
YXZhaWxhYmxlICh1bmFsbG9jYXRlZCkgc3BpbmxvY2suICBJZiBubyBtb3JlCglsb2NrcyBhcmUg
YXZhaWxhYmxlLCBpdCByZXR1cm5zIE5VTEwuCnN0cnVjdCBod3NwaW5sb2NrICpod3NwaW5sb2Nr
X3JlcXVlc3Rfc3BlY2lmaWModW5zaWduZWQgaW50KTsKCVByb3ZpZGVzIGZvciAic3RhdGljIGFs
bG9jYXRpb24iIG9mIGEgc3BlY2lmaWMgaGFyZHdhcmUgc3BpbmxvY2suIFRoaXMKCWFsbG93cyB0
aGUgc3lzdGVtIHRvIHVzZSBhIHNwZWNpZmljIHNwaW5sb2NrLCBpZGVudGlmaWVkIGJ5IGFuIElE
LiBJZgoJdGhlIElEIGlzIGludmFsaWQgb3IgaWYgdGhlIGRlc2lyZWQgbG9jayBpcyBhbHJlYWR5
IGFsbG9jYXRlZCwgdGhpcwoJd2lsbCByZXR1cm4gTlVMTC4gIE90aGVyd2lzZSBpdCByZXR1cm5z
IGEgc3BpbmxvY2sgaGFuZGxlLgppbnQgaHdzcGlubG9ja19mcmVlKHN0cnVjdCBod3NwaW5sb2Nr
ICopOwoJRnJlZXMgYW4gYWxsb2NhdGVkIGhhcmR3YXJlIHNwaW5sb2NrIChlaXRoZXIgcmVzZXJ2
ZWQgb3IgdW5yZXNlcnZlZCkuCgpTaWduZWQtb2ZmLWJ5OiBTaW1vbiBRdWUgPHNxdWVAdGkuY29t
PgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAg
MiArCiBhcmNoL2FybS9tYWNoLW9tYXAyL2h3c3BpbmxvY2tzLmMgICAgICAgICAgICB8ICAgNzEg
KysrKysrCiBhcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfNDR4eF9kYXRhLmMgICB8ICAg
IDIgKy0KIGFyY2gvYXJtL3BsYXQtb21hcC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgICAg
MyArLQogYXJjaC9hcm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYyAgICAgICAgICAgICAgfCAgMzM1
ICsrKysrKysrKysrKysrKysrKysrKysrKysrCiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9w
bGF0L2h3c3BpbmxvY2suaCB8ICAgMjkgKysrCiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9w
bGF0L29tYXA0NHh4LmggICB8ICAgIDIgKwogNyBmaWxlcyBjaGFuZ2VkLCA0NDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLW9t
YXAyL2h3c3BpbmxvY2tzLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9wbGF0LW9tYXAv
aHdzcGlubG9jay5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1
ZGUvcGxhdC9od3NwaW5sb2NrLmgKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL01h
a2VmaWxlIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtlZmlsZQppbmRleCA2NzI1YjNhLi41ZjVj
ODdiIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlCisrKyBiL2FyY2gv
YXJtL21hY2gtb21hcDIvTWFrZWZpbGUKQEAgLTE3MCwzICsxNzAsNSBAQCBvYmoteQkJCQkJKz0g
JChuYW5kLW0pICQobmFuZC15KQogCiBzbWM5MXgtJChDT05GSUdfU01DOTFYKQkJCTo9IGdwbWMt
c21jOTF4Lm8KIG9iai15CQkJCQkrPSAkKHNtYzkxeC1tKSAkKHNtYzkxeC15KQorCitvYmotJChD
T05GSUdfQVJDSF9PTUFQNCkJCSs9IGh3c3BpbmxvY2tzLm8KXCBObyBuZXdsaW5lIGF0IGVuZCBv
ZiBmaWxlCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2h3c3BpbmxvY2tzLmMgYi9h
cmNoL2FybS9tYWNoLW9tYXAyL2h3c3BpbmxvY2tzLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMC4uNThhNjQ4MwotLS0gL2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL21hY2gtb21h
cDIvaHdzcGlubG9ja3MuYwpAQCAtMCwwICsxLDcxIEBACisvKgorICogT01BUCBoYXJkd2FyZSBz
cGlubG9jayBkZXZpY2UgaW5pdGlhbGl6YXRpb24KKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMTAg
VGV4YXMgSW5zdHJ1bWVudHMuIEFsbCByaWdodHMgcmVzZXJ2ZWQuCisgKgorICogQ29udGFjdDog
U2ltb24gUXVlIDxzcXVlQHRpLmNvbT4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0
d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCisgKiBtb2RpZnkgaXQgdW5kZXIg
dGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogdmVyc2lvbiAy
IGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICoKKyAqIFRo
aXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNl
ZnVsLCBidXQKKyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxp
ZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VCisgKiBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZv
ciBtb3JlIGRldGFpbHMuCisgKgorICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBv
ZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqIGFsb25nIHdpdGggdGhpcyBwcm9n
cmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisgKiBGb3VuZGF0aW9uLCBJ
bmMuLCA1MSBGcmFua2xpbiBTdCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEKKyAqIDAyMTEwLTEz
MDEgVVNBCisgKgorICovCisKKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxs
aW51eC9pbnRlcnJ1cHQuaD4KKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KKyNpbmNsdWRlIDxs
aW51eC9kZWxheS5oPgorI2luY2x1ZGUgPGxpbnV4L2lvLmg+CisjaW5jbHVkZSA8bGludXgvc2xh
Yi5oPgorCisjaW5jbHVkZSA8cGxhdC9od3NwaW5sb2NrLmg+CisjaW5jbHVkZSA8cGxhdC9vbWFw
X2RldmljZS5oPgorI2luY2x1ZGUgPHBsYXQvb21hcF9od21vZC5oPgorCisvKiBTcGlubG9jayBy
ZWdpc3RlciBvZmZzZXRzICovCisjZGVmaW5lIFJFVklTSU9OX09GRlNFVAkJCTB4MDAwMAorI2Rl
ZmluZSBTWVNDT05GSUdfT0ZGU0VUCQkweDAwMTAKKyNkZWZpbmUgU1lTU1RBVFVTX09GRlNFVAkJ
MHgwMDE0CisjZGVmaW5lIExPQ0tfQkFTRV9PRkZTRVQJCTB4MDgwMAorI2RlZmluZSBMT0NLX09G
RlNFVChpKQkJCShMT0NLX0JBU0VfT0ZGU0VUICsgMHg0ICogKGkpKQorCisvKiBJbml0aWFsaXph
dGlvbiBmdW5jdGlvbiAqLworaW50IF9faW5pdCBod3NwaW5sb2Nrc19pbml0KHZvaWQpCit7CisJ
aW50IHJldHZhbCA9IDA7CisKKwlzdHJ1Y3QgaHdzcGlubG9ja19wbGF0X2luZm8gKnBkYXRhOwor
CXN0cnVjdCBvbWFwX2h3bW9kICpvaDsKKwljaGFyICpvaF9uYW1lLCAqcGRldl9uYW1lOworCisJ
b2hfbmFtZSA9ICJzcGlubG9jayI7CisJb2ggPSBvbWFwX2h3bW9kX2xvb2t1cChvaF9uYW1lKTsK
KwlpZiAoV0FSTl9PTihvaCA9PSBOVUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlwZGV2X25h
bWUgPSAiaHdzcGlubG9jayI7CisKKwkvKiBQYXNzIGRhdGEgdG8gZGV2aWNlIGluaXRpYWxpemF0
aW9uICovCisJcGRhdGEgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgaHdzcGlubG9ja19wbGF0X2lu
Zm8pLCBHRlBfS0VSTkVMKTsKKwlpZiAoV0FSTl9PTihwZGF0YSA9PSBOVUxMKSkKKwkJcmV0dXJu
IC1FTk9NRU07CisJcGRhdGEtPnN5c3N0YXR1c19vZmZzZXQgPSBTWVNTVEFUVVNfT0ZGU0VUOwor
CXBkYXRhLT5sb2NrX2Jhc2Vfb2Zmc2V0ID0gTE9DS19CQVNFX09GRlNFVDsKKworCW9tYXBfZGV2
aWNlX2J1aWxkKHBkZXZfbmFtZSwgMCwgb2gsIHBkYXRhLAorCQkJc2l6ZW9mKHN0cnVjdCBod3Nw
aW5sb2NrX3BsYXRfaW5mbyksIE5VTEwsIDAsIGZhbHNlKTsKKworCXJldHVybiByZXR2YWw7Cit9
Cittb2R1bGVfaW5pdChod3NwaW5sb2Nrc19pbml0KTsKKwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9vbWFwX2h3bW9kXzQ0eHhfZGF0YS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9v
bWFwX2h3bW9kXzQ0eHhfZGF0YS5jCmluZGV4IGQ4ZDZkNTguLmNlNmM1ZmYgMTAwNjQ0Ci0tLSBh
L2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF80NHh4X2RhdGEuYworKysgYi9hcmNoL2Fy
bS9tYWNoLW9tYXAyL29tYXBfaHdtb2RfNDR4eF9kYXRhLmMKQEAgLTQ4NzUsNyArNDg3NSw3IEBA
IHN0YXRpYyBfX2luaXRkYXRhIHN0cnVjdCBvbWFwX2h3bW9kICpvbWFwNDR4eF9od21vZHNbXSA9
IHsKIC8qCSZvbWFwNDR4eF9zbWFydHJlZmxleF9pdmFfaHdtb2QsICovCiAvKgkmb21hcDQ0eHhf
c21hcnRyZWZsZXhfbXB1X2h3bW9kLCAqLwogCS8qIHNwaW5sb2NrIGNsYXNzICovCi0vKgkmb21h
cDQ0eHhfc3BpbmxvY2tfaHdtb2QsICovCisJJm9tYXA0NHh4X3NwaW5sb2NrX2h3bW9kLAogCS8q
IHRpbWVyIGNsYXNzICovCiAJJm9tYXA0NHh4X3RpbWVyMV9od21vZCwKIAkmb21hcDQ0eHhfdGlt
ZXIyX2h3bW9kLApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlIGIvYXJj
aC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlCmluZGV4IGEzN2FiZjUuLmY3MjVhZmMgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL3BsYXQtb21hcC9NYWtlZmlsZQorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAv
TWFrZWZpbGUKQEAgLTMyLDQgKzMyLDUgQEAgb2JqLXkgKz0gJChpMmMtb21hcC1tKSAkKGkyYy1v
bWFwLXkpCiBvYmotJChDT05GSUdfT01BUF9NQk9YX0ZXSykgKz0gbWFpbGJveC5vCiBvYmotJChD
T05GSUdfT01BUF9SRU1PVEVfUFJPQykgKz0gcmVtb3RlcHJvYy5vCiAKLW9iai0kKENPTkZJR19P
TUFQX1BNX05PT1ApICs9IG9tYXAtcG0tbm9vcC5vClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmls
ZQorb2JqLSQoQ09ORklHX09NQVBfUE1fTk9PUCkgKz0gb21hcC1wbS1ub29wLm8KK29iai0kKENP
TkZJR19BUkNIX09NQVA0KSArPSBod3NwaW5sb2NrLm8KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBm
aWxlCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaHdzcGlubG9jay5jIGIvYXJjaC9h
cm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAw
MDAwLi4xODgzYWRkCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2h3c3Bp
bmxvY2suYwpAQCAtMCwwICsxLDMzNSBAQAorLyoKKyAqIE9NQVAgaGFyZHdhcmUgc3BpbmxvY2sg
ZHJpdmVyCisgKgorICogQ29weXJpZ2h0IChDKSAyMDEwIFRleGFzIEluc3RydW1lbnRzLiBBbGwg
cmlnaHRzIHJlc2VydmVkLgorICoKKyAqIENvbnRhY3Q6IFNpbW9uIFF1ZSA8c3F1ZUB0aS5jb20+
CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UKKyAqIHZlcnNpb24gMiBhcyBwdWJsaXNoZWQgYnkgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0
ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0CisgKiBXSVRIT1VUIEFO
WSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
IEdOVQorICogR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAq
IFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1Ymxp
YyBMaWNlbnNlCisgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0
aGUgRnJlZSBTb2Z0d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZp
ZnRoIEZsb29yLCBCb3N0b24sIE1BCisgKiAwMjExMC0xMzAxIFVTQQorICoKKyAqIFRoaXMgZHJp
dmVyIHN1cHBvcnRzOgorICogLSBSZXNlcnZlZCBzcGlubG9ja3MgZm9yIGludGVybmFsIHVzZQor
ICogLSBEeW5hbWljIGFsbG9jYXRpb24gb2YgdW5yZXNlcnZlZCBsb2NrcworICogLSBMb2NrLCB1
bmxvY2ssIGFuZCB0cnlsb2NrIGZ1bmN0aW9ucywgd2l0aCBvciB3aXRob3V0IGRpc2FibGluZyBp
cnFzL3ByZWVtcHQKKyAqIC0gUmVnaXN0ZXJlZCBhcyBhIHBsYXRmb3JtIGRldmljZSBkcml2ZXIK
KyAqCisgKiBUaGUgZGV2aWNlIGluaXRpYWxpemF0aW9uIHVzZXMgaHdtb2QgdG8gY29uZmlndXJl
IHRoZSBkZXZpY2VzLiAgT25lIGRldmljZQorICogd2lsbCBiZSBjcmVhdGVkIGZvciBlYWNoIElQ
LiAgSXQgd2lsbCBwYXNzIHNwaW5sb2NrIHJlZ2lzdGVyIG9mZnNldCBpbmZvIHRvCisgKiB0aGUg
ZHJpdmVyLiAgVGhlIGRldmljZSBpbml0aWFsaXphdGlvbiBmaWxlIGlzOgorICogICAgICAgICAg
YXJjaC9hcm0vbWFjaC1vbWFwMi9od3NwaW5sb2Nrcy5jCisgKgorICogVGhlIGRyaXZlciB0YWtl
cyBpbiByZWdpc3RlciBvZmZzZXQgaW5mbyBwYXNzZWQgaW4gZGV2aWNlIGluaXRpYWxpemF0aW9u
LgorICogSXQgdXNlcyBod21vZCB0byBvYnRhaW4gdGhlIGJhc2UgYWRkcmVzcyBvZiB0aGUgaGFy
ZHdhcmUgc3BpbmxvY2sgbW9kdWxlLgorICogVGhlbiBpdCByZWFkcyBpbmZvIGZyb20gdGhlIHJl
Z2lzdGVycy4gIFRoZSBmdW5jdGlvbiBod3NwaW5sb2NrX3Byb2JlKCkKKyAqIGluaXRpYWxpemVz
IHRoZSBhcnJheSBvZiBzcGlubG9jayBzdHJ1Y3R1cmVzLCBlYWNoIGNvbnRhaW5pbmcgYSBzcGlu
bG9jaworICogcmVnaXN0ZXIgYWRkcmVzcyBjYWxjdWxhdGVkIGZyb20gdGhlIGJhc2UgYWRkcmVz
cyBhbmQgbG9jayBvZmZzZXRzLgorICoKKyAqIEhlcmUncyBhbiBBUEkgc3VtbWFyeToKKyAqCisg
KiBpbnQgaHdzcGlubG9ja19sb2NrKHN0cnVjdCBod3NwaW5sb2NrICopOworICogICAgICBBdHRl
bXB0IHRvIGxvY2sgYSBoYXJkd2FyZSBzcGlubG9jay4gIElmIGl0IGlzIGJ1c3ksIHRoZSBmdW5j
dGlvbiB3aWxsCisgKiAgICAgIGtlZXAgdHJ5aW5nIHVudGlsIGl0IHN1Y2NlZWRzLiAgVGhpcyBp
cyBhIGJsb2NraW5nIGZ1bmN0aW9uLgorICogaW50IGh3c3BpbmxvY2tfdHJ5bG9jayhzdHJ1Y3Qg
aHdzcGlubG9jayAqKTsKKyAqICAgICAgQXR0ZW1wdCB0byBsb2NrIGEgaGFyZHdhcmUgc3Bpbmxv
Y2suICBJZiBpdCBpcyBidXN5LCB0aGUgZnVuY3Rpb24gd2lsbAorICogICAgICByZXR1cm4gQlVT
WS4gIElmIGl0IHN1Y2NlZWRzIGluIGxvY2tpbmcsIHRoZSBmdW5jdGlvbiB3aWxsIHJldHVybgor
ICogICAgICBBQ1FVSVJFRC4gIFRoaXMgaXMgYSBub24tYmxvY2tpbmcgZnVuY3Rpb24KKyAqIGlu
dCBod3NwaW5sb2NrX3VubG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqKTsKKyAqICAgICAgVW5sb2Nr
IGEgaGFyZHdhcmUgc3BpbmxvY2suCisgKgorICogc3RydWN0IGh3c3BpbmxvY2sgKmh3c3Bpbmxv
Y2tfcmVxdWVzdCh2b2lkKTsKKyAqICAgICAgUHJvdmlkZXMgZm9yICJkeW5hbWljIGFsbG9jYXRp
b24iIG9mIGEgaGFyZHdhcmUgc3BpbmxvY2suICBJdCByZXR1cm5zCisgKiAgICAgIHRoZSBoYW5k
bGUgdG8gdGhlIG5leHQgYXZhaWxhYmxlICh1bmFsbG9jYXRlZCkgc3BpbmxvY2suICBJZiBubyBt
b3JlCisgKiAgICAgIGxvY2tzIGFyZSBhdmFpbGFibGUsIGl0IHJldHVybnMgTlVMTC4KKyAqIHN0
cnVjdCBod3NwaW5sb2NrICpod3NwaW5sb2NrX3JlcXVlc3Rfc3BlY2lmaWModW5zaWduZWQgaW50
KTsKKyAqICAgICAgUHJvdmlkZXMgZm9yICJzdGF0aWMgYWxsb2NhdGlvbiIgb2YgYSBzcGVjaWZp
YyBoYXJkd2FyZSBzcGlubG9jay4gVGhpcworICogICAgICBhbGxvd3MgdGhlIHN5c3RlbSB0byB1
c2UgYSBzcGVjaWZpYyBzcGlubG9jaywgaWRlbnRpZmllZCBieSBhbiBJRC4gSWYKKyAqICAgICAg
dGhlIElEIGlzIGludmFsaWQgb3IgaWYgdGhlIGRlc2lyZWQgbG9jayBpcyBhbHJlYWR5IGFsbG9j
YXRlZCwgdGhpcworICogICAgICB3aWxsIHJldHVybiBOVUxMLiAgT3RoZXJ3aXNlIGl0IHJldHVy
bnMgYSBzcGlubG9jayBoYW5kbGUuCisgKiBpbnQgaHdzcGlubG9ja19mcmVlKHN0cnVjdCBod3Nw
aW5sb2NrICopOworICogICAgICBGcmVlcyBhbiBhbGxvY2F0ZWQgaGFyZHdhcmUgc3BpbmxvY2sg
KGVpdGhlciByZXNlcnZlZCBvciB1bnJlc2VydmVkKS4KKyAqLworCisjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgv
ZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5o
PgorI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+
CisjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KKworI2luY2x1ZGUgPHBsYXQvaHdzcGlubG9j
ay5oPgorCisvKiBTcGlubG9jayBjb3VudCBjb2RlICovCisjZGVmaW5lIFNQSU5MT0NLXzMyX1JF
R1MJCTEKKyNkZWZpbmUgU1BJTkxPQ0tfNjRfUkVHUwkJMgorI2RlZmluZSBTUElOTE9DS18xMjhf
UkVHUwkJNAorI2RlZmluZSBTUElOTE9DS18yNTZfUkVHUwkJOAorI2RlZmluZSBTUElOTE9DS19O
VU1MT0NLU19PRkZTRVQJMjQKKworLyogZm9yIG1hbmFnaW5nIGEgaGFyZHdhcmUgc3BpbmxvY2sg
bW9kdWxlICovCitzdHJ1Y3QgaHdzcGlubG9ja19zdGF0ZSB7CisJYm9vbCBpc19pbml0OwkJCS8q
IEZvciBmaXJzdC10aW1lIGluaXRpYWxpemF0aW9uICovCisJaW50IG51bV9sb2NrczsJCQkvKiBU
b3RhbCBudW1iZXIgb2YgbG9ja3MgaW4gc3lzdGVtICovCisJc3BpbmxvY2tfdCBsb2NhbF9sb2Nr
OwkJLyogTG9jYWwgcHJvdGVjdGlvbiAqLworCXZvaWQgX19pb21lbSAqaW9fYmFzZTsJCS8qIE1h
cHBlZCBiYXNlIGFkZHJlc3MgKi8KK307CisKKy8qIFBvaW50cyB0byB0aGUgaGFyZHdhcmUgc3Bp
bmxvY2sgbW9kdWxlICovCitzdGF0aWMgc3RydWN0IGh3c3BpbmxvY2tfc3RhdGUgaHdzcGlubG9j
a19zdGF0ZTsKK3N0YXRpYyBzdHJ1Y3QgaHdzcGlubG9ja19zdGF0ZSAqaHdzcGlubG9ja19tb2R1
bGUgPSAmaHdzcGlubG9ja19zdGF0ZTsKKworLyogU3BpbmxvY2sgb2JqZWN0ICovCitzdHJ1Y3Qg
aHdzcGlubG9jayB7CisJYm9vbCBpc19pbml0OworCWludCBpZDsKKwl2b2lkIF9faW9tZW0gKmxv
Y2tfcmVnOworCWJvb2wgaXNfYWxsb2NhdGVkOworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXY7Cit9OworCisvKiBBcnJheSBvZiBzcGlubG9ja3MgKi8KK3N0YXRpYyBzdHJ1Y3QgaHdzcGlu
bG9jayAqaHdzcGlubG9ja3M7CisKKy8qIEFQSSBmdW5jdGlvbnMgKi8KKworLyogQnVzeSBsb29w
IHRvIGFjcXVpcmUgYSBzcGlubG9jayAqLworaW50IGh3c3BpbmxvY2tfbG9jayhzdHJ1Y3QgaHdz
cGlubG9jayAqaGFuZGxlKQoreworCWludCByZXR2YWw7CisKKwlpZiAoV0FSTl9PTihoYW5kbGUg
PT0gTlVMTCkpCisJCXJldHVybiAtRUlOVkFMOworCisJaWYgKFdBUk5fT04oaW5faXJxKCkpKQor
CQlyZXR1cm4gLUVQRVJNOworCisJaWYgKHBtX3J1bnRpbWVfZ2V0KCZoYW5kbGUtPnBkZXYtPmRl
dikgPCAwKQorCQlyZXR1cm4gLUVOT0RFVjsKKworCS8qIEF0dGVtcHQgdG8gYWNxdWlyZSB0aGUg
bG9jayBieSByZWFkaW5nIGZyb20gaXQgKi8KKwlkbyB7CisJCXJldHZhbCA9IHJlYWRsKGhhbmRs
ZS0+bG9ja19yZWcpOworCX0gd2hpbGUgKHJldHZhbCA9PSBIV1NQSU5MT0NLX0JVU1kpOworCisJ
cmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfbG9jayk7CisKKy8qIEF0dGVt
cHQgdG8gYWNxdWlyZSBhIHNwaW5sb2NrIG9uY2UgKi8KK2ludCBod3NwaW5sb2NrX3RyeWxvY2so
c3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSkKK3sKKwlpbnQgcmV0dmFsID0gMDsKKworCWlmIChX
QVJOX09OKGhhbmRsZSA9PSBOVUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpZiAoV0FSTl9P
Tihpbl9pcnEoKSkpCisJCXJldHVybiAtRVBFUk07CisKKwlpZiAocG1fcnVudGltZV9nZXQoJmhh
bmRsZS0+cGRldi0+ZGV2KSA8IDApCisJCXJldHVybiAtRU5PREVWOworCisJLyogQXR0ZW1wdCB0
byBhY3F1aXJlIHRoZSBsb2NrIGJ5IHJlYWRpbmcgZnJvbSBpdCAqLworCXJldHZhbCA9IHJlYWRs
KGhhbmRsZS0+bG9ja19yZWcpOworCisJaWYgKHJldHZhbCA9PSBIV1NQSU5MT0NLX0JVU1kpCisJ
CXBtX3J1bnRpbWVfcHV0KCZoYW5kbGUtPnBkZXYtPmRldik7CisKKwlyZXR1cm4gcmV0dmFsOwor
fQorRVhQT1JUX1NZTUJPTChod3NwaW5sb2NrX3RyeWxvY2spOworCisvKiBSZWxlYXNlIGEgc3Bp
bmxvY2sgKi8KK2ludCBod3NwaW5sb2NrX3VubG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxl
KQoreworCWlmIChXQVJOX09OKGhhbmRsZSA9PSBOVUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisK
KwkvKiBSZWxlYXNlIGl0IGJ5IHdyaXRpbmcgMCB0byBpdCAqLworCXdyaXRlbCgwLCBoYW5kbGUt
PmxvY2tfcmVnKTsKKworCXBtX3J1bnRpbWVfcHV0KCZoYW5kbGUtPnBkZXYtPmRldik7CisKKwly
ZXR1cm4gMDsKK30KK0VYUE9SVF9TWU1CT0woaHdzcGlubG9ja191bmxvY2spOworCisvKiBSZXF1
ZXN0IGFuIHVuY2xhaW1lZCBzcGlubG9jayAqLworc3RydWN0IGh3c3BpbmxvY2sgKmh3c3Bpbmxv
Y2tfcmVxdWVzdCh2b2lkKQoreworCWludCBpOworCWJvb2wgZm91bmQgPSBmYWxzZTsKKwlzdHJ1
Y3QgaHdzcGlubG9jayAqaGFuZGxlID0gTlVMTDsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCisJ
c3Bpbl9sb2NrX2lycXNhdmUoJmh3c3BpbmxvY2tfbW9kdWxlLT5sb2NhbF9sb2NrLCBmbGFncyk7
CisJLyogU2VhcmNoIGZvciBhbiB1bmNsYWltZWQsIHVucmVzZXJ2ZWQgbG9jayAqLworCWZvciAo
aSA9IDA7IGkgPCBod3NwaW5sb2NrX21vZHVsZS0+bnVtX2xvY2tzICYmICFmb3VuZDsgaSsrKSB7
CisJCWlmICghaHdzcGlubG9ja3NbaV0uaXNfYWxsb2NhdGVkKSB7CisJCQlmb3VuZCA9IHRydWU7
CisJCQloYW5kbGUgPSAmaHdzcGlubG9ja3NbaV07CisJCX0KKwl9CisJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmaHdzcGlubG9ja19tb2R1bGUtPmxvY2FsX2xvY2ssIGZsYWdzKTsKKworCS8qIFJl
dHVybiBlcnJvciBpZiBubyBtb3JlIGxvY2tzIGF2YWlsYWJsZSAqLworCWlmICghZm91bmQpCisJ
CXJldHVybiBOVUxMOworCisJaGFuZGxlLT5pc19hbGxvY2F0ZWQgPSB0cnVlOworCisJcmV0dXJu
IGhhbmRsZTsKK30KK0VYUE9SVF9TWU1CT0woaHdzcGlubG9ja19yZXF1ZXN0KTsKKworLyogUmVx
dWVzdCBhbiB1bmNsYWltZWQgc3BpbmxvY2sgYnkgSUQgKi8KK3N0cnVjdCBod3NwaW5sb2NrICpo
d3NwaW5sb2NrX3JlcXVlc3Rfc3BlY2lmaWModW5zaWduZWQgaW50IGlkKQoreworCXN0cnVjdCBo
d3NwaW5sb2NrICpoYW5kbGUgPSBOVUxMOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKKwlzcGlu
X2xvY2tfaXJxc2F2ZSgmaHdzcGlubG9ja19tb2R1bGUtPmxvY2FsX2xvY2ssIGZsYWdzKTsKKwor
CWlmIChXQVJOX09OKGh3c3BpbmxvY2tzW2lkXS5pc19hbGxvY2F0ZWQpKQorCQlnb3RvIGV4aXQ7
CisKKwloYW5kbGUgPSAmaHdzcGlubG9ja3NbaWRdOworCWhhbmRsZS0+aXNfYWxsb2NhdGVkID0g
dHJ1ZTsKKworZXhpdDoKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZod3NwaW5sb2NrX21vZHVs
ZS0+bG9jYWxfbG9jaywgZmxhZ3MpOworCXJldHVybiBoYW5kbGU7Cit9CitFWFBPUlRfU1lNQk9M
KGh3c3BpbmxvY2tfcmVxdWVzdF9zcGVjaWZpYyk7CisKKy8qIFJlbGVhc2UgYSBjbGFpbWVkIHNw
aW5sb2NrICovCitpbnQgaHdzcGlubG9ja19mcmVlKHN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUp
Cit7CisJaWYgKFdBUk5fT04oaGFuZGxlID09IE5VTEwpKQorCQlyZXR1cm4gLUVJTlZBTDsKKwor
CWlmIChXQVJOX09OKCFoYW5kbGUtPmlzX2FsbG9jYXRlZCkpCisJCXJldHVybiAtRU5PTUVNOwor
CisJaGFuZGxlLT5pc19hbGxvY2F0ZWQgPSBmYWxzZTsKKworCXJldHVybiAwOworfQorRVhQT1JU
X1NZTUJPTChod3NwaW5sb2NrX2ZyZWUpOworCisvKiBQcm9iZSBmdW5jdGlvbiAqLworc3RhdGlj
IGludCBfX2RldmluaXQgaHdzcGlubG9ja19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQoreworCXN0cnVjdCBod3NwaW5sb2NrX3BsYXRfaW5mbyAqcGRhdGEgPSBwZGV2LT5kZXYu
cGxhdGZvcm1fZGF0YTsKKwlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsKKwl2b2lkIF9faW9tZW0gKmlv
X2Jhc2U7CisJaW50IGlkOworCisJdm9pZCBfX2lvbWVtICpzeXNzdGF0dXNfcmVnOworCisJLyog
RGV0ZXJtaW5lIG51bWJlciBvZiBsb2NrcyAqLworCXN5c3N0YXR1c19yZWcgPSBpb3JlbWFwKE9N
QVA0NFhYX1NQSU5MT0NLX0JBU0UgKworCQkJCQlwZGF0YS0+c3lzc3RhdHVzX29mZnNldCwgc2l6
ZW9mKHUzMikpOworCXN3aXRjaCAocmVhZGwoc3lzc3RhdHVzX3JlZykgPj4gU1BJTkxPQ0tfTlVN
TE9DS1NfT0ZGU0VUKSB7CisJY2FzZSBTUElOTE9DS18zMl9SRUdTOgorCQlod3NwaW5sb2NrX21v
ZHVsZS0+bnVtX2xvY2tzID0gMzI7CisJCWJyZWFrOworCWNhc2UgU1BJTkxPQ0tfNjRfUkVHUzoK
KwkJaHdzcGlubG9ja19tb2R1bGUtPm51bV9sb2NrcyA9IDY0OworCQlicmVhazsKKwljYXNlIFNQ
SU5MT0NLXzEyOF9SRUdTOgorCQlod3NwaW5sb2NrX21vZHVsZS0+bnVtX2xvY2tzID0gMTI4Owor
CQlicmVhazsKKwljYXNlIFNQSU5MT0NLXzI1Nl9SRUdTOgorCQlod3NwaW5sb2NrX21vZHVsZS0+
bnVtX2xvY2tzID0gMjU2OworCQlicmVhazsKKwlkZWZhdWx0OgorCQlyZXR1cm4gLUVJTlZBTDsJ
LyogSW52YWxpZCBzcGlubG9jayBjb3VudCBjb2RlICovCisJfQorCWlvdW5tYXAoc3lzc3RhdHVz
X3JlZyk7CisKKwkvKiBBbGxvY2F0ZSBzcGlubG9jayBkZXZpY2Ugb2JqZWN0cyAqLworCWh3c3Bp
bmxvY2tzID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IGh3c3BpbmxvY2spICoKKwkJCWh3c3Bpbmxv
Y2tfbW9kdWxlLT5udW1fbG9ja3MsIEdGUF9LRVJORUwpOworCWlmIChXQVJOX09OKGh3c3Bpbmxv
Y2tzID09IE5VTEwpKQorCQlyZXR1cm4gLUVOT01FTTsKKworCS8qIEluaXRpYWxpemUgbG9jYWwg
bG9jayAqLworCXNwaW5fbG9ja19pbml0KCZod3NwaW5sb2NrX21vZHVsZS0+bG9jYWxfbG9jayk7
CisKKwkvKiBHZXQgYWRkcmVzcyBpbmZvICovCisJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNl
KHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKKworCS8qIE1hcCBzcGlubG9jayBtb2R1bGUgYWRk
cmVzcyBzcGFjZSAqLworCWlvX2Jhc2UgPSBpb3JlbWFwKHJlcy0+c3RhcnQsIHJlc291cmNlX3Np
emUocmVzKSk7CisJaHdzcGlubG9ja19tb2R1bGUtPmlvX2Jhc2UgPSBpb19iYXNlOworCisJLyog
U2V0IHVwIGVhY2ggaW5kaXZpZHVhbCBsb2NrIGhhbmRsZSAqLworCWZvciAoaWQgPSAwOyBpZCA8
IGh3c3BpbmxvY2tfbW9kdWxlLT5udW1fbG9ja3M7IGlkKyspIHsKKwkJaHdzcGlubG9ja3NbaWRd
LmlkCQk9IGlkOworCQlod3NwaW5sb2Nrc1tpZF0ucGRldgkJPSBwZGV2OworCisJCWh3c3Bpbmxv
Y2tzW2lkXS5pc19pbml0CQk9IHRydWU7CisJCWh3c3BpbmxvY2tzW2lkXS5pc19hbGxvY2F0ZWQJ
PSBmYWxzZTsKKworCQlod3NwaW5sb2Nrc1tpZF0ubG9ja19yZWcJPSBpb19iYXNlICsgcGRhdGEt
PgorCQkJCQlsb2NrX2Jhc2Vfb2Zmc2V0ICsgc2l6ZW9mKHUzMikgKiBpZDsKKwl9CisKKwlyZXR1
cm4gMDsKK30KKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaHdzcGlubG9ja19kcml2
ZXIgPSB7CisJLnByb2JlCQk9IGh3c3BpbmxvY2tfcHJvYmUsCisJLmRyaXZlcgkJPSB7CisJCS5u
YW1lCT0gImh3c3BpbmxvY2siLAorCX0sCit9OworCisvKiBJbml0aWFsaXphdGlvbiBmdW5jdGlv
biAqLworc3RhdGljIGludCBfX2luaXQgaHdzcGlubG9ja19pbml0KHZvaWQpCit7CisJaW50IHJl
dHZhbCA9IDA7CisKKwkvKiBSZWdpc3RlciBzcGlubG9jayBkcml2ZXIgKi8KKwlyZXR2YWwgPSBw
bGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmh3c3BpbmxvY2tfZHJpdmVyKTsKKworCXJldHVybiBy
ZXR2YWw7Cit9CisKKy8qIENsZWFudXAgZnVuY3Rpb24gKi8KK3N0YXRpYyB2b2lkIF9fZXhpdCBo
d3NwaW5sb2NrX2V4aXQodm9pZCkKK3sKKwlpbnQgaWQ7CisKKwlwbGF0Zm9ybV9kcml2ZXJfdW5y
ZWdpc3RlcigmaHdzcGlubG9ja19kcml2ZXIpOworCisJZm9yIChpZCA9IDA7IGlkIDwgaHdzcGlu
bG9ja19tb2R1bGUtPm51bV9sb2NrczsgaWQrKykKKwkJaHdzcGlubG9ja3NbaWRdLmlzX2luaXQg
PSBmYWxzZTsKKwlpb3VubWFwKGh3c3BpbmxvY2tfbW9kdWxlLT5pb19iYXNlKTsKKworCS8qIEZy
ZWUgc3BpbmxvY2sgZGV2aWNlIG9iamVjdHMgKi8KKwlpZiAoaHdzcGlubG9ja19tb2R1bGUtPmlz
X2luaXQpCisJCWtmcmVlKGh3c3BpbmxvY2tzKTsKK30KKworbW9kdWxlX2luaXQoaHdzcGlubG9j
a19pbml0KTsKK21vZHVsZV9leGl0KGh3c3BpbmxvY2tfZXhpdCk7CisKK01PRFVMRV9MSUNFTlNF
KCJHUEwgdjIiKTsKK01PRFVMRV9ERVNDUklQVElPTigiSGFyZHdhcmUgc3BpbmxvY2sgZHJpdmVy
Iik7CitNT0RVTEVfQVVUSE9SKCJTaW1vbiBRdWUiKTsKK01PRFVMRV9BVVRIT1IoIkhhcmkgS2Fu
aWdlcmkiKTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdz
cGlubG9jay5oIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9od3NwaW5sb2NrLmgK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uOGM2OWNhNQotLS0gL2Rldi9udWxs
CisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdzcGlubG9jay5oCkBAIC0w
LDAgKzEsMjkgQEAKKy8qIGh3c3BpbmxvY2suaCAqLworCisjaWZuZGVmIEhXU1BJTkxPQ0tfSAor
I2RlZmluZSBIV1NQSU5MT0NLX0gKKworI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5o
PgorI2luY2x1ZGUgPHBsYXQvb21hcDQ0eHguaD4KKworLyogUmVhZCB2YWx1ZXMgZnJvbSB0aGUg
c3BpbmxvY2sgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgSFdTUElOTE9DS19BQ1FVSVJFRCAwCisjZGVm
aW5lIEhXU1BJTkxPQ0tfQlVTWSAxCisKKy8qIERldmljZSBkYXRhICovCitzdHJ1Y3QgaHdzcGlu
bG9ja19wbGF0X2luZm8geworCXUzMiBzeXNzdGF0dXNfb2Zmc2V0OwkJLyogU3lzdGVtIHN0YXR1
cyByZWdpc3RlciBvZmZzZXQgKi8KKwl1MzIgbG9ja19iYXNlX29mZnNldDsJCS8qIE9mZnNldCBv
ZiBzcGlubG9jayByZWdpc3RlcnMgKi8KK307CisKK3N0cnVjdCBod3NwaW5sb2NrOworCitpbnQg
aHdzcGlubG9ja19sb2NrKHN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUpOworaW50IGh3c3Bpbmxv
Y2tfdHJ5bG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlKTsKK2ludCBod3NwaW5sb2NrX3Vu
bG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlKTsKKworc3RydWN0IGh3c3BpbmxvY2sgKmh3
c3BpbmxvY2tfcmVxdWVzdCh2b2lkKTsKK3N0cnVjdCBod3NwaW5sb2NrICpod3NwaW5sb2NrX3Jl
cXVlc3Rfc3BlY2lmaWModW5zaWduZWQgaW50IGlkKTsKK2ludCBod3NwaW5sb2NrX2ZyZWUoc3Ry
dWN0IGh3c3BpbmxvY2sgKmh3c3BpbmxvY2tfcHRyKTsKKworI2VuZGlmIC8qIEhXU1BJTkxPQ0tf
SCAqLwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwNDR4
eC5oIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwNDR4eC5oCmluZGV4IDhi
M2YxMmYuLjgwMTY1MDggMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3Bs
YXQvb21hcDQ0eHguaAorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L29tYXA0
NHh4LmgKQEAgLTUyLDUgKzUyLDcgQEAKICNkZWZpbmUgT01BUDRfTU1VMV9CQVNFCQkJMHg1NTA4
MjAwMAogI2RlZmluZSBPTUFQNF9NTVUyX0JBU0UJCQkweDRBMDY2MDAwCiAKKyNkZWZpbmUgT01B
UDQ0WFhfU1BJTkxPQ0tfQkFTRQkJKEw0XzQ0WFhfQkFTRSArIDB4RjYwMDApCisKICNlbmRpZiAv
KiBfX0FTTV9BUkNIX09NQVA0NFhYX0ggKi8KIAotLSAKMS43LjAKCg==

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1475D2256dlee03entticom_--
