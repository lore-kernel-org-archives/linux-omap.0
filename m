From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [RFC v.2] omap: hwspinlock: Added hwspinlock driver
Date: Tue, 29 Jun 2010 22:54:06 +0200
Message-ID: <74583B8642AB8841B30447520659FCA901AA69615D@dnce01.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167E8@dbde02.ent.ti.com>,<F39349C6FA641B4A831B7BF4EBF4D4E14728E5B3@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D9E40C@dbde02.ent.ti.com>
 <F39349C6FA641B4A831B7BF4EBF4D4E1473E30B7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45830 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab0F2UyU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 16:54:20 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E1473E30B7@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, P
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Hi Simon,

>From: Que, Simon
>Sent: Tuesday, June 29, 2010 2:28 PM
>To: linux-omap@vger.kernel.org; Kevin Hilman; Cousson, Benoit;
>
>Hello,
>
>Thanks for all your comments and feedback.  I've updated the
>patch with changes based on the feedback I've received:
>
>- Switched to using hwmod.  I enabled the hwmod entry for
>spinlock in omap_hwmod_44xx_data.
>- Removed reserved/unreserved distinction.  Removed CONFIG
>option for number of reserved locks as well.  The reservation
>will be done at runtime as Kevin and Benoit have suggested.
>The new API simply provides for reservation of spinlock w/
>specific ID or the next available spinlock.
>- Simplified #define names -- removed the HWSPINLOCK prefix.
>- Added OMAP4 conditional to Makefiles for building hwspinlock.
>- Moved base address definition of spinlock register to omap44xx.h
>- Base addresses are mapped using ioremap and accessed using
>readl/writel.
>- Removed the irqsave/restore functions.  Now there are only
>lock/trylock/unlock, without the irq and preempt
>disable/enable.  This keeps it simple, and we can add the
>irq/preempt disable/enable as a future enhancement.
>
>Regarding reserving locks: how do we use the board code to
>reserve locks?  This is not familiar to us.
>
>Please see attached patch, or inline patch contents below.
>
>Thanks,
>Simon
>
>
>===============================================================
>=============
>
>
>From a1aa1f5a85814bdf924d140b664a3305224392b2 Mon Sep 17 00:00:00 2001
>From: Simon Que <sque@ti.com>
>Date: Wed, 23 Jun 2010 18:40:30 -0500
>Subject: [PATCH] omap: hwspinlock: Added hwspinlock driver
>
>Created driver for OMAP hardware spinlock.  This driver supports:
>- Reserved spinlocks for internal use
>- Dynamic allocation of unreserved locks
>- Lock, unlock, and trylock functions, with or without
>disabling irqs/preempt
>- Registered as a platform device driver
>
>The device initialization uses hwmod to configure the devices.
> One device will
>be created for each hardware spinlock.  It will pass spinlock register
>addresses to the driver.  The device initialization file is:
>               arch/arm/mach-omap2/hwspinlocks.c
>
>The driver takes in data passed in device initialization.  The function
>hwspinlock_probe() initializes the array of spinlock structures, each
>containing a spinlock register address provided by the device
>initialization.
>The device driver file is:
>               arch/arm/plat-omap/hwspinlock.c
>
>Here's an API summary:
>int hwspinlock_lock(struct hwspinlock *);
>       Attempt to lock a hardware spinlock.  If it is busy,
>the function will
>       keep trying until it succeeds.  This is a blocking function.
>int hwspinlock_trylock(struct hwspinlock *);
>       Attempt to lock a hardware spinlock.  If it is busy,
>the function will
>       return BUSY.  If it succeeds in locking, the function
>will return
>       ACQUIRED.  This is a non-blocking function
>int hwspinlock_unlock(struct hwspinlock *);
>       Unlock a hardware spinlock.
>
>struct hwspinlock *hwspinlock_request(void);
>       Provides for "dynamic allocation" of a hardware
>spinlock.  It returns
>       the handle to the next available (unallocated)
>spinlock.  If no more
>       locks are available, it returns NULL.
>struct hwspinlock *hwspinlock_request_specific(unsigned int);
>       Provides for "static allocation" of a specific hardware
>spinlock. This
>       allows the system to use a specific spinlock,
>identified by an ID. If
>       the ID is invalid or if the desired lock is already
>allocated, this
>       will return NULL.  Otherwise it returns a spinlock handle.
>int hwspinlock_free(struct hwspinlock *);
>       Frees an allocated hardware spinlock (either reserved
>or unreserved).
>
>Signed-off-by: Simon Que <sque@ti.com>
>---
> arch/arm/mach-omap2/Makefile                 |    2 +
> arch/arm/mach-omap2/hwspinlocks.c            |  122 +++++++++++++
> arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
> arch/arm/plat-omap/Makefile                  |    3 +-
> arch/arm/plat-omap/hwspinlock.c              |  250
>++++++++++++++++++++++++++
> arch/arm/plat-omap/include/plat/hwspinlock.h |   30 +++
> arch/arm/plat-omap/include/plat/omap44xx.h   |    2 +
> 7 files changed, 409 insertions(+), 2 deletions(-)
> create mode 100644 arch/arm/mach-omap2/hwspinlocks.c
> create mode 100644 arch/arm/plat-omap/hwspinlock.c
> create mode 100644 arch/arm/plat-omap/include/plat/hwspinlock.h
>
>diff --git a/arch/arm/mach-omap2/Makefile
>b/arch/arm/mach-omap2/Makefile
>index 6725b3a..5f5c87b 100644
>--- a/arch/arm/mach-omap2/Makefile
>+++ b/arch/arm/mach-omap2/Makefile
>@@ -170,3 +170,5 @@ obj-y
>+= $(nand-m) $(nand-y)
>
> smc91x-$(CONFIG_SMC91X)                       := gpmc-smc91x.o
> obj-y                                 += $(smc91x-m) $(smc91x-y)
>+
>+obj-$(CONFIG_ARCH_OMAP4)              += hwspinlocks.o
>\ No newline at end of file
>diff --git a/arch/arm/mach-omap2/hwspinlocks.c
>b/arch/arm/mach-omap2/hwspinlocks.c
>new file mode 100644
>index 0000000..868edea
>--- /dev/null
>+++ b/arch/arm/mach-omap2/hwspinlocks.c
>@@ -0,0 +1,122 @@
>+/*
>+ * OMAP hardware spinlock driver
>+ *
>+ * Copyright (C) 2010 Texas Instruments. All rights reserved.
>+ *
>+ * Contact: Simon Que <sque@ti.com>
>+ *
>+ * This program is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License
>+ * version 2 as published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope that it will be useful, but
>+ * WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>+ * General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>+ * 02110-1301 USA
>+ *
>+ */
>+
>+#include <linux/module.h>
>+#include <linux/interrupt.h>
>+#include <linux/device.h>
>+#include <linux/delay.h>
>+#include <linux/io.h>
>+#include <linux/slab.h>
>+
>+#include <plat/hwspinlock.h>
>+
>+#include <plat/omap_device.h>
>+#include <plat/omap_hwmod.h>
>+
>+#define SPINLOCK_REGADDR(reg)         (OMAP44XX_SPINLOCK_BASE + (reg))

You should not access the physical address directly. The driver should just do a regular platform_get_resource(pdev, IORESOURCE_MEM...) to get the physical address and then do the ioremap.


>+
>+/* Spinlock register offsets */
>+#define REVISION_OFFSET                       0x0000
>+#define SYSCONFIG_OFFSET              0x0010
>+#define SYSSTATUS_OFFSET              0x0014
>+#define LOCK_BASE_OFFSET              0x0800
>+
>+/* Spinlock register addresses */
>+#define SPINLOCK_REVISION_REG         \
>+              SPINLOCK_REGADDR(REVISION_OFFSET)
>+#define SPINLOCK_SYSCONFIG_REG                \
>+              SPINLOCK_REGADDR(SYSCONFIG_OFFSET)
>+#define SPINLOCK_SYSSTATUS_REG                \
>+              SPINLOCK_REGADDR(SYSSTATUS_OFFSET)
>+#define SPINLOCK_LOCK_REG(i)          \
>+              SPINLOCK_REGADDR(LOCK_BASE_OFFSET + 0x4 * (i))
>+
>+/* Spinlock count code */
>+#define SPINLOCK_32_REGS              1
>+#define SPINLOCK_64_REGS              2
>+#define SPINLOCK_128_REGS             4
>+#define SPINLOCK_256_REGS             8
>+#define SPINLOCK_NUMLOCKS_OFFSET      24
>+
>+/* Initialization function */
>+int __init hwspinlocks_init(void)
>+{
>+      int i;
>+      int retval = 0;
>+
>+      struct hwspinlock_plat_info *pdata;
>+      void __iomem *base;
>+      int num_locks;
>+
>+      void __iomem *sysstatus_reg = ioremap(SPINLOCK_SYSSTATUS_REG,
>+
>sizeof(u32));
>+
>+      struct omap_hwmod *oh;
>+      char *oh_name, *pdev_name;
>+
>+      /* Determine number of locks */
>+      switch (readl(sysstatus_reg) >> SPINLOCK_NUMLOCKS_OFFSET) {
>+      case SPINLOCK_32_REGS:
>+              num_locks = 32;
>+              break;
>+      case SPINLOCK_64_REGS:
>+              num_locks = 64;
>+              break;
>+      case SPINLOCK_128_REGS:
>+              num_locks = 128;
>+              break;
>+      case SPINLOCK_256_REGS:
>+              num_locks = 256;
>+              break;
>+      default:
>+              return -EINVAL; /* Invalid spinlock count code */
>+      }
>+
>+      iounmap(sysstatus_reg);
>+
>+      oh_name = "spinlock";
>+      oh = omap_hwmod_lookup(oh_name);
>+      if (WARN_ON(oh == NULL))
>+              return -EINVAL;
>+
>+      pdev_name = "hwspinlock";
>+
>+      /* Device drivers */
>+      for (i = 0; i < num_locks; i++) {
>+              base = ioremap(SPINLOCK_LOCK_REG(i), sizeof(u32));

That should be done during probe time and not during device init time.

Regards,
Benoit

Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



