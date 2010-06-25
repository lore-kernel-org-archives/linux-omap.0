From: "Que, Simon" <sque@ti.com>
Subject: [RFC] omap: hwspinlock: Added hwspinlock driver
Date: Thu, 24 Jun 2010 19:40:17 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F39349C6FA641B4A831B7BF4EBF4D4E14728DDBBdlee03entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56174 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab0FYAkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 20:40:19 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

--_002_F39349C6FA641B4A831B7BF4EBF4D4E14728DDBBdlee03entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

We are introducing a kernel driver for hardware spinlock, called hwspinlock=
.
It is designed to interface with the OMAP4 hardware spinlock module.  This
driver supports:
- Reserved spinlocks for internal use
- Dynamic allocation of unreserved locks
- Lock, unlock, and trylock functions, with or without disabling irqs/preem=
pt
- Registered as a platform device driver

The device initialization will set aside some spinlocks as reserved for
special-purpose use.  All other locks can be used by anyone.  This is
configurable using a Kconfig option.  The device initialization file is:
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

int hwspinlock_lock_irqsave(struct hwspinlock *, unsigned long *);
        Same as hwspinlock_lock, but disables interrupts and preemption
int hwspinlock_trylock_irqsave(struct hwspinlock *, unsigned long *);
        Same as hwspinlock_trylock, but disables interrupts and preemption
int hwspinlock_unlock_irqrestore(struct hwspinlock *, unsigned long);
        Same as hwspinlock_unlock, but restores interrupts and preemption

struct hwspinlock *hwspinlock_request(void);
        Provides for "dynamic allocation" of an unreserved hardware spinloc=
k.
        If no more locks are available, returns NULL.
struct hwspinlock *hwspinlock_request_specific(unsigned int);
        Provides for "static allocation" of a reserved hardware spinlock. T=
his
        allows the system to use a specific reserved lock, identified by an=
 ID.
        If the ID is invalid or if the desired lock is already allocated, t=
his
        will return NULL.
int hwspinlock_free(struct hwspinlock *);
        Frees an allocated hardware spinlock (either reserved or unreserved=
).

Please see the below patch contents, or the attached patch, and provide fee=
dback.

Signed-off-by: Simon Que <sque@ti.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 9f73d79..a13c188 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -182,3 +182,13 @@ config OMAP3_SDRC_AC_TIMING
          wish to say no.  Selecting yes without understanding what is
          going on could result in system crashes;

+config OMAP_HWSPINLOCK_NUM_RESERVED
+       int "Number of hardware spinlocks reserved for system use"
+       depends on ARCH_OMAP
+       default 8
+       range 0 32
+       help
+         Choose a number of hardware spinlocks to reserve for internal use=
.
+         The rest will be unreserved and availble for general use.  Make
+         that the number of reserved locks does not exceed the total numbe=
r
+         available locks.
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6725b3a..14af19a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -170,3 +170,5 @@ obj-y                                       +=3D $(nand=
-m) $(nand-y)

 smc91x-$(CONFIG_SMC91X)                        :=3D gpmc-smc91x.o
 obj-y                                  +=3D $(smc91x-m) $(smc91x-y)
+
+obj-y                                  +=3D hwspinlocks.o
\ No newline at end of file
diff --git a/arch/arm/mach-omap2/hwspinlocks.c b/arch/arm/mach-omap2/hwspin=
locks.c
new file mode 100644
index 0000000..de813a0
--- /dev/null
+++ b/arch/arm/mach-omap2/hwspinlocks.c
@@ -0,0 +1,126 @@
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
+/* Base address of HW spinlock module */
+#define HWSPINLOCK_BASE                (L4_44XX_BASE + 0xF6000)
+#define HWSPINLOCK_REGADDR(reg)                                \
+                       OMAP2_L4_IO_ADDRESS(HWSPINLOCK_BASE + (reg))
+
+/* Spinlock register offsets */
+#define HWSPINLOCK_REVISION                    0x0000
+#define HWSPINLOCK_SYSCONFIG                   0x0010
+#define HWSPINLOCK_SYSSTATUS                   0x0014
+#define HWSPINLOCK_LOCK_BASE                   0x0800
+
+/* Spinlock register addresses */
+#define HWSPINLOCK_REVISION_REG                        \
+       HWSPINLOCK_REGADDR(HWSPINLOCK_REVISION)
+#define HWSPINLOCK_SYSCONFIG_REG                       \
+       HWSPINLOCK_REGADDR(HWSPINLOCK_SYSCONFIG)
+#define HWSPINLOCK_SYSSTATUS_REG                       \
+       HWSPINLOCK_REGADDR(HWSPINLOCK_SYSSTATUS)
+#define HWSPINLOCK_LOCK_REG(i)                 \
+       HWSPINLOCK_REGADDR(HWSPINLOCK_LOCK_BASE + 0x4 * (i))
+
+/* Spinlock count code */
+#define HWSPINLOCK_32_REGS                             1
+#define HWSPINLOCK_64_REGS                             2
+#define HWSPINLOCK_128_REGS                            4
+#define HWSPINLOCK_256_REGS                            8
+#define HWSPINLOCK_NUMLOCKS_OFFSET                     24
+
+
+/* Initialization function */
+int __init hwspinlocks_init(void)
+{
+       int i;
+       int retval =3D 0;
+
+       struct platform_device *pdev;
+       struct hwspinlock_plat_info *pdata;
+       void __iomem *base;
+       int num_locks;
+       bool is_reserved;
+
+       /* Determine number of locks */
+       switch (__raw_readl(HWSPINLOCK_SYSSTATUS_REG) >>
+                                       HWSPINLOCK_NUMLOCKS_OFFSET) {
+       case HWSPINLOCK_32_REGS:
+               num_locks =3D 32;
+               break;
+       case HWSPINLOCK_64_REGS:
+               num_locks =3D 64;
+               break;
+       case HWSPINLOCK_128_REGS:
+               num_locks =3D 128;
+               break;
+       case HWSPINLOCK_256_REGS:
+               num_locks =3D 256;
+               break;
+       default:
+               return -EINVAL; /* Invalid spinlock count code */
+       }
+
+       /* Device drivers */
+       for (i =3D 0; i < num_locks; i++) {
+               pdev =3D platform_device_alloc("hwspinlock", i);
+
+               base =3D HWSPINLOCK_LOCK_REG(i);  /* Get register address *=
/
+
+               /* Some locks are reserved for system use */
+               if (i < CONFIG_OMAP_HWSPINLOCK_NUM_RESERVED)
+                       is_reserved =3D true;
+               else
+                       is_reserved =3D false;
+
+               /* Pass data to device initialization */
+               pdata =3D kzalloc(sizeof(struct hwspinlock_plat_info),
+                                                               GFP_KERNEL)=
;
+               pdata->num_locks =3D num_locks;
+               pdata->io_base =3D base;
+               pdata->is_reserved =3D is_reserved;
+               retval =3D platform_device_add_data(pdev, pdata, sizeof(*pd=
ata));
+               if (retval)
+                       goto device_add_fail;
+
+               retval =3D platform_device_add(pdev);
+               if (retval)
+                       goto device_add_fail;
+               continue;
+device_add_fail:
+               platform_device_put(pdev);
+       }
+
+       return retval;
+}
+module_init(hwspinlocks_init);
+
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index a37abf5..fb98ff9 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -32,4 +32,5 @@ obj-y +=3D $(i2c-omap-m) $(i2c-omap-y)
 obj-$(CONFIG_OMAP_MBOX_FWK) +=3D mailbox.o
 obj-$(CONFIG_OMAP_REMOTE_PROC) +=3D remoteproc.o

-obj-$(CONFIG_OMAP_PM_NOOP) +=3D omap-pm-noop.o
\ No newline at end of file
+obj-$(CONFIG_OMAP_PM_NOOP) +=3D omap-pm-noop.o
+obj-y +=3D hwspinlock.o
\ No newline at end of file
diff --git a/arch/arm/plat-omap/hwspinlock.c b/arch/arm/plat-omap/hwspinloc=
k.c
new file mode 100644
index 0000000..327a524
--- /dev/null
+++ b/arch/arm/plat-omap/hwspinlock.c
@@ -0,0 +1,331 @@
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
+       void __iomem *io_base;
+       bool is_reserved;
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
+               retval =3D __raw_readl(handle->io_base);
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
+       retval =3D __raw_readl(handle->io_base);
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
+       __raw_writel(0, handle->io_base);
+
+       return 0;
+}
+EXPORT_SYMBOL(hwspinlock_unlock);
+
+/* Busy loop to acquire a spinlock, disabling interrupts/preemption */
+int hwspinlock_lock_irqsave(struct hwspinlock *handle, unsigned long *flag=
s)
+{
+       int retval;
+       unsigned long temp_flags;
+
+       if (WARN_ON(handle =3D=3D NULL))
+               return -EINVAL;
+
+       if (WARN_ON(in_atomic() || in_irq()))
+               return -EPERM;
+
+       if (WARN_ON(flags =3D=3D NULL))
+               return -EINVAL;
+
+       /* Attempt to acquire the lock by reading from it */
+       do {
+               preempt_disable();                      /* Disable preempti=
on */
+               local_irq_save(temp_flags);             /* Disable interrup=
ts */
+
+               retval =3D __raw_readl(handle->io_base);
+
+               /* Restore interrupts and preemption if not successful */
+               if (retval =3D=3D HWSPINLOCK_BUSY) {
+                       local_irq_restore(temp_flags);
+                       preempt_enable();
+               }
+       } while (retval =3D=3D HWSPINLOCK_BUSY);
+
+       *flags =3D temp_flags;            /* Return IRQ state */
+
+       return 0;
+}
+EXPORT_SYMBOL(hwspinlock_lock_irqsave);
+
+/* Attempt to acquire a spinlock once, disabling interrupts/preemption */
+int hwspinlock_trylock_irqsave(struct hwspinlock *handle, unsigned long *f=
lags)
+{
+       int retval =3D 0;
+       unsigned long temp_flags;
+
+       if (WARN_ON(handle =3D=3D NULL))
+               return -EINVAL;
+
+       if (WARN_ON(in_atomic() || in_irq()))
+               return -EPERM;
+
+       if (WARN_ON(flags =3D=3D NULL))
+               return -EINVAL;
+
+       preempt_disable();                      /* Disable preemption */
+       local_irq_save(temp_flags);             /* Disable interrupts */
+
+       /* Attempt to acquire the lock by reading from it */
+       retval =3D __raw_readl(handle->io_base);
+
+       /* Restore interrupts and preemption if not successful */
+       if (retval =3D=3D HWSPINLOCK_BUSY) {
+               local_irq_restore(temp_flags);
+               preempt_enable();
+       } else
+               *flags =3D temp_flags;    /* Return IRQ state */
+
+       return retval;
+}
+EXPORT_SYMBOL(hwspinlock_trylock_irqsave);
+
+/* Unlock a spinlock that was locked with irq/preempt disabled */
+int hwspinlock_unlock_irqrestore(struct hwspinlock *handle, unsigned long
+                                                                       fla=
gs)
+{
+       if (WARN_ON(handle =3D=3D NULL))
+               return -EINVAL;
+
+       /* Release it by writing 0 to it */
+       __raw_writel(0, handle->io_base);
+
+       /* Restore interrupts and preemption */
+       local_irq_restore(flags);
+       preempt_enable();
+
+       return 0;
+}
+EXPORT_SYMBOL(hwspinlock_unlock_irqrestore);
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
+               if (!hwspinlocks[i].is_allocated &&
+                                               !hwspinlocks[i].is_reserved=
) {
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
+       if (WARN_ON(!hwspinlocks[id].is_reserved))
+               goto exit;
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
+       int id =3D pdev->id;
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
+       }
+
+       hwspinlocks[id].pdev                    =3D pdev;
+
+       hwspinlocks[id].is_reserved             =3D pdata->is_reserved;
+       hwspinlocks[id].is_allocated            =3D false;
+       hwspinlocks[id].io_base                 =3D pdata->io_base;
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
+       /* Make sure the it was properly initialized */
+       if (WARN_ON(!hwspinlock_module->is_init))
+               return -EACCES;
+
+       return retval;
+}
+
+/* Cleanup function */
+static void __exit hwspinlock_exit(void)
+{
+       platform_driver_unregister(&hwspinlock_driver);
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
index 0000000..1cdf7a8
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/hwspinlock.h
@@ -0,0 +1,35 @@
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
+int hwspinlock_lock_irqsave(struct hwspinlock *handle, unsigned long *flag=
s);
+int hwspinlock_trylock_irqsave(struct hwspinlock *handle, unsigned long *f=
lags);
+int hwspinlock_unlock_irqrestore(struct hwspinlock *handle, unsigned long
+                                                                       fla=
gs);
+
+struct hwspinlock *hwspinlock_request(void);
+struct hwspinlock *hwspinlock_request_specific(unsigned int id);
+int hwspinlock_free(struct hwspinlock *hwspinlock_ptr);
+
+#endif /* HWSPINLOCK_H */
--
1.7.0


--_002_F39349C6FA641B4A831B7BF4EBF4D4E14728DDBBdlee03entticom_
Content-Type: application/octet-stream;
	name="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"
Content-Description: 0001-omap-hwspinlock-Added-hwspinlock-driver.patch
Content-Disposition: attachment;
	filename="0001-omap-hwspinlock-Added-hwspinlock-driver.patch"; size=18143;
	creation-date="Thu, 24 Jun 2010 19:47:30 GMT";
	modification-date="Thu, 24 Jun 2010 19:47:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5ZDk2N2ZhYmZkMzAwYmFlMTNmYTIyMzNhODAzYjZlMzA0NzdiYWY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBRdWUgPHNxdWVAdGkuY29tPgpEYXRlOiBXZWQsIDIz
IEp1biAyMDEwIDE4OjQwOjMwIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gb21hcDogaHdzcGlubG9j
azogQWRkZWQgaHdzcGlubG9jayBkcml2ZXIKCkNyZWF0ZWQgZHJpdmVyIGZvciBPTUFQIGhhcmR3
YXJlIHNwaW5sb2NrLiAgVGhpcyBkcml2ZXIgc3VwcG9ydHM6Ci0gUmVzZXJ2ZWQgc3BpbmxvY2tz
IGZvciBpbnRlcm5hbCB1c2UKLSBEeW5hbWljIGFsbG9jYXRpb24gb2YgdW5yZXNlcnZlZCBsb2Nr
cwotIExvY2ssIHVubG9jaywgYW5kIHRyeWxvY2sgZnVuY3Rpb25zLCB3aXRoIG9yIHdpdGhvdXQg
ZGlzYWJsaW5nIGlycXMvcHJlZW1wdAotIFJlZ2lzdGVyZWQgYXMgYSBwbGF0Zm9ybSBkZXZpY2Ug
ZHJpdmVyCgpUaGUgZGV2aWNlIGluaXRpYWxpemF0aW9uIHdpbGwgc2V0IGFzaWRlIHNvbWUgc3Bp
bmxvY2tzIGFzIHJlc2VydmVkIGZvcgpzcGVjaWFsLXB1cnBvc2UgdXNlLiAgQWxsIG90aGVyIGxv
Y2tzIGNhbiBiZSB1c2VkIGJ5IGFueW9uZS4gIFRoaXMgaXMKY29uZmlndXJhYmxlIHVzaW5nIGEg
S2NvbmZpZyBvcHRpb24uICBUaGUgZGV2aWNlIGluaXRpYWxpemF0aW9uIGZpbGUgaXM6CgkJYXJj
aC9hcm0vbWFjaC1vbWFwMi9od3NwaW5sb2Nrcy5jCgpUaGUgZHJpdmVyIHRha2VzIGluIGRhdGEg
cGFzc2VkIGluIGRldmljZSBpbml0aWFsaXphdGlvbi4gIFRoZSBmdW5jdGlvbgpod3NwaW5sb2Nr
X3Byb2JlKCkgaW5pdGlhbGl6ZXMgdGhlIGFycmF5IG9mIHNwaW5sb2NrIHN0cnVjdHVyZXMsIGVh
Y2gKY29udGFpbmluZyBhIHNwaW5sb2NrIHJlZ2lzdGVyIGFkZHJlc3MgcHJvdmlkZWQgYnkgdGhl
IGRldmljZSBpbml0aWFsaXphdGlvbi4KVGhlIGRldmljZSBkcml2ZXIgZmlsZSBpczoKCQlhcmNo
L2FybS9wbGF0LW9tYXAvaHdzcGlubG9jay5jCgpIZXJlJ3MgYW4gQVBJIHN1bW1hcnk6CmludCBo
d3NwaW5sb2NrX2xvY2soc3RydWN0IGh3c3BpbmxvY2sgKik7CglBdHRlbXB0IHRvIGxvY2sgYSBo
YXJkd2FyZSBzcGlubG9jay4gIElmIGl0IGlzIGJ1c3ksIHRoZSBmdW5jdGlvbiB3aWxsCglrZWVw
IHRyeWluZyB1bnRpbCBpdCBzdWNjZWVkcy4gIFRoaXMgaXMgYSBibG9ja2luZyBmdW5jdGlvbi4K
aW50IGh3c3BpbmxvY2tfdHJ5bG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqKTsKCUF0dGVtcHQgdG8g
bG9jayBhIGhhcmR3YXJlIHNwaW5sb2NrLiAgSWYgaXQgaXMgYnVzeSwgdGhlIGZ1bmN0aW9uIHdp
bGwKCXJldHVybiBCVVNZLiAgSWYgaXQgc3VjY2VlZHMgaW4gbG9ja2luZywgdGhlIGZ1bmN0aW9u
IHdpbGwgcmV0dXJuCglBQ1FVSVJFRC4gIFRoaXMgaXMgYSBub24tYmxvY2tpbmcgZnVuY3Rpb24K
aW50IGh3c3BpbmxvY2tfdW5sb2NrKHN0cnVjdCBod3NwaW5sb2NrICopOwoJVW5sb2NrIGEgaGFy
ZHdhcmUgc3BpbmxvY2suCgppbnQgaHdzcGlubG9ja19sb2NrX2lycXNhdmUoc3RydWN0IGh3c3Bp
bmxvY2sgKiwgdW5zaWduZWQgbG9uZyAqKTsKCVNhbWUgYXMgaHdzcGlubG9ja19sb2NrLCBidXQg
ZGlzYWJsZXMgaW50ZXJydXB0cyBhbmQgcHJlZW1wdGlvbgppbnQgaHdzcGlubG9ja190cnlsb2Nr
X2lycXNhdmUoc3RydWN0IGh3c3BpbmxvY2sgKiwgdW5zaWduZWQgbG9uZyAqKTsKCVNhbWUgYXMg
aHdzcGlubG9ja190cnlsb2NrLCBidXQgZGlzYWJsZXMgaW50ZXJydXB0cyBhbmQgcHJlZW1wdGlv
bgppbnQgaHdzcGlubG9ja191bmxvY2tfaXJxcmVzdG9yZShzdHJ1Y3QgaHdzcGlubG9jayAqLCB1
bnNpZ25lZCBsb25nKTsKCVNhbWUgYXMgaHdzcGlubG9ja191bmxvY2ssIGJ1dCByZXN0b3JlcyBp
bnRlcnJ1cHRzIGFuZCBwcmVlbXB0aW9uCgpzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19y
ZXF1ZXN0KHZvaWQpOwoJUHJvdmlkZXMgZm9yICJkeW5hbWljIGFsbG9jYXRpb24iIG9mIGFuIHVu
cmVzZXJ2ZWQgaGFyZHdhcmUgc3BpbmxvY2suCglJZiBubyBtb3JlIGxvY2tzIGFyZSBhdmFpbGFi
bGUsIHJldHVybnMgTlVMTC4Kc3RydWN0IGh3c3BpbmxvY2sgKmh3c3BpbmxvY2tfcmVxdWVzdF9z
cGVjaWZpYyh1bnNpZ25lZCBpbnQpOwoJUHJvdmlkZXMgZm9yICJzdGF0aWMgYWxsb2NhdGlvbiIg
b2YgYSByZXNlcnZlZCBoYXJkd2FyZSBzcGlubG9jay4gVGhpcwoJYWxsb3dzIHRoZSBzeXN0ZW0g
dG8gdXNlIGEgc3BlY2lmaWMgcmVzZXJ2ZWQgbG9jaywgaWRlbnRpZmllZCBieSBhbiBJRC4KCUlm
IHRoZSBJRCBpcyBpbnZhbGlkIG9yIGlmIHRoZSBkZXNpcmVkIGxvY2sgaXMgYWxyZWFkeSBhbGxv
Y2F0ZWQsIHRoaXMKCXdpbGwgcmV0dXJuIE5VTEwuCmludCBod3NwaW5sb2NrX2ZyZWUoc3RydWN0
IGh3c3BpbmxvY2sgKik7CglGcmVlcyBhbiBhbGxvY2F0ZWQgaGFyZHdhcmUgc3BpbmxvY2sgKGVp
dGhlciByZXNlcnZlZCBvciB1bnJlc2VydmVkKS4KClNpZ25lZC1vZmYtYnk6IFNpbW9uIFF1ZSA8
c3F1ZUB0aS5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9LY29uZmlnICAgICAgICAgICAg
ICAgICAgfCAgIDEwICsKIGFyY2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgIHwgICAgMiArCiBhcmNoL2FybS9tYWNoLW9tYXAyL2h3c3BpbmxvY2tzLmMgICAgICAgICAg
ICB8ICAxMjYgKysrKysrKysrKwogYXJjaC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlICAgICAgICAg
ICAgICAgICAgfCAgICAzICstCiBhcmNoL2FybS9wbGF0LW9tYXAvaHdzcGlubG9jay5jICAgICAg
ICAgICAgICB8ICAzMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysKIGFyY2gvYXJtL3BsYXQt
b21hcC9pbmNsdWRlL3BsYXQvaHdzcGlubG9jay5oIHwgICAzNSArKysKIDYgZmlsZXMgY2hhbmdl
ZCwgNTA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9hcm0vbWFjaC1vbWFwMi9od3NwaW5sb2Nrcy5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJj
aC9hcm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
L3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdzcGlubG9jay5oCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbWFjaC1vbWFwMi9LY29uZmlnIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9LY29uZmlnCmluZGV4
IDlmNzNkNzkuLmExM2MxODggMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvS2NvbmZp
ZworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL0tjb25maWcKQEAgLTE4MiwzICsxODIsMTMgQEAg
Y29uZmlnIE9NQVAzX1NEUkNfQUNfVElNSU5HCiAJICB3aXNoIHRvIHNheSBuby4gIFNlbGVjdGlu
ZyB5ZXMgd2l0aG91dCB1bmRlcnN0YW5kaW5nIHdoYXQgaXMKIAkgIGdvaW5nIG9uIGNvdWxkIHJl
c3VsdCBpbiBzeXN0ZW0gY3Jhc2hlczsKIAorY29uZmlnIE9NQVBfSFdTUElOTE9DS19OVU1fUkVT
RVJWRUQKKwlpbnQgIk51bWJlciBvZiBoYXJkd2FyZSBzcGlubG9ja3MgcmVzZXJ2ZWQgZm9yIHN5
c3RlbSB1c2UiCisJZGVwZW5kcyBvbiBBUkNIX09NQVAKKwlkZWZhdWx0IDgKKwlyYW5nZSAwIDMy
CisJaGVscAorCSAgQ2hvb3NlIGEgbnVtYmVyIG9mIGhhcmR3YXJlIHNwaW5sb2NrcyB0byByZXNl
cnZlIGZvciBpbnRlcm5hbCB1c2UuCisJICBUaGUgcmVzdCB3aWxsIGJlIHVucmVzZXJ2ZWQgYW5k
IGF2YWlsYmxlIGZvciBnZW5lcmFsIHVzZS4gIE1ha2UKKwkgIHRoYXQgdGhlIG51bWJlciBvZiBy
ZXNlcnZlZCBsb2NrcyBkb2VzIG5vdCBleGNlZWQgdGhlIHRvdGFsIG51bWJlcgorCSAgYXZhaWxh
YmxlIGxvY2tzLgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtlZmlsZSBiL2Fy
Y2gvYXJtL21hY2gtb21hcDIvTWFrZWZpbGUKaW5kZXggNjcyNWIzYS4uMTRhZjE5YSAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9NYWtlZmlsZQorKysgYi9hcmNoL2FybS9tYWNoLW9t
YXAyL01ha2VmaWxlCkBAIC0xNzAsMyArMTcwLDUgQEAgb2JqLXkJCQkJCSs9ICQobmFuZC1tKSAk
KG5hbmQteSkKIAogc21jOTF4LSQoQ09ORklHX1NNQzkxWCkJCQk6PSBncG1jLXNtYzkxeC5vCiBv
YmoteQkJCQkJKz0gJChzbWM5MXgtbSkgJChzbWM5MXgteSkKKworb2JqLXkJCQkJCSs9IGh3c3Bp
bmxvY2tzLm8KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLW9tYXAyL2h3c3BpbmxvY2tzLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2h3c3Bpbmxv
Y2tzLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZGU4MTNhMAotLS0gL2Rl
di9udWxsCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvaHdzcGlubG9ja3MuYwpAQCAtMCwwICsx
LDEyNiBAQAorLyoKKyAqIE9NQVAgaGFyZHdhcmUgc3BpbmxvY2sgZHJpdmVyCisgKgorICogQ29w
eXJpZ2h0IChDKSAyMDEwIFRleGFzIEluc3RydW1lbnRzLiBBbGwgcmlnaHRzIHJlc2VydmVkLgor
ICoKKyAqIENvbnRhY3Q6IFNpbW9uIFF1ZSA8c3F1ZUB0aS5jb20+CisgKgorICogVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgorICog
bW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UKKyAqIHZlcnNpb24gMiBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhh
dCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0CisgKiBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91
dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklU
TkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlIEdOVQorICogR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQgaGF2ZSBy
ZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBhbG9u
ZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQor
ICogRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24s
IE1BCisgKiAwMjExMC0xMzAxIFVTQQorICoKKyAqLworCisjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvZGV2aWNl
Lmg+CisjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5oPgorI2lu
Y2x1ZGUgPGxpbnV4L3NsYWIuaD4KKworI2luY2x1ZGUgPHBsYXQvaHdzcGlubG9jay5oPgorCisv
KiBCYXNlIGFkZHJlc3Mgb2YgSFcgc3BpbmxvY2sgbW9kdWxlICovCisjZGVmaW5lIEhXU1BJTkxP
Q0tfQkFTRQkJKEw0XzQ0WFhfQkFTRSArIDB4RjYwMDApCisjZGVmaW5lIEhXU1BJTkxPQ0tfUkVH
QUREUihyZWcpCQkJCVwKKwkJCU9NQVAyX0w0X0lPX0FERFJFU1MoSFdTUElOTE9DS19CQVNFICsg
KHJlZykpCisKKy8qIFNwaW5sb2NrIHJlZ2lzdGVyIG9mZnNldHMgKi8KKyNkZWZpbmUgSFdTUElO
TE9DS19SRVZJU0lPTgkJCTB4MDAwMAorI2RlZmluZSBIV1NQSU5MT0NLX1NZU0NPTkZJRwkJCTB4
MDAxMAorI2RlZmluZSBIV1NQSU5MT0NLX1NZU1NUQVRVUwkJCTB4MDAxNAorI2RlZmluZSBIV1NQ
SU5MT0NLX0xPQ0tfQkFTRQkJCTB4MDgwMAorCisvKiBTcGlubG9jayByZWdpc3RlciBhZGRyZXNz
ZXMgKi8KKyNkZWZpbmUgSFdTUElOTE9DS19SRVZJU0lPTl9SRUcJCQlcCisJSFdTUElOTE9DS19S
RUdBRERSKEhXU1BJTkxPQ0tfUkVWSVNJT04pCisjZGVmaW5lIEhXU1BJTkxPQ0tfU1lTQ09ORklH
X1JFRwkJCVwKKwlIV1NQSU5MT0NLX1JFR0FERFIoSFdTUElOTE9DS19TWVNDT05GSUcpCisjZGVm
aW5lIEhXU1BJTkxPQ0tfU1lTU1RBVFVTX1JFRwkJCVwKKwlIV1NQSU5MT0NLX1JFR0FERFIoSFdT
UElOTE9DS19TWVNTVEFUVVMpCisjZGVmaW5lIEhXU1BJTkxPQ0tfTE9DS19SRUcoaSkJCQlcCisJ
SFdTUElOTE9DS19SRUdBRERSKEhXU1BJTkxPQ0tfTE9DS19CQVNFICsgMHg0ICogKGkpKQorCisv
KiBTcGlubG9jayBjb3VudCBjb2RlICovCisjZGVmaW5lIEhXU1BJTkxPQ0tfMzJfUkVHUwkJCQkx
CisjZGVmaW5lIEhXU1BJTkxPQ0tfNjRfUkVHUwkJCQkyCisjZGVmaW5lIEhXU1BJTkxPQ0tfMTI4
X1JFR1MJCQkJNAorI2RlZmluZSBIV1NQSU5MT0NLXzI1Nl9SRUdTCQkJCTgKKyNkZWZpbmUgSFdT
UElOTE9DS19OVU1MT0NLU19PRkZTRVQJCQkyNAorCisKKy8qIEluaXRpYWxpemF0aW9uIGZ1bmN0
aW9uICovCitpbnQgX19pbml0IGh3c3BpbmxvY2tzX2luaXQodm9pZCkKK3sKKwlpbnQgaTsKKwlp
bnQgcmV0dmFsID0gMDsKKworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7CisJc3RydWN0
IGh3c3BpbmxvY2tfcGxhdF9pbmZvICpwZGF0YTsKKwl2b2lkIF9faW9tZW0gKmJhc2U7CisJaW50
IG51bV9sb2NrczsKKwlib29sIGlzX3Jlc2VydmVkOworCisJLyogRGV0ZXJtaW5lIG51bWJlciBv
ZiBsb2NrcyAqLworCXN3aXRjaCAoX19yYXdfcmVhZGwoSFdTUElOTE9DS19TWVNTVEFUVVNfUkVH
KSA+PgorCQkJCQlIV1NQSU5MT0NLX05VTUxPQ0tTX09GRlNFVCkgeworCWNhc2UgSFdTUElOTE9D
S18zMl9SRUdTOgorCQludW1fbG9ja3MgPSAzMjsKKwkJYnJlYWs7CisJY2FzZSBIV1NQSU5MT0NL
XzY0X1JFR1M6CisJCW51bV9sb2NrcyA9IDY0OworCQlicmVhazsKKwljYXNlIEhXU1BJTkxPQ0tf
MTI4X1JFR1M6CisJCW51bV9sb2NrcyA9IDEyODsKKwkJYnJlYWs7CisJY2FzZSBIV1NQSU5MT0NL
XzI1Nl9SRUdTOgorCQludW1fbG9ja3MgPSAyNTY7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXJl
dHVybiAtRUlOVkFMOwkvKiBJbnZhbGlkIHNwaW5sb2NrIGNvdW50IGNvZGUgKi8KKwl9CisKKwkv
KiBEZXZpY2UgZHJpdmVycyAqLworCWZvciAoaSA9IDA7IGkgPCBudW1fbG9ja3M7IGkrKykgewor
CQlwZGV2ID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9jKCJod3NwaW5sb2NrIiwgaSk7CisKKwkJYmFz
ZSA9IEhXU1BJTkxPQ0tfTE9DS19SRUcoaSk7CS8qIEdldCByZWdpc3RlciBhZGRyZXNzICovCisK
KwkJLyogU29tZSBsb2NrcyBhcmUgcmVzZXJ2ZWQgZm9yIHN5c3RlbSB1c2UgKi8KKwkJaWYgKGkg
PCBDT05GSUdfT01BUF9IV1NQSU5MT0NLX05VTV9SRVNFUlZFRCkKKwkJCWlzX3Jlc2VydmVkID0g
dHJ1ZTsKKwkJZWxzZQorCQkJaXNfcmVzZXJ2ZWQgPSBmYWxzZTsKKworCQkvKiBQYXNzIGRhdGEg
dG8gZGV2aWNlIGluaXRpYWxpemF0aW9uICovCisJCXBkYXRhID0ga3phbGxvYyhzaXplb2Yoc3Ry
dWN0IGh3c3BpbmxvY2tfcGxhdF9pbmZvKSwKKwkJCQkJCQkJR0ZQX0tFUk5FTCk7CisJCXBkYXRh
LT5udW1fbG9ja3MgPSBudW1fbG9ja3M7CisJCXBkYXRhLT5pb19iYXNlID0gYmFzZTsKKwkJcGRh
dGEtPmlzX3Jlc2VydmVkID0gaXNfcmVzZXJ2ZWQ7CisJCXJldHZhbCA9IHBsYXRmb3JtX2Rldmlj
ZV9hZGRfZGF0YShwZGV2LCBwZGF0YSwgc2l6ZW9mKCpwZGF0YSkpOworCQlpZiAocmV0dmFsKQor
CQkJZ290byBkZXZpY2VfYWRkX2ZhaWw7CisKKwkJcmV0dmFsID0gcGxhdGZvcm1fZGV2aWNlX2Fk
ZChwZGV2KTsKKwkJaWYgKHJldHZhbCkKKwkJCWdvdG8gZGV2aWNlX2FkZF9mYWlsOworCQljb250
aW51ZTsKK2RldmljZV9hZGRfZmFpbDoKKwkJcGxhdGZvcm1fZGV2aWNlX3B1dChwZGV2KTsKKwl9
CisKKwlyZXR1cm4gcmV0dmFsOworfQorbW9kdWxlX2luaXQoaHdzcGlubG9ja3NfaW5pdCk7CisK
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9NYWtlZmlsZSBiL2FyY2gvYXJtL3BsYXQt
b21hcC9NYWtlZmlsZQppbmRleCBhMzdhYmY1Li5mYjk4ZmY5IDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9wbGF0LW9tYXAvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlCkBA
IC0zMiw0ICszMiw1IEBAIG9iai15ICs9ICQoaTJjLW9tYXAtbSkgJChpMmMtb21hcC15KQogb2Jq
LSQoQ09ORklHX09NQVBfTUJPWF9GV0spICs9IG1haWxib3gubwogb2JqLSQoQ09ORklHX09NQVBf
UkVNT1RFX1BST0MpICs9IHJlbW90ZXByb2MubwogCi1vYmotJChDT05GSUdfT01BUF9QTV9OT09Q
KSArPSBvbWFwLXBtLW5vb3AubwpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKK29iai0kKENP
TkZJR19PTUFQX1BNX05PT1ApICs9IG9tYXAtcG0tbm9vcC5vCitvYmoteSArPSBod3NwaW5sb2Nr
Lm8KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0
LW9tYXAvaHdzcGlubG9jay5jIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYwpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4zMjdhNTI0Ci0tLSAvZGV2L251bGwKKysr
IGIvYXJjaC9hcm0vcGxhdC1vbWFwL2h3c3BpbmxvY2suYwpAQCAtMCwwICsxLDMzMSBAQAorLyoK
KyAqIE9NQVAgaGFyZHdhcmUgc3BpbmxvY2sgZHJpdmVyCisgKgorICogQ29weXJpZ2h0IChDKSAy
MDEwIFRleGFzIEluc3RydW1lbnRzLiBBbGwgcmlnaHRzIHJlc2VydmVkLgorICoKKyAqIENvbnRh
Y3Q6IFNpbW9uIFF1ZSA8c3F1ZUB0aS5jb20+CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqIHZlcnNp
b24gMiBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisg
KiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJl
IHVzZWZ1bCwgYnV0CisgKiBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBp
bXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlIEdOVQorICogR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNv
cHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBhbG9uZyB3aXRoIHRoaXMg
cHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorICogRm91bmRhdGlv
biwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BCisgKiAwMjEx
MC0xMzAxIFVTQQorICoKKyAqLworCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVk
ZSA8bGludXgvaW50ZXJydXB0Lmg+CisjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CisjaW5jbHVk
ZSA8bGludXgvZGVsYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5oPgorI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4KKyNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgorCisjaW5jbHVkZSA8cGxhdC9o
d3NwaW5sb2NrLmg+CisKKy8qIGZvciBtYW5hZ2luZyBhIGhhcmR3YXJlIHNwaW5sb2NrIG1vZHVs
ZSAqLworc3RydWN0IGh3c3BpbmxvY2tfc3RhdGUgeworCWJvb2wgaXNfaW5pdDsJCQkvKiBGb3Ig
Zmlyc3QtdGltZSBpbml0aWFsaXphdGlvbiAqLworCWludCBudW1fbG9ja3M7CQkJLyogVG90YWwg
bnVtYmVyIG9mIGxvY2tzIGluIHN5c3RlbSAqLworCXNwaW5sb2NrX3QgbG9jYWxfbG9jazsJCS8q
IExvY2FsIHByb3RlY3Rpb24gKi8KK307CisKKy8qIFBvaW50cyB0byB0aGUgaGFyZHdhcmUgc3Bp
bmxvY2sgbW9kdWxlICovCitzdGF0aWMgc3RydWN0IGh3c3BpbmxvY2tfc3RhdGUgaHdzcGlubG9j
a19zdGF0ZTsKK3N0YXRpYyBzdHJ1Y3QgaHdzcGlubG9ja19zdGF0ZSAqaHdzcGlubG9ja19tb2R1
bGUgPSAmaHdzcGlubG9ja19zdGF0ZTsKKworLyogU3BpbmxvY2sgb2JqZWN0ICovCitzdHJ1Y3Qg
aHdzcGlubG9jayB7CisJdm9pZCBfX2lvbWVtICppb19iYXNlOworCWJvb2wgaXNfcmVzZXJ2ZWQ7
CisJYm9vbCBpc19hbGxvY2F0ZWQ7CisJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsKK307
CisKKy8qIEFycmF5IG9mIHNwaW5sb2NrcyAqLworc3RhdGljIHN0cnVjdCBod3NwaW5sb2NrICpo
d3NwaW5sb2NrczsKKworLyogQVBJIGZ1bmN0aW9ucyAqLworCisvKiBCdXN5IGxvb3AgdG8gYWNx
dWlyZSBhIHNwaW5sb2NrICovCitpbnQgaHdzcGlubG9ja19sb2NrKHN0cnVjdCBod3NwaW5sb2Nr
ICpoYW5kbGUpCit7CisJaW50IHJldHZhbDsKKworCWlmIChXQVJOX09OKGhhbmRsZSA9PSBOVUxM
KSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpZiAoV0FSTl9PTihpbl9hdG9taWMoKSB8fCBpbl9p
cnEoKSkpCisJCXJldHVybiAtRVBFUk07CisKKwkvKiBBdHRlbXB0IHRvIGFjcXVpcmUgdGhlIGxv
Y2sgYnkgcmVhZGluZyBmcm9tIGl0ICovCisJZG8geworCQlyZXR2YWwgPSBfX3Jhd19yZWFkbCho
YW5kbGUtPmlvX2Jhc2UpOworCX0gd2hpbGUgKHJldHZhbCA9PSBIV1NQSU5MT0NLX0JVU1kpOwor
CisJcmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfbG9jayk7CisKKy8qIEF0
dGVtcHQgdG8gYWNxdWlyZSBhIHNwaW5sb2NrIG9uY2UgKi8KK2ludCBod3NwaW5sb2NrX3RyeWxv
Y2soc3RydWN0IGh3c3BpbmxvY2sgKmhhbmRsZSkKK3sKKwlpbnQgcmV0dmFsID0gMDsKKworCWlm
IChXQVJOX09OKGhhbmRsZSA9PSBOVUxMKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpZiAoV0FS
Tl9PTihpbl9hdG9taWMoKSB8fCBpbl9pcnEoKSkpCisJCXJldHVybiAtRVBFUk07CisKKwkvKiBB
dHRlbXB0IHRvIGFjcXVpcmUgdGhlIGxvY2sgYnkgcmVhZGluZyBmcm9tIGl0ICovCisJcmV0dmFs
ID0gX19yYXdfcmVhZGwoaGFuZGxlLT5pb19iYXNlKTsKKworCXJldHVybiByZXR2YWw7Cit9CitF
WFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfdHJ5bG9jayk7CisKKy8qIFJlbGVhc2UgYSBzcGlubG9j
ayAqLworaW50IGh3c3BpbmxvY2tfdW5sb2NrKHN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUpCit7
CisJaWYgKFdBUk5fT04oaGFuZGxlID09IE5VTEwpKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCS8q
IFJlbGVhc2UgaXQgYnkgd3JpdGluZyAwIHRvIGl0ICovCisJX19yYXdfd3JpdGVsKDAsIGhhbmRs
ZS0+aW9fYmFzZSk7CisKKwlyZXR1cm4gMDsKK30KK0VYUE9SVF9TWU1CT0woaHdzcGlubG9ja191
bmxvY2spOworCisvKiBCdXN5IGxvb3AgdG8gYWNxdWlyZSBhIHNwaW5sb2NrLCBkaXNhYmxpbmcg
aW50ZXJydXB0cy9wcmVlbXB0aW9uICovCitpbnQgaHdzcGlubG9ja19sb2NrX2lycXNhdmUoc3Ry
dWN0IGh3c3BpbmxvY2sgKmhhbmRsZSwgdW5zaWduZWQgbG9uZyAqZmxhZ3MpCit7CisJaW50IHJl
dHZhbDsKKwl1bnNpZ25lZCBsb25nIHRlbXBfZmxhZ3M7CisKKwlpZiAoV0FSTl9PTihoYW5kbGUg
PT0gTlVMTCkpCisJCXJldHVybiAtRUlOVkFMOworCisJaWYgKFdBUk5fT04oaW5fYXRvbWljKCkg
fHwgaW5faXJxKCkpKQorCQlyZXR1cm4gLUVQRVJNOworCisJaWYgKFdBUk5fT04oZmxhZ3MgPT0g
TlVMTCkpCisJCXJldHVybiAtRUlOVkFMOworCisJLyogQXR0ZW1wdCB0byBhY3F1aXJlIHRoZSBs
b2NrIGJ5IHJlYWRpbmcgZnJvbSBpdCAqLworCWRvIHsKKwkJcHJlZW1wdF9kaXNhYmxlKCk7CQkJ
LyogRGlzYWJsZSBwcmVlbXB0aW9uICovCisJCWxvY2FsX2lycV9zYXZlKHRlbXBfZmxhZ3MpOwkJ
LyogRGlzYWJsZSBpbnRlcnJ1cHRzICovCisKKwkJcmV0dmFsID0gX19yYXdfcmVhZGwoaGFuZGxl
LT5pb19iYXNlKTsKKworCQkvKiBSZXN0b3JlIGludGVycnVwdHMgYW5kIHByZWVtcHRpb24gaWYg
bm90IHN1Y2Nlc3NmdWwgKi8KKwkJaWYgKHJldHZhbCA9PSBIV1NQSU5MT0NLX0JVU1kpIHsKKwkJ
CWxvY2FsX2lycV9yZXN0b3JlKHRlbXBfZmxhZ3MpOworCQkJcHJlZW1wdF9lbmFibGUoKTsKKwkJ
fQorCX0gd2hpbGUgKHJldHZhbCA9PSBIV1NQSU5MT0NLX0JVU1kpOworCisJKmZsYWdzID0gdGVt
cF9mbGFnczsJCS8qIFJldHVybiBJUlEgc3RhdGUgKi8KKworCXJldHVybiAwOworfQorRVhQT1JU
X1NZTUJPTChod3NwaW5sb2NrX2xvY2tfaXJxc2F2ZSk7CisKKy8qIEF0dGVtcHQgdG8gYWNxdWly
ZSBhIHNwaW5sb2NrIG9uY2UsIGRpc2FibGluZyBpbnRlcnJ1cHRzL3ByZWVtcHRpb24gKi8KK2lu
dCBod3NwaW5sb2NrX3RyeWxvY2tfaXJxc2F2ZShzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlLCB1
bnNpZ25lZCBsb25nICpmbGFncykKK3sKKwlpbnQgcmV0dmFsID0gMDsKKwl1bnNpZ25lZCBsb25n
IHRlbXBfZmxhZ3M7CisKKwlpZiAoV0FSTl9PTihoYW5kbGUgPT0gTlVMTCkpCisJCXJldHVybiAt
RUlOVkFMOworCisJaWYgKFdBUk5fT04oaW5fYXRvbWljKCkgfHwgaW5faXJxKCkpKQorCQlyZXR1
cm4gLUVQRVJNOworCisJaWYgKFdBUk5fT04oZmxhZ3MgPT0gTlVMTCkpCisJCXJldHVybiAtRUlO
VkFMOworCisJcHJlZW1wdF9kaXNhYmxlKCk7CQkJLyogRGlzYWJsZSBwcmVlbXB0aW9uICovCisJ
bG9jYWxfaXJxX3NhdmUodGVtcF9mbGFncyk7CQkvKiBEaXNhYmxlIGludGVycnVwdHMgKi8KKwor
CS8qIEF0dGVtcHQgdG8gYWNxdWlyZSB0aGUgbG9jayBieSByZWFkaW5nIGZyb20gaXQgKi8KKwly
ZXR2YWwgPSBfX3Jhd19yZWFkbChoYW5kbGUtPmlvX2Jhc2UpOworCisJLyogUmVzdG9yZSBpbnRl
cnJ1cHRzIGFuZCBwcmVlbXB0aW9uIGlmIG5vdCBzdWNjZXNzZnVsICovCisJaWYgKHJldHZhbCA9
PSBIV1NQSU5MT0NLX0JVU1kpIHsKKwkJbG9jYWxfaXJxX3Jlc3RvcmUodGVtcF9mbGFncyk7CisJ
CXByZWVtcHRfZW5hYmxlKCk7CisJfSBlbHNlCisJCSpmbGFncyA9IHRlbXBfZmxhZ3M7CS8qIFJl
dHVybiBJUlEgc3RhdGUgKi8KKworCXJldHVybiByZXR2YWw7Cit9CitFWFBPUlRfU1lNQk9MKGh3
c3BpbmxvY2tfdHJ5bG9ja19pcnFzYXZlKTsKKworLyogVW5sb2NrIGEgc3BpbmxvY2sgdGhhdCB3
YXMgbG9ja2VkIHdpdGggaXJxL3ByZWVtcHQgZGlzYWJsZWQgKi8KK2ludCBod3NwaW5sb2NrX3Vu
bG9ja19pcnFyZXN0b3JlKHN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUsIHVuc2lnbmVkIGxvbmcK
KwkJCQkJCQkJCWZsYWdzKQoreworCWlmIChXQVJOX09OKGhhbmRsZSA9PSBOVUxMKSkKKwkJcmV0
dXJuIC1FSU5WQUw7CisKKwkvKiBSZWxlYXNlIGl0IGJ5IHdyaXRpbmcgMCB0byBpdCAqLworCV9f
cmF3X3dyaXRlbCgwLCBoYW5kbGUtPmlvX2Jhc2UpOworCisJLyogUmVzdG9yZSBpbnRlcnJ1cHRz
IGFuZCBwcmVlbXB0aW9uICovCisJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOworCXByZWVtcHRf
ZW5hYmxlKCk7CisKKwlyZXR1cm4gMDsKK30KK0VYUE9SVF9TWU1CT0woaHdzcGlubG9ja191bmxv
Y2tfaXJxcmVzdG9yZSk7CisKKy8qIFJlcXVlc3QgYW4gdW5jbGFpbWVkIHNwaW5sb2NrICovCitz
dHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19yZXF1ZXN0KHZvaWQpCit7CisJaW50IGk7CisJ
Ym9vbCBmb3VuZCA9IGZhbHNlOworCXN0cnVjdCBod3NwaW5sb2NrICpoYW5kbGUgPSBOVUxMOwor
CXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmaHdzcGlubG9ja19t
b2R1bGUtPmxvY2FsX2xvY2ssIGZsYWdzKTsKKwkvKiBTZWFyY2ggZm9yIGFuIHVuY2xhaW1lZCwg
dW5yZXNlcnZlZCBsb2NrICovCisJZm9yIChpID0gMDsgaSA8IGh3c3BpbmxvY2tfbW9kdWxlLT5u
dW1fbG9ja3MgJiYgIWZvdW5kOyBpKyspIHsKKwkJaWYgKCFod3NwaW5sb2Nrc1tpXS5pc19hbGxv
Y2F0ZWQgJiYKKwkJCQkJCSFod3NwaW5sb2Nrc1tpXS5pc19yZXNlcnZlZCkgeworCQkJZm91bmQg
PSB0cnVlOworCQkJaGFuZGxlID0gJmh3c3BpbmxvY2tzW2ldOworCQl9CisJfQorCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJmh3c3BpbmxvY2tfbW9kdWxlLT5sb2NhbF9sb2NrLCBmbGFncyk7CisK
KwkvKiBSZXR1cm4gZXJyb3IgaWYgbm8gbW9yZSBsb2NrcyBhdmFpbGFibGUgKi8KKwlpZiAoIWZv
dW5kKQorCQlyZXR1cm4gTlVMTDsKKworCWhhbmRsZS0+aXNfYWxsb2NhdGVkID0gdHJ1ZTsKKwor
CXJldHVybiBoYW5kbGU7Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfcmVxdWVzdCk7CisK
Ky8qIFJlcXVlc3QgYW4gdW5jbGFpbWVkIHNwaW5sb2NrIGJ5IElEICovCitzdHJ1Y3QgaHdzcGlu
bG9jayAqaHdzcGlubG9ja19yZXF1ZXN0X3NwZWNpZmljKHVuc2lnbmVkIGludCBpZCkKK3sKKwlz
dHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlID0gTlVMTDsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOwor
CisJc3Bpbl9sb2NrX2lycXNhdmUoJmh3c3BpbmxvY2tfbW9kdWxlLT5sb2NhbF9sb2NrLCBmbGFn
cyk7CisKKwlpZiAoV0FSTl9PTighaHdzcGlubG9ja3NbaWRdLmlzX3Jlc2VydmVkKSkKKwkJZ290
byBleGl0OworCisJaWYgKFdBUk5fT04oaHdzcGlubG9ja3NbaWRdLmlzX2FsbG9jYXRlZCkpCisJ
CWdvdG8gZXhpdDsKKworCWhhbmRsZSA9ICZod3NwaW5sb2Nrc1tpZF07CisJaGFuZGxlLT5pc19h
bGxvY2F0ZWQgPSB0cnVlOworCitleGl0OgorCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmh3c3Bp
bmxvY2tfbW9kdWxlLT5sb2NhbF9sb2NrLCBmbGFncyk7CisJcmV0dXJuIGhhbmRsZTsKK30KK0VY
UE9SVF9TWU1CT0woaHdzcGlubG9ja19yZXF1ZXN0X3NwZWNpZmljKTsKKworLyogUmVsZWFzZSBh
IGNsYWltZWQgc3BpbmxvY2sgKi8KK2ludCBod3NwaW5sb2NrX2ZyZWUoc3RydWN0IGh3c3Bpbmxv
Y2sgKmhhbmRsZSkKK3sKKwlpZiAoV0FSTl9PTihoYW5kbGUgPT0gTlVMTCkpCisJCXJldHVybiAt
RUlOVkFMOworCisJaWYgKFdBUk5fT04oIWhhbmRsZS0+aXNfYWxsb2NhdGVkKSkKKwkJcmV0dXJu
IC1FTk9NRU07CisKKwloYW5kbGUtPmlzX2FsbG9jYXRlZCA9IGZhbHNlOworCisJcmV0dXJuIDA7
Cit9CitFWFBPUlRfU1lNQk9MKGh3c3BpbmxvY2tfZnJlZSk7CisKKy8qIFByb2JlIGZ1bmN0aW9u
ICovCitzdGF0aWMgaW50IF9fZGV2aW5pdCBod3NwaW5sb2NrX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IGh3c3BpbmxvY2tfcGxhdF9pbmZvICpwZGF0YSA9
IHBkZXYtPmRldi5wbGF0Zm9ybV9kYXRhOworCWludCBpZCA9IHBkZXYtPmlkOworCisJLyogU2V0
IHVwIHRoZSBzcGlubG9jayBjb3VudCBhbmQgYXJyYXkgKi8KKwlpZiAoIWh3c3BpbmxvY2tfbW9k
dWxlLT5pc19pbml0KSB7CisJCWh3c3BpbmxvY2tfbW9kdWxlLT5udW1fbG9ja3MgPSBwZGF0YS0+
bnVtX2xvY2tzOworCisJCS8qIEFsbG9jYXRlIHNwaW5sb2NrIGRldmljZSBvYmplY3RzICovCisJ
CWh3c3BpbmxvY2tzID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IGh3c3BpbmxvY2spICoKKwkJCQlo
d3NwaW5sb2NrX21vZHVsZS0+bnVtX2xvY2tzLCBHRlBfS0VSTkVMKTsKKwkJaWYgKFdBUk5fT04o
aHdzcGlubG9ja3MgPT0gTlVMTCkpCisJCQlyZXR1cm4gLUVOT01FTTsKKworCQkvKiBJbml0aWFs
aXplIGxvY2FsIGxvY2sgKi8KKwkJc3Bpbl9sb2NrX2luaXQoJmh3c3BpbmxvY2tfbW9kdWxlLT5s
b2NhbF9sb2NrKTsKKworCQkvKiBPbmx5IGRvIGluaXRpYWxpemF0aW9uIG9uY2UgKi8KKwkJaHdz
cGlubG9ja19tb2R1bGUtPmlzX2luaXQgPSB0cnVlOworCX0KKworCWh3c3BpbmxvY2tzW2lkXS5w
ZGV2CQkJPSBwZGV2OworCisJaHdzcGlubG9ja3NbaWRdLmlzX3Jlc2VydmVkCQk9IHBkYXRhLT5p
c19yZXNlcnZlZDsKKwlod3NwaW5sb2Nrc1tpZF0uaXNfYWxsb2NhdGVkCQk9IGZhbHNlOworCWh3
c3BpbmxvY2tzW2lkXS5pb19iYXNlCQkJPSBwZGF0YS0+aW9fYmFzZTsKKworCXJldHVybiAwOwor
fQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBod3NwaW5sb2NrX2RyaXZlciA9IHsK
KwkucHJvYmUgICAgICAgICAgPSBod3NwaW5sb2NrX3Byb2JlLAorCS5kcml2ZXIgICAgICAgICA9
IHsKKwkJLm5hbWUgICA9ICJod3NwaW5sb2NrIiwKKwl9LAorfTsKKworLyogSW5pdGlhbGl6YXRp
b24gZnVuY3Rpb24gKi8KK3N0YXRpYyBpbnQgX19pbml0IGh3c3BpbmxvY2tfaW5pdCh2b2lkKQor
eworCWludCByZXR2YWwgPSAwOworCisJLyogUmVnaXN0ZXIgc3BpbmxvY2sgZHJpdmVyICovCisJ
cmV0dmFsID0gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZod3NwaW5sb2NrX2RyaXZlcik7CisK
KwkvKiBNYWtlIHN1cmUgdGhlIGl0IHdhcyBwcm9wZXJseSBpbml0aWFsaXplZCAqLworCWlmIChX
QVJOX09OKCFod3NwaW5sb2NrX21vZHVsZS0+aXNfaW5pdCkpCisJCXJldHVybiAtRUFDQ0VTOwor
CisJcmV0dXJuIHJldHZhbDsKK30KKworLyogQ2xlYW51cCBmdW5jdGlvbiAqLworc3RhdGljIHZv
aWQgX19leGl0IGh3c3BpbmxvY2tfZXhpdCh2b2lkKQoreworCXBsYXRmb3JtX2RyaXZlcl91bnJl
Z2lzdGVyKCZod3NwaW5sb2NrX2RyaXZlcik7CisKKwkvKiBGcmVlIHNwaW5sb2NrIGRldmljZSBv
YmplY3RzICovCisJaWYgKGh3c3BpbmxvY2tfbW9kdWxlLT5pc19pbml0KQorCQlrZnJlZShod3Nw
aW5sb2Nrcyk7Cit9CisKK21vZHVsZV9pbml0KGh3c3BpbmxvY2tfaW5pdCk7Cittb2R1bGVfZXhp
dChod3NwaW5sb2NrX2V4aXQpOworCitNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7CitNT0RVTEVf
REVTQ1JJUFRJT04oIkhhcmR3YXJlIHNwaW5sb2NrIGRyaXZlciIpOworTU9EVUxFX0FVVEhPUigi
U2ltb24gUXVlIik7CitNT0RVTEVfQVVUSE9SKCJIYXJpIEthbmlnZXJpIik7CmRpZmYgLS1naXQg
YS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9wbGF0L2h3c3BpbmxvY2suaCBiL2FyY2gvYXJt
L3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvaHdzcGlubG9jay5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAuLjFjZGY3YTgKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9wbGF0
LW9tYXAvaW5jbHVkZS9wbGF0L2h3c3BpbmxvY2suaApAQCAtMCwwICsxLDM1IEBACisvKiBod3Nw
aW5sb2NrLmggKi8KKworI2lmbmRlZiBIV1NQSU5MT0NLX0gKKyNkZWZpbmUgSFdTUElOTE9DS19I
CisKKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KKyNpbmNsdWRlIDxwbGF0L29t
YXA0NHh4Lmg+CisKKy8qIFJlYWQgdmFsdWVzIGZyb20gdGhlIHNwaW5sb2NrIHJlZ2lzdGVyICov
CisjZGVmaW5lIEhXU1BJTkxPQ0tfQUNRVUlSRUQgMAorI2RlZmluZSBIV1NQSU5MT0NLX0JVU1kg
MQorCisvKiBEZXZpY2UgZGF0YSAqLworc3RydWN0IGh3c3BpbmxvY2tfcGxhdF9pbmZvIHsKKwlp
bnQgbnVtX2xvY2tzOwkJCS8qIE51bWJlciBvZiBsb2NrcyAoaW5pdGlhbGl6YXRpb24pICovCisJ
dm9pZCBfX2lvbWVtICppb19iYXNlOwkJLyogQWRkcmVzcyBvZiBzcGlubG9jayByZWdpc3RlciAq
LworCWJvb2wgaXNfcmVzZXJ2ZWQ7CQkvKiBSZXNlcnZlZCBmb3Igc3lzdGVtIHVzZT8gKi8KK307
CisKK3N0cnVjdCBod3NwaW5sb2NrOworCitpbnQgaHdzcGlubG9ja19sb2NrKHN0cnVjdCBod3Nw
aW5sb2NrICpoYW5kbGUpOworaW50IGh3c3BpbmxvY2tfdHJ5bG9jayhzdHJ1Y3QgaHdzcGlubG9j
ayAqaGFuZGxlKTsKK2ludCBod3NwaW5sb2NrX3VubG9jayhzdHJ1Y3QgaHdzcGlubG9jayAqaGFu
ZGxlKTsKKworaW50IGh3c3BpbmxvY2tfbG9ja19pcnFzYXZlKHN0cnVjdCBod3NwaW5sb2NrICpo
YW5kbGUsIHVuc2lnbmVkIGxvbmcgKmZsYWdzKTsKK2ludCBod3NwaW5sb2NrX3RyeWxvY2tfaXJx
c2F2ZShzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxlLCB1bnNpZ25lZCBsb25nICpmbGFncyk7Citp
bnQgaHdzcGlubG9ja191bmxvY2tfaXJxcmVzdG9yZShzdHJ1Y3QgaHdzcGlubG9jayAqaGFuZGxl
LCB1bnNpZ25lZCBsb25nCisJCQkJCQkJCQlmbGFncyk7CisKK3N0cnVjdCBod3NwaW5sb2NrICpo
d3NwaW5sb2NrX3JlcXVlc3Qodm9pZCk7CitzdHJ1Y3QgaHdzcGlubG9jayAqaHdzcGlubG9ja19y
ZXF1ZXN0X3NwZWNpZmljKHVuc2lnbmVkIGludCBpZCk7CitpbnQgaHdzcGlubG9ja19mcmVlKHN0
cnVjdCBod3NwaW5sb2NrICpod3NwaW5sb2NrX3B0cik7CisKKyNlbmRpZiAvKiBIV1NQSU5MT0NL
X0ggKi8KLS0gCjEuNy4wCgo=

--_002_F39349C6FA641B4A831B7BF4EBF4D4E14728DDBBdlee03entticom_--
