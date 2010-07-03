From: "Que, Simon" <sque@ti.com>
Subject: [RFC v.3] omap: hwspinlock: Added hwspinlock driver
Date: Fri, 2 Jul 2010 19:19:07 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1474EA6A1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E1474EA6A1dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55419 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab0GCATJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Jul 2010 20:19:09 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1474EA6A1dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I have updated my draft of the spinlock driver patch based on feedback from=
 the Linux-OMAP community.

The changes I have made since RFC v.2:
- Only one device initialization per IP (in this case, OMAP4) -- this means=
 the driver's probe func will only be called once.
- Spinlock address is obtained by calling platform_get_resource from driver=
, and ioremapped by driver.  This makes better use of hwmod.
- Device initialization only provides spinlock register offsets, not mapped=
 or raw addresses.
- Determining number of locks and lock register addresses is done in driver=
, not device init.
- Calling pm_runtime_get and pm_runtime_put when acquiring/releasing lock.
- Fixed file header comment: hwspinlocks.c should be called "device initial=
ization" not "driver"

Please see attached patch or inline patch below, and provide feedback.  I h=
ope to submit the finalized patch on Tuesday July 6.

Thanks,
Simon

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>From 86223480bb46177b4c625b01122d0a4f40eb95c0 Mon Sep 17 00:00:00 2001
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
 arch/arm/mach-omap2/hwspinlocks.c            |   72 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
 arch/arm/plat-omap/Makefile                  |    3 +-
 arch/arm/plat-omap/hwspinlock.c              |  298 ++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/hwspinlock.h |   29 +++
 arch/arm/plat-omap/include/plat/omap44xx.h   |    2 +
 7 files changed, 406 insertions(+), 2 deletions(-)
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
index 0000000..f0b212b
--- /dev/null
+++ b/arch/arm/mach-omap2/hwspinlocks.c
@@ -0,0 +1,72 @@
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
+
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
index 0000000..7cfd2c0
--- /dev/null
+++ b/arch/arm/plat-omap/hwspinlock.c
@@ -0,0 +1,298 @@
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
+       if (WARN_ON(in_atomic() || in_irq()))
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
+       if (retval =3D=3D HWSPINLOCK_BUSY)
+               pm_runtime_put(&handle->pdev->dev);
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
+       if (WARN_ON(in_atomic() || in_irq()))
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


--_002_F39349C6FA641B4A831B7BF4EBF4D4E1474EA6A1dlee03entticom_
Content-Type: application/octet-stream;
	name="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"
Content-Description: 0001-omap-hwspinlock-Added-hwspinlock-driver.patch
Content-Disposition: attachment;
	filename="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"; size=15588;
	creation-date="Fri, 02 Jul 2010 19:20:24 GMT";
	modification-date="Fri, 02 Jul 2010 19:20:24 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NjIyMzQ4MGJiNDYxNzdiNGM2MjViMDExMjJkMGE0ZjQwZWI5NWMwIE1vbiBTZXAgMTcg
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
aC1vbWFwMi9od3NwaW5sb2Nrcy5jICAgICAgICAgICAgfCAgIDcyICsrKysrKwogYXJjaC9hcm0v
bWFjaC1vbWFwMi9vbWFwX2h3bW9kXzQ0eHhfZGF0YS5jICAgfCAgICAyICstCiBhcmNoL2FybS9w
bGF0LW9tYXAvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgIDMgKy0KIGFyY2gvYXJtL3Bs
YXQtb21hcC9od3NwaW5sb2NrLmMgICAgICAgICAgICAgIHwgIDI5OCArKysrKysrKysrKysrKysr
KysrKysrKysrKwogYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9od3NwaW5sb2NrLmgg
fCAgIDI5ICsrKwogYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwNDR4eC5oICAg
fCAgICAyICsKIDcgZmlsZXMgY2hhbmdlZCwgNDA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
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
Mi9od3NwaW5sb2Nrcy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmYwYjIx
MmIKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2h3c3BpbmxvY2tzLmMK
QEAgLTAsMCArMSw3MiBAQAorLyoKKyAqIE9NQVAgaGFyZHdhcmUgc3BpbmxvY2sgZGV2aWNlIGlu
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
PHBsYXQvaHdzcGlubG9jay5oPgorCisjaW5jbHVkZSA8cGxhdC9vbWFwX2RldmljZS5oPgorI2lu
Y2x1ZGUgPHBsYXQvb21hcF9od21vZC5oPgorCisvKiBTcGlubG9jayByZWdpc3RlciBvZmZzZXRz
ICovCisjZGVmaW5lIFJFVklTSU9OX09GRlNFVAkJCTB4MDAwMAorI2RlZmluZSBTWVNDT05GSUdf
T0ZGU0VUCQkweDAwMTAKKyNkZWZpbmUgU1lTU1RBVFVTX09GRlNFVAkJMHgwMDE0CisjZGVmaW5l
IExPQ0tfQkFTRV9PRkZTRVQJCTB4MDgwMAorI2RlZmluZSBMT0NLX09GRlNFVChpKQkJCShMT0NL
X0JBU0VfT0ZGU0VUICsgMHg0ICogKGkpKQorCisvKiBJbml0aWFsaXphdGlvbiBmdW5jdGlvbiAq
LworaW50IF9faW5pdCBod3NwaW5sb2Nrc19pbml0KHZvaWQpCit7CisJaW50IHJldHZhbCA9IDA7
CisKKwlzdHJ1Y3QgaHdzcGlubG9ja19wbGF0X2luZm8gKnBkYXRhOworCXN0cnVjdCBvbWFwX2h3
bW9kICpvaDsKKwljaGFyICpvaF9uYW1lLCAqcGRldl9uYW1lOworCisJb2hfbmFtZSA9ICJzcGlu
bG9jayI7CisJb2ggPSBvbWFwX2h3bW9kX2xvb2t1cChvaF9uYW1lKTsKKwlpZiAoV0FSTl9PTihv
aCA9PSBOVUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlwZGV2X25hbWUgPSAiaHdzcGlubG9j
ayI7CisKKwkvKiBQYXNzIGRhdGEgdG8gZGV2aWNlIGluaXRpYWxpemF0aW9uICovCisJcGRhdGEg
PSBremFsbG9jKHNpemVvZihzdHJ1Y3QgaHdzcGlubG9ja19wbGF0X2luZm8pLCBHRlBfS0VSTkVM
KTsKKwlpZiAoV0FSTl9PTihwZGF0YSA9PSBOVUxMKSkKKwkJcmV0dXJuIC1FTk9NRU07CisJcGRh
dGEtPnN5c3N0YXR1c19vZmZzZXQgPSBTWVNTVEFUVVNfT0ZGU0VUOworCXBkYXRhLT5sb2NrX2Jh
c2Vfb2Zmc2V0ID0gTE9DS19CQVNFX09GRlNFVDsKKworCW9tYXBfZGV2aWNlX2J1aWxkKHBkZXZf
bmFtZSwgMCwgb2gsIHBkYXRhLAorCQkJc2l6ZW9mKHN0cnVjdCBod3NwaW5sb2NrX3BsYXRfaW5m
byksIE5VTEwsIDAsIGZhbHNlKTsKKworCXJldHVybiByZXR2YWw7Cit9Cittb2R1bGVfaW5pdCho
d3NwaW5sb2Nrc19pbml0KTsKKwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFw
X2h3bW9kXzQ0eHhfZGF0YS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9kXzQ0eHhf
ZGF0YS5jCmluZGV4IGQ4ZDZkNTguLmNlNmM1ZmYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gt
b21hcDIvb21hcF9od21vZF80NHh4X2RhdGEuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL29t
YXBfaHdtb2RfNDR4eF9kYXRhLmMKQEAgLTQ4NzUsNyArNDg3NSw3IEBAIHN0YXRpYyBfX2luaXRk
YXRhIHN0cnVjdCBvbWFwX2h3bW9kICpvbWFwNDR4eF9od21vZHNbXSA9IHsKIC8qCSZvbWFwNDR4
eF9zbWFydHJlZmxleF9pdmFfaHdtb2QsICovCiAvKgkmb21hcDQ0eHhfc21hcnRyZWZsZXhfbXB1
X2h3bW9kLCAqLwogCS8qIHNwaW5sb2NrIGNsYXNzICovCi0vKgkmb21hcDQ0eHhfc3BpbmxvY2tf
aHdtb2QsICovCisJJm9tYXA0NHh4X3NwaW5sb2NrX2h3bW9kLAogCS8qIHRpbWVyIGNsYXNzICov
CiAJJm9tYXA0NHh4X3RpbWVyMV9od21vZCwKIAkmb21hcDQ0eHhfdGltZXIyX2h3bW9kLApkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlIGIvYXJjaC9hcm0vcGxhdC1vbWFw
L01ha2VmaWxlCmluZGV4IGEzN2FiZjUuLmY3MjVhZmMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3Bs
YXQtb21hcC9NYWtlZmlsZQorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvTWFrZWZpbGUKQEAgLTMy
LDQgKzMyLDUgQEAgb2JqLXkgKz0gJChpMmMtb21hcC1tKSAkKGkyYy1vbWFwLXkpCiBvYmotJChD
T05GSUdfT01BUF9NQk9YX0ZXSykgKz0gbWFpbGJveC5vCiBvYmotJChDT05GSUdfT01BUF9SRU1P
VEVfUFJPQykgKz0gcmVtb3RlcHJvYy5vCiAKLW9iai0kKENPTkZJR19PTUFQX1BNX05PT1ApICs9
IG9tYXAtcG0tbm9vcC5vClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQorb2JqLSQoQ09ORklH
X09NQVBfUE1fTk9PUCkgKz0gb21hcC1wbS1ub29wLm8KK29iai0kKENPTkZJR19BUkNIX09NQVA0
KSArPSBod3NwaW5sb2NrLm8KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9wbGF0LW9tYXAvaHdzcGlubG9jay5jIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2h3
c3BpbmxvY2suYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi43Y2ZkMmMwCi0t
LSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYwpAQCAtMCww
ICsxLDI5OCBAQAorLyoKKyAqIE9NQVAgaGFyZHdhcmUgc3BpbmxvY2sgZHJpdmVyCisgKgorICog
Q29weXJpZ2h0IChDKSAyMDEwIFRleGFzIEluc3RydW1lbnRzLiBBbGwgcmlnaHRzIHJlc2VydmVk
LgorICoKKyAqIENvbnRhY3Q6IFNpbW9uIFF1ZSA8c3F1ZUB0aS5jb20+CisgKgorICogVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgor
ICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UKKyAqIHZlcnNpb24gMiBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0CisgKiBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0
aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3Ig
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlIEdOVQorICogR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQgaGF2
ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBh
bG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2Fy
ZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0
b24sIE1BCisgKiAwMjExMC0xMzAxIFVTQQorICoKKyAqLworCisjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvZGV2
aWNlLmg+CisjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5oPgor
I2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cisj
aW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KKworI2luY2x1ZGUgPHBsYXQvaHdzcGlubG9jay5o
PgorCisvKiBTcGlubG9jayBjb3VudCBjb2RlICovCisjZGVmaW5lIFNQSU5MT0NLXzMyX1JFR1MJ
CTEKKyNkZWZpbmUgU1BJTkxPQ0tfNjRfUkVHUwkJMgorI2RlZmluZSBTUElOTE9DS18xMjhfUkVH
UwkJNAorI2RlZmluZSBTUElOTE9DS18yNTZfUkVHUwkJOAorI2RlZmluZSBTUElOTE9DS19OVU1M
T0NLU19PRkZTRVQJMjQKKworLyogZm9yIG1hbmFnaW5nIGEgaGFyZHdhcmUgc3BpbmxvY2sgbW9k
dWxlICovCitzdHJ1Y3QgaHdzcGlubG9ja19zdGF0ZSB7CisJYm9vbCBpc19pbml0OwkJCS8qIEZv
ciBmaXJzdC10aW1lIGluaXRpYWxpemF0aW9uICovCisJaW50IG51bV9sb2NrczsJCQkvKiBUb3Rh
bCBudW1iZXIgb2YgbG9ja3MgaW4gc3lzdGVtICovCisJc3BpbmxvY2tfdCBsb2NhbF9sb2NrOwkJ
LyogTG9jYWwgcHJvdGVjdGlvbiAqLworCXZvaWQgX19pb21lbSAqaW9fYmFzZTsJCS8qIE1hcHBl
ZCBiYXNlIGFkZHJlc3MgKi8KK307CisKKy8qIFBvaW50cyB0byB0aGUgaGFyZHdhcmUgc3Bpbmxv
Y2sgbW9kdWxlICovCitzdGF0aWMgc3RydWN0IGh3c3BpbmxvY2tfc3RhdGUgaHdzcGlubG9ja19z
dGF0ZTsKK3N0YXRpYyBzdHJ1Y3QgaHdzcGlubG9ja19zdGF0ZSAqaHdzcGlubG9ja19tb2R1bGUg
PSAmaHdzcGlubG9ja19zdGF0ZTsKKworLyogU3BpbmxvY2sgb2JqZWN0ICovCitzdHJ1Y3QgaHdz
cGlubG9jayB7CisJYm9vbCBpc19pbml0OworCWludCBpZDsKKwl2b2lkIF9faW9tZW0gKmxvY2tf
cmVnOworCWJvb2wgaXNfYWxsb2NhdGVkOworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7
Cit9OworCisvKiBBcnJheSBvZiBzcGlubG9ja3MgKi8KK3N0YXRpYyBzdHJ1Y3QgaHdzcGlubG9j
ayAqaHdzcGlubG9ja3M7CisKKy8qIEFQSSBmdW5jdGlvbnMgKi8KKworLyogQnVzeSBsb29wIHRv
IGFjcXVpcmUgYSBzcGlubG9jayAqLworaW50IGh3c3BpbmxvY2tfbG9jayhzdHJ1Y3QgaHdzcGlu
bG9jayAqaGFuZGxlKQoreworCWludCByZXR2YWw7CisKKwlpZiAoV0FSTl9PTihoYW5kbGUgPT0g
TlVMTCkpCisJCXJldHVybiAtRUlOVkFMOworCisJaWYgKFdBUk5fT04oaW5fYXRvbWljKCkgfHwg
aW5faXJxKCkpKQorCQlyZXR1cm4gLUVQRVJNOworCisJaWYgKHBtX3J1bnRpbWVfZ2V0KCZoYW5k
bGUtPnBkZXYtPmRldikgPCAwKQorCQlyZXR1cm4gLUVOT0RFVjsKKworCS8qIEF0dGVtcHQgdG8g
YWNxdWlyZSB0aGUgbG9jayBieSByZWFkaW5nIGZyb20gaXQgKi8KKwlkbyB7CisJCXJldHZhbCA9
IHJlYWRsKGhhbmRsZS0+bG9ja19yZWcpOworCX0gd2hpbGUgKHJldHZhbCA9PSBIV1NQSU5MT0NL
X0JVU1kpOworCisJaWYgKHJldHZhbCA9PSBIV1NQSU5MT0NLX0JVU1kpCisJCXBtX3J1bnRpbWVf
cHV0KCZoYW5kbGUtPnBkZXYtPmRldik7CisKKwlyZXR1cm4gMDsKK30KK0VYUE9SVF9TWU1CT0wo
aHdzcGlubG9ja19sb2NrKTsKKworLyogQXR0ZW1wdCB0byBhY3F1aXJlIGEgc3BpbmxvY2sgb25j
ZSAqLworaW50IGh3c3BpbmxvY2tfdHJ5bG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlKQor
eworCWludCByZXR2YWwgPSAwOworCisJaWYgKFdBUk5fT04oaGFuZGxlID09IE5VTEwpKQorCQly
ZXR1cm4gLUVJTlZBTDsKKworCWlmIChXQVJOX09OKGluX2F0b21pYygpIHx8IGluX2lycSgpKSkK
KwkJcmV0dXJuIC1FUEVSTTsKKworCWlmIChwbV9ydW50aW1lX2dldCgmaGFuZGxlLT5wZGV2LT5k
ZXYpIDwgMCkKKwkJcmV0dXJuIC1FTk9ERVY7CisKKwkvKiBBdHRlbXB0IHRvIGFjcXVpcmUgdGhl
IGxvY2sgYnkgcmVhZGluZyBmcm9tIGl0ICovCisJcmV0dmFsID0gcmVhZGwoaGFuZGxlLT5sb2Nr
X3JlZyk7CisKKwlpZiAocmV0dmFsID09IEhXU1BJTkxPQ0tfQlVTWSkKKwkJcG1fcnVudGltZV9w
dXQoJmhhbmRsZS0+cGRldi0+ZGV2KTsKKworCXJldHVybiByZXR2YWw7Cit9CitFWFBPUlRfU1lN
Qk9MKGh3c3BpbmxvY2tfdHJ5bG9jayk7CisKKy8qIFJlbGVhc2UgYSBzcGlubG9jayAqLworaW50
IGh3c3BpbmxvY2tfdW5sb2NrKHN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUpCit7CisJaWYgKFdB
Uk5fT04oaGFuZGxlID09IE5VTEwpKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCS8qIFJlbGVhc2Ug
aXQgYnkgd3JpdGluZyAwIHRvIGl0ICovCisJd3JpdGVsKDAsIGhhbmRsZS0+bG9ja19yZWcpOwor
CisJcG1fcnVudGltZV9wdXQoJmhhbmRsZS0+cGRldi0+ZGV2KTsKKworCXJldHVybiAwOworfQor
RVhQT1JUX1NZTUJPTChod3NwaW5sb2NrX3VubG9jayk7CisKKy8qIFJlcXVlc3QgYW4gdW5jbGFp
bWVkIHNwaW5sb2NrICovCitzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19yZXF1ZXN0KHZv
aWQpCit7CisJaW50IGk7CisJYm9vbCBmb3VuZCA9IGZhbHNlOworCXN0cnVjdCBod3NwaW5sb2Nr
ICpoYW5kbGUgPSBOVUxMOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKKwlzcGluX2xvY2tfaXJx
c2F2ZSgmaHdzcGlubG9ja19tb2R1bGUtPmxvY2FsX2xvY2ssIGZsYWdzKTsKKwkvKiBTZWFyY2gg
Zm9yIGFuIHVuY2xhaW1lZCwgdW5yZXNlcnZlZCBsb2NrICovCisJZm9yIChpID0gMDsgaSA8IGh3
c3BpbmxvY2tfbW9kdWxlLT5udW1fbG9ja3MgJiYgIWZvdW5kOyBpKyspIHsKKwkJaWYgKCFod3Nw
aW5sb2Nrc1tpXS5pc19hbGxvY2F0ZWQpIHsKKwkJCWZvdW5kID0gdHJ1ZTsKKwkJCWhhbmRsZSA9
ICZod3NwaW5sb2Nrc1tpXTsKKwkJfQorCX0KKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZod3Nw
aW5sb2NrX21vZHVsZS0+bG9jYWxfbG9jaywgZmxhZ3MpOworCisJLyogUmV0dXJuIGVycm9yIGlm
IG5vIG1vcmUgbG9ja3MgYXZhaWxhYmxlICovCisJaWYgKCFmb3VuZCkKKwkJcmV0dXJuIE5VTEw7
CisKKwloYW5kbGUtPmlzX2FsbG9jYXRlZCA9IHRydWU7CisKKwlyZXR1cm4gaGFuZGxlOworfQor
RVhQT1JUX1NZTUJPTChod3NwaW5sb2NrX3JlcXVlc3QpOworCisvKiBSZXF1ZXN0IGFuIHVuY2xh
aW1lZCBzcGlubG9jayBieSBJRCAqLworc3RydWN0IGh3c3BpbmxvY2sgKmh3c3BpbmxvY2tfcmVx
dWVzdF9zcGVjaWZpYyh1bnNpZ25lZCBpbnQgaWQpCit7CisJc3RydWN0IGh3c3BpbmxvY2sgKmhh
bmRsZSA9IE5VTEw7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKKworCXNwaW5fbG9ja19pcnFzYXZl
KCZod3NwaW5sb2NrX21vZHVsZS0+bG9jYWxfbG9jaywgZmxhZ3MpOworCisJaWYgKFdBUk5fT04o
aHdzcGlubG9ja3NbaWRdLmlzX2FsbG9jYXRlZCkpCisJCWdvdG8gZXhpdDsKKworCWhhbmRsZSA9
ICZod3NwaW5sb2Nrc1tpZF07CisJaGFuZGxlLT5pc19hbGxvY2F0ZWQgPSB0cnVlOworCitleGl0
OgorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmh3c3BpbmxvY2tfbW9kdWxlLT5sb2NhbF9sb2Nr
LCBmbGFncyk7CisJcmV0dXJuIGhhbmRsZTsKK30KK0VYUE9SVF9TWU1CT0woaHdzcGlubG9ja19y
ZXF1ZXN0X3NwZWNpZmljKTsKKworLyogUmVsZWFzZSBhIGNsYWltZWQgc3BpbmxvY2sgKi8KK2lu
dCBod3NwaW5sb2NrX2ZyZWUoc3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSkKK3sKKwlpZiAoV0FS
Tl9PTihoYW5kbGUgPT0gTlVMTCkpCisJCXJldHVybiAtRUlOVkFMOworCisJaWYgKFdBUk5fT04o
IWhhbmRsZS0+aXNfYWxsb2NhdGVkKSkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwloYW5kbGUtPmlz
X2FsbG9jYXRlZCA9IGZhbHNlOworCisJcmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3Bp
bmxvY2tfZnJlZSk7CisKKy8qIFByb2JlIGZ1bmN0aW9uICovCitzdGF0aWMgaW50IF9fZGV2aW5p
dCBod3NwaW5sb2NrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3Ry
dWN0IGh3c3BpbmxvY2tfcGxhdF9pbmZvICpwZGF0YSA9IHBkZXYtPmRldi5wbGF0Zm9ybV9kYXRh
OworCXN0cnVjdCByZXNvdXJjZSAqcmVzOworCXZvaWQgX19pb21lbSAqaW9fYmFzZTsKKwlpbnQg
aWQ7CisKKwl2b2lkIF9faW9tZW0gKnN5c3N0YXR1c19yZWc7CisKKwkvKiBEZXRlcm1pbmUgbnVt
YmVyIG9mIGxvY2tzICovCisJc3lzc3RhdHVzX3JlZyA9IGlvcmVtYXAoT01BUDQ0WFhfU1BJTkxP
Q0tfQkFTRSArCisJCQkJCXBkYXRhLT5zeXNzdGF0dXNfb2Zmc2V0LCBzaXplb2YodTMyKSk7CisJ
c3dpdGNoIChyZWFkbChzeXNzdGF0dXNfcmVnKSA+PiBTUElOTE9DS19OVU1MT0NLU19PRkZTRVQp
IHsKKwljYXNlIFNQSU5MT0NLXzMyX1JFR1M6CisJCWh3c3BpbmxvY2tfbW9kdWxlLT5udW1fbG9j
a3MgPSAzMjsKKwkJYnJlYWs7CisJY2FzZSBTUElOTE9DS182NF9SRUdTOgorCQlod3NwaW5sb2Nr
X21vZHVsZS0+bnVtX2xvY2tzID0gNjQ7CisJCWJyZWFrOworCWNhc2UgU1BJTkxPQ0tfMTI4X1JF
R1M6CisJCWh3c3BpbmxvY2tfbW9kdWxlLT5udW1fbG9ja3MgPSAxMjg7CisJCWJyZWFrOworCWNh
c2UgU1BJTkxPQ0tfMjU2X1JFR1M6CisJCWh3c3BpbmxvY2tfbW9kdWxlLT5udW1fbG9ja3MgPSAy
NTY7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXJldHVybiAtRUlOVkFMOwkvKiBJbnZhbGlkIHNw
aW5sb2NrIGNvdW50IGNvZGUgKi8KKwl9CisJaW91bm1hcChzeXNzdGF0dXNfcmVnKTsKKworCS8q
IEFsbG9jYXRlIHNwaW5sb2NrIGRldmljZSBvYmplY3RzICovCisJaHdzcGlubG9ja3MgPSBrbWFs
bG9jKHNpemVvZihzdHJ1Y3QgaHdzcGlubG9jaykgKgorCQkJaHdzcGlubG9ja19tb2R1bGUtPm51
bV9sb2NrcywgR0ZQX0tFUk5FTCk7CisJaWYgKFdBUk5fT04oaHdzcGlubG9ja3MgPT0gTlVMTCkp
CisJCXJldHVybiAtRU5PTUVNOworCisJLyogSW5pdGlhbGl6ZSBsb2NhbCBsb2NrICovCisJc3Bp
bl9sb2NrX2luaXQoJmh3c3BpbmxvY2tfbW9kdWxlLT5sb2NhbF9sb2NrKTsKKworCS8qIEdldCBh
ZGRyZXNzIGluZm8gKi8KKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNP
VVJDRV9NRU0sIDApOworCisJLyogTWFwIHNwaW5sb2NrIG1vZHVsZSBhZGRyZXNzIHNwYWNlICov
CisJaW9fYmFzZSA9IGlvcmVtYXAocmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsKKwlo
d3NwaW5sb2NrX21vZHVsZS0+aW9fYmFzZSA9IGlvX2Jhc2U7CisKKwkvKiBTZXQgdXAgZWFjaCBp
bmRpdmlkdWFsIGxvY2sgaGFuZGxlICovCisJZm9yIChpZCA9IDA7IGlkIDwgaHdzcGlubG9ja19t
b2R1bGUtPm51bV9sb2NrczsgaWQrKykgeworCQlod3NwaW5sb2Nrc1tpZF0uaWQJCT0gaWQ7CisJ
CWh3c3BpbmxvY2tzW2lkXS5wZGV2CQk9IHBkZXY7CisKKwkJaHdzcGlubG9ja3NbaWRdLmlzX2lu
aXQJCT0gdHJ1ZTsKKwkJaHdzcGlubG9ja3NbaWRdLmlzX2FsbG9jYXRlZAk9IGZhbHNlOworCisJ
CWh3c3BpbmxvY2tzW2lkXS5sb2NrX3JlZwk9IGlvX2Jhc2UgKyBwZGF0YS0+CisJCQkJCWxvY2tf
YmFzZV9vZmZzZXQgKyBzaXplb2YodTMyKSAqIGlkOworCX0KKworCXJldHVybiAwOworfQorCitz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBod3NwaW5sb2NrX2RyaXZlciA9IHsKKwkucHJv
YmUJCT0gaHdzcGlubG9ja19wcm9iZSwKKwkuZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSAiaHdzcGlu
bG9jayIsCisJfSwKK307CisKKy8qIEluaXRpYWxpemF0aW9uIGZ1bmN0aW9uICovCitzdGF0aWMg
aW50IF9faW5pdCBod3NwaW5sb2NrX2luaXQodm9pZCkKK3sKKwlpbnQgcmV0dmFsID0gMDsKKwor
CS8qIFJlZ2lzdGVyIHNwaW5sb2NrIGRyaXZlciAqLworCXJldHZhbCA9IHBsYXRmb3JtX2RyaXZl
cl9yZWdpc3RlcigmaHdzcGlubG9ja19kcml2ZXIpOworCisJcmV0dXJuIHJldHZhbDsKK30KKwor
LyogQ2xlYW51cCBmdW5jdGlvbiAqLworc3RhdGljIHZvaWQgX19leGl0IGh3c3BpbmxvY2tfZXhp
dCh2b2lkKQoreworCWludCBpZDsKKworCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZod3Nw
aW5sb2NrX2RyaXZlcik7CisKKwlmb3IgKGlkID0gMDsgaWQgPCBod3NwaW5sb2NrX21vZHVsZS0+
bnVtX2xvY2tzOyBpZCsrKQorCQlod3NwaW5sb2Nrc1tpZF0uaXNfaW5pdCA9IGZhbHNlOworCWlv
dW5tYXAoaHdzcGlubG9ja19tb2R1bGUtPmlvX2Jhc2UpOworCisJLyogRnJlZSBzcGlubG9jayBk
ZXZpY2Ugb2JqZWN0cyAqLworCWlmIChod3NwaW5sb2NrX21vZHVsZS0+aXNfaW5pdCkKKwkJa2Zy
ZWUoaHdzcGlubG9ja3MpOworfQorCittb2R1bGVfaW5pdChod3NwaW5sb2NrX2luaXQpOworbW9k
dWxlX2V4aXQoaHdzcGlubG9ja19leGl0KTsKKworTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwor
TU9EVUxFX0RFU0NSSVBUSU9OKCJIYXJkd2FyZSBzcGlubG9jayBkcml2ZXIiKTsKK01PRFVMRV9B
VVRIT1IoIlNpbW9uIFF1ZSIpOworTU9EVUxFX0FVVEhPUigiSGFyaSBLYW5pZ2VyaSIpOwpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9od3NwaW5sb2NrLmggYi9h
cmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2h3c3BpbmxvY2suaApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwLi44YzY5Y2E1Ci0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9h
cm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9od3NwaW5sb2NrLmgKQEAgLTAsMCArMSwyOSBAQAor
LyogaHdzcGlubG9jay5oICovCisKKyNpZm5kZWYgSFdTUElOTE9DS19ICisjZGVmaW5lIEhXU1BJ
TkxPQ0tfSAorCisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8
cGxhdC9vbWFwNDR4eC5oPgorCisvKiBSZWFkIHZhbHVlcyBmcm9tIHRoZSBzcGlubG9jayByZWdp
c3RlciAqLworI2RlZmluZSBIV1NQSU5MT0NLX0FDUVVJUkVEIDAKKyNkZWZpbmUgSFdTUElOTE9D
S19CVVNZIDEKKworLyogRGV2aWNlIGRhdGEgKi8KK3N0cnVjdCBod3NwaW5sb2NrX3BsYXRfaW5m
byB7CisJdTMyIHN5c3N0YXR1c19vZmZzZXQ7CQkvKiBTeXN0ZW0gc3RhdHVzIHJlZ2lzdGVyIG9m
ZnNldCAqLworCXUzMiBsb2NrX2Jhc2Vfb2Zmc2V0OwkJLyogT2Zmc2V0IG9mIHNwaW5sb2NrIHJl
Z2lzdGVycyAqLworfTsKKworc3RydWN0IGh3c3BpbmxvY2s7CisKK2ludCBod3NwaW5sb2NrX2xv
Y2soc3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSk7CitpbnQgaHdzcGlubG9ja190cnlsb2NrKHN0
cnVjdCBod3NwaW5sb2NrICpoYW5kbGUpOworaW50IGh3c3BpbmxvY2tfdW5sb2NrKHN0cnVjdCBo
d3NwaW5sb2NrICpoYW5kbGUpOworCitzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19yZXF1
ZXN0KHZvaWQpOworc3RydWN0IGh3c3BpbmxvY2sgKmh3c3BpbmxvY2tfcmVxdWVzdF9zcGVjaWZp
Yyh1bnNpZ25lZCBpbnQgaWQpOworaW50IGh3c3BpbmxvY2tfZnJlZShzdHJ1Y3QgaHdzcGlubG9j
ayAqaHdzcGlubG9ja19wdHIpOworCisjZW5kaWYgLyogSFdTUElOTE9DS19IICovCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L29tYXA0NHh4LmggYi9hcmNoL2Fy
bS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L29tYXA0NHh4LmgKaW5kZXggOGIzZjEyZi4uODAxNjUw
OCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwNDR4eC5o
CisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvb21hcDQ0eHguaApAQCAtNTIs
NSArNTIsNyBAQAogI2RlZmluZSBPTUFQNF9NTVUxX0JBU0UJCQkweDU1MDgyMDAwCiAjZGVmaW5l
IE9NQVA0X01NVTJfQkFTRQkJCTB4NEEwNjYwMDAKIAorI2RlZmluZSBPTUFQNDRYWF9TUElOTE9D
S19CQVNFCQkoTDRfNDRYWF9CQVNFICsgMHhGNjAwMCkKKwogI2VuZGlmIC8qIF9fQVNNX0FSQ0hf
T01BUDQ0WFhfSCAqLwogCi0tIAoxLjcuMAoK

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1474EA6A1dlee03entticom_--
