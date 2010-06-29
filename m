From: "Que, Simon" <sque@ti.com>
Subject: [RFC v.2] omap: hwspinlock: Added hwspinlock driver
Date: Tue, 29 Jun 2010 14:27:46 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1473E30B7@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167E8@dbde02.ent.ti.com>,<F39349C6FA641B4A831B7BF4EBF4D4E14728E5B3@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D9E40C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E1473E30B7dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54572 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755299Ab0F2T1v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jun 2010 15:27:51 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D9E40C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1473E30B7dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks for all your comments and feedback.  I've updated the patch with cha=
nges based on the feedback I've received:

- Switched to using hwmod.  I enabled the hwmod entry for spinlock in omap_=
hwmod_44xx_data.
- Removed reserved/unreserved distinction.  Removed CONFIG option for numbe=
r of reserved locks as well.  The reservation will be done at runtime as Ke=
vin and Benoit have suggested.  The new API simply provides for reservation=
 of spinlock w/ specific ID or the next available spinlock.
- Simplified #define names -- removed the HWSPINLOCK prefix.
- Added OMAP4 conditional to Makefiles for building hwspinlock.
- Moved base address definition of spinlock register to omap44xx.h
- Base addresses are mapped using ioremap and accessed using readl/writel.
- Removed the irqsave/restore functions.  Now there are only lock/trylock/u=
nlock, without the irq and preempt disable/enable.  This keeps it simple, a=
nd we can add the irq/preempt disable/enable as a future enhancement.

Regarding reserving locks: how do we use the board code to reserve locks?  =
This is not familiar to us.

Please see attached patch, or inline patch contents below.

Thanks,
Simon


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


>From a1aa1f5a85814bdf924d140b664a3305224392b2 Mon Sep 17 00:00:00 2001
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
 arch/arm/mach-omap2/hwspinlocks.c            |  122 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
 arch/arm/plat-omap/Makefile                  |    3 +-
 arch/arm/plat-omap/hwspinlock.c              |  250 ++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/hwspinlock.h |   30 +++
 arch/arm/plat-omap/include/plat/omap44xx.h   |    2 +
 7 files changed, 409 insertions(+), 2 deletions(-)
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
index 0000000..868edea
--- /dev/null
+++ b/arch/arm/mach-omap2/hwspinlocks.c
@@ -0,0 +1,122 @@
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
+#include <linux/slab.h>
+
+#include <plat/hwspinlock.h>
+
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
+
+#define SPINLOCK_REGADDR(reg)          (OMAP44XX_SPINLOCK_BASE + (reg))
+
+/* Spinlock register offsets */
+#define REVISION_OFFSET                        0x0000
+#define SYSCONFIG_OFFSET               0x0010
+#define SYSSTATUS_OFFSET               0x0014
+#define LOCK_BASE_OFFSET               0x0800
+
+/* Spinlock register addresses */
+#define SPINLOCK_REVISION_REG          \
+               SPINLOCK_REGADDR(REVISION_OFFSET)
+#define SPINLOCK_SYSCONFIG_REG         \
+               SPINLOCK_REGADDR(SYSCONFIG_OFFSET)
+#define SPINLOCK_SYSSTATUS_REG         \
+               SPINLOCK_REGADDR(SYSSTATUS_OFFSET)
+#define SPINLOCK_LOCK_REG(i)           \
+               SPINLOCK_REGADDR(LOCK_BASE_OFFSET + 0x4 * (i))
+
+/* Spinlock count code */
+#define SPINLOCK_32_REGS               1
+#define SPINLOCK_64_REGS               2
+#define SPINLOCK_128_REGS              4
+#define SPINLOCK_256_REGS              8
+#define SPINLOCK_NUMLOCKS_OFFSET       24
+
+/* Initialization function */
+int __init hwspinlocks_init(void)
+{
+       int i;
+       int retval =3D 0;
+
+       struct hwspinlock_plat_info *pdata;
+       void __iomem *base;
+       int num_locks;
+
+       void __iomem *sysstatus_reg =3D ioremap(SPINLOCK_SYSSTATUS_REG,
+                                                               sizeof(u32)=
);
+
+       struct omap_hwmod *oh;
+       char *oh_name, *pdev_name;
+
+       /* Determine number of locks */
+       switch (readl(sysstatus_reg) >> SPINLOCK_NUMLOCKS_OFFSET) {
+       case SPINLOCK_32_REGS:
+               num_locks =3D 32;
+               break;
+       case SPINLOCK_64_REGS:
+               num_locks =3D 64;
+               break;
+       case SPINLOCK_128_REGS:
+               num_locks =3D 128;
+               break;
+       case SPINLOCK_256_REGS:
+               num_locks =3D 256;
+               break;
+       default:
+               return -EINVAL; /* Invalid spinlock count code */
+       }
+
+       iounmap(sysstatus_reg);
+
+       oh_name =3D "spinlock";
+       oh =3D omap_hwmod_lookup(oh_name);
+       if (WARN_ON(oh =3D=3D NULL))
+               return -EINVAL;
+
+       pdev_name =3D "hwspinlock";
+
+       /* Device drivers */
+       for (i =3D 0; i < num_locks; i++) {
+               base =3D ioremap(SPINLOCK_LOCK_REG(i), sizeof(u32));
+
+               /* Pass data to device initialization */
+               pdata =3D kzalloc(sizeof(struct hwspinlock_plat_info),
+                                                               GFP_KERNEL)=
;
+               pdata->num_locks =3D num_locks;
+               pdata->io_base =3D base;
+
+               omap_device_build(pdev_name, i, oh, pdata,
+                               sizeof(struct hwspinlock_plat_info),
+                               NULL, 0, false);
+       }
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
index 0000000..dbbf543
--- /dev/null
+++ b/arch/arm/plat-omap/hwspinlock.c
@@ -0,0 +1,250 @@
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
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <plat/hwspinlock.h>
+
+/* for managing a hardware spinlock module */
+struct hwspinlock_state {
+       bool is_init;                   /* For first-time initialization */
+       int num_locks;                  /* Total number of locks in system =
*/
+       spinlock_t local_lock;          /* Local protection */
+};
+
+/* Points to the hardware spinlock module */
+static struct hwspinlock_state hwspinlock_state;
+static struct hwspinlock_state *hwspinlock_module =3D &hwspinlock_state;
+
+/* Spinlock object */
+struct hwspinlock {
+       bool is_init;
+       void __iomem *io_base;
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
+       /* Attempt to acquire the lock by reading from it */
+       do {
+               retval =3D readl(handle->io_base);
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
+       if (WARN_ON(in_atomic() || in_irq()))
+               return -EPERM;
+
+       /* Attempt to acquire the lock by reading from it */
+       retval =3D readl(handle->io_base);
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
+       writel(0, handle->io_base);
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
+       int id;
+
+       /* Set up the spinlock count and array */
+       if (!hwspinlock_module->is_init) {
+               hwspinlock_module->num_locks =3D pdata->num_locks;
+
+               /* Allocate spinlock device objects */
+               hwspinlocks =3D kmalloc(sizeof(struct hwspinlock) *
+                               hwspinlock_module->num_locks, GFP_KERNEL);
+               if (WARN_ON(hwspinlocks =3D=3D NULL))
+                       return -ENOMEM;
+
+               /* Initialize local lock */
+               spin_lock_init(&hwspinlock_module->local_lock);
+
+               /* Only do initialization once */
+               hwspinlock_module->is_init =3D true;
+
+               for (id =3D 0; id < pdata->num_locks; id++)
+                       hwspinlocks[id].is_init =3D false;
+       }
+
+       id =3D pdev->id;
+
+       hwspinlocks[id].pdev                    =3D pdev;
+
+       hwspinlocks[id].is_allocated            =3D false;
+       hwspinlocks[id].io_base                 =3D pdata->io_base;
+       hwspinlocks[id].is_init                 =3D true;
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
+       for (id =3D 0; id < hwspinlock_module->num_locks; id++) {
+               iounmap(hwspinlocks[id].io_base);
+               hwspinlocks[id].is_init =3D false;
+       }
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
index 0000000..6de2cb9
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/hwspinlock.h
@@ -0,0 +1,30 @@
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
+       int num_locks;                  /* Number of locks (initialization)=
 */
+       void __iomem *io_base;          /* Address of spinlock register */
+       bool is_reserved;               /* Reserved for system use? */
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


--_002_F39349C6FA641B4A831B7BF4EBF4D4E1473E30B7dlee03entticom_
Content-Type: application/octet-stream;
	name="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"
Content-Description: 0001-omap-hwspinlock-Added-hwspinlock-driver.patch
Content-Disposition: attachment;
	filename="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"; size=15430;
	creation-date="Mon, 28 Jun 2010 18:00:56 GMT";
	modification-date="Mon, 28 Jun 2010 18:00:56 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMWFhMWY1YTg1ODE0YmRmOTI0ZDE0MGI2NjRhMzMwNTIyNDM5MmIyIE1vbiBTZXAgMTcg
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
aC1vbWFwMi9od3NwaW5sb2Nrcy5jICAgICAgICAgICAgfCAgMTIyICsrKysrKysrKysrKysKIGFy
Y2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF80NHh4X2RhdGEuYyAgIHwgICAgMiArLQogYXJj
aC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgICAzICstCiBhcmNo
L2FybS9wbGF0LW9tYXAvaHdzcGlubG9jay5jICAgICAgICAgICAgICB8ICAyNTAgKysrKysrKysr
KysrKysrKysrKysrKysrKysKIGFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdzcGlu
bG9jay5oIHwgICAzMCArKysKIGFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvb21hcDQ0
eHguaCAgIHwgICAgMiArCiA3IGZpbGVzIGNoYW5nZWQsIDQwOSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtb21hcDIvaHdzcGlu
bG9ja3MuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL3BsYXQtb21hcC9od3NwaW5sb2Nr
LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2h3
c3BpbmxvY2suaAoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUgYi9h
cmNoL2FybS9tYWNoLW9tYXAyL01ha2VmaWxlCmluZGV4IDY3MjViM2EuLjVmNWM4N2IgMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0vbWFjaC1v
bWFwMi9NYWtlZmlsZQpAQCAtMTcwLDMgKzE3MCw1IEBAIG9iai15CQkJCQkrPSAkKG5hbmQtbSkg
JChuYW5kLXkpCiAKIHNtYzkxeC0kKENPTkZJR19TTUM5MVgpCQkJOj0gZ3BtYy1zbWM5MXgubwog
b2JqLXkJCQkJCSs9ICQoc21jOTF4LW0pICQoc21jOTF4LXkpCisKK29iai0kKENPTkZJR19BUkNI
X09NQVA0KQkJKz0gaHdzcGlubG9ja3MubwpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvaHdzcGlubG9ja3MuYyBiL2FyY2gvYXJtL21h
Y2gtb21hcDIvaHdzcGlubG9ja3MuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
Li44NjhlZGVhCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9od3NwaW5s
b2Nrcy5jCkBAIC0wLDAgKzEsMTIyIEBACisvKgorICogT01BUCBoYXJkd2FyZSBzcGlubG9jayBk
cml2ZXIKKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMTAgVGV4YXMgSW5zdHJ1bWVudHMuIEFsbCBy
aWdodHMgcmVzZXJ2ZWQuCisgKgorICogQ29udGFjdDogU2ltb24gUXVlIDxzcXVlQHRpLmNvbT4K
KyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1
dGUgaXQgYW5kL29yCisgKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZQorICogdmVyc2lvbiAyIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRl
ZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQKKyAqIFdJVEhPVVQgQU5Z
IFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNI
QU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUg
R05VCisgKiBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICog
WW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UKKyAqIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRo
ZSBGcmVlIFNvZnR3YXJlCisgKiBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdCwgRmlm
dGggRmxvb3IsIEJvc3RvbiwgTUEKKyAqIDAyMTEwLTEzMDEgVVNBCisgKgorICovCisKKyNpbmNs
dWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KKyNpbmNs
dWRlIDxsaW51eC9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgorI2luY2x1ZGUg
PGxpbnV4L2lvLmg+CisjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorCisjaW5jbHVkZSA8cGxhdC9o
d3NwaW5sb2NrLmg+CisKKyNpbmNsdWRlIDxwbGF0L29tYXBfZGV2aWNlLmg+CisjaW5jbHVkZSA8
cGxhdC9vbWFwX2h3bW9kLmg+CisKKyNkZWZpbmUgU1BJTkxPQ0tfUkVHQUREUihyZWcpCQkoT01B
UDQ0WFhfU1BJTkxPQ0tfQkFTRSArIChyZWcpKQorCisvKiBTcGlubG9jayByZWdpc3RlciBvZmZz
ZXRzICovCisjZGVmaW5lIFJFVklTSU9OX09GRlNFVAkJCTB4MDAwMAorI2RlZmluZSBTWVNDT05G
SUdfT0ZGU0VUCQkweDAwMTAKKyNkZWZpbmUgU1lTU1RBVFVTX09GRlNFVAkJMHgwMDE0CisjZGVm
aW5lIExPQ0tfQkFTRV9PRkZTRVQJCTB4MDgwMAorCisvKiBTcGlubG9jayByZWdpc3RlciBhZGRy
ZXNzZXMgKi8KKyNkZWZpbmUgU1BJTkxPQ0tfUkVWSVNJT05fUkVHCQlcCisJCVNQSU5MT0NLX1JF
R0FERFIoUkVWSVNJT05fT0ZGU0VUKQorI2RlZmluZSBTUElOTE9DS19TWVNDT05GSUdfUkVHCQlc
CisJCVNQSU5MT0NLX1JFR0FERFIoU1lTQ09ORklHX09GRlNFVCkKKyNkZWZpbmUgU1BJTkxPQ0tf
U1lTU1RBVFVTX1JFRwkJXAorCQlTUElOTE9DS19SRUdBRERSKFNZU1NUQVRVU19PRkZTRVQpCisj
ZGVmaW5lIFNQSU5MT0NLX0xPQ0tfUkVHKGkpCQlcCisJCVNQSU5MT0NLX1JFR0FERFIoTE9DS19C
QVNFX09GRlNFVCArIDB4NCAqIChpKSkKKworLyogU3BpbmxvY2sgY291bnQgY29kZSAqLworI2Rl
ZmluZSBTUElOTE9DS18zMl9SRUdTCQkxCisjZGVmaW5lIFNQSU5MT0NLXzY0X1JFR1MJCTIKKyNk
ZWZpbmUgU1BJTkxPQ0tfMTI4X1JFR1MJCTQKKyNkZWZpbmUgU1BJTkxPQ0tfMjU2X1JFR1MJCTgK
KyNkZWZpbmUgU1BJTkxPQ0tfTlVNTE9DS1NfT0ZGU0VUCTI0CisKKy8qIEluaXRpYWxpemF0aW9u
IGZ1bmN0aW9uICovCitpbnQgX19pbml0IGh3c3BpbmxvY2tzX2luaXQodm9pZCkKK3sKKwlpbnQg
aTsKKwlpbnQgcmV0dmFsID0gMDsKKworCXN0cnVjdCBod3NwaW5sb2NrX3BsYXRfaW5mbyAqcGRh
dGE7CisJdm9pZCBfX2lvbWVtICpiYXNlOworCWludCBudW1fbG9ja3M7CisKKwl2b2lkIF9faW9t
ZW0gKnN5c3N0YXR1c19yZWcgPSBpb3JlbWFwKFNQSU5MT0NLX1NZU1NUQVRVU19SRUcsCisJCQkJ
CQkJCXNpemVvZih1MzIpKTsKKworCXN0cnVjdCBvbWFwX2h3bW9kICpvaDsKKwljaGFyICpvaF9u
YW1lLCAqcGRldl9uYW1lOworCisJLyogRGV0ZXJtaW5lIG51bWJlciBvZiBsb2NrcyAqLworCXN3
aXRjaCAocmVhZGwoc3lzc3RhdHVzX3JlZykgPj4gU1BJTkxPQ0tfTlVNTE9DS1NfT0ZGU0VUKSB7
CisJY2FzZSBTUElOTE9DS18zMl9SRUdTOgorCQludW1fbG9ja3MgPSAzMjsKKwkJYnJlYWs7CisJ
Y2FzZSBTUElOTE9DS182NF9SRUdTOgorCQludW1fbG9ja3MgPSA2NDsKKwkJYnJlYWs7CisJY2Fz
ZSBTUElOTE9DS18xMjhfUkVHUzoKKwkJbnVtX2xvY2tzID0gMTI4OworCQlicmVhazsKKwljYXNl
IFNQSU5MT0NLXzI1Nl9SRUdTOgorCQludW1fbG9ja3MgPSAyNTY7CisJCWJyZWFrOworCWRlZmF1
bHQ6CisJCXJldHVybiAtRUlOVkFMOwkvKiBJbnZhbGlkIHNwaW5sb2NrIGNvdW50IGNvZGUgKi8K
Kwl9CisKKwlpb3VubWFwKHN5c3N0YXR1c19yZWcpOworCisJb2hfbmFtZSA9ICJzcGlubG9jayI7
CisJb2ggPSBvbWFwX2h3bW9kX2xvb2t1cChvaF9uYW1lKTsKKwlpZiAoV0FSTl9PTihvaCA9PSBO
VUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlwZGV2X25hbWUgPSAiaHdzcGlubG9jayI7CisK
KwkvKiBEZXZpY2UgZHJpdmVycyAqLworCWZvciAoaSA9IDA7IGkgPCBudW1fbG9ja3M7IGkrKykg
eworCQliYXNlID0gaW9yZW1hcChTUElOTE9DS19MT0NLX1JFRyhpKSwgc2l6ZW9mKHUzMikpOwor
CisJCS8qIFBhc3MgZGF0YSB0byBkZXZpY2UgaW5pdGlhbGl6YXRpb24gKi8KKwkJcGRhdGEgPSBr
emFsbG9jKHNpemVvZihzdHJ1Y3QgaHdzcGlubG9ja19wbGF0X2luZm8pLAorCQkJCQkJCQlHRlBf
S0VSTkVMKTsKKwkJcGRhdGEtPm51bV9sb2NrcyA9IG51bV9sb2NrczsKKwkJcGRhdGEtPmlvX2Jh
c2UgPSBiYXNlOworCisJCW9tYXBfZGV2aWNlX2J1aWxkKHBkZXZfbmFtZSwgaSwgb2gsIHBkYXRh
LAorCQkJCXNpemVvZihzdHJ1Y3QgaHdzcGlubG9ja19wbGF0X2luZm8pLAorCQkJCU5VTEwsIDAs
IGZhbHNlKTsKKwl9CisKKwlyZXR1cm4gcmV0dmFsOworfQorbW9kdWxlX2luaXQoaHdzcGlubG9j
a3NfaW5pdCk7CisKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF80
NHh4X2RhdGEuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZF80NHh4X2RhdGEuYwpp
bmRleCBkOGQ2ZDU4Li5jZTZjNWZmIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL29t
YXBfaHdtb2RfNDR4eF9kYXRhLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3bW9k
XzQ0eHhfZGF0YS5jCkBAIC00ODc1LDcgKzQ4NzUsNyBAQCBzdGF0aWMgX19pbml0ZGF0YSBzdHJ1
Y3Qgb21hcF9od21vZCAqb21hcDQ0eHhfaHdtb2RzW10gPSB7CiAvKgkmb21hcDQ0eHhfc21hcnRy
ZWZsZXhfaXZhX2h3bW9kLCAqLwogLyoJJm9tYXA0NHh4X3NtYXJ0cmVmbGV4X21wdV9od21vZCwg
Ki8KIAkvKiBzcGlubG9jayBjbGFzcyAqLwotLyoJJm9tYXA0NHh4X3NwaW5sb2NrX2h3bW9kLCAq
LworCSZvbWFwNDR4eF9zcGlubG9ja19od21vZCwKIAkvKiB0aW1lciBjbGFzcyAqLwogCSZvbWFw
NDR4eF90aW1lcjFfaHdtb2QsCiAJJm9tYXA0NHh4X3RpbWVyMl9od21vZCwKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL3BsYXQtb21hcC9NYWtlZmlsZSBiL2FyY2gvYXJtL3BsYXQtb21hcC9NYWtlZmls
ZQppbmRleCBhMzdhYmY1Li5mNzI1YWZjIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAv
TWFrZWZpbGUKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlCkBAIC0zMiw0ICszMiw1
IEBAIG9iai15ICs9ICQoaTJjLW9tYXAtbSkgJChpMmMtb21hcC15KQogb2JqLSQoQ09ORklHX09N
QVBfTUJPWF9GV0spICs9IG1haWxib3gubwogb2JqLSQoQ09ORklHX09NQVBfUkVNT1RFX1BST0Mp
ICs9IHJlbW90ZXByb2MubwogCi1vYmotJChDT05GSUdfT01BUF9QTV9OT09QKSArPSBvbWFwLXBt
LW5vb3AubwpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKK29iai0kKENPTkZJR19PTUFQX1BN
X05PT1ApICs9IG9tYXAtcG0tbm9vcC5vCitvYmotJChDT05GSUdfQVJDSF9PTUFQNCkgKz0gaHdz
cGlubG9jay5vClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYyBiL2FyY2gvYXJtL3BsYXQtb21hcC9od3NwaW5sb2Nr
LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZGJiZjU0MwotLS0gL2Rldi9u
dWxsCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9od3NwaW5sb2NrLmMKQEAgLTAsMCArMSwyNTAg
QEAKKy8qCisgKiBPTUFQIGhhcmR3YXJlIHNwaW5sb2NrIGRyaXZlcgorICoKKyAqIENvcHlyaWdo
dCAoQykgMjAxMCBUZXhhcyBJbnN0cnVtZW50cy4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisg
KiBDb250YWN0OiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKKyAqIG1vZGlm
eSBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisg
KiB2ZXJzaW9uIDIgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24u
CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQg
d2lsbCBiZSB1c2VmdWwsIGJ1dAorICogV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZl
biB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1Mg
Rk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUKKyAqIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2
ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogYWxvbmcgd2l0
aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyAqIEZv
dW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQQor
ICogMDIxMTAtMTMwMSBVU0EKKyAqCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgor
I2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgor
I2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVkZSA8bGludXgvaW8uaD4KKyNpbmNsdWRl
IDxsaW51eC9zbGFiLmg+CisjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KKworI2luY2x1ZGUg
PHBsYXQvaHdzcGlubG9jay5oPgorCisvKiBmb3IgbWFuYWdpbmcgYSBoYXJkd2FyZSBzcGlubG9j
ayBtb2R1bGUgKi8KK3N0cnVjdCBod3NwaW5sb2NrX3N0YXRlIHsKKwlib29sIGlzX2luaXQ7CQkJ
LyogRm9yIGZpcnN0LXRpbWUgaW5pdGlhbGl6YXRpb24gKi8KKwlpbnQgbnVtX2xvY2tzOwkJCS8q
IFRvdGFsIG51bWJlciBvZiBsb2NrcyBpbiBzeXN0ZW0gKi8KKwlzcGlubG9ja190IGxvY2FsX2xv
Y2s7CQkvKiBMb2NhbCBwcm90ZWN0aW9uICovCit9OworCisvKiBQb2ludHMgdG8gdGhlIGhhcmR3
YXJlIHNwaW5sb2NrIG1vZHVsZSAqLworc3RhdGljIHN0cnVjdCBod3NwaW5sb2NrX3N0YXRlIGh3
c3BpbmxvY2tfc3RhdGU7CitzdGF0aWMgc3RydWN0IGh3c3BpbmxvY2tfc3RhdGUgKmh3c3Bpbmxv
Y2tfbW9kdWxlID0gJmh3c3BpbmxvY2tfc3RhdGU7CisKKy8qIFNwaW5sb2NrIG9iamVjdCAqLwor
c3RydWN0IGh3c3BpbmxvY2sgeworCWJvb2wgaXNfaW5pdDsKKwl2b2lkIF9faW9tZW0gKmlvX2Jh
c2U7CisJYm9vbCBpc19hbGxvY2F0ZWQ7CisJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsK
K307CisKKy8qIEFycmF5IG9mIHNwaW5sb2NrcyAqLworc3RhdGljIHN0cnVjdCBod3NwaW5sb2Nr
ICpod3NwaW5sb2NrczsKKworLyogQVBJIGZ1bmN0aW9ucyAqLworCisvKiBCdXN5IGxvb3AgdG8g
YWNxdWlyZSBhIHNwaW5sb2NrICovCitpbnQgaHdzcGlubG9ja19sb2NrKHN0cnVjdCBod3NwaW5s
b2NrICpoYW5kbGUpCit7CisJaW50IHJldHZhbDsKKworCWlmIChXQVJOX09OKGhhbmRsZSA9PSBO
VUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpZiAoV0FSTl9PTihpbl9hdG9taWMoKSB8fCBp
bl9pcnEoKSkpCisJCXJldHVybiAtRVBFUk07CisKKwkvKiBBdHRlbXB0IHRvIGFjcXVpcmUgdGhl
IGxvY2sgYnkgcmVhZGluZyBmcm9tIGl0ICovCisJZG8geworCQlyZXR2YWwgPSByZWFkbChoYW5k
bGUtPmlvX2Jhc2UpOworCX0gd2hpbGUgKHJldHZhbCA9PSBIV1NQSU5MT0NLX0JVU1kpOworCisJ
cmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfbG9jayk7CisKKy8qIEF0dGVt
cHQgdG8gYWNxdWlyZSBhIHNwaW5sb2NrIG9uY2UgKi8KK2ludCBod3NwaW5sb2NrX3RyeWxvY2so
c3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSkKK3sKKwlpbnQgcmV0dmFsID0gMDsKKworCWlmIChX
QVJOX09OKGhhbmRsZSA9PSBOVUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpZiAoV0FSTl9P
Tihpbl9hdG9taWMoKSB8fCBpbl9pcnEoKSkpCisJCXJldHVybiAtRVBFUk07CisKKwkvKiBBdHRl
bXB0IHRvIGFjcXVpcmUgdGhlIGxvY2sgYnkgcmVhZGluZyBmcm9tIGl0ICovCisJcmV0dmFsID0g
cmVhZGwoaGFuZGxlLT5pb19iYXNlKTsKKworCXJldHVybiByZXR2YWw7Cit9CitFWFBPUlRfU1lN
Qk9MKGh3c3BpbmxvY2tfdHJ5bG9jayk7CisKKy8qIFJlbGVhc2UgYSBzcGlubG9jayAqLworaW50
IGh3c3BpbmxvY2tfdW5sb2NrKHN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUpCit7CisJaWYgKFdB
Uk5fT04oaGFuZGxlID09IE5VTEwpKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCS8qIFJlbGVhc2Ug
aXQgYnkgd3JpdGluZyAwIHRvIGl0ICovCisJd3JpdGVsKDAsIGhhbmRsZS0+aW9fYmFzZSk7CisK
KwlyZXR1cm4gMDsKK30KK0VYUE9SVF9TWU1CT0woaHdzcGlubG9ja191bmxvY2spOworCisvKiBS
ZXF1ZXN0IGFuIHVuY2xhaW1lZCBzcGlubG9jayAqLworc3RydWN0IGh3c3BpbmxvY2sgKmh3c3Bp
bmxvY2tfcmVxdWVzdCh2b2lkKQoreworCWludCBpOworCWJvb2wgZm91bmQgPSBmYWxzZTsKKwlz
dHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlID0gTlVMTDsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOwor
CisJc3Bpbl9sb2NrX2lycXNhdmUoJmh3c3BpbmxvY2tfbW9kdWxlLT5sb2NhbF9sb2NrLCBmbGFn
cyk7CisJLyogU2VhcmNoIGZvciBhbiB1bmNsYWltZWQsIHVucmVzZXJ2ZWQgbG9jayAqLworCWZv
ciAoaSA9IDA7IGkgPCBod3NwaW5sb2NrX21vZHVsZS0+bnVtX2xvY2tzICYmICFmb3VuZDsgaSsr
KSB7CisJCWlmICghaHdzcGlubG9ja3NbaV0uaXNfYWxsb2NhdGVkKSB7CisJCQlmb3VuZCA9IHRy
dWU7CisJCQloYW5kbGUgPSAmaHdzcGlubG9ja3NbaV07CisJCX0KKwl9CisJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmaHdzcGlubG9ja19tb2R1bGUtPmxvY2FsX2xvY2ssIGZsYWdzKTsKKworCS8q
IFJldHVybiBlcnJvciBpZiBubyBtb3JlIGxvY2tzIGF2YWlsYWJsZSAqLworCWlmICghZm91bmQp
CisJCXJldHVybiBOVUxMOworCisJaGFuZGxlLT5pc19hbGxvY2F0ZWQgPSB0cnVlOworCisJcmV0
dXJuIGhhbmRsZTsKK30KK0VYUE9SVF9TWU1CT0woaHdzcGlubG9ja19yZXF1ZXN0KTsKKworLyog
UmVxdWVzdCBhbiB1bmNsYWltZWQgc3BpbmxvY2sgYnkgSUQgKi8KK3N0cnVjdCBod3NwaW5sb2Nr
ICpod3NwaW5sb2NrX3JlcXVlc3Rfc3BlY2lmaWModW5zaWduZWQgaW50IGlkKQoreworCXN0cnVj
dCBod3NwaW5sb2NrICpoYW5kbGUgPSBOVUxMOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKKwlz
cGluX2xvY2tfaXJxc2F2ZSgmaHdzcGlubG9ja19tb2R1bGUtPmxvY2FsX2xvY2ssIGZsYWdzKTsK
KworCWlmIChXQVJOX09OKGh3c3BpbmxvY2tzW2lkXS5pc19hbGxvY2F0ZWQpKQorCQlnb3RvIGV4
aXQ7CisKKwloYW5kbGUgPSAmaHdzcGlubG9ja3NbaWRdOworCWhhbmRsZS0+aXNfYWxsb2NhdGVk
ID0gdHJ1ZTsKKworZXhpdDoKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZod3NwaW5sb2NrX21v
ZHVsZS0+bG9jYWxfbG9jaywgZmxhZ3MpOworCXJldHVybiBoYW5kbGU7Cit9CitFWFBPUlRfU1lN
Qk9MKGh3c3BpbmxvY2tfcmVxdWVzdF9zcGVjaWZpYyk7CisKKy8qIFJlbGVhc2UgYSBjbGFpbWVk
IHNwaW5sb2NrICovCitpbnQgaHdzcGlubG9ja19mcmVlKHN0cnVjdCBod3NwaW5sb2NrICpoYW5k
bGUpCit7CisJaWYgKFdBUk5fT04oaGFuZGxlID09IE5VTEwpKQorCQlyZXR1cm4gLUVJTlZBTDsK
KworCWlmIChXQVJOX09OKCFoYW5kbGUtPmlzX2FsbG9jYXRlZCkpCisJCXJldHVybiAtRU5PTUVN
OworCisJaGFuZGxlLT5pc19hbGxvY2F0ZWQgPSBmYWxzZTsKKworCXJldHVybiAwOworfQorRVhQ
T1JUX1NZTUJPTChod3NwaW5sb2NrX2ZyZWUpOworCisvKiBQcm9iZSBmdW5jdGlvbiAqLworc3Rh
dGljIGludCBfX2RldmluaXQgaHdzcGlubG9ja19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQoreworCXN0cnVjdCBod3NwaW5sb2NrX3BsYXRfaW5mbyAqcGRhdGEgPSBwZGV2LT5k
ZXYucGxhdGZvcm1fZGF0YTsKKwlpbnQgaWQ7CisKKwkvKiBTZXQgdXAgdGhlIHNwaW5sb2NrIGNv
dW50IGFuZCBhcnJheSAqLworCWlmICghaHdzcGlubG9ja19tb2R1bGUtPmlzX2luaXQpIHsKKwkJ
aHdzcGlubG9ja19tb2R1bGUtPm51bV9sb2NrcyA9IHBkYXRhLT5udW1fbG9ja3M7CisKKwkJLyog
QWxsb2NhdGUgc3BpbmxvY2sgZGV2aWNlIG9iamVjdHMgKi8KKwkJaHdzcGlubG9ja3MgPSBrbWFs
bG9jKHNpemVvZihzdHJ1Y3QgaHdzcGlubG9jaykgKgorCQkJCWh3c3BpbmxvY2tfbW9kdWxlLT5u
dW1fbG9ja3MsIEdGUF9LRVJORUwpOworCQlpZiAoV0FSTl9PTihod3NwaW5sb2NrcyA9PSBOVUxM
KSkKKwkJCXJldHVybiAtRU5PTUVNOworCisJCS8qIEluaXRpYWxpemUgbG9jYWwgbG9jayAqLwor
CQlzcGluX2xvY2tfaW5pdCgmaHdzcGlubG9ja19tb2R1bGUtPmxvY2FsX2xvY2spOworCisJCS8q
IE9ubHkgZG8gaW5pdGlhbGl6YXRpb24gb25jZSAqLworCQlod3NwaW5sb2NrX21vZHVsZS0+aXNf
aW5pdCA9IHRydWU7CisKKwkJZm9yIChpZCA9IDA7IGlkIDwgcGRhdGEtPm51bV9sb2NrczsgaWQr
KykKKwkJCWh3c3BpbmxvY2tzW2lkXS5pc19pbml0ID0gZmFsc2U7CisJfQorCisJaWQgPSBwZGV2
LT5pZDsKKworCWh3c3BpbmxvY2tzW2lkXS5wZGV2CQkJPSBwZGV2OworCisJaHdzcGlubG9ja3Nb
aWRdLmlzX2FsbG9jYXRlZAkJPSBmYWxzZTsKKwlod3NwaW5sb2Nrc1tpZF0uaW9fYmFzZQkJCT0g
cGRhdGEtPmlvX2Jhc2U7CisJaHdzcGlubG9ja3NbaWRdLmlzX2luaXQJCQk9IHRydWU7CisKKwly
ZXR1cm4gMDsKK30KKworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaHdzcGlubG9ja19k
cml2ZXIgPSB7CisJLnByb2JlCQk9IGh3c3BpbmxvY2tfcHJvYmUsCisJLmRyaXZlcgkJPSB7CisJ
CS5uYW1lCT0gImh3c3BpbmxvY2siLAorCX0sCit9OworCisvKiBJbml0aWFsaXphdGlvbiBmdW5j
dGlvbiAqLworc3RhdGljIGludCBfX2luaXQgaHdzcGlubG9ja19pbml0KHZvaWQpCit7CisJaW50
IHJldHZhbCA9IDA7CisKKwkvKiBSZWdpc3RlciBzcGlubG9jayBkcml2ZXIgKi8KKwlyZXR2YWwg
PSBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmh3c3BpbmxvY2tfZHJpdmVyKTsKKworCXJldHVy
biByZXR2YWw7Cit9CisKKy8qIENsZWFudXAgZnVuY3Rpb24gKi8KK3N0YXRpYyB2b2lkIF9fZXhp
dCBod3NwaW5sb2NrX2V4aXQodm9pZCkKK3sKKwlpbnQgaWQ7CisKKwlwbGF0Zm9ybV9kcml2ZXJf
dW5yZWdpc3RlcigmaHdzcGlubG9ja19kcml2ZXIpOworCisJZm9yIChpZCA9IDA7IGlkIDwgaHdz
cGlubG9ja19tb2R1bGUtPm51bV9sb2NrczsgaWQrKykgeworCQlpb3VubWFwKGh3c3BpbmxvY2tz
W2lkXS5pb19iYXNlKTsKKwkJaHdzcGlubG9ja3NbaWRdLmlzX2luaXQgPSBmYWxzZTsKKwl9CisK
KwkvKiBGcmVlIHNwaW5sb2NrIGRldmljZSBvYmplY3RzICovCisJaWYgKGh3c3BpbmxvY2tfbW9k
dWxlLT5pc19pbml0KQorCQlrZnJlZShod3NwaW5sb2Nrcyk7Cit9CisKK21vZHVsZV9pbml0KGh3
c3BpbmxvY2tfaW5pdCk7Cittb2R1bGVfZXhpdChod3NwaW5sb2NrX2V4aXQpOworCitNT0RVTEVf
TElDRU5TRSgiR1BMIHYyIik7CitNT0RVTEVfREVTQ1JJUFRJT04oIkhhcmR3YXJlIHNwaW5sb2Nr
IGRyaXZlciIpOworTU9EVUxFX0FVVEhPUigiU2ltb24gUXVlIik7CitNT0RVTEVfQVVUSE9SKCJI
YXJpIEthbmlnZXJpIik7CmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9w
bGF0L2h3c3BpbmxvY2suaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdzcGlu
bG9jay5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjZkZTJjYjkKLS0tIC9k
ZXYvbnVsbAorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2h3c3BpbmxvY2su
aApAQCAtMCwwICsxLDMwIEBACisvKiBod3NwaW5sb2NrLmggKi8KKworI2lmbmRlZiBIV1NQSU5M
T0NLX0gKKyNkZWZpbmUgSFdTUElOTE9DS19ICisKKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9k
ZXZpY2UuaD4KKyNpbmNsdWRlIDxwbGF0L29tYXA0NHh4Lmg+CisKKy8qIFJlYWQgdmFsdWVzIGZy
b20gdGhlIHNwaW5sb2NrIHJlZ2lzdGVyICovCisjZGVmaW5lIEhXU1BJTkxPQ0tfQUNRVUlSRUQg
MAorI2RlZmluZSBIV1NQSU5MT0NLX0JVU1kgMQorCisvKiBEZXZpY2UgZGF0YSAqLworc3RydWN0
IGh3c3BpbmxvY2tfcGxhdF9pbmZvIHsKKwlpbnQgbnVtX2xvY2tzOwkJCS8qIE51bWJlciBvZiBs
b2NrcyAoaW5pdGlhbGl6YXRpb24pICovCisJdm9pZCBfX2lvbWVtICppb19iYXNlOwkJLyogQWRk
cmVzcyBvZiBzcGlubG9jayByZWdpc3RlciAqLworCWJvb2wgaXNfcmVzZXJ2ZWQ7CQkvKiBSZXNl
cnZlZCBmb3Igc3lzdGVtIHVzZT8gKi8KK307CisKK3N0cnVjdCBod3NwaW5sb2NrOworCitpbnQg
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

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1473E30B7dlee03entticom_--
