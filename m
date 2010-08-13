From: "Que, Simon" <sque@ti.com>
Subject: [PATCH 2/3 v3] omap: hwspinlock: Created driver for OMAP hardware
 spinlock
Date: Fri, 13 Aug 2010 14:59:02 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB0@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB0dlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36541 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411Ab0HMT7F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Aug 2010 15:59:05 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB0dlee03entticom_
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
 arch/arm/plat-omap/hwspinlock.c              |  347 ++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/hwspinlock.h |   53 ++++
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
index 0000000..f4b0185
--- /dev/null
+++ b/arch/arm/plat-omap/hwspinlock.c
@@ -0,0 +1,347 @@
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
+#include <linux/list.h>
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
+       struct list_head head;
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
+/* List for keeping track of free locks */
+static struct list_head free_locks;
+
+/* API functions */
+
+/* Busy loop to acquire a spinlock, with timeout */
+int hwspinlock_lock_timeout(struct hwspinlock *handle, int max_attempts)
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
+       } while (retval =3D=3D HWSPINLOCK_BUSY && (max_attempts > 0 &&
+                                       num_attempts < max_attempts));
+
+       /* If there was a timeout, put the device back */
+       if (num_attempts >=3D max_attempts)
+               pm_runtime_put_sync(&handle->pdev->dev);
+
+       return retval;
+}
+EXPORT_SYMBOL(hwspinlock_lock_timeout);
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
+       struct hwspinlock *handle =3D NULL;
+       unsigned long flags;
+
+       spin_lock_irqsave(&hwspinlock_state.local_lock, flags);
+
+       if (WARN_ON(!hwspinlock_state.is_init))
+               goto exit;
+
+       if (WARN_ON(list_empty(&free_locks)))
+               goto exit;
+
+       handle =3D (struct hwspinlock *) free_locks.next;
+       list_del(free_locks.next);
+       handle->is_allocated =3D true;
+
+exit:
+       spin_unlock_irqrestore(&hwspinlock_state.local_lock, flags);
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
+       if (WARN_ON(!hwspinlock_state.is_init))
+               goto exit;
+
+       if (WARN_ON(id >=3D hwspinlock_state.num_locks))
+               goto exit;
+
+       if (WARN_ON(hwspinlock_array[id].is_allocated))
+               goto exit;
+
+       handle =3D &hwspinlock_array[id];
+       handle->is_allocated =3D true;
+
+       /* Remove from free lock list */
+       list_del(&handle->head);
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
+       unsigned long flags;
+
+       spin_lock_irqsave(&hwspinlock_state.local_lock, flags);
+
+       if (WARN_ON(handle =3D=3D NULL))
+               return -EINVAL;
+
+       if (WARN_ON(!handle->is_allocated))
+               return -ENOMEM;
+
+       list_add(&free_locks, &handle->head);
+       handle->is_allocated =3D false;
+
+       spin_unlock_irqrestore(&hwspinlock_state.local_lock, flags);
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
+       /* Get address info */
+       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+       /* Map spinlock module address space */
+       io_base =3D ioremap(res->start, resource_size(res));
+       hwspinlock_state.io_base =3D io_base;
+
+       /* Determine number of locks */
+       switch (readl(io_base + SYSSTATUS_OFFSET) >>
+                               SPINLOCK_NUMLOCKS_BIT_OFFSET) {
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
+       /* Mark module as initialized */
+       hwspinlock_state.is_init =3D true;
+
+       /* Initialize lock lists */
+       INIT_LIST_HEAD(&free_locks);
+
+       /* Set up each individual lock handle */
+       for (id =3D 0; id < hwspinlock_state.num_locks; id++) {
+               hwspinlock_array[id].id                 =3D id;
+               hwspinlock_array[id].pdev               =3D pdev;
+               hwspinlock_array[id].is_init            =3D true;
+               hwspinlock_array[id].is_allocated       =3D false;
+
+               hwspinlock_array[id].lock_reg   =3D io_base + LOCK_BASE_OFF=
SET +
+                                                       sizeof(u32) * id;
+
+               /* Add it to the list of free locks */
+               list_add(&hwspinlock_array[id].head, &free_locks);
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
+
+       INIT_LIST_HEAD(&free_locks);    /* Clear free lock list */
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
index 0000000..3a38190
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/hwspinlock.h
@@ -0,0 +1,53 @@
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
+/* Basic operations */
+int hwspinlock_lock_timeout(struct hwspinlock *handle, int max_attempts);
+int hwspinlock_unlock(struct hwspinlock *handle);
+
+/* Try locking once */
+#define hwspinlock_trylock(h) (hwspinlock_lock_timeout(h, 1))
+/* Lock without timeout */
+#define hwspinlock_lock(h) (hwspinlock_lock_timeout(h, -1))
+
+/* Allocation functions */
+struct hwspinlock *hwspinlock_request(void);
+struct hwspinlock *hwspinlock_request_specific(unsigned int id);
+int hwspinlock_free(struct hwspinlock *hwspinlock_ptr);
+
+#endif /* HWSPINLOCK_H */
--
1.7.0


--_002_F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB0dlee03entticom_
Content-Type: application/octet-stream;
	name="0002-Created-driver-for-OMAP-hardware-spinlock.patch"
Content-Description: 0002-Created-driver-for-OMAP-hardware-spinlock.patch
Content-Disposition: attachment;
	filename="0002-Created-driver-for-OMAP-hardware-spinlock.patch"; size=17228;
	creation-date="Fri, 13 Aug 2010 15:05:47 GMT";
	modification-date="Fri, 13 Aug 2010 15:05:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyZTFmZjdkMTk0MGE0NjU1OGYyM2MzMTFhNDYyNDM4YzY5NDc3MzBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgpEYXRlOiBGcmksIDYg
QXVnIDIwMTAgMTA6NDM6MDYgLTA1MDAKU3ViamVjdDogW1BBVENIIDIvM10gQ3JlYXRlZCBkcml2
ZXIgZm9yIE9NQVAgaGFyZHdhcmUgc3BpbmxvY2suCgogLSBSZXNlcnZlZCBzcGlubG9ja3MgZm9y
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
cmNoL2FybS9wbGF0LW9tYXAvaHdzcGlubG9jay5jICAgICAgICAgICAgICB8ICAzNDcgKysrKysr
KysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdz
cGlubG9jay5oIHwgICA1MyArKysrCiAzIGZpbGVzIGNoYW5nZWQsIDQ2NSBpbnNlcnRpb25zKCsp
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
LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZjRiMDE4NQotLS0gL2Rldi9u
dWxsCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9od3NwaW5sb2NrLmMKQEAgLTAsMCArMSwzNDcg
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
L2xpc3QuaD4KKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+CisjaW5jbHVkZSA8bGludXgv
c2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+CisKKyNpbmNsdWRlIDxwbGF0L2h3
c3BpbmxvY2suaD4KKworLyogU3BpbmxvY2sgcmVnaXN0ZXIgb2Zmc2V0cyAqLworI2RlZmluZSBT
WVNTVEFUVVNfT0ZGU0VUCQkweDAwMTQKKyNkZWZpbmUgTE9DS19CQVNFX09GRlNFVAkJMHgwODAw
CisKKy8qIFNwaW5sb2NrIGNvdW50IGNvZGUgKi8KKyNkZWZpbmUgU1BJTkxPQ0tfMzJfUkVHUwkJ
MQorI2RlZmluZSBTUElOTE9DS182NF9SRUdTCQkyCisjZGVmaW5lIFNQSU5MT0NLXzEyOF9SRUdT
CQk0CisjZGVmaW5lIFNQSU5MT0NLXzI1Nl9SRUdTCQk4CisjZGVmaW5lIFNQSU5MT0NLX05VTUxP
Q0tTX0JJVF9PRkZTRVQJMjQKKworLyogTnVtYmVyIG9mIGF0dGVtcHRzIHRvIHRyeSBsb2NraW5n
ICovCisjZGVmaW5lIE1BWF9MT0NLX0FUVEVNUFRTCQkxMDAwCisKKy8qIGZvciBtYW5hZ2luZyBh
IGhhcmR3YXJlIHNwaW5sb2NrIG1vZHVsZSAqLworc3RydWN0IGh3c3BpbmxvY2tfbW9kdWxlX3N0
YXRlIHsKKwlib29sIGlzX2luaXQ7CQkJLyogRm9yIGZpcnN0LXRpbWUgaW5pdGlhbGl6YXRpb24g
Ki8KKwlpbnQgbnVtX2xvY2tzOwkJCS8qIFRvdGFsIG51bWJlciBvZiBsb2NrcyBpbiBzeXN0ZW0g
Ki8KKwlzcGlubG9ja190IGxvY2FsX2xvY2s7CQkvKiBMb2NhbCBwcm90ZWN0aW9uICovCisJdm9p
ZCBfX2lvbWVtICppb19iYXNlOwkJLyogTWFwcGVkIGJhc2UgYWRkcmVzcyAqLworfTsKKworLyog
UG9pbnRzIHRvIHRoZSBoYXJkd2FyZSBzcGlubG9jayBtb2R1bGUgKi8KK3N0YXRpYyBzdHJ1Y3Qg
aHdzcGlubG9ja19tb2R1bGVfc3RhdGUgaHdzcGlubG9ja19zdGF0ZTsKKworLyogU3BpbmxvY2sg
b2JqZWN0ICovCitzdHJ1Y3QgaHdzcGlubG9jayB7CisJc3RydWN0IGxpc3RfaGVhZCBoZWFkOwor
CWJvb2wgaXNfaW5pdDsKKwlpbnQgaWQ7CisJdm9pZCBfX2lvbWVtICpsb2NrX3JlZzsKKwlib29s
IGlzX2FsbG9jYXRlZDsKKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2OworfTsKKworLyog
QXJyYXkgb2Ygc3BpbmxvY2tzICovCitzdGF0aWMgc3RydWN0IGh3c3BpbmxvY2sgKmh3c3Bpbmxv
Y2tfYXJyYXk7CisKKy8qIExpc3QgZm9yIGtlZXBpbmcgdHJhY2sgb2YgZnJlZSBsb2NrcyAqLwor
c3RhdGljIHN0cnVjdCBsaXN0X2hlYWQgZnJlZV9sb2NrczsKKworLyogQVBJIGZ1bmN0aW9ucyAq
LworCisvKiBCdXN5IGxvb3AgdG8gYWNxdWlyZSBhIHNwaW5sb2NrLCB3aXRoIHRpbWVvdXQgKi8K
K2ludCBod3NwaW5sb2NrX2xvY2tfdGltZW91dChzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlLCBp
bnQgbWF4X2F0dGVtcHRzKQoreworCWludCByZXR2YWw7CisJaW50IG51bV9hdHRlbXB0cyA9IDA7
CisKKwlpZiAoV0FSTl9PTihoYW5kbGUgPT0gTlVMTCkpCisJCXJldHVybiAtRUlOVkFMOworCisJ
LyogVGhpcyBpcyBub3QgcGVybWl0dGVkIGluIElSUSBiZWNhdXNlIHdlIGRvIG5vdCB3YW50IGEg
Y29udGV4dCAqLworCS8qIHN3aXRjaCB3aGlsZSB0aGUgbG9jayBpcyBiZWluZyBoZWxkICovCisJ
aWYgKFdBUk5fT04oaW5faXJxKCkpKQorCQlyZXR1cm4gLUVQRVJNOworCisJaWYgKHBtX3J1bnRp
bWVfZ2V0X3N5bmMoJmhhbmRsZS0+cGRldi0+ZGV2KSA8IDApCisJCXJldHVybiAtRU5PREVWOwor
CisJLyogQXR0ZW1wdCB0byBhY3F1aXJlIHRoZSBsb2NrIGJ5IHJlYWRpbmcgZnJvbSBpdCAqLwor
CWRvIHsKKwkJcmV0dmFsID0gcmVhZGwoaGFuZGxlLT5sb2NrX3JlZyk7CisJCW51bV9hdHRlbXB0
cysrOwkJLyogSW5jcmVtZW50IHRoZSB0aW1lb3V0IGNvdW50ZXIgKi8KKwl9IHdoaWxlIChyZXR2
YWwgPT0gSFdTUElOTE9DS19CVVNZICYmIChtYXhfYXR0ZW1wdHMgPiAwICYmCisJCQkJCW51bV9h
dHRlbXB0cyA8IG1heF9hdHRlbXB0cykpOworCisJLyogSWYgdGhlcmUgd2FzIGEgdGltZW91dCwg
cHV0IHRoZSBkZXZpY2UgYmFjayAqLworCWlmIChudW1fYXR0ZW1wdHMgPj0gbWF4X2F0dGVtcHRz
KQorCQlwbV9ydW50aW1lX3B1dF9zeW5jKCZoYW5kbGUtPnBkZXYtPmRldik7CisKKwlyZXR1cm4g
cmV0dmFsOworfQorRVhQT1JUX1NZTUJPTChod3NwaW5sb2NrX2xvY2tfdGltZW91dCk7CisKKy8q
IFJlbGVhc2UgYSBzcGlubG9jayAqLworaW50IGh3c3BpbmxvY2tfdW5sb2NrKHN0cnVjdCBod3Nw
aW5sb2NrICpoYW5kbGUpCit7CisJaWYgKFdBUk5fT04oaGFuZGxlID09IE5VTEwpKQorCQlyZXR1
cm4gLUVJTlZBTDsKKworCS8qIFJlbGVhc2UgaXQgYnkgd3JpdGluZyAwIHRvIGl0ICovCisJd3Jp
dGVsKDAsIGhhbmRsZS0+bG9ja19yZWcpOworCisJcG1fcnVudGltZV9wdXRfc3luYygmaGFuZGxl
LT5wZGV2LT5kZXYpOworCisJcmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tf
dW5sb2NrKTsKKworLyogUmVxdWVzdCBhbiB1bmNsYWltZWQgc3BpbmxvY2sgKi8KK3N0cnVjdCBo
d3NwaW5sb2NrICpod3NwaW5sb2NrX3JlcXVlc3Qodm9pZCkKK3sKKwlzdHJ1Y3QgaHdzcGlubG9j
ayAqaGFuZGxlID0gTlVMTDsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCisJc3Bpbl9sb2NrX2ly
cXNhdmUoJmh3c3BpbmxvY2tfc3RhdGUubG9jYWxfbG9jaywgZmxhZ3MpOworCisJaWYgKFdBUk5f
T04oIWh3c3BpbmxvY2tfc3RhdGUuaXNfaW5pdCkpCisJCWdvdG8gZXhpdDsKKworCWlmIChXQVJO
X09OKGxpc3RfZW1wdHkoJmZyZWVfbG9ja3MpKSkKKwkJZ290byBleGl0OworCisJaGFuZGxlID0g
KHN0cnVjdCBod3NwaW5sb2NrICopIGZyZWVfbG9ja3MubmV4dDsKKwlsaXN0X2RlbChmcmVlX2xv
Y2tzLm5leHQpOworCWhhbmRsZS0+aXNfYWxsb2NhdGVkID0gdHJ1ZTsKKworZXhpdDoKKwlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZod3NwaW5sb2NrX3N0YXRlLmxvY2FsX2xvY2ssIGZsYWdzKTsK
KwlyZXR1cm4gaGFuZGxlOworfQorRVhQT1JUX1NZTUJPTChod3NwaW5sb2NrX3JlcXVlc3QpOwor
CisvKiBSZXF1ZXN0IGFuIHVuY2xhaW1lZCBzcGlubG9jayBieSBJRCAqLworc3RydWN0IGh3c3Bp
bmxvY2sgKmh3c3BpbmxvY2tfcmVxdWVzdF9zcGVjaWZpYyh1bnNpZ25lZCBpbnQgaWQpCit7CisJ
c3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSA9IE5VTEw7CisJdW5zaWduZWQgbG9uZyBmbGFnczsK
KworCXNwaW5fbG9ja19pcnFzYXZlKCZod3NwaW5sb2NrX3N0YXRlLmxvY2FsX2xvY2ssIGZsYWdz
KTsKKworCWlmIChXQVJOX09OKCFod3NwaW5sb2NrX3N0YXRlLmlzX2luaXQpKQorCQlnb3RvIGV4
aXQ7CisKKwlpZiAoV0FSTl9PTihpZCA+PSBod3NwaW5sb2NrX3N0YXRlLm51bV9sb2NrcykpCisJ
CWdvdG8gZXhpdDsKKworCWlmIChXQVJOX09OKGh3c3BpbmxvY2tfYXJyYXlbaWRdLmlzX2FsbG9j
YXRlZCkpCisJCWdvdG8gZXhpdDsKKworCWhhbmRsZSA9ICZod3NwaW5sb2NrX2FycmF5W2lkXTsK
KwloYW5kbGUtPmlzX2FsbG9jYXRlZCA9IHRydWU7CisKKwkvKiBSZW1vdmUgZnJvbSBmcmVlIGxv
Y2sgbGlzdCAqLworCWxpc3RfZGVsKCZoYW5kbGUtPmhlYWQpOworCitleGl0OgorCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJmh3c3BpbmxvY2tfc3RhdGUubG9jYWxfbG9jaywgZmxhZ3MpOworCXJl
dHVybiBoYW5kbGU7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfcmVxdWVzdF9zcGVjaWZp
Yyk7CisKKy8qIFJlbGVhc2UgYSBjbGFpbWVkIHNwaW5sb2NrICovCitpbnQgaHdzcGlubG9ja19m
cmVlKHN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUpCit7CisJdW5zaWduZWQgbG9uZyBmbGFnczsK
KworCXNwaW5fbG9ja19pcnFzYXZlKCZod3NwaW5sb2NrX3N0YXRlLmxvY2FsX2xvY2ssIGZsYWdz
KTsKKworCWlmIChXQVJOX09OKGhhbmRsZSA9PSBOVUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisK
KwlpZiAoV0FSTl9PTighaGFuZGxlLT5pc19hbGxvY2F0ZWQpKQorCQlyZXR1cm4gLUVOT01FTTsK
KworCWxpc3RfYWRkKCZmcmVlX2xvY2tzLCAmaGFuZGxlLT5oZWFkKTsKKwloYW5kbGUtPmlzX2Fs
bG9jYXRlZCA9IGZhbHNlOworCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaHdzcGlubG9ja19z
dGF0ZS5sb2NhbF9sb2NrLCBmbGFncyk7CisJcmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKGh3
c3BpbmxvY2tfZnJlZSk7CisKKy8qIFByb2JlIGZ1bmN0aW9uICovCitzdGF0aWMgaW50IF9fZGV2
aW5pdCBod3NwaW5sb2NrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJ
c3RydWN0IHJlc291cmNlICpyZXM7CisJdm9pZCBfX2lvbWVtICppb19iYXNlOworCWludCBpZDsK
KworCS8qIEdldCBhZGRyZXNzIGluZm8gKi8KKwlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOworCisJLyogTWFwIHNwaW5sb2NrIG1vZHVsZSBhZGRy
ZXNzIHNwYWNlICovCisJaW9fYmFzZSA9IGlvcmVtYXAocmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6
ZShyZXMpKTsKKwlod3NwaW5sb2NrX3N0YXRlLmlvX2Jhc2UgPSBpb19iYXNlOworCisJLyogRGV0
ZXJtaW5lIG51bWJlciBvZiBsb2NrcyAqLworCXN3aXRjaCAocmVhZGwoaW9fYmFzZSArIFNZU1NU
QVRVU19PRkZTRVQpID4+CisJCQkJU1BJTkxPQ0tfTlVNTE9DS1NfQklUX09GRlNFVCkgeworCWNh
c2UgU1BJTkxPQ0tfMzJfUkVHUzoKKwkJaHdzcGlubG9ja19zdGF0ZS5udW1fbG9ja3MgPSAzMjsK
KwkJYnJlYWs7CisJY2FzZSBTUElOTE9DS182NF9SRUdTOgorCQlod3NwaW5sb2NrX3N0YXRlLm51
bV9sb2NrcyA9IDY0OworCQlicmVhazsKKwljYXNlIFNQSU5MT0NLXzEyOF9SRUdTOgorCQlod3Nw
aW5sb2NrX3N0YXRlLm51bV9sb2NrcyA9IDEyODsKKwkJYnJlYWs7CisJY2FzZSBTUElOTE9DS18y
NTZfUkVHUzoKKwkJaHdzcGlubG9ja19zdGF0ZS5udW1fbG9ja3MgPSAyNTY7CisJCWJyZWFrOwor
CWRlZmF1bHQ6CisJCXJldHVybiAtRUlOVkFMOwkvKiBJbnZhbGlkIHNwaW5sb2NrIGNvdW50IGNv
ZGUgKi8KKwl9CisKKwkvKiBBbGxvY2F0ZSBzcGlubG9jayBkZXZpY2Ugb2JqZWN0cyAqLworCWh3
c3BpbmxvY2tfYXJyYXkgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgaHdzcGlubG9jaykgKgorCQkJ
aHdzcGlubG9ja19zdGF0ZS5udW1fbG9ja3MsIEdGUF9LRVJORUwpOworCWlmIChXQVJOX09OKGh3
c3BpbmxvY2tfYXJyYXkgPT0gTlVMTCkpCisJCXJldHVybiAtRU5PTUVNOworCisJLyogSW5pdGlh
bGl6ZSBsb2NhbCBsb2NrICovCisJc3Bpbl9sb2NrX2luaXQoJmh3c3BpbmxvY2tfc3RhdGUubG9j
YWxfbG9jayk7CisKKwkvKiBNYXJrIG1vZHVsZSBhcyBpbml0aWFsaXplZCAqLworCWh3c3Bpbmxv
Y2tfc3RhdGUuaXNfaW5pdCA9IHRydWU7CisKKwkvKiBJbml0aWFsaXplIGxvY2sgbGlzdHMgKi8K
KwlJTklUX0xJU1RfSEVBRCgmZnJlZV9sb2Nrcyk7CisKKwkvKiBTZXQgdXAgZWFjaCBpbmRpdmlk
dWFsIGxvY2sgaGFuZGxlICovCisJZm9yIChpZCA9IDA7IGlkIDwgaHdzcGlubG9ja19zdGF0ZS5u
dW1fbG9ja3M7IGlkKyspIHsKKwkJaHdzcGlubG9ja19hcnJheVtpZF0uaWQJCQk9IGlkOworCQlo
d3NwaW5sb2NrX2FycmF5W2lkXS5wZGV2CQk9IHBkZXY7CisJCWh3c3BpbmxvY2tfYXJyYXlbaWRd
LmlzX2luaXQJCT0gdHJ1ZTsKKwkJaHdzcGlubG9ja19hcnJheVtpZF0uaXNfYWxsb2NhdGVkCT0g
ZmFsc2U7CisKKwkJaHdzcGlubG9ja19hcnJheVtpZF0ubG9ja19yZWcJPSBpb19iYXNlICsgTE9D
S19CQVNFX09GRlNFVCArCisJCQkJCQkJc2l6ZW9mKHUzMikgKiBpZDsKKworCQkvKiBBZGQgaXQg
dG8gdGhlIGxpc3Qgb2YgZnJlZSBsb2NrcyAqLworCQlsaXN0X2FkZCgmaHdzcGlubG9ja19hcnJh
eVtpZF0uaGVhZCwgJmZyZWVfbG9ja3MpOworCX0KKwlwbV9ydW50aW1lX2VuYWJsZSgmcGRldi0+
ZGV2KTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBo
d3NwaW5sb2NrX2RyaXZlciA9IHsKKwkucHJvYmUJCT0gaHdzcGlubG9ja19wcm9iZSwKKwkuZHJp
dmVyCQk9IHsKKwkJLm5hbWUJPSAiaHdzcGlubG9jayIsCisJfSwKK307CisKKy8qIEluaXRpYWxp
emF0aW9uIGZ1bmN0aW9uICovCitzdGF0aWMgaW50IF9faW5pdCBod3NwaW5sb2NrX2luaXQodm9p
ZCkKK3sKKwlpbnQgcmV0dmFsID0gMDsKKworCS8qIFJlZ2lzdGVyIHNwaW5sb2NrIGRyaXZlciAq
LworCXJldHZhbCA9IHBsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcigmaHdzcGlubG9ja19kcml2ZXIp
OworCisJcmV0dXJuIHJldHZhbDsKK30KK3Bvc3Rjb3JlX2luaXRjYWxsKGh3c3BpbmxvY2tfaW5p
dCk7CisKKy8qIENsZWFudXAgZnVuY3Rpb24gKi8KK3N0YXRpYyB2b2lkIF9fZXhpdCBod3NwaW5s
b2NrX2V4aXQodm9pZCkKK3sKKwlpbnQgaWQ7CisKKwlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3Rl
cigmaHdzcGlubG9ja19kcml2ZXIpOworCisJZm9yIChpZCA9IDA7IGlkIDwgaHdzcGlubG9ja19z
dGF0ZS5udW1fbG9ja3M7IGlkKyspCisJCWh3c3BpbmxvY2tfYXJyYXlbaWRdLmlzX2luaXQgPSBm
YWxzZTsKKwlpb3VubWFwKGh3c3BpbmxvY2tfc3RhdGUuaW9fYmFzZSk7CisKKwkvKiBGcmVlIHNw
aW5sb2NrIGRldmljZSBvYmplY3RzICovCisJaWYgKGh3c3BpbmxvY2tfc3RhdGUuaXNfaW5pdCkK
KwkJa2ZyZWUoaHdzcGlubG9ja19hcnJheSk7CisKKwlJTklUX0xJU1RfSEVBRCgmZnJlZV9sb2Nr
cyk7CS8qIENsZWFyIGZyZWUgbG9jayBsaXN0ICovCit9Cittb2R1bGVfZXhpdChod3NwaW5sb2Nr
X2V4aXQpOworCitNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7CitNT0RVTEVfREVTQ1JJUFRJT04o
IkhhcmR3YXJlIHNwaW5sb2NrIGRyaXZlciIpOworTU9EVUxFX0FVVEhPUigiU2ltb24gUXVlIik7
CitNT0RVTEVfQVVUSE9SKCJIYXJpIEthbmlnZXJpIik7CmRpZmYgLS1naXQgYS9hcmNoL2FybS9w
bGF0LW9tYXAvaW5jbHVkZS9wbGF0L2h3c3BpbmxvY2suaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9p
bmNsdWRlL3BsYXQvaHdzcGlubG9jay5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAuLjNhMzgxOTAKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVk
ZS9wbGF0L2h3c3BpbmxvY2suaApAQCAtMCwwICsxLDUzIEBACisvKgorICogT01BUCBoYXJkd2Fy
ZSBzcGlubG9jayBkcml2ZXIgaGVhZGVyCisgKgorICogQ29weXJpZ2h0IChDKSAyMDEwIFRleGFz
IEluc3RydW1lbnRzLiBBbGwgcmlnaHRzIHJlc2VydmVkLgorICoKKyAqIENvbnRhY3Q6IFNpbW9u
IFF1ZSA8c3F1ZUB0aS5jb20+CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7
IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0
ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqIHZlcnNpb24gMiBhcyBw
dWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlzIHBy
b2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwg
YnV0CisgKiBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IFBVUlBPU0UuICBTZWUgdGhlIEdOVQorICogR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9y
ZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsg
aWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwg
NTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BCisgKiAwMjExMC0xMzAxIFVT
QQorICoKKyAqLworCisjaWZuZGVmIEhXU1BJTkxPQ0tfSAorI2RlZmluZSBIV1NQSU5MT0NLX0gK
KworI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPHBsYXQvb21h
cDQ0eHguaD4KKworLyogVmFsdWVzIHRoYXQgYXJlIHJlYWQgZnJvbSB0aGUgc3BpbmxvY2sgcmVn
aXN0ZXIgKi8KKy8qIEFDUVVJUkVEIG1lYW5zIHRoZSBsb2NrIHdhcyBzdWNjZXNzZnVsbHkgYWNx
dWlyZWQgYnkgdGhlIHJlYWQgb3BlcmF0aW9uICovCisvKiBCVVNZIG1lYW5zIHRoZSBsb2NrIHdh
cyBhbHJlYWR5IGFjcXVpcmVkIGJlZm9yZSB0aGUgcmVhZCBvcGVyYXRpb24sIGFuZCAqLworLyog
ICB0aHVzIHRoZSByZWFkIG9wZXJhdGlvbiB3YXMgbm90IHN1Y2Nlc3NmdWwgKi8KKyNkZWZpbmUg
SFdTUElOTE9DS19BQ1FVSVJFRAkwCisjZGVmaW5lIEhXU1BJTkxPQ0tfQlVTWQkJMQorCitzdHJ1
Y3QgaHdzcGlubG9jazsKKworLyogQmFzaWMgb3BlcmF0aW9ucyAqLworaW50IGh3c3BpbmxvY2tf
bG9ja190aW1lb3V0KHN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUsIGludCBtYXhfYXR0ZW1wdHMp
OworaW50IGh3c3BpbmxvY2tfdW5sb2NrKHN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUpOworCisv
KiBUcnkgbG9ja2luZyBvbmNlICovCisjZGVmaW5lIGh3c3BpbmxvY2tfdHJ5bG9jayhoKSAoaHdz
cGlubG9ja19sb2NrX3RpbWVvdXQoaCwgMSkpCisvKiBMb2NrIHdpdGhvdXQgdGltZW91dCAqLwor
I2RlZmluZSBod3NwaW5sb2NrX2xvY2soaCkgKGh3c3BpbmxvY2tfbG9ja190aW1lb3V0KGgsIC0x
KSkKKworLyogQWxsb2NhdGlvbiBmdW5jdGlvbnMgKi8KK3N0cnVjdCBod3NwaW5sb2NrICpod3Nw
aW5sb2NrX3JlcXVlc3Qodm9pZCk7CitzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19yZXF1
ZXN0X3NwZWNpZmljKHVuc2lnbmVkIGludCBpZCk7CitpbnQgaHdzcGlubG9ja19mcmVlKHN0cnVj
dCBod3NwaW5sb2NrICpod3NwaW5sb2NrX3B0cik7CisKKyNlbmRpZiAvKiBIV1NQSU5MT0NLX0gg
Ki8KLS0gCjEuNy4wCgo=

--_002_F39349C6FA641B4A831B7BF4EBF4D4E1481CCCB0dlee03entticom_--
