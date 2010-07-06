From: "Que, Simon" <sque@ti.com>
Subject: [RFC v.4] omap: hwspinlock: Added hwspinlock driver
Date: Tue, 6 Jul 2010 15:25:21 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0Fdlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51169 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab0GFUZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 16:25:23 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0Fdlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

This is the fourth and final RFC for the hardware spinlock driver.  I have =
incorporated some changes and fixes based on Santosh's comments.

Please give your comments.

Thanks,
Simon


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>From d4794eff60e5e509581fedaf2660b0d2d92463ab Mon Sep 17 00:00:00 2001
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
be created for each hardware spinlock.  It will pass spinlock register
addresses to the driver.  The device initialization file is:
                arch/arm/mach-omap2/hwspinlocks.c

The driver takes in data passed in device initialization.  The function
hwspinlock_probe() initializes the array of spinlock structures, each
containing a spinlock register address provided by the device initializatio=
n.
The device driver file is:
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
        ACQUIRED.  This is a non-blocking function
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
 arch/arm/plat-omap/hwspinlock.c              |  295 ++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/hwspinlock.h |   29 +++
 arch/arm/plat-omap/include/plat/omap44xx.h   |    2 +
 7 files changed, 402 insertions(+), 2 deletions(-)
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
index 0000000..eca1fc7
--- /dev/null
+++ b/arch/arm/plat-omap/hwspinlock.c
@@ -0,0 +1,295 @@
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


--_002_F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0Fdlee03entticom_
Content-Type: application/octet-stream;
	name="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"
Content-Description: 0001-omap-hwspinlock-Added-hwspinlock-driver.patch
Content-Disposition: attachment;
	filename="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"; size=15482;
	creation-date="Tue, 06 Jul 2010 15:28:06 GMT";
	modification-date="Tue, 06 Jul 2010 15:28:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkNDc5NGVmZjYwZTVlNTA5NTgxZmVkYWYyNjYwYjBkMmQ5MjQ2M2FiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgpEYXRlOiBXZWQsIDIz
IEp1biAyMDEwIDE4OjQwOjMwIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gb21hcDogaHdzcGlubG9j
azogQWRkZWQgaHdzcGlubG9jayBkcml2ZXIKCkNyZWF0ZWQgZHJpdmVyIGZvciBPTUFQIGhhcmR3
YXJlIHNwaW5sb2NrLiAgVGhpcyBkcml2ZXIgc3VwcG9ydHM6Ci0gUmVzZXJ2ZWQgc3BpbmxvY2tz
IGZvciBpbnRlcm5hbCB1c2UKLSBEeW5hbWljIGFsbG9jYXRpb24gb2YgdW5yZXNlcnZlZCBsb2Nr
cwotIExvY2ssIHVubG9jaywgYW5kIHRyeWxvY2sgZnVuY3Rpb25zLCB3aXRoIG9yIHdpdGhvdXQg
ZGlzYWJsaW5nIGlycXMvcHJlZW1wdAotIFJlZ2lzdGVyZWQgYXMgYSBwbGF0Zm9ybSBkZXZpY2Ug
ZHJpdmVyCgpUaGUgZGV2aWNlIGluaXRpYWxpemF0aW9uIHVzZXMgaHdtb2QgdG8gY29uZmlndXJl
IHRoZSBkZXZpY2VzLiAgT25lIGRldmljZSB3aWxsCmJlIGNyZWF0ZWQgZm9yIGVhY2ggaGFyZHdh
cmUgc3BpbmxvY2suICBJdCB3aWxsIHBhc3Mgc3BpbmxvY2sgcmVnaXN0ZXIKYWRkcmVzc2VzIHRv
IHRoZSBkcml2ZXIuICBUaGUgZGV2aWNlIGluaXRpYWxpemF0aW9uIGZpbGUgaXM6CgkJYXJjaC9h
cm0vbWFjaC1vbWFwMi9od3NwaW5sb2Nrcy5jCgpUaGUgZHJpdmVyIHRha2VzIGluIGRhdGEgcGFz
c2VkIGluIGRldmljZSBpbml0aWFsaXphdGlvbi4gIFRoZSBmdW5jdGlvbgpod3NwaW5sb2NrX3By
b2JlKCkgaW5pdGlhbGl6ZXMgdGhlIGFycmF5IG9mIHNwaW5sb2NrIHN0cnVjdHVyZXMsIGVhY2gK
Y29udGFpbmluZyBhIHNwaW5sb2NrIHJlZ2lzdGVyIGFkZHJlc3MgcHJvdmlkZWQgYnkgdGhlIGRl
dmljZSBpbml0aWFsaXphdGlvbi4KVGhlIGRldmljZSBkcml2ZXIgZmlsZSBpczoKCQlhcmNoL2Fy
bS9wbGF0LW9tYXAvaHdzcGlubG9jay5jCgpIZXJlJ3MgYW4gQVBJIHN1bW1hcnk6CmludCBod3Nw
aW5sb2NrX2xvY2soc3RydWN0IGh3c3BpbmxvY2sgKik7CglBdHRlbXB0IHRvIGxvY2sgYSBoYXJk
d2FyZSBzcGlubG9jay4gIElmIGl0IGlzIGJ1c3ksIHRoZSBmdW5jdGlvbiB3aWxsCglrZWVwIHRy
eWluZyB1bnRpbCBpdCBzdWNjZWVkcy4gIFRoaXMgaXMgYSBibG9ja2luZyBmdW5jdGlvbi4KaW50
IGh3c3BpbmxvY2tfdHJ5bG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqKTsKCUF0dGVtcHQgdG8gbG9j
ayBhIGhhcmR3YXJlIHNwaW5sb2NrLiAgSWYgaXQgaXMgYnVzeSwgdGhlIGZ1bmN0aW9uIHdpbGwK
CXJldHVybiBCVVNZLiAgSWYgaXQgc3VjY2VlZHMgaW4gbG9ja2luZywgdGhlIGZ1bmN0aW9uIHdp
bGwgcmV0dXJuCglBQ1FVSVJFRC4gIFRoaXMgaXMgYSBub24tYmxvY2tpbmcgZnVuY3Rpb24KaW50
IGh3c3BpbmxvY2tfdW5sb2NrKHN0cnVjdCBod3NwaW5sb2NrICopOwoJVW5sb2NrIGEgaGFyZHdh
cmUgc3BpbmxvY2suCgpzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19yZXF1ZXN0KHZvaWQp
OwoJUHJvdmlkZXMgZm9yICJkeW5hbWljIGFsbG9jYXRpb24iIG9mIGEgaGFyZHdhcmUgc3Bpbmxv
Y2suICBJdCByZXR1cm5zCgl0aGUgaGFuZGxlIHRvIHRoZSBuZXh0IGF2YWlsYWJsZSAodW5hbGxv
Y2F0ZWQpIHNwaW5sb2NrLiAgSWYgbm8gbW9yZQoJbG9ja3MgYXJlIGF2YWlsYWJsZSwgaXQgcmV0
dXJucyBOVUxMLgpzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19yZXF1ZXN0X3NwZWNpZmlj
KHVuc2lnbmVkIGludCk7CglQcm92aWRlcyBmb3IgInN0YXRpYyBhbGxvY2F0aW9uIiBvZiBhIHNw
ZWNpZmljIGhhcmR3YXJlIHNwaW5sb2NrLiBUaGlzCglhbGxvd3MgdGhlIHN5c3RlbSB0byB1c2Ug
YSBzcGVjaWZpYyBzcGlubG9jaywgaWRlbnRpZmllZCBieSBhbiBJRC4gSWYKCXRoZSBJRCBpcyBp
bnZhbGlkIG9yIGlmIHRoZSBkZXNpcmVkIGxvY2sgaXMgYWxyZWFkeSBhbGxvY2F0ZWQsIHRoaXMK
CXdpbGwgcmV0dXJuIE5VTEwuICBPdGhlcndpc2UgaXQgcmV0dXJucyBhIHNwaW5sb2NrIGhhbmRs
ZS4KaW50IGh3c3BpbmxvY2tfZnJlZShzdHJ1Y3QgaHdzcGlubG9jayAqKTsKCUZyZWVzIGFuIGFs
bG9jYXRlZCBoYXJkd2FyZSBzcGlubG9jayAoZWl0aGVyIHJlc2VydmVkIG9yIHVucmVzZXJ2ZWQp
LgoKU2lnbmVkLW9mZi1ieTogU2ltb24gUXVlIDxzcXVlQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9t
YWNoLW9tYXAyL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgIDIgKwogYXJjaC9hcm0vbWFj
aC1vbWFwMi9od3NwaW5sb2Nrcy5jICAgICAgICAgICAgfCAgIDcxICsrKysrKwogYXJjaC9hcm0v
bWFjaC1vbWFwMi9vbWFwX2h3bW9kXzQ0eHhfZGF0YS5jICAgfCAgICAyICstCiBhcmNoL2FybS9w
bGF0LW9tYXAvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgIDMgKy0KIGFyY2gvYXJtL3Bs
YXQtb21hcC9od3NwaW5sb2NrLmMgICAgICAgICAgICAgIHwgIDI5NSArKysrKysrKysrKysrKysr
KysrKysrKysrKwogYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9od3NwaW5sb2NrLmgg
fCAgIDI5ICsrKwogYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwNDR4eC5oICAg
fCAgICAyICsKIDcgZmlsZXMgY2hhbmdlZCwgNDAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vbWFjaC1vbWFwMi9od3NwaW5sb2Nrcy5j
CiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYwogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdzcGlubG9j
ay5oCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtlZmlsZSBiL2FyY2gvYXJt
L21hY2gtb21hcDIvTWFrZWZpbGUKaW5kZXggNjcyNWIzYS4uNWY1Yzg3YiAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtlZmlsZQorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL01h
a2VmaWxlCkBAIC0xNzAsMyArMTcwLDUgQEAgb2JqLXkJCQkJCSs9ICQobmFuZC1tKSAkKG5hbmQt
eSkKIAogc21jOTF4LSQoQ09ORklHX1NNQzkxWCkJCQk6PSBncG1jLXNtYzkxeC5vCiBvYmoteQkJ
CQkJKz0gJChzbWM5MXgtbSkgJChzbWM5MXgteSkKKworb2JqLSQoQ09ORklHX0FSQ0hfT01BUDQp
CQkrPSBod3NwaW5sb2Nrcy5vClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9od3NwaW5sb2Nrcy5jIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9od3NwaW5sb2Nrcy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjU4YTY0
ODMKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2h3c3BpbmxvY2tzLmMK
QEAgLTAsMCArMSw3MSBAQAorLyoKKyAqIE9NQVAgaGFyZHdhcmUgc3BpbmxvY2sgZGV2aWNlIGlu
aXRpYWxpemF0aW9uCisgKgorICogQ29weXJpZ2h0IChDKSAyMDEwIFRleGFzIEluc3RydW1lbnRz
LiBBbGwgcmlnaHRzIHJlc2VydmVkLgorICoKKyAqIENvbnRhY3Q6IFNpbW9uIFF1ZSA8c3F1ZUB0
aS5jb20+CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVk
aXN0cmlidXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqIHZlcnNpb24gMiBhcyBwdWJsaXNoZWQgYnkg
dGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlz
dHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0CisgKiBXSVRI
T1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisg
KiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBT
ZWUgdGhlIEdOVQorICogR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgor
ICoKKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlCisgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0
ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4g
U3QsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BCisgKiAwMjExMC0xMzAxIFVTQQorICoKKyAqLwor
CisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+
CisjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KKyNp
bmNsdWRlIDxsaW51eC9pby5oPgorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKworI2luY2x1ZGUg
PHBsYXQvaHdzcGlubG9jay5oPgorI2luY2x1ZGUgPHBsYXQvb21hcF9kZXZpY2UuaD4KKyNpbmNs
dWRlIDxwbGF0L29tYXBfaHdtb2QuaD4KKworLyogU3BpbmxvY2sgcmVnaXN0ZXIgb2Zmc2V0cyAq
LworI2RlZmluZSBSRVZJU0lPTl9PRkZTRVQJCQkweDAwMDAKKyNkZWZpbmUgU1lTQ09ORklHX09G
RlNFVAkJMHgwMDEwCisjZGVmaW5lIFNZU1NUQVRVU19PRkZTRVQJCTB4MDAxNAorI2RlZmluZSBM
T0NLX0JBU0VfT0ZGU0VUCQkweDA4MDAKKyNkZWZpbmUgTE9DS19PRkZTRVQoaSkJCQkoTE9DS19C
QVNFX09GRlNFVCArIDB4NCAqIChpKSkKKworLyogSW5pdGlhbGl6YXRpb24gZnVuY3Rpb24gKi8K
K2ludCBfX2luaXQgaHdzcGlubG9ja3NfaW5pdCh2b2lkKQoreworCWludCByZXR2YWwgPSAwOwor
CisJc3RydWN0IGh3c3BpbmxvY2tfcGxhdF9pbmZvICpwZGF0YTsKKwlzdHJ1Y3Qgb21hcF9od21v
ZCAqb2g7CisJY2hhciAqb2hfbmFtZSwgKnBkZXZfbmFtZTsKKworCW9oX25hbWUgPSAic3Bpbmxv
Y2siOworCW9oID0gb21hcF9od21vZF9sb29rdXAob2hfbmFtZSk7CisJaWYgKFdBUk5fT04ob2gg
PT0gTlVMTCkpCisJCXJldHVybiAtRUlOVkFMOworCisJcGRldl9uYW1lID0gImh3c3BpbmxvY2si
OworCisJLyogUGFzcyBkYXRhIHRvIGRldmljZSBpbml0aWFsaXphdGlvbiAqLworCXBkYXRhID0g
a3phbGxvYyhzaXplb2Yoc3RydWN0IGh3c3BpbmxvY2tfcGxhdF9pbmZvKSwgR0ZQX0tFUk5FTCk7
CisJaWYgKFdBUk5fT04ocGRhdGEgPT0gTlVMTCkpCisJCXJldHVybiAtRU5PTUVNOworCXBkYXRh
LT5zeXNzdGF0dXNfb2Zmc2V0ID0gU1lTU1RBVFVTX09GRlNFVDsKKwlwZGF0YS0+bG9ja19iYXNl
X29mZnNldCA9IExPQ0tfQkFTRV9PRkZTRVQ7CisKKwlvbWFwX2RldmljZV9idWlsZChwZGV2X25h
bWUsIDAsIG9oLCBwZGF0YSwKKwkJCXNpemVvZihzdHJ1Y3QgaHdzcGlubG9ja19wbGF0X2luZm8p
LCBOVUxMLCAwLCBmYWxzZSk7CisKKwlyZXR1cm4gcmV0dmFsOworfQorbW9kdWxlX2luaXQoaHdz
cGlubG9ja3NfaW5pdCk7CisKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9o
d21vZF80NHh4X2RhdGEuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF80NHh4X2Rh
dGEuYwppbmRleCBkOGQ2ZDU4Li5jZTZjNWZmIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9t
YXAyL29tYXBfaHdtb2RfNDR4eF9kYXRhLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFw
X2h3bW9kXzQ0eHhfZGF0YS5jCkBAIC00ODc1LDcgKzQ4NzUsNyBAQCBzdGF0aWMgX19pbml0ZGF0
YSBzdHJ1Y3Qgb21hcF9od21vZCAqb21hcDQ0eHhfaHdtb2RzW10gPSB7CiAvKgkmb21hcDQ0eHhf
c21hcnRyZWZsZXhfaXZhX2h3bW9kLCAqLwogLyoJJm9tYXA0NHh4X3NtYXJ0cmVmbGV4X21wdV9o
d21vZCwgKi8KIAkvKiBzcGlubG9jayBjbGFzcyAqLwotLyoJJm9tYXA0NHh4X3NwaW5sb2NrX2h3
bW9kLCAqLworCSZvbWFwNDR4eF9zcGlubG9ja19od21vZCwKIAkvKiB0aW1lciBjbGFzcyAqLwog
CSZvbWFwNDR4eF90aW1lcjFfaHdtb2QsCiAJJm9tYXA0NHh4X3RpbWVyMl9od21vZCwKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9NYWtlZmlsZSBiL2FyY2gvYXJtL3BsYXQtb21hcC9N
YWtlZmlsZQppbmRleCBhMzdhYmY1Li5mNzI1YWZjIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0
LW9tYXAvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlCkBAIC0zMiw0
ICszMiw1IEBAIG9iai15ICs9ICQoaTJjLW9tYXAtbSkgJChpMmMtb21hcC15KQogb2JqLSQoQ09O
RklHX09NQVBfTUJPWF9GV0spICs9IG1haWxib3gubwogb2JqLSQoQ09ORklHX09NQVBfUkVNT1RF
X1BST0MpICs9IHJlbW90ZXByb2MubwogCi1vYmotJChDT05GSUdfT01BUF9QTV9OT09QKSArPSBv
bWFwLXBtLW5vb3AubwpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKK29iai0kKENPTkZJR19P
TUFQX1BNX05PT1ApICs9IG9tYXAtcG0tbm9vcC5vCitvYmotJChDT05GSUdfQVJDSF9PTUFQNCkg
Kz0gaHdzcGlubG9jay5vClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYyBiL2FyY2gvYXJtL3BsYXQtb21hcC9od3Nw
aW5sb2NrLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZWNhMWZjNwotLS0g
L2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9od3NwaW5sb2NrLmMKQEAgLTAsMCAr
MSwyOTUgQEAKKy8qCisgKiBPTUFQIGhhcmR3YXJlIHNwaW5sb2NrIGRyaXZlcgorICoKKyAqIENv
cHlyaWdodCAoQykgMjAxMCBUZXhhcyBJbnN0cnVtZW50cy4gQWxsIHJpZ2h0cyByZXNlcnZlZC4K
KyAqCisgKiBDb250YWN0OiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgorICoKKyAqIFRoaXMgcHJv
Z3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKKyAq
IG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlCisgKiB2ZXJzaW9uIDIgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb24uCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRo
YXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dAorICogV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhv
dXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJ
VE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUKKyAqIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUg
cmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogYWxv
bmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUK
KyAqIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0LCBGaWZ0aCBGbG9vciwgQm9zdG9u
LCBNQQorICogMDIxMTAtMTMwMSBVU0EKKyAqCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L21vZHVs
ZS5oPgorI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L2Rldmlj
ZS5oPgorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVkZSA8bGludXgvaW8uaD4KKyNp
bmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+CisjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2lu
Y2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+CisKKyNpbmNsdWRlIDxwbGF0L2h3c3BpbmxvY2suaD4K
KworLyogU3BpbmxvY2sgY291bnQgY29kZSAqLworI2RlZmluZSBTUElOTE9DS18zMl9SRUdTCQkx
CisjZGVmaW5lIFNQSU5MT0NLXzY0X1JFR1MJCTIKKyNkZWZpbmUgU1BJTkxPQ0tfMTI4X1JFR1MJ
CTQKKyNkZWZpbmUgU1BJTkxPQ0tfMjU2X1JFR1MJCTgKKyNkZWZpbmUgU1BJTkxPQ0tfTlVNTE9D
S1NfT0ZGU0VUCTI0CisKKy8qIGZvciBtYW5hZ2luZyBhIGhhcmR3YXJlIHNwaW5sb2NrIG1vZHVs
ZSAqLworc3RydWN0IGh3c3BpbmxvY2tfc3RhdGUgeworCWJvb2wgaXNfaW5pdDsJCQkvKiBGb3Ig
Zmlyc3QtdGltZSBpbml0aWFsaXphdGlvbiAqLworCWludCBudW1fbG9ja3M7CQkJLyogVG90YWwg
bnVtYmVyIG9mIGxvY2tzIGluIHN5c3RlbSAqLworCXNwaW5sb2NrX3QgbG9jYWxfbG9jazsJCS8q
IExvY2FsIHByb3RlY3Rpb24gKi8KKwl2b2lkIF9faW9tZW0gKmlvX2Jhc2U7CQkvKiBNYXBwZWQg
YmFzZSBhZGRyZXNzICovCit9OworCisvKiBQb2ludHMgdG8gdGhlIGhhcmR3YXJlIHNwaW5sb2Nr
IG1vZHVsZSAqLworc3RhdGljIHN0cnVjdCBod3NwaW5sb2NrX3N0YXRlIGh3c3BpbmxvY2tfc3Rh
dGU7CitzdGF0aWMgc3RydWN0IGh3c3BpbmxvY2tfc3RhdGUgKmh3c3BpbmxvY2tfbW9kdWxlID0g
Jmh3c3BpbmxvY2tfc3RhdGU7CisKKy8qIFNwaW5sb2NrIG9iamVjdCAqLworc3RydWN0IGh3c3Bp
bmxvY2sgeworCWJvb2wgaXNfaW5pdDsKKwlpbnQgaWQ7CisJdm9pZCBfX2lvbWVtICpsb2NrX3Jl
ZzsKKwlib29sIGlzX2FsbG9jYXRlZDsKKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Owor
fTsKKworLyogQXJyYXkgb2Ygc3BpbmxvY2tzICovCitzdGF0aWMgc3RydWN0IGh3c3BpbmxvY2sg
Kmh3c3BpbmxvY2tzOworCisvKiBBUEkgZnVuY3Rpb25zICovCisKKy8qIEJ1c3kgbG9vcCB0byBh
Y3F1aXJlIGEgc3BpbmxvY2sgKi8KK2ludCBod3NwaW5sb2NrX2xvY2soc3RydWN0IGh3c3Bpbmxv
Y2sgKmhhbmRsZSkKK3sKKwlpbnQgcmV0dmFsOworCisJaWYgKFdBUk5fT04oaGFuZGxlID09IE5V
TEwpKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWlmIChXQVJOX09OKGluX2lycSgpKSkKKwkJcmV0
dXJuIC1FUEVSTTsKKworCWlmIChwbV9ydW50aW1lX2dldCgmaGFuZGxlLT5wZGV2LT5kZXYpIDwg
MCkKKwkJcmV0dXJuIC1FTk9ERVY7CisKKwkvKiBBdHRlbXB0IHRvIGFjcXVpcmUgdGhlIGxvY2sg
YnkgcmVhZGluZyBmcm9tIGl0ICovCisJZG8geworCQlyZXR2YWwgPSByZWFkbChoYW5kbGUtPmxv
Y2tfcmVnKTsKKwl9IHdoaWxlIChyZXR2YWwgPT0gSFdTUElOTE9DS19CVVNZKTsKKworCXJldHVy
biAwOworfQorRVhQT1JUX1NZTUJPTChod3NwaW5sb2NrX2xvY2spOworCisvKiBBdHRlbXB0IHRv
IGFjcXVpcmUgYSBzcGlubG9jayBvbmNlICovCitpbnQgaHdzcGlubG9ja190cnlsb2NrKHN0cnVj
dCBod3NwaW5sb2NrICpoYW5kbGUpCit7CisJaW50IHJldHZhbCA9IDA7CisKKwlpZiAoV0FSTl9P
TihoYW5kbGUgPT0gTlVMTCkpCisJCXJldHVybiAtRUlOVkFMOworCisJaWYgKFdBUk5fT04oaW5f
aXJxKCkpKQorCQlyZXR1cm4gLUVQRVJNOworCisJaWYgKHBtX3J1bnRpbWVfZ2V0KCZoYW5kbGUt
PnBkZXYtPmRldikgPCAwKQorCQlyZXR1cm4gLUVOT0RFVjsKKworCS8qIEF0dGVtcHQgdG8gYWNx
dWlyZSB0aGUgbG9jayBieSByZWFkaW5nIGZyb20gaXQgKi8KKwlyZXR2YWwgPSByZWFkbChoYW5k
bGUtPmxvY2tfcmVnKTsKKworCWlmIChyZXR2YWwgPT0gSFdTUElOTE9DS19CVVNZKQorCQlwbV9y
dW50aW1lX3B1dCgmaGFuZGxlLT5wZGV2LT5kZXYpOworCisJcmV0dXJuIHJldHZhbDsKK30KK0VY
UE9SVF9TWU1CT0woaHdzcGlubG9ja190cnlsb2NrKTsKKworLyogUmVsZWFzZSBhIHNwaW5sb2Nr
ICovCitpbnQgaHdzcGlubG9ja191bmxvY2soc3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSkKK3sK
KwlpZiAoV0FSTl9PTihoYW5kbGUgPT0gTlVMTCkpCisJCXJldHVybiAtRUlOVkFMOworCisJLyog
UmVsZWFzZSBpdCBieSB3cml0aW5nIDAgdG8gaXQgKi8KKwl3cml0ZWwoMCwgaGFuZGxlLT5sb2Nr
X3JlZyk7CisKKwlwbV9ydW50aW1lX3B1dCgmaGFuZGxlLT5wZGV2LT5kZXYpOworCisJcmV0dXJu
IDA7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfdW5sb2NrKTsKKworLyogUmVxdWVzdCBh
biB1bmNsYWltZWQgc3BpbmxvY2sgKi8KK3N0cnVjdCBod3NwaW5sb2NrICpod3NwaW5sb2NrX3Jl
cXVlc3Qodm9pZCkKK3sKKwlpbnQgaTsKKwlib29sIGZvdW5kID0gZmFsc2U7CisJc3RydWN0IGh3
c3BpbmxvY2sgKmhhbmRsZSA9IE5VTEw7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKKworCXNwaW5f
bG9ja19pcnFzYXZlKCZod3NwaW5sb2NrX21vZHVsZS0+bG9jYWxfbG9jaywgZmxhZ3MpOworCS8q
IFNlYXJjaCBmb3IgYW4gdW5jbGFpbWVkLCB1bnJlc2VydmVkIGxvY2sgKi8KKwlmb3IgKGkgPSAw
OyBpIDwgaHdzcGlubG9ja19tb2R1bGUtPm51bV9sb2NrcyAmJiAhZm91bmQ7IGkrKykgeworCQlp
ZiAoIWh3c3BpbmxvY2tzW2ldLmlzX2FsbG9jYXRlZCkgeworCQkJZm91bmQgPSB0cnVlOworCQkJ
aGFuZGxlID0gJmh3c3BpbmxvY2tzW2ldOworCQl9CisJfQorCXNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmh3c3BpbmxvY2tfbW9kdWxlLT5sb2NhbF9sb2NrLCBmbGFncyk7CisKKwkvKiBSZXR1cm4g
ZXJyb3IgaWYgbm8gbW9yZSBsb2NrcyBhdmFpbGFibGUgKi8KKwlpZiAoIWZvdW5kKQorCQlyZXR1
cm4gTlVMTDsKKworCWhhbmRsZS0+aXNfYWxsb2NhdGVkID0gdHJ1ZTsKKworCXJldHVybiBoYW5k
bGU7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfcmVxdWVzdCk7CisKKy8qIFJlcXVlc3Qg
YW4gdW5jbGFpbWVkIHNwaW5sb2NrIGJ5IElEICovCitzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlu
bG9ja19yZXF1ZXN0X3NwZWNpZmljKHVuc2lnbmVkIGludCBpZCkKK3sKKwlzdHJ1Y3QgaHdzcGlu
bG9jayAqaGFuZGxlID0gTlVMTDsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCisJc3Bpbl9sb2Nr
X2lycXNhdmUoJmh3c3BpbmxvY2tfbW9kdWxlLT5sb2NhbF9sb2NrLCBmbGFncyk7CisKKwlpZiAo
V0FSTl9PTihod3NwaW5sb2Nrc1tpZF0uaXNfYWxsb2NhdGVkKSkKKwkJZ290byBleGl0OworCisJ
aGFuZGxlID0gJmh3c3BpbmxvY2tzW2lkXTsKKwloYW5kbGUtPmlzX2FsbG9jYXRlZCA9IHRydWU7
CisKK2V4aXQ6CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaHdzcGlubG9ja19tb2R1bGUtPmxv
Y2FsX2xvY2ssIGZsYWdzKTsKKwlyZXR1cm4gaGFuZGxlOworfQorRVhQT1JUX1NZTUJPTChod3Nw
aW5sb2NrX3JlcXVlc3Rfc3BlY2lmaWMpOworCisvKiBSZWxlYXNlIGEgY2xhaW1lZCBzcGlubG9j
ayAqLworaW50IGh3c3BpbmxvY2tfZnJlZShzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlKQorewor
CWlmIChXQVJOX09OKGhhbmRsZSA9PSBOVUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpZiAo
V0FSTl9PTighaGFuZGxlLT5pc19hbGxvY2F0ZWQpKQorCQlyZXR1cm4gLUVOT01FTTsKKworCWhh
bmRsZS0+aXNfYWxsb2NhdGVkID0gZmFsc2U7CisKKwlyZXR1cm4gMDsKK30KK0VYUE9SVF9TWU1C
T0woaHdzcGlubG9ja19mcmVlKTsKKworLyogUHJvYmUgZnVuY3Rpb24gKi8KK3N0YXRpYyBpbnQg
X19kZXZpbml0IGh3c3BpbmxvY2tfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
K3sKKwlzdHJ1Y3QgaHdzcGlubG9ja19wbGF0X2luZm8gKnBkYXRhID0gcGRldi0+ZGV2LnBsYXRm
b3JtX2RhdGE7CisJc3RydWN0IHJlc291cmNlICpyZXM7CisJdm9pZCBfX2lvbWVtICppb19iYXNl
OworCWludCBpZDsKKworCXZvaWQgX19pb21lbSAqc3lzc3RhdHVzX3JlZzsKKworCS8qIERldGVy
bWluZSBudW1iZXIgb2YgbG9ja3MgKi8KKwlzeXNzdGF0dXNfcmVnID0gaW9yZW1hcChPTUFQNDRY
WF9TUElOTE9DS19CQVNFICsKKwkJCQkJcGRhdGEtPnN5c3N0YXR1c19vZmZzZXQsIHNpemVvZih1
MzIpKTsKKwlzd2l0Y2ggKHJlYWRsKHN5c3N0YXR1c19yZWcpID4+IFNQSU5MT0NLX05VTUxPQ0tT
X09GRlNFVCkgeworCWNhc2UgU1BJTkxPQ0tfMzJfUkVHUzoKKwkJaHdzcGlubG9ja19tb2R1bGUt
Pm51bV9sb2NrcyA9IDMyOworCQlicmVhazsKKwljYXNlIFNQSU5MT0NLXzY0X1JFR1M6CisJCWh3
c3BpbmxvY2tfbW9kdWxlLT5udW1fbG9ja3MgPSA2NDsKKwkJYnJlYWs7CisJY2FzZSBTUElOTE9D
S18xMjhfUkVHUzoKKwkJaHdzcGlubG9ja19tb2R1bGUtPm51bV9sb2NrcyA9IDEyODsKKwkJYnJl
YWs7CisJY2FzZSBTUElOTE9DS18yNTZfUkVHUzoKKwkJaHdzcGlubG9ja19tb2R1bGUtPm51bV9s
b2NrcyA9IDI1NjsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJcmV0dXJuIC1FSU5WQUw7CS8qIElu
dmFsaWQgc3BpbmxvY2sgY291bnQgY29kZSAqLworCX0KKwlpb3VubWFwKHN5c3N0YXR1c19yZWcp
OworCisJLyogQWxsb2NhdGUgc3BpbmxvY2sgZGV2aWNlIG9iamVjdHMgKi8KKwlod3NwaW5sb2Nr
cyA9IGttYWxsb2Moc2l6ZW9mKHN0cnVjdCBod3NwaW5sb2NrKSAqCisJCQlod3NwaW5sb2NrX21v
ZHVsZS0+bnVtX2xvY2tzLCBHRlBfS0VSTkVMKTsKKwlpZiAoV0FSTl9PTihod3NwaW5sb2NrcyA9
PSBOVUxMKSkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwkvKiBJbml0aWFsaXplIGxvY2FsIGxvY2sg
Ki8KKwlzcGluX2xvY2tfaW5pdCgmaHdzcGlubG9ja19tb2R1bGUtPmxvY2FsX2xvY2spOworCisJ
LyogR2V0IGFkZHJlc3MgaW5mbyAqLworCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgMCk7CisKKwkvKiBNYXAgc3BpbmxvY2sgbW9kdWxlIGFkZHJlc3Mg
c3BhY2UgKi8KKwlpb19iYXNlID0gaW9yZW1hcChyZXMtPnN0YXJ0LCByZXNvdXJjZV9zaXplKHJl
cykpOworCWh3c3BpbmxvY2tfbW9kdWxlLT5pb19iYXNlID0gaW9fYmFzZTsKKworCS8qIFNldCB1
cCBlYWNoIGluZGl2aWR1YWwgbG9jayBoYW5kbGUgKi8KKwlmb3IgKGlkID0gMDsgaWQgPCBod3Nw
aW5sb2NrX21vZHVsZS0+bnVtX2xvY2tzOyBpZCsrKSB7CisJCWh3c3BpbmxvY2tzW2lkXS5pZAkJ
PSBpZDsKKwkJaHdzcGlubG9ja3NbaWRdLnBkZXYJCT0gcGRldjsKKworCQlod3NwaW5sb2Nrc1tp
ZF0uaXNfaW5pdAkJPSB0cnVlOworCQlod3NwaW5sb2Nrc1tpZF0uaXNfYWxsb2NhdGVkCT0gZmFs
c2U7CisKKwkJaHdzcGlubG9ja3NbaWRdLmxvY2tfcmVnCT0gaW9fYmFzZSArIHBkYXRhLT4KKwkJ
CQkJbG9ja19iYXNlX29mZnNldCArIHNpemVvZih1MzIpICogaWQ7CisJfQorCisJcmV0dXJuIDA7
Cit9CisKK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGh3c3BpbmxvY2tfZHJpdmVyID0g
eworCS5wcm9iZQkJPSBod3NwaW5sb2NrX3Byb2JlLAorCS5kcml2ZXIJCT0geworCQkubmFtZQk9
ICJod3NwaW5sb2NrIiwKKwl9LAorfTsKKworLyogSW5pdGlhbGl6YXRpb24gZnVuY3Rpb24gKi8K
K3N0YXRpYyBpbnQgX19pbml0IGh3c3BpbmxvY2tfaW5pdCh2b2lkKQoreworCWludCByZXR2YWwg
PSAwOworCisJLyogUmVnaXN0ZXIgc3BpbmxvY2sgZHJpdmVyICovCisJcmV0dmFsID0gcGxhdGZv
cm1fZHJpdmVyX3JlZ2lzdGVyKCZod3NwaW5sb2NrX2RyaXZlcik7CisKKwlyZXR1cm4gcmV0dmFs
OworfQorCisvKiBDbGVhbnVwIGZ1bmN0aW9uICovCitzdGF0aWMgdm9pZCBfX2V4aXQgaHdzcGlu
bG9ja19leGl0KHZvaWQpCit7CisJaW50IGlkOworCisJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0
ZXIoJmh3c3BpbmxvY2tfZHJpdmVyKTsKKworCWZvciAoaWQgPSAwOyBpZCA8IGh3c3BpbmxvY2tf
bW9kdWxlLT5udW1fbG9ja3M7IGlkKyspCisJCWh3c3BpbmxvY2tzW2lkXS5pc19pbml0ID0gZmFs
c2U7CisJaW91bm1hcChod3NwaW5sb2NrX21vZHVsZS0+aW9fYmFzZSk7CisKKwkvKiBGcmVlIHNw
aW5sb2NrIGRldmljZSBvYmplY3RzICovCisJaWYgKGh3c3BpbmxvY2tfbW9kdWxlLT5pc19pbml0
KQorCQlrZnJlZShod3NwaW5sb2Nrcyk7Cit9CisKK21vZHVsZV9pbml0KGh3c3BpbmxvY2tfaW5p
dCk7Cittb2R1bGVfZXhpdChod3NwaW5sb2NrX2V4aXQpOworCitNT0RVTEVfTElDRU5TRSgiR1BM
IHYyIik7CitNT0RVTEVfREVTQ1JJUFRJT04oIkhhcmR3YXJlIHNwaW5sb2NrIGRyaXZlciIpOwor
TU9EVUxFX0FVVEhPUigiU2ltb24gUXVlIik7CitNT0RVTEVfQVVUSE9SKCJIYXJpIEthbmlnZXJp
Iik7CmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2h3c3Bpbmxv
Y2suaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdzcGlubG9jay5oCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjhjNjljYTUKLS0tIC9kZXYvbnVsbAorKysg
Yi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2h3c3BpbmxvY2suaApAQCAtMCwwICsx
LDI5IEBACisvKiBod3NwaW5sb2NrLmggKi8KKworI2lmbmRlZiBIV1NQSU5MT0NLX0gKKyNkZWZp
bmUgSFdTUElOTE9DS19ICisKKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNp
bmNsdWRlIDxwbGF0L29tYXA0NHh4Lmg+CisKKy8qIFJlYWQgdmFsdWVzIGZyb20gdGhlIHNwaW5s
b2NrIHJlZ2lzdGVyICovCisjZGVmaW5lIEhXU1BJTkxPQ0tfQUNRVUlSRUQgMAorI2RlZmluZSBI
V1NQSU5MT0NLX0JVU1kgMQorCisvKiBEZXZpY2UgZGF0YSAqLworc3RydWN0IGh3c3BpbmxvY2tf
cGxhdF9pbmZvIHsKKwl1MzIgc3lzc3RhdHVzX29mZnNldDsJCS8qIFN5c3RlbSBzdGF0dXMgcmVn
aXN0ZXIgb2Zmc2V0ICovCisJdTMyIGxvY2tfYmFzZV9vZmZzZXQ7CQkvKiBPZmZzZXQgb2Ygc3Bp
bmxvY2sgcmVnaXN0ZXJzICovCit9OworCitzdHJ1Y3QgaHdzcGlubG9jazsKKworaW50IGh3c3Bp
bmxvY2tfbG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlKTsKK2ludCBod3NwaW5sb2NrX3Ry
eWxvY2soc3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSk7CitpbnQgaHdzcGlubG9ja191bmxvY2so
c3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSk7CisKK3N0cnVjdCBod3NwaW5sb2NrICpod3NwaW5s
b2NrX3JlcXVlc3Qodm9pZCk7CitzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19yZXF1ZXN0
X3NwZWNpZmljKHVuc2lnbmVkIGludCBpZCk7CitpbnQgaHdzcGlubG9ja19mcmVlKHN0cnVjdCBo
d3NwaW5sb2NrICpod3NwaW5sb2NrX3B0cik7CisKKyNlbmRpZiAvKiBIV1NQSU5MT0NLX0ggKi8K
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvb21hcDQ0eHguaCBi
L2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvb21hcDQ0eHguaAppbmRleCA4YjNmMTJm
Li44MDE2NTA4IDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L29t
YXA0NHh4LmgKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwNDR4eC5o
CkBAIC01Miw1ICs1Miw3IEBACiAjZGVmaW5lIE9NQVA0X01NVTFfQkFTRQkJCTB4NTUwODIwMDAK
ICNkZWZpbmUgT01BUDRfTU1VMl9CQVNFCQkJMHg0QTA2NjAwMAogCisjZGVmaW5lIE9NQVA0NFhY
X1NQSU5MT0NLX0JBU0UJCShMNF80NFhYX0JBU0UgKyAweEY2MDAwKQorCiAjZW5kaWYgLyogX19B
U01fQVJDSF9PTUFQNDRYWF9IICovCiAKLS0gCjEuNy4wCgo=

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0Fdlee03entticom_--
