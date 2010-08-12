From: "Que, Simon" <sque@ti.com>
Subject: [PATCH 3/4 v2] omap: hwspinlock: Created driver for OMAP hardware
 spinlock.
Date: Wed, 11 Aug 2010 19:29:50 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56810 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759483Ab0HLA3x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Aug 2010 20:29:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48dlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Created driver for OMAP hardware spinlock.

 - Reserved spinlocks for internal use
 - Dynamic allocation of unreserved locks
 - Lock, unlock, and trylock functions, with or without disabling irqs/pree=
mpt
 - Registered as a platform device driver

The device initialization uses hwmod to configure the devices.
One device will be created for each IP.  It will pass spinlock register off=
set info to the driver.  The device initialization file is:
                arch/arm/mach-omap2/hwspinlocks.c

The driver takes in register offset info passed in device initialization.
It uses hwmod to obtain the base address of the hardware spinlock module.
Then it reads info from the registers.  The function hwspinlock_probe() ini=
tializes the array of spinlock structures, each containing a spinlock regis=
ter address calculated from the base address and lock offsets.
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
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Krishnamoorthy, Balaji T <balajitk@ti.com>
---
 arch/arm/mach-omap2/hwspinlocks.c            |   65 +++++
 arch/arm/plat-omap/hwspinlock.c              |  353 ++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/hwspinlock.h |   47 ++++
 3 files changed, 465 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hwspinlocks.c
 create mode 100644 arch/arm/plat-omap/hwspinlock.c
 create mode 100644 arch/arm/plat-omap/include/plat/hwspinlock.h

diff --git a/arch/arm/mach-omap2/hwspinlocks.c b/arch/arm/mach-omap2/hwspin=
locks.c
new file mode 100644
index 0000000..154fc40
--- /dev/null
+++ b/arch/arm/mach-omap2/hwspinlocks.c
@@ -0,0 +1,65 @@
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
+
+struct omap_device_pm_latency omap_spinlock_latency[] =3D {
+       {
+               .deactivate_func =3D omap_device_idle_hwmods,
+               .activate_func   =3D omap_device_enable_hwmods,
+               .flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+       }
+};
+
+/* Initialization function */
+int __init hwspinlocks_init(void)
+{
+       int retval =3D 0;
+
+       struct omap_hwmod *oh;
+       const char *oh_name, *pdev_name;
+
+       oh_name =3D "spinlock";
+       oh =3D omap_hwmod_lookup(oh_name);
+       if (WARN_ON(oh =3D=3D NULL))
+               return -EINVAL;
+
+       pdev_name =3D "hwspinlock";
+
+       /* Pass data to device initialization */
+       omap_device_build(pdev_name, 0, oh, NULL, 0, omap_spinlock_latency,
+                               ARRAY_SIZE(omap_spinlock_latency), false);
+
+       return retval;
+}
+postcore_initcall(hwspinlocks_init);
diff --git a/arch/arm/plat-omap/hwspinlock.c b/arch/arm/plat-omap/hwspinloc=
k.c
new file mode 100644
index 0000000..6f78658
--- /dev/null
+++ b/arch/arm/plat-omap/hwspinlock.c
@@ -0,0 +1,353 @@
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
+ *          arch/arm/mach-omap2/hwspinlock_array.c
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
+/* Spinlock register offsets */
+#define SYSSTATUS_OFFSET               0x0014
+#define LOCK_BASE_OFFSET               0x0800
+
+/* Spinlock count code */
+#define SPINLOCK_32_REGS               1
+#define SPINLOCK_64_REGS               2
+#define SPINLOCK_128_REGS              4
+#define SPINLOCK_256_REGS              8
+#define SPINLOCK_NUMLOCKS_BIT_OFFSET   24
+
+/* Number of attempts to try locking */
+#define MAX_LOCK_ATTEMPTS              1000
+
+/* for managing a hardware spinlock module */
+struct hwspinlock_module_state {
+       bool is_init;                   /* For first-time initialization */
+       int num_locks;                  /* Total number of locks in system =
*/
+       spinlock_t local_lock;          /* Local protection */
+       void __iomem *io_base;          /* Mapped base address */
+};
+
+/* Points to the hardware spinlock module */
+static struct hwspinlock_module_state hwspinlock_state;
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
+static struct hwspinlock *hwspinlock_array;
+
+/* API functions */
+
+/* Busy loop to acquire a spinlock */
+int hwspinlock_lock(struct hwspinlock *handle)
+{
+       int retval;
+       int num_attempts =3D 0;
+
+       if (WARN_ON(handle =3D=3D NULL))
+               return -EINVAL;
+
+       /* This is not permitted in IRQ because we do not want a context */
+       /* switch while the lock is being held */
+       if (WARN_ON(in_irq()))
+               return -EPERM;
+
+       if (pm_runtime_get_sync(&handle->pdev->dev) < 0)
+               return -ENODEV;
+
+       /* Attempt to acquire the lock by reading from it */
+       do {
+               retval =3D readl(handle->lock_reg);
+               num_attempts++;         /* Increment the timeout counter */
+       } while (retval =3D=3D HWSPINLOCK_BUSY &&
+                                       num_attempts < MAX_LOCK_ATTEMPTS);
+
+       /* If there was a timeout, put the device back */
+       if (num_attempts >=3D MAX_LOCK_ATTEMPTS)
+               pm_runtime_put_sync(&handle->pdev->dev);
+
+       return retval;
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
+       /* This is not permitted in IRQ because we do not want a context */
+       /* switch while the lock is being held */
+       if (WARN_ON(in_irq()))
+               return -EPERM;
+
+       if ((retval =3D pm_runtime_get_sync(&handle->pdev->dev)) < 0)
+               return -ENODEV;
+
+       /* Attempt to acquire the lock by reading from it */
+       retval =3D readl(handle->lock_reg);
+
+       if (retval =3D=3D HWSPINLOCK_BUSY)
+               pm_runtime_put_sync(&handle->pdev->dev);
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
+       pm_runtime_put_sync(&handle->pdev->dev);
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
+       spin_lock_irqsave(&hwspinlock_state.local_lock, flags);
+       /* Search for an unclaimed, unreserved lock */
+       for (i =3D 0; i < hwspinlock_state.num_locks && !found; i++) {
+               if (!hwspinlock_array[i].is_allocated) {
+                       found =3D true;
+                       handle =3D &hwspinlock_array[i];
+               }
+       }
+       spin_unlock_irqrestore(&hwspinlock_state.local_lock, flags);
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
+       spin_lock_irqsave(&hwspinlock_state.local_lock, flags);
+
+       if (WARN_ON(hwspinlock_array[id].is_allocated))
+               goto exit;
+
+       handle =3D &hwspinlock_array[id];
+       handle->is_allocated =3D true;
+
+exit:
+       spin_unlock_irqrestore(&hwspinlock_state.local_lock, flags);
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
+       struct resource *res;
+       void __iomem *io_base;
+       int id;
+
+       void __iomem *sysstatus_reg;
+
+       /* Determine number of locks */
+       sysstatus_reg =3D ioremap(OMAP44XX_SPINLOCK_BASE + SYSSTATUS_OFFSET=
,
+                                                               sizeof(u32)=
);
+       if (sysstatus_reg =3D=3D NULL)
+               return -EFAULT;
+
+       switch (readl(sysstatus_reg) >> SPINLOCK_NUMLOCKS_BIT_OFFSET) {
+       case SPINLOCK_32_REGS:
+               hwspinlock_state.num_locks =3D 32;
+               break;
+       case SPINLOCK_64_REGS:
+               hwspinlock_state.num_locks =3D 64;
+               break;
+       case SPINLOCK_128_REGS:
+               hwspinlock_state.num_locks =3D 128;
+               break;
+       case SPINLOCK_256_REGS:
+               hwspinlock_state.num_locks =3D 256;
+               break;
+       default:
+               return -EINVAL; /* Invalid spinlock count code */
+       }
+       iounmap(sysstatus_reg);
+
+       /* Allocate spinlock device objects */
+       hwspinlock_array =3D kmalloc(sizeof(struct hwspinlock) *
+                       hwspinlock_state.num_locks, GFP_KERNEL);
+       if (WARN_ON(hwspinlock_array =3D=3D NULL))
+               return -ENOMEM;
+
+       /* Initialize local lock */
+       spin_lock_init(&hwspinlock_state.local_lock);
+
+       /* Get address info */
+       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+       /* Map spinlock module address space */
+       io_base =3D ioremap(res->start, resource_size(res));
+       hwspinlock_state.io_base =3D io_base;
+
+       /* Set up each individual lock handle */
+       for (id =3D 0; id < hwspinlock_state.num_locks; id++) {
+               hwspinlock_array[id].id         =3D id;
+               hwspinlock_array[id].pdev               =3D pdev;
+               hwspinlock_array[id].is_init            =3D true;
+               hwspinlock_array[id].is_allocated       =3D false;
+
+               hwspinlock_array[id].lock_reg   =3D io_base + LOCK_BASE_OFF=
SET +
+                                                       sizeof(u32) * id;
+       }
+       pm_runtime_enable(&pdev->dev);
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
+postcore_initcall(hwspinlock_init);
+
+/* Cleanup function */
+static void __exit hwspinlock_exit(void)
+{
+       int id;
+
+       platform_driver_unregister(&hwspinlock_driver);
+
+       for (id =3D 0; id < hwspinlock_state.num_locks; id++)
+               hwspinlock_array[id].is_init =3D false;
+       iounmap(hwspinlock_state.io_base);
+
+       /* Free spinlock device objects */
+       if (hwspinlock_state.is_init)
+               kfree(hwspinlock_array);
+}
+module_exit(hwspinlock_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Hardware spinlock driver");
+MODULE_AUTHOR("Simon Que");
+MODULE_AUTHOR("Hari Kanigeri");
diff --git a/arch/arm/plat-omap/include/plat/hwspinlock.h b/arch/arm/plat-o=
map/include/plat/hwspinlock.h
new file mode 100644
index 0000000..ea64c48
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/hwspinlock.h
@@ -0,0 +1,47 @@
+/*
+ * OMAP hardware spinlock driver header
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
+#ifndef HWSPINLOCK_H
+#define HWSPINLOCK_H
+
+#include <linux/platform_device.h>
+#include <plat/omap44xx.h>
+
+/* Values that are read from the spinlock register */
+/* ACQUIRED means the lock was successfully acquired by the read operation=
 */
+/* BUSY means the lock was already acquired before the read operation, and=
 */
+/*   thus the read operation was not successful */
+#define HWSPINLOCK_ACQUIRED    0
+#define HWSPINLOCK_BUSY                1
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


--_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48dlee03entticom_
Content-Type: application/octet-stream;
	name="0003-omap-hwspinlock-Created-driver-for-OMAP-hardware-spinlock.patch"
Content-Description: 0003-omap-hwspinlock-Created-driver-for-OMAP-hardware-spinlock.patch
Content-Disposition: attachment; filename=
	"0003-omap-hwspinlock-Created-driver-for-OMAP-hardware-spinlock.patch";
	size=17114; creation-date="Wed, 11 Aug 2010 17:26:23 GMT";
	modification-date="Wed, 11 Aug 2010 17:26:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmZGQyNjdmZWYwZDEyYzU3ZmVkYmVkOWFkMTZiNDhiNjMzMGYwNWE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgpEYXRlOiBGcmksIDYg
QXVnIDIwMTAgMTA6NDM6MDYgLTA1MDBpClN1YmplY3Q6IFtQQVRDSCAzLzRdIENyZWF0ZWQgZHJp
dmVyIGZvciBPTUFQIGhhcmR3YXJlIHNwaW5sb2NrLgogLSBSZXNlcnZlZCBzcGlubG9ja3MgZm9y
IGludGVybmFsIHVzZQogLSBEeW5hbWljIGFsbG9jYXRpb24gb2YgdW5yZXNlcnZlZCBsb2Nrcwog
LSBMb2NrLCB1bmxvY2ssIGFuZCB0cnlsb2NrIGZ1bmN0aW9ucywgd2l0aCBvciB3aXRob3V0IGRp
c2FibGluZyBpcnFzL3ByZWVtcHQKIC0gUmVnaXN0ZXJlZCBhcyBhIHBsYXRmb3JtIGRldmljZSBk
cml2ZXIKClRoZSBkZXZpY2UgaW5pdGlhbGl6YXRpb24gdXNlcyBod21vZCB0byBjb25maWd1cmUg
dGhlIGRldmljZXMuCk9uZSBkZXZpY2Ugd2lsbCBiZSBjcmVhdGVkIGZvciBlYWNoIElQLiAgSXQg
d2lsbCBwYXNzIHNwaW5sb2NrIHJlZ2lzdGVyIG9mZnNldCBpbmZvIHRvIHRoZSBkcml2ZXIuICBU
aGUgZGV2aWNlIGluaXRpYWxpemF0aW9uIGZpbGUgaXM6CgkJYXJjaC9hcm0vbWFjaC1vbWFwMi9o
d3NwaW5sb2Nrcy5jCgpUaGUgZHJpdmVyIHRha2VzIGluIHJlZ2lzdGVyIG9mZnNldCBpbmZvIHBh
c3NlZCBpbiBkZXZpY2UgaW5pdGlhbGl6YXRpb24uCkl0IHVzZXMgaHdtb2QgdG8gb2J0YWluIHRo
ZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIGhhcmR3YXJlIHNwaW5sb2NrIG1vZHVsZS4KVGhlbiBpdCBy
ZWFkcyBpbmZvIGZyb20gdGhlIHJlZ2lzdGVycy4gIFRoZSBmdW5jdGlvbiBod3NwaW5sb2NrX3By
b2JlKCkgaW5pdGlhbGl6ZXMgdGhlIGFycmF5IG9mIHNwaW5sb2NrIHN0cnVjdHVyZXMsIGVhY2gg
Y29udGFpbmluZyBhIHNwaW5sb2NrIHJlZ2lzdGVyIGFkZHJlc3MgY2FsY3VsYXRlZCBmcm9tIHRo
ZSBiYXNlIGFkZHJlc3MgYW5kIGxvY2sgb2Zmc2V0cy4KVGhlIGRldmljZSBkcml2ZXIgZmlsZSBp
czoKCQlhcmNoL2FybS9wbGF0LW9tYXAvaHdzcGlubG9jay5jCgpIZXJlJ3MgYW4gQVBJIHN1bW1h
cnk6CmludCBod3NwaW5sb2NrX2xvY2soc3RydWN0IGh3c3BpbmxvY2sgKik7CglBdHRlbXB0IHRv
IGxvY2sgYSBoYXJkd2FyZSBzcGlubG9jay4gIElmIGl0IGlzIGJ1c3ksIHRoZSBmdW5jdGlvbiB3
aWxsCglrZWVwIHRyeWluZyB1bnRpbCBpdCBzdWNjZWVkcy4gIFRoaXMgaXMgYSBibG9ja2luZyBm
dW5jdGlvbi4KaW50IGh3c3BpbmxvY2tfdHJ5bG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqKTsKCUF0
dGVtcHQgdG8gbG9jayBhIGhhcmR3YXJlIHNwaW5sb2NrLiAgSWYgaXQgaXMgYnVzeSwgdGhlIGZ1
bmN0aW9uIHdpbGwKCXJldHVybiBCVVNZLiAgSWYgaXQgc3VjY2VlZHMgaW4gbG9ja2luZywgdGhl
IGZ1bmN0aW9uIHdpbGwgcmV0dXJuCglBQ1FVSVJFRC4gIFRoaXMgaXMgYSBub24tYmxvY2tpbmcg
ZnVuY3Rpb24uCmludCBod3NwaW5sb2NrX3VubG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqKTsKCVVu
bG9jayBhIGhhcmR3YXJlIHNwaW5sb2NrLgoKc3RydWN0IGh3c3BpbmxvY2sgKmh3c3BpbmxvY2tf
cmVxdWVzdCh2b2lkKTsKCVByb3ZpZGVzIGZvciAiZHluYW1pYyBhbGxvY2F0aW9uIiBvZiBhIGhh
cmR3YXJlIHNwaW5sb2NrLiAgSXQgcmV0dXJucwoJdGhlIGhhbmRsZSB0byB0aGUgbmV4dCBhdmFp
bGFibGUgKHVuYWxsb2NhdGVkKSBzcGlubG9jay4gIElmIG5vIG1vcmUKCWxvY2tzIGFyZSBhdmFp
bGFibGUsIGl0IHJldHVybnMgTlVMTC4Kc3RydWN0IGh3c3BpbmxvY2sgKmh3c3BpbmxvY2tfcmVx
dWVzdF9zcGVjaWZpYyh1bnNpZ25lZCBpbnQpOwoJUHJvdmlkZXMgZm9yICJzdGF0aWMgYWxsb2Nh
dGlvbiIgb2YgYSBzcGVjaWZpYyBoYXJkd2FyZSBzcGlubG9jay4gVGhpcwoJYWxsb3dzIHRoZSBz
eXN0ZW0gdG8gdXNlIGEgc3BlY2lmaWMgc3BpbmxvY2ssIGlkZW50aWZpZWQgYnkgYW4gSUQuIElm
Cgl0aGUgSUQgaXMgaW52YWxpZCBvciBpZiB0aGUgZGVzaXJlZCBsb2NrIGlzIGFscmVhZHkgYWxs
b2NhdGVkLCB0aGlzCgl3aWxsIHJldHVybiBOVUxMLiAgT3RoZXJ3aXNlIGl0IHJldHVybnMgYSBz
cGlubG9jayBoYW5kbGUuCmludCBod3NwaW5sb2NrX2ZyZWUoc3RydWN0IGh3c3BpbmxvY2sgKik7
CglGcmVlcyBhbiBhbGxvY2F0ZWQgaGFyZHdhcmUgc3BpbmxvY2sgKGVpdGhlciByZXNlcnZlZCBv
ciB1bnJlc2VydmVkKS4KClNpZ25lZC1vZmYtYnk6IFNpbW9uIFF1ZSA8c3F1ZUB0aS5jb20+ClNp
Z25lZC1vZmYtYnk6IEhhcmkgS2FuaWdlcmkgPGgta2FuaWdlcmkyQHRpLmNvbT4KU2lnbmVkLW9m
Zi1ieTogS3Jpc2huYW1vb3J0aHksIEJhbGFqaSBUIDxiYWxhaml0a0B0aS5jb20+Ci0tLQogYXJj
aC9hcm0vbWFjaC1vbWFwMi9od3NwaW5sb2Nrcy5jICAgICAgICAgICAgfCAgIDY1ICsrKysrCiBh
cmNoL2FybS9wbGF0LW9tYXAvaHdzcGlubG9jay5jICAgICAgICAgICAgICB8ICAzNTMgKysrKysr
KysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdz
cGlubG9jay5oIHwgICA0NyArKysrCiAzIGZpbGVzIGNoYW5nZWQsIDQ2NSBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtb21hcDIv
aHdzcGlubG9ja3MuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL3BsYXQtb21hcC9od3Nw
aW5sb2NrLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9w
bGF0L2h3c3BpbmxvY2suaAoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvaHdzcGlu
bG9ja3MuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvaHdzcGlubG9ja3MuYwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwLi4xNTRmYzQwCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9h
cm0vbWFjaC1vbWFwMi9od3NwaW5sb2Nrcy5jCkBAIC0wLDAgKzEsNjUgQEAKKy8qCisgKiBPTUFQ
IGhhcmR3YXJlIHNwaW5sb2NrIGRldmljZSBpbml0aWFsaXphdGlvbgorICoKKyAqIENvcHlyaWdo
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
IDxsaW51eC9zbGFiLmg+CisKKyNpbmNsdWRlIDxwbGF0L2h3c3BpbmxvY2suaD4KKyNpbmNsdWRl
IDxwbGF0L29tYXBfZGV2aWNlLmg+CisjaW5jbHVkZSA8cGxhdC9vbWFwX2h3bW9kLmg+CisKKwor
c3RydWN0IG9tYXBfZGV2aWNlX3BtX2xhdGVuY3kgb21hcF9zcGlubG9ja19sYXRlbmN5W10gPSB7
CisJeworCQkuZGVhY3RpdmF0ZV9mdW5jID0gb21hcF9kZXZpY2VfaWRsZV9od21vZHMsCisJCS5h
Y3RpdmF0ZV9mdW5jICAgPSBvbWFwX2RldmljZV9lbmFibGVfaHdtb2RzLAorCQkuZmxhZ3MgPSBP
TUFQX0RFVklDRV9MQVRFTkNZX0FVVE9fQURKVVNULAorCX0KK307CisKKy8qIEluaXRpYWxpemF0
aW9uIGZ1bmN0aW9uICovCitpbnQgX19pbml0IGh3c3BpbmxvY2tzX2luaXQodm9pZCkKK3sKKwlp
bnQgcmV0dmFsID0gMDsKKworCXN0cnVjdCBvbWFwX2h3bW9kICpvaDsKKwljb25zdCBjaGFyICpv
aF9uYW1lLCAqcGRldl9uYW1lOworCisJb2hfbmFtZSA9ICJzcGlubG9jayI7CisJb2ggPSBvbWFw
X2h3bW9kX2xvb2t1cChvaF9uYW1lKTsKKwlpZiAoV0FSTl9PTihvaCA9PSBOVUxMKSkKKwkJcmV0
dXJuIC1FSU5WQUw7CisKKwlwZGV2X25hbWUgPSAiaHdzcGlubG9jayI7CisKKwkvKiBQYXNzIGRh
dGEgdG8gZGV2aWNlIGluaXRpYWxpemF0aW9uICovCisJb21hcF9kZXZpY2VfYnVpbGQocGRldl9u
YW1lLCAwLCBvaCwgTlVMTCwgMCwgb21hcF9zcGlubG9ja19sYXRlbmN5LAorCQkJCUFSUkFZX1NJ
WkUob21hcF9zcGlubG9ja19sYXRlbmN5KSwgZmFsc2UpOworCisJcmV0dXJuIHJldHZhbDsKK30K
K3Bvc3Rjb3JlX2luaXRjYWxsKGh3c3BpbmxvY2tzX2luaXQpOwpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYyBiL2FyY2gvYXJtL3BsYXQtb21hcC9od3NwaW5sb2Nr
LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNmY3ODY1OAotLS0gL2Rldi9u
dWxsCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9od3NwaW5sb2NrLmMKQEAgLTAsMCArMSwzNTMg
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
ICogMDIxMTAtMTMwMSBVU0EKKyAqCisgKiBUaGlzIGRyaXZlciBzdXBwb3J0czoKKyAqIC0gUmVz
ZXJ2ZWQgc3BpbmxvY2tzIGZvciBpbnRlcm5hbCB1c2UKKyAqIC0gRHluYW1pYyBhbGxvY2F0aW9u
IG9mIHVucmVzZXJ2ZWQgbG9ja3MKKyAqIC0gTG9jaywgdW5sb2NrLCBhbmQgdHJ5bG9jayBmdW5j
dGlvbnMsIHdpdGggb3Igd2l0aG91dCBkaXNhYmxpbmcgaXJxcy9wcmVlbXB0CisgKiAtIFJlZ2lz
dGVyZWQgYXMgYSBwbGF0Zm9ybSBkZXZpY2UgZHJpdmVyCisgKgorICogVGhlIGRldmljZSBpbml0
aWFsaXphdGlvbiB1c2VzIGh3bW9kIHRvIGNvbmZpZ3VyZSB0aGUgZGV2aWNlcy4gIE9uZSBkZXZp
Y2UKKyAqIHdpbGwgYmUgY3JlYXRlZCBmb3IgZWFjaCBJUC4gIEl0IHdpbGwgcGFzcyBzcGlubG9j
ayByZWdpc3RlciBvZmZzZXQgaW5mbyB0bworICogdGhlIGRyaXZlci4gIFRoZSBkZXZpY2UgaW5p
dGlhbGl6YXRpb24gZmlsZSBpczoKKyAqICAgICAgICAgIGFyY2gvYXJtL21hY2gtb21hcDIvaHdz
cGlubG9ja19hcnJheS5jCisgKgorICogVGhlIGRyaXZlciB0YWtlcyBpbiByZWdpc3RlciBvZmZz
ZXQgaW5mbyBwYXNzZWQgaW4gZGV2aWNlIGluaXRpYWxpemF0aW9uLgorICogSXQgdXNlcyBod21v
ZCB0byBvYnRhaW4gdGhlIGJhc2UgYWRkcmVzcyBvZiB0aGUgaGFyZHdhcmUgc3BpbmxvY2sgbW9k
dWxlLgorICogVGhlbiBpdCByZWFkcyBpbmZvIGZyb20gdGhlIHJlZ2lzdGVycy4gIFRoZSBmdW5j
dGlvbiBod3NwaW5sb2NrX3Byb2JlKCkKKyAqIGluaXRpYWxpemVzIHRoZSBhcnJheSBvZiBzcGlu
bG9jayBzdHJ1Y3R1cmVzLCBlYWNoIGNvbnRhaW5pbmcgYSBzcGlubG9jaworICogcmVnaXN0ZXIg
YWRkcmVzcyBjYWxjdWxhdGVkIGZyb20gdGhlIGJhc2UgYWRkcmVzcyBhbmQgbG9jayBvZmZzZXRz
LgorICoKKyAqIEhlcmUncyBhbiBBUEkgc3VtbWFyeToKKyAqCisgKiBpbnQgaHdzcGlubG9ja19s
b2NrKHN0cnVjdCBod3NwaW5sb2NrICopOworICogICAgICBBdHRlbXB0IHRvIGxvY2sgYSBoYXJk
d2FyZSBzcGlubG9jay4gIElmIGl0IGlzIGJ1c3ksIHRoZSBmdW5jdGlvbiB3aWxsCisgKiAgICAg
IGtlZXAgdHJ5aW5nIHVudGlsIGl0IHN1Y2NlZWRzLiAgVGhpcyBpcyBhIGJsb2NraW5nIGZ1bmN0
aW9uLgorICogaW50IGh3c3BpbmxvY2tfdHJ5bG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqKTsKKyAq
ICAgICAgQXR0ZW1wdCB0byBsb2NrIGEgaGFyZHdhcmUgc3BpbmxvY2suICBJZiBpdCBpcyBidXN5
LCB0aGUgZnVuY3Rpb24gd2lsbAorICogICAgICByZXR1cm4gQlVTWS4gIElmIGl0IHN1Y2NlZWRz
IGluIGxvY2tpbmcsIHRoZSBmdW5jdGlvbiB3aWxsIHJldHVybgorICogICAgICBBQ1FVSVJFRC4g
IFRoaXMgaXMgYSBub24tYmxvY2tpbmcgZnVuY3Rpb24KKyAqIGludCBod3NwaW5sb2NrX3VubG9j
ayhzdHJ1Y3QgaHdzcGlubG9jayAqKTsKKyAqICAgICAgVW5sb2NrIGEgaGFyZHdhcmUgc3Bpbmxv
Y2suCisgKgorICogc3RydWN0IGh3c3BpbmxvY2sgKmh3c3BpbmxvY2tfcmVxdWVzdCh2b2lkKTsK
KyAqICAgICAgUHJvdmlkZXMgZm9yICJkeW5hbWljIGFsbG9jYXRpb24iIG9mIGEgaGFyZHdhcmUg
c3BpbmxvY2suICBJdCByZXR1cm5zCisgKiAgICAgIHRoZSBoYW5kbGUgdG8gdGhlIG5leHQgYXZh
aWxhYmxlICh1bmFsbG9jYXRlZCkgc3BpbmxvY2suICBJZiBubyBtb3JlCisgKiAgICAgIGxvY2tz
IGFyZSBhdmFpbGFibGUsIGl0IHJldHVybnMgTlVMTC4KKyAqIHN0cnVjdCBod3NwaW5sb2NrICpo
d3NwaW5sb2NrX3JlcXVlc3Rfc3BlY2lmaWModW5zaWduZWQgaW50KTsKKyAqICAgICAgUHJvdmlk
ZXMgZm9yICJzdGF0aWMgYWxsb2NhdGlvbiIgb2YgYSBzcGVjaWZpYyBoYXJkd2FyZSBzcGlubG9j
ay4gVGhpcworICogICAgICBhbGxvd3MgdGhlIHN5c3RlbSB0byB1c2UgYSBzcGVjaWZpYyBzcGlu
bG9jaywgaWRlbnRpZmllZCBieSBhbiBJRC4gSWYKKyAqICAgICAgdGhlIElEIGlzIGludmFsaWQg
b3IgaWYgdGhlIGRlc2lyZWQgbG9jayBpcyBhbHJlYWR5IGFsbG9jYXRlZCwgdGhpcworICogICAg
ICB3aWxsIHJldHVybiBOVUxMLiAgT3RoZXJ3aXNlIGl0IHJldHVybnMgYSBzcGlubG9jayBoYW5k
bGUuCisgKiBpbnQgaHdzcGlubG9ja19mcmVlKHN0cnVjdCBod3NwaW5sb2NrICopOworICogICAg
ICBGcmVlcyBhbiBhbGxvY2F0ZWQgaGFyZHdhcmUgc3BpbmxvY2sgKGVpdGhlciByZXNlcnZlZCBv
ciB1bnJlc2VydmVkKS4KKyAqLworCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVk
ZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CisjaW5jbHVk
ZSA8bGludXgvZGVsYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5oPgorI2luY2x1ZGUgPGxpbnV4
L3BtX3J1bnRpbWUuaD4KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CisjaW5jbHVkZSA8bGludXgv
c3BpbmxvY2suaD4KKworI2luY2x1ZGUgPHBsYXQvaHdzcGlubG9jay5oPgorCisvKiBTcGlubG9j
ayByZWdpc3RlciBvZmZzZXRzICovCisjZGVmaW5lIFNZU1NUQVRVU19PRkZTRVQJCTB4MDAxNAor
I2RlZmluZSBMT0NLX0JBU0VfT0ZGU0VUCQkweDA4MDAKKworLyogU3BpbmxvY2sgY291bnQgY29k
ZSAqLworI2RlZmluZSBTUElOTE9DS18zMl9SRUdTCQkxCisjZGVmaW5lIFNQSU5MT0NLXzY0X1JF
R1MJCTIKKyNkZWZpbmUgU1BJTkxPQ0tfMTI4X1JFR1MJCTQKKyNkZWZpbmUgU1BJTkxPQ0tfMjU2
X1JFR1MJCTgKKyNkZWZpbmUgU1BJTkxPQ0tfTlVNTE9DS1NfQklUX09GRlNFVAkyNAorCisvKiBO
dW1iZXIgb2YgYXR0ZW1wdHMgdG8gdHJ5IGxvY2tpbmcgKi8KKyNkZWZpbmUgTUFYX0xPQ0tfQVRU
RU1QVFMJCTEwMDAKKworLyogZm9yIG1hbmFnaW5nIGEgaGFyZHdhcmUgc3BpbmxvY2sgbW9kdWxl
ICovCitzdHJ1Y3QgaHdzcGlubG9ja19tb2R1bGVfc3RhdGUgeworCWJvb2wgaXNfaW5pdDsJCQkv
KiBGb3IgZmlyc3QtdGltZSBpbml0aWFsaXphdGlvbiAqLworCWludCBudW1fbG9ja3M7CQkJLyog
VG90YWwgbnVtYmVyIG9mIGxvY2tzIGluIHN5c3RlbSAqLworCXNwaW5sb2NrX3QgbG9jYWxfbG9j
azsJCS8qIExvY2FsIHByb3RlY3Rpb24gKi8KKwl2b2lkIF9faW9tZW0gKmlvX2Jhc2U7CQkvKiBN
YXBwZWQgYmFzZSBhZGRyZXNzICovCit9OworCisvKiBQb2ludHMgdG8gdGhlIGhhcmR3YXJlIHNw
aW5sb2NrIG1vZHVsZSAqLworc3RhdGljIHN0cnVjdCBod3NwaW5sb2NrX21vZHVsZV9zdGF0ZSBo
d3NwaW5sb2NrX3N0YXRlOworCisvKiBTcGlubG9jayBvYmplY3QgKi8KK3N0cnVjdCBod3NwaW5s
b2NrIHsKKwlib29sIGlzX2luaXQ7CisJaW50IGlkOworCXZvaWQgX19pb21lbSAqbG9ja19yZWc7
CisJYm9vbCBpc19hbGxvY2F0ZWQ7CisJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsKK307
CisKKy8qIEFycmF5IG9mIHNwaW5sb2NrcyAqLworc3RhdGljIHN0cnVjdCBod3NwaW5sb2NrICpo
d3NwaW5sb2NrX2FycmF5OworCisvKiBBUEkgZnVuY3Rpb25zICovCisKKy8qIEJ1c3kgbG9vcCB0
byBhY3F1aXJlIGEgc3BpbmxvY2sgKi8KK2ludCBod3NwaW5sb2NrX2xvY2soc3RydWN0IGh3c3Bp
bmxvY2sgKmhhbmRsZSkKK3sKKwlpbnQgcmV0dmFsOworCWludCBudW1fYXR0ZW1wdHMgPSAwOwor
CisJaWYgKFdBUk5fT04oaGFuZGxlID09IE5VTEwpKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCS8q
IFRoaXMgaXMgbm90IHBlcm1pdHRlZCBpbiBJUlEgYmVjYXVzZSB3ZSBkbyBub3Qgd2FudCBhIGNv
bnRleHQgKi8KKwkvKiBzd2l0Y2ggd2hpbGUgdGhlIGxvY2sgaXMgYmVpbmcgaGVsZCAqLworCWlm
IChXQVJOX09OKGluX2lycSgpKSkKKwkJcmV0dXJuIC1FUEVSTTsKKworCWlmIChwbV9ydW50aW1l
X2dldF9zeW5jKCZoYW5kbGUtPnBkZXYtPmRldikgPCAwKQorCQlyZXR1cm4gLUVOT0RFVjsKKwor
CS8qIEF0dGVtcHQgdG8gYWNxdWlyZSB0aGUgbG9jayBieSByZWFkaW5nIGZyb20gaXQgKi8KKwlk
byB7CisJCXJldHZhbCA9IHJlYWRsKGhhbmRsZS0+bG9ja19yZWcpOworCQludW1fYXR0ZW1wdHMr
KzsJCS8qIEluY3JlbWVudCB0aGUgdGltZW91dCBjb3VudGVyICovCisJfSB3aGlsZSAocmV0dmFs
ID09IEhXU1BJTkxPQ0tfQlVTWSAmJgorCQkJCQludW1fYXR0ZW1wdHMgPCBNQVhfTE9DS19BVFRF
TVBUUyk7CisKKwkvKiBJZiB0aGVyZSB3YXMgYSB0aW1lb3V0LCBwdXQgdGhlIGRldmljZSBiYWNr
ICovCisJaWYgKG51bV9hdHRlbXB0cyA+PSBNQVhfTE9DS19BVFRFTVBUUykKKwkJcG1fcnVudGlt
ZV9wdXRfc3luYygmaGFuZGxlLT5wZGV2LT5kZXYpOworCisJcmV0dXJuIHJldHZhbDsKK30KK0VY
UE9SVF9TWU1CT0woaHdzcGlubG9ja19sb2NrKTsKKworLyogQXR0ZW1wdCB0byBhY3F1aXJlIGEg
c3BpbmxvY2sgb25jZSAqLworaW50IGh3c3BpbmxvY2tfdHJ5bG9jayhzdHJ1Y3QgaHdzcGlubG9j
ayAqaGFuZGxlKQoreworCWludCByZXR2YWwgPSAwOworCisJaWYgKFdBUk5fT04oaGFuZGxlID09
IE5VTEwpKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCS8qIFRoaXMgaXMgbm90IHBlcm1pdHRlZCBp
biBJUlEgYmVjYXVzZSB3ZSBkbyBub3Qgd2FudCBhIGNvbnRleHQgKi8KKwkvKiBzd2l0Y2ggd2hp
bGUgdGhlIGxvY2sgaXMgYmVpbmcgaGVsZCAqLworCWlmIChXQVJOX09OKGluX2lycSgpKSkKKwkJ
cmV0dXJuIC1FUEVSTTsKKworCWlmICgocmV0dmFsID0gcG1fcnVudGltZV9nZXRfc3luYygmaGFu
ZGxlLT5wZGV2LT5kZXYpKSA8IDApCisJCXJldHVybiAtRU5PREVWOworCisJLyogQXR0ZW1wdCB0
byBhY3F1aXJlIHRoZSBsb2NrIGJ5IHJlYWRpbmcgZnJvbSBpdCAqLworCXJldHZhbCA9IHJlYWRs
KGhhbmRsZS0+bG9ja19yZWcpOworCisJaWYgKHJldHZhbCA9PSBIV1NQSU5MT0NLX0JVU1kpCisJ
CXBtX3J1bnRpbWVfcHV0X3N5bmMoJmhhbmRsZS0+cGRldi0+ZGV2KTsKKworCXJldHVybiByZXR2
YWw7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfdHJ5bG9jayk7CisKKy8qIFJlbGVhc2Ug
YSBzcGlubG9jayAqLworaW50IGh3c3BpbmxvY2tfdW5sb2NrKHN0cnVjdCBod3NwaW5sb2NrICpo
YW5kbGUpCit7CisJaWYgKFdBUk5fT04oaGFuZGxlID09IE5VTEwpKQorCQlyZXR1cm4gLUVJTlZB
TDsKKworCS8qIFJlbGVhc2UgaXQgYnkgd3JpdGluZyAwIHRvIGl0ICovCisJd3JpdGVsKDAsIGhh
bmRsZS0+bG9ja19yZWcpOworCisJcG1fcnVudGltZV9wdXRfc3luYygmaGFuZGxlLT5wZGV2LT5k
ZXYpOworCisJcmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfdW5sb2NrKTsK
KworLyogUmVxdWVzdCBhbiB1bmNsYWltZWQgc3BpbmxvY2sgKi8KK3N0cnVjdCBod3NwaW5sb2Nr
ICpod3NwaW5sb2NrX3JlcXVlc3Qodm9pZCkKK3sKKwlpbnQgaTsKKwlib29sIGZvdW5kID0gZmFs
c2U7CisJc3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSA9IE5VTEw7CisJdW5zaWduZWQgbG9uZyBm
bGFnczsKKworCXNwaW5fbG9ja19pcnFzYXZlKCZod3NwaW5sb2NrX3N0YXRlLmxvY2FsX2xvY2ss
IGZsYWdzKTsKKwkvKiBTZWFyY2ggZm9yIGFuIHVuY2xhaW1lZCwgdW5yZXNlcnZlZCBsb2NrICov
CisJZm9yIChpID0gMDsgaSA8IGh3c3BpbmxvY2tfc3RhdGUubnVtX2xvY2tzICYmICFmb3VuZDsg
aSsrKSB7CisJCWlmICghaHdzcGlubG9ja19hcnJheVtpXS5pc19hbGxvY2F0ZWQpIHsKKwkJCWZv
dW5kID0gdHJ1ZTsKKwkJCWhhbmRsZSA9ICZod3NwaW5sb2NrX2FycmF5W2ldOworCQl9CisJfQor
CXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmh3c3BpbmxvY2tfc3RhdGUubG9jYWxfbG9jaywgZmxh
Z3MpOworCisJLyogUmV0dXJuIGVycm9yIGlmIG5vIG1vcmUgbG9ja3MgYXZhaWxhYmxlICovCisJ
aWYgKCFmb3VuZCkKKwkJcmV0dXJuIE5VTEw7CisKKwloYW5kbGUtPmlzX2FsbG9jYXRlZCA9IHRy
dWU7CisKKwlyZXR1cm4gaGFuZGxlOworfQorRVhQT1JUX1NZTUJPTChod3NwaW5sb2NrX3JlcXVl
c3QpOworCisvKiBSZXF1ZXN0IGFuIHVuY2xhaW1lZCBzcGlubG9jayBieSBJRCAqLworc3RydWN0
IGh3c3BpbmxvY2sgKmh3c3BpbmxvY2tfcmVxdWVzdF9zcGVjaWZpYyh1bnNpZ25lZCBpbnQgaWQp
Cit7CisJc3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSA9IE5VTEw7CisJdW5zaWduZWQgbG9uZyBm
bGFnczsKKworCXNwaW5fbG9ja19pcnFzYXZlKCZod3NwaW5sb2NrX3N0YXRlLmxvY2FsX2xvY2ss
IGZsYWdzKTsKKworCWlmIChXQVJOX09OKGh3c3BpbmxvY2tfYXJyYXlbaWRdLmlzX2FsbG9jYXRl
ZCkpCisJCWdvdG8gZXhpdDsKKworCWhhbmRsZSA9ICZod3NwaW5sb2NrX2FycmF5W2lkXTsKKwlo
YW5kbGUtPmlzX2FsbG9jYXRlZCA9IHRydWU7CisKK2V4aXQ6CisJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmaHdzcGlubG9ja19zdGF0ZS5sb2NhbF9sb2NrLCBmbGFncyk7CisJcmV0dXJuIGhhbmRs
ZTsKK30KK0VYUE9SVF9TWU1CT0woaHdzcGlubG9ja19yZXF1ZXN0X3NwZWNpZmljKTsKKworLyog
UmVsZWFzZSBhIGNsYWltZWQgc3BpbmxvY2sgKi8KK2ludCBod3NwaW5sb2NrX2ZyZWUoc3RydWN0
IGh3c3BpbmxvY2sgKmhhbmRsZSkKK3sKKwlpZiAoV0FSTl9PTihoYW5kbGUgPT0gTlVMTCkpCisJ
CXJldHVybiAtRUlOVkFMOworCisJaWYgKFdBUk5fT04oIWhhbmRsZS0+aXNfYWxsb2NhdGVkKSkK
KwkJcmV0dXJuIC1FTk9NRU07CisKKwloYW5kbGUtPmlzX2FsbG9jYXRlZCA9IGZhbHNlOworCisJ
cmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfZnJlZSk7CisKKy8qIFByb2Jl
IGZ1bmN0aW9uICovCitzdGF0aWMgaW50IF9fZGV2aW5pdCBod3NwaW5sb2NrX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IHJlc291cmNlICpyZXM7CisJdm9p
ZCBfX2lvbWVtICppb19iYXNlOworCWludCBpZDsKKworCXZvaWQgX19pb21lbSAqc3lzc3RhdHVz
X3JlZzsKKworCS8qIERldGVybWluZSBudW1iZXIgb2YgbG9ja3MgKi8KKwlzeXNzdGF0dXNfcmVn
ID0gaW9yZW1hcChPTUFQNDRYWF9TUElOTE9DS19CQVNFICsgU1lTU1RBVFVTX09GRlNFVCwKKwkJ
CQkJCQkJc2l6ZW9mKHUzMikpOworCWlmIChzeXNzdGF0dXNfcmVnID09IE5VTEwpCisJCXJldHVy
biAtRUZBVUxUOworCisJc3dpdGNoIChyZWFkbChzeXNzdGF0dXNfcmVnKSA+PiBTUElOTE9DS19O
VU1MT0NLU19CSVRfT0ZGU0VUKSB7CisJY2FzZSBTUElOTE9DS18zMl9SRUdTOgorCQlod3NwaW5s
b2NrX3N0YXRlLm51bV9sb2NrcyA9IDMyOworCQlicmVhazsKKwljYXNlIFNQSU5MT0NLXzY0X1JF
R1M6CisJCWh3c3BpbmxvY2tfc3RhdGUubnVtX2xvY2tzID0gNjQ7CisJCWJyZWFrOworCWNhc2Ug
U1BJTkxPQ0tfMTI4X1JFR1M6CisJCWh3c3BpbmxvY2tfc3RhdGUubnVtX2xvY2tzID0gMTI4Owor
CQlicmVhazsKKwljYXNlIFNQSU5MT0NLXzI1Nl9SRUdTOgorCQlod3NwaW5sb2NrX3N0YXRlLm51
bV9sb2NrcyA9IDI1NjsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJcmV0dXJuIC1FSU5WQUw7CS8q
IEludmFsaWQgc3BpbmxvY2sgY291bnQgY29kZSAqLworCX0KKwlpb3VubWFwKHN5c3N0YXR1c19y
ZWcpOworCisJLyogQWxsb2NhdGUgc3BpbmxvY2sgZGV2aWNlIG9iamVjdHMgKi8KKwlod3NwaW5s
b2NrX2FycmF5ID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IGh3c3BpbmxvY2spICoKKwkJCWh3c3Bp
bmxvY2tfc3RhdGUubnVtX2xvY2tzLCBHRlBfS0VSTkVMKTsKKwlpZiAoV0FSTl9PTihod3NwaW5s
b2NrX2FycmF5ID09IE5VTEwpKQorCQlyZXR1cm4gLUVOT01FTTsKKworCS8qIEluaXRpYWxpemUg
bG9jYWwgbG9jayAqLworCXNwaW5fbG9ja19pbml0KCZod3NwaW5sb2NrX3N0YXRlLmxvY2FsX2xv
Y2spOworCisJLyogR2V0IGFkZHJlc3MgaW5mbyAqLworCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNv
dXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7CisKKwkvKiBNYXAgc3BpbmxvY2sgbW9kdWxl
IGFkZHJlc3Mgc3BhY2UgKi8KKwlpb19iYXNlID0gaW9yZW1hcChyZXMtPnN0YXJ0LCByZXNvdXJj
ZV9zaXplKHJlcykpOworCWh3c3BpbmxvY2tfc3RhdGUuaW9fYmFzZSA9IGlvX2Jhc2U7CisKKwkv
KiBTZXQgdXAgZWFjaCBpbmRpdmlkdWFsIGxvY2sgaGFuZGxlICovCisJZm9yIChpZCA9IDA7IGlk
IDwgaHdzcGlubG9ja19zdGF0ZS5udW1fbG9ja3M7IGlkKyspIHsKKwkJaHdzcGlubG9ja19hcnJh
eVtpZF0uaWQJCT0gaWQ7CisJCWh3c3BpbmxvY2tfYXJyYXlbaWRdLnBkZXYJCT0gcGRldjsKKwkJ
aHdzcGlubG9ja19hcnJheVtpZF0uaXNfaW5pdAkJPSB0cnVlOworCQlod3NwaW5sb2NrX2FycmF5
W2lkXS5pc19hbGxvY2F0ZWQJPSBmYWxzZTsKKworCQlod3NwaW5sb2NrX2FycmF5W2lkXS5sb2Nr
X3JlZwk9IGlvX2Jhc2UgKyBMT0NLX0JBU0VfT0ZGU0VUICsKKwkJCQkJCQlzaXplb2YodTMyKSAq
IGlkOworCX0KKwlwbV9ydW50aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsKKworCXJldHVybiAwOwor
fQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBod3NwaW5sb2NrX2RyaXZlciA9IHsK
KwkucHJvYmUJCT0gaHdzcGlubG9ja19wcm9iZSwKKwkuZHJpdmVyCQk9IHsKKwkJLm5hbWUJPSAi
aHdzcGlubG9jayIsCisJfSwKK307CisKKy8qIEluaXRpYWxpemF0aW9uIGZ1bmN0aW9uICovCitz
dGF0aWMgaW50IF9faW5pdCBod3NwaW5sb2NrX2luaXQodm9pZCkKK3sKKwlpbnQgcmV0dmFsID0g
MDsKKworCS8qIFJlZ2lzdGVyIHNwaW5sb2NrIGRyaXZlciAqLworCXJldHZhbCA9IHBsYXRmb3Jt
X2RyaXZlcl9yZWdpc3RlcigmaHdzcGlubG9ja19kcml2ZXIpOworCisJcmV0dXJuIHJldHZhbDsK
K30KK3Bvc3Rjb3JlX2luaXRjYWxsKGh3c3BpbmxvY2tfaW5pdCk7CisKKy8qIENsZWFudXAgZnVu
Y3Rpb24gKi8KK3N0YXRpYyB2b2lkIF9fZXhpdCBod3NwaW5sb2NrX2V4aXQodm9pZCkKK3sKKwlp
bnQgaWQ7CisKKwlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3RlcigmaHdzcGlubG9ja19kcml2ZXIp
OworCisJZm9yIChpZCA9IDA7IGlkIDwgaHdzcGlubG9ja19zdGF0ZS5udW1fbG9ja3M7IGlkKysp
CisJCWh3c3BpbmxvY2tfYXJyYXlbaWRdLmlzX2luaXQgPSBmYWxzZTsKKwlpb3VubWFwKGh3c3Bp
bmxvY2tfc3RhdGUuaW9fYmFzZSk7CisKKwkvKiBGcmVlIHNwaW5sb2NrIGRldmljZSBvYmplY3Rz
ICovCisJaWYgKGh3c3BpbmxvY2tfc3RhdGUuaXNfaW5pdCkKKwkJa2ZyZWUoaHdzcGlubG9ja19h
cnJheSk7Cit9Cittb2R1bGVfZXhpdChod3NwaW5sb2NrX2V4aXQpOworCitNT0RVTEVfTElDRU5T
RSgiR1BMIHYyIik7CitNT0RVTEVfREVTQ1JJUFRJT04oIkhhcmR3YXJlIHNwaW5sb2NrIGRyaXZl
ciIpOworTU9EVUxFX0FVVEhPUigiU2ltb24gUXVlIik7CitNT0RVTEVfQVVUSE9SKCJIYXJpIEth
bmlnZXJpIik7CmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2h3
c3BpbmxvY2suaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdzcGlubG9jay5o
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmVhNjRjNDgKLS0tIC9kZXYvbnVs
bAorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2h3c3BpbmxvY2suaApAQCAt
MCwwICsxLDQ3IEBACisvKgorICogT01BUCBoYXJkd2FyZSBzcGlubG9jayBkcml2ZXIgaGVhZGVy
CisgKgorICogQ29weXJpZ2h0IChDKSAyMDEwIFRleGFzIEluc3RydW1lbnRzLiBBbGwgcmlnaHRz
IHJlc2VydmVkLgorICoKKyAqIENvbnRhY3Q6IFNpbW9uIFF1ZSA8c3F1ZUB0aS5jb20+CisgKgor
ICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vcgorICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UKKyAqIHZlcnNpb24gMiBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4g
dGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0CisgKiBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFC
SUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlIEdOVQor
ICogR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBz
aG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlCisgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJl
ZSBTb2Z0d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZs
b29yLCBCb3N0b24sIE1BCisgKiAwMjExMC0xMzAxIFVTQQorICoKKyAqLworCisjaWZuZGVmIEhX
U1BJTkxPQ0tfSAorI2RlZmluZSBIV1NQSU5MT0NLX0gKKworI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPgorI2luY2x1ZGUgPHBsYXQvb21hcDQ0eHguaD4KKworLyogVmFsdWVzIHRo
YXQgYXJlIHJlYWQgZnJvbSB0aGUgc3BpbmxvY2sgcmVnaXN0ZXIgKi8KKy8qIEFDUVVJUkVEIG1l
YW5zIHRoZSBsb2NrIHdhcyBzdWNjZXNzZnVsbHkgYWNxdWlyZWQgYnkgdGhlIHJlYWQgb3BlcmF0
aW9uICovCisvKiBCVVNZIG1lYW5zIHRoZSBsb2NrIHdhcyBhbHJlYWR5IGFjcXVpcmVkIGJlZm9y
ZSB0aGUgcmVhZCBvcGVyYXRpb24sIGFuZCAqLworLyogICB0aHVzIHRoZSByZWFkIG9wZXJhdGlv
biB3YXMgbm90IHN1Y2Nlc3NmdWwgKi8KKyNkZWZpbmUgSFdTUElOTE9DS19BQ1FVSVJFRAkwCisj
ZGVmaW5lIEhXU1BJTkxPQ0tfQlVTWQkJMQorCitzdHJ1Y3QgaHdzcGlubG9jazsKKworaW50IGh3
c3BpbmxvY2tfbG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlKTsKK2ludCBod3NwaW5sb2Nr
X3RyeWxvY2soc3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSk7CitpbnQgaHdzcGlubG9ja191bmxv
Y2soc3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSk7CisKK3N0cnVjdCBod3NwaW5sb2NrICpod3Nw
aW5sb2NrX3JlcXVlc3Qodm9pZCk7CitzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19yZXF1
ZXN0X3NwZWNpZmljKHVuc2lnbmVkIGludCBpZCk7CitpbnQgaHdzcGlubG9ja19mcmVlKHN0cnVj
dCBod3NwaW5sb2NrICpod3NwaW5sb2NrX3B0cik7CisKKyNlbmRpZiAvKiBIV1NQSU5MT0NLX0gg
Ki8KLS0gCjEuNy4wCgo=

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48dlee03entticom_--
