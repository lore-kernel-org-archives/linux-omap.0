From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [RFC v.2] omap: hwspinlock: Added hwspinlock driver
Date: Tue, 29 Jun 2010 23:18:59 +0200
Message-ID: <74583B8642AB8841B30447520659FCA901AA69616D@dnce01.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167E8@dbde02.ent.ti.com>,<F39349C6FA641B4A831B7BF4EBF4D4E14728E5B3@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5D9E40C@dbde02.ent.ti.com>
 <F39349C6FA641B4A831B7BF4EBF4D4E1473E30B7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34571 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756020Ab0F2VTJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 17:19:09 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E1473E30B7@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, P
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

>From: Que, Simon
>Sent: Tuesday, June 29, 2010 2:28 PM

[snip]

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

Sorry, I missed that part in my previous email...
Are you trying to create one omap_device per lock?

You cannot really do that, because omap_device is supposed to have a one device to many hwmods mapping, but not a many devices to one hwmod.

There is no reference counting done in the framework, so as soon as you will try to enable several locks, that should output a warning saying that you are trying to enable twice the same hwmod. Same thing when you will disable.

Didn't you have that kind of issue during your tests?
BTW, are you enabling the device at some point? I cannot see that either in this patch?

Benoit

>+              base = ioremap(SPINLOCK_LOCK_REG(i), sizeof(u32));
>+
>+              /* Pass data to device initialization */
>+              pdata = kzalloc(sizeof(struct hwspinlock_plat_info),
>+
>GFP_KERNEL);
>+              pdata->num_locks = num_locks;
>+              pdata->io_base = base;
>+
>+              omap_device_build(pdev_name, i, oh, pdata,
>+                              sizeof(struct hwspinlock_plat_info),
>+                              NULL, 0, false);
>+      }
>+
>+      return retval;
>+}
>+module_init(hwspinlocks_init);
>+
>diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>index d8d6d58..ce6c5ff 100644
>--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>@@ -4875,7 +4875,7 @@ static __initdata struct omap_hwmod
>*omap44xx_hwmods[] = {
> /*    &omap44xx_smartreflex_iva_hwmod, */
> /*    &omap44xx_smartreflex_mpu_hwmod, */
>       /* spinlock class */
>-/*    &omap44xx_spinlock_hwmod, */
>+      &omap44xx_spinlock_hwmod,
>       /* timer class */
>       &omap44xx_timer1_hwmod,
>       &omap44xx_timer2_hwmod,
>diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
>index a37abf5..f725afc 100644
>--- a/arch/arm/plat-omap/Makefile
>+++ b/arch/arm/plat-omap/Makefile
>@@ -32,4 +32,5 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
> obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
> obj-$(CONFIG_OMAP_REMOTE_PROC) += remoteproc.o
>
>-obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
>\ No newline at end of file
>+obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
>+obj-$(CONFIG_ARCH_OMAP4) += hwspinlock.o
>\ No newline at end of file
>diff --git a/arch/arm/plat-omap/hwspinlock.c
>b/arch/arm/plat-omap/hwspinlock.c
>new file mode 100644
>index 0000000..dbbf543
>--- /dev/null
>+++ b/arch/arm/plat-omap/hwspinlock.c
>@@ -0,0 +1,250 @@
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
>+#include <linux/spinlock.h>
>+
>+#include <plat/hwspinlock.h>
>+
>+/* for managing a hardware spinlock module */
>+struct hwspinlock_state {
>+      bool is_init;                   /* For first-time
>initialization */
>+      int num_locks;                  /* Total number of
>locks in system */
>+      spinlock_t local_lock;          /* Local protection */
>+};
>+
>+/* Points to the hardware spinlock module */
>+static struct hwspinlock_state hwspinlock_state;
>+static struct hwspinlock_state *hwspinlock_module = &hwspinlock_state;
>+
>+/* Spinlock object */
>+struct hwspinlock {
>+      bool is_init;
>+      void __iomem *io_base;
>+      bool is_allocated;
>+      struct platform_device *pdev;
>+};
>+
>+/* Array of spinlocks */
>+static struct hwspinlock *hwspinlocks;
>+
>+/* API functions */
>+
>+/* Busy loop to acquire a spinlock */
>+int hwspinlock_lock(struct hwspinlock *handle)
>+{
>+      int retval;
>+
>+      if (WARN_ON(handle == NULL))
>+              return -EINVAL;
>+
>+      if (WARN_ON(in_atomic() || in_irq()))
>+              return -EPERM;
>+
>+      /* Attempt to acquire the lock by reading from it */
>+      do {
>+              retval = readl(handle->io_base);
>+      } while (retval == HWSPINLOCK_BUSY);
>+
>+      return 0;
>+}
>+EXPORT_SYMBOL(hwspinlock_lock);
>+
>+/* Attempt to acquire a spinlock once */
>+int hwspinlock_trylock(struct hwspinlock *handle)
>+{
>+      int retval = 0;
>+
>+      if (WARN_ON(handle == NULL))
>+              return -EINVAL;
>+
>+      if (WARN_ON(in_atomic() || in_irq()))
>+              return -EPERM;
>+
>+      /* Attempt to acquire the lock by reading from it */
>+      retval = readl(handle->io_base);
>+
>+      return retval;
>+}
>+EXPORT_SYMBOL(hwspinlock_trylock);
>+
>+/* Release a spinlock */
>+int hwspinlock_unlock(struct hwspinlock *handle)
>+{
>+      if (WARN_ON(handle == NULL))
>+              return -EINVAL;
>+
>+      /* Release it by writing 0 to it */
>+      writel(0, handle->io_base);
>+
>+      return 0;
>+}
>+EXPORT_SYMBOL(hwspinlock_unlock);
>+
>+/* Request an unclaimed spinlock */
>+struct hwspinlock *hwspinlock_request(void)
>+{
>+      int i;
>+      bool found = false;
>+      struct hwspinlock *handle = NULL;
>+      unsigned long flags;
>+
>+      spin_lock_irqsave(&hwspinlock_module->local_lock, flags);
>+      /* Search for an unclaimed, unreserved lock */
>+      for (i = 0; i < hwspinlock_module->num_locks && !found; i++) {
>+              if (!hwspinlocks[i].is_allocated) {
>+                      found = true;
>+                      handle = &hwspinlocks[i];
>+              }
>+      }
>+      spin_unlock_irqrestore(&hwspinlock_module->local_lock, flags);
>+
>+      /* Return error if no more locks available */
>+      if (!found)
>+              return NULL;
>+
>+      handle->is_allocated = true;
>+
>+      return handle;
>+}
>+EXPORT_SYMBOL(hwspinlock_request);
>+
>+/* Request an unclaimed spinlock by ID */
>+struct hwspinlock *hwspinlock_request_specific(unsigned int id)
>+{
>+      struct hwspinlock *handle = NULL;
>+      unsigned long flags;
>+
>+      spin_lock_irqsave(&hwspinlock_module->local_lock, flags);
>+
>+      if (WARN_ON(hwspinlocks[id].is_allocated))
>+              goto exit;
>+
>+      handle = &hwspinlocks[id];
>+      handle->is_allocated = true;
>+
>+exit:
>+      spin_unlock_irqrestore(&hwspinlock_module->local_lock, flags);
>+      return handle;
>+}
>+EXPORT_SYMBOL(hwspinlock_request_specific);
>+
>+/* Release a claimed spinlock */
>+int hwspinlock_free(struct hwspinlock *handle)
>+{
>+      if (WARN_ON(handle == NULL))
>+              return -EINVAL;
>+
>+      if (WARN_ON(!handle->is_allocated))
>+              return -ENOMEM;
>+
>+      handle->is_allocated = false;
>+
>+      return 0;
>+}
>+EXPORT_SYMBOL(hwspinlock_free);
>+
>+/* Probe function */
>+static int __devinit hwspinlock_probe(struct platform_device *pdev)
>+{
>+      struct hwspinlock_plat_info *pdata = pdev->dev.platform_data;
>+      int id;
>+
>+      /* Set up the spinlock count and array */
>+      if (!hwspinlock_module->is_init) {
>+              hwspinlock_module->num_locks = pdata->num_locks;
>+
>+              /* Allocate spinlock device objects */
>+              hwspinlocks = kmalloc(sizeof(struct hwspinlock) *
>+                              hwspinlock_module->num_locks,
>GFP_KERNEL);
>+              if (WARN_ON(hwspinlocks == NULL))
>+                      return -ENOMEM;
>+
>+              /* Initialize local lock */
>+              spin_lock_init(&hwspinlock_module->local_lock);
>+
>+              /* Only do initialization once */
>+              hwspinlock_module->is_init = true;
>+
>+              for (id = 0; id < pdata->num_locks; id++)
>+                      hwspinlocks[id].is_init = false;
>+      }
>+
>+      id = pdev->id;
>+
>+      hwspinlocks[id].pdev                    = pdev;
>+
>+      hwspinlocks[id].is_allocated            = false;
>+      hwspinlocks[id].io_base                 = pdata->io_base;
>+      hwspinlocks[id].is_init                 = true;
>+
>+      return 0;
>+}
>+
>+static struct platform_driver hwspinlock_driver = {
>+      .probe          = hwspinlock_probe,
>+      .driver         = {
>+              .name   = "hwspinlock",
>+      },
>+};
>+
>+/* Initialization function */
>+static int __init hwspinlock_init(void)
>+{
>+      int retval = 0;
>+
>+      /* Register spinlock driver */
>+      retval = platform_driver_register(&hwspinlock_driver);
>+
>+      return retval;
>+}
>+
>+/* Cleanup function */
>+static void __exit hwspinlock_exit(void)
>+{
>+      int id;
>+
>+      platform_driver_unregister(&hwspinlock_driver);
>+
>+      for (id = 0; id < hwspinlock_module->num_locks; id++) {
>+              iounmap(hwspinlocks[id].io_base);
>+              hwspinlocks[id].is_init = false;
>+      }
>+
>+      /* Free spinlock device objects */
>+      if (hwspinlock_module->is_init)
>+              kfree(hwspinlocks);
>+}
>+
>+module_init(hwspinlock_init);
>+module_exit(hwspinlock_exit);
>+
>+MODULE_LICENSE("GPL v2");
>+MODULE_DESCRIPTION("Hardware spinlock driver");
>+MODULE_AUTHOR("Simon Que");
>+MODULE_AUTHOR("Hari Kanigeri");
>diff --git a/arch/arm/plat-omap/include/plat/hwspinlock.h
>b/arch/arm/plat-omap/include/plat/hwspinlock.h
>new file mode 100644
>index 0000000..6de2cb9
>--- /dev/null
>+++ b/arch/arm/plat-omap/include/plat/hwspinlock.h
>@@ -0,0 +1,30 @@
>+/* hwspinlock.h */
>+
>+#ifndef HWSPINLOCK_H
>+#define HWSPINLOCK_H
>+
>+#include <linux/platform_device.h>
>+#include <plat/omap44xx.h>
>+
>+/* Read values from the spinlock register */
>+#define HWSPINLOCK_ACQUIRED 0
>+#define HWSPINLOCK_BUSY 1
>+
>+/* Device data */
>+struct hwspinlock_plat_info {
>+      int num_locks;                  /* Number of locks
>(initialization) */
>+      void __iomem *io_base;          /* Address of spinlock
>register */
>+      bool is_reserved;               /* Reserved for system use? */
>+};
>+
>+struct hwspinlock;
>+
>+int hwspinlock_lock(struct hwspinlock *handle);
>+int hwspinlock_trylock(struct hwspinlock *handle);
>+int hwspinlock_unlock(struct hwspinlock *handle);
>+
>+struct hwspinlock *hwspinlock_request(void);
>+struct hwspinlock *hwspinlock_request_specific(unsigned int id);
>+int hwspinlock_free(struct hwspinlock *hwspinlock_ptr);
>+
>+#endif /* HWSPINLOCK_H */
>diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h
>b/arch/arm/plat-omap/include/plat/omap44xx.h
>index 8b3f12f..8016508 100644
>--- a/arch/arm/plat-omap/include/plat/omap44xx.h
>+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
>@@ -52,5 +52,7 @@
> #define OMAP4_MMU1_BASE                       0x55082000
> #define OMAP4_MMU2_BASE                       0x4A066000
>
>+#define OMAP44XX_SPINLOCK_BASE                (L4_44XX_BASE + 0xF6000)
>+
> #endif /* __ASM_ARCH_OMAP44XX_H */
>
>--
>1.7.0
>
>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



