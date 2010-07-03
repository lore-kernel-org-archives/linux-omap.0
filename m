From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC v.3] omap: hwspinlock: Added hwspinlock driver
Date: Sat, 3 Jul 2010 12:24:29 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEF1B@dbde02.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1474EA6A1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39642 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab0GCGyg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jul 2010 02:54:36 -0400
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E1474EA6A1@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Que, Simon
> Sent: Saturday, July 03, 2010 5:49 AM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Ohad Ben-Cohen
> Subject: [RFC v.3] omap: hwspinlock: Added hwspinlock driver
>
[..]
>
> Created driver for OMAP hardware spinlock.  This driver supports:
> - Reserved spinlocks for internal use
> - Dynamic allocation of unreserved locks
> - Lock, unlock, and trylock functions, with or without disabling
> irqs/preempt
> - Registered as a platform device driver
>
> The device initialization uses hwmod to configure the devices.  One device
> will
> be created for each hardware spinlock.  It will pass spinlock register
> addresses to the driver.  The device initialization file is:
>                 arch/arm/mach-omap2/hwspinlocks.c
>
> The driver takes in data passed in device initialization.  The function
> hwspinlock_probe() initializes the array of spinlock structures, each
> containing a spinlock register address provided by the device
> initialization.
> The device driver file is:
>                 arch/arm/plat-omap/hwspinlock.c
>
> Here's an API summary:
> int hwspinlock_lock(struct hwspinlock *);
>         Attempt to lock a hardware spinlock.  If it is busy, the function
> will
>         keep trying until it succeeds.  This is a blocking function.
> int hwspinlock_trylock(struct hwspinlock *);
>         Attempt to lock a hardware spinlock.  If it is busy, the function
> will
>         return BUSY.  If it succeeds in locking, the function will return
>         ACQUIRED.  This is a non-blocking function
> int hwspinlock_unlock(struct hwspinlock *);
>         Unlock a hardware spinlock.
>
> struct hwspinlock *hwspinlock_request(void);
>         Provides for "dynamic allocation" of a hardware spinlock.  It
> returns
>         the handle to the next available (unallocated) spinlock.  If no
> more
>         locks are available, it returns NULL.
> struct hwspinlock *hwspinlock_request_specific(unsigned int);
>         Provides for "static allocation" of a specific hardware spinlock.
> This
>         allows the system to use a specific spinlock, identified by an ID.
> If
>         the ID is invalid or if the desired lock is already allocated,
> this
>         will return NULL.  Otherwise it returns a spinlock handle.
> int hwspinlock_free(struct hwspinlock *);
>         Frees an allocated hardware spinlock (either reserved or
> unreserved).
>
> Signed-off-by: Simon Que <sque@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                 |    2 +
>  arch/arm/mach-omap2/hwspinlocks.c            |   72 ++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
>  arch/arm/plat-omap/Makefile                  |    3 +-
>  arch/arm/plat-omap/hwspinlock.c              |  298
> ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/hwspinlock.h |   29 +++
>  arch/arm/plat-omap/include/plat/omap44xx.h   |    2 +
>  7 files changed, 406 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/hwspinlocks.c
>  create mode 100644 arch/arm/plat-omap/hwspinlock.c
>  create mode 100644 arch/arm/plat-omap/include/plat/hwspinlock.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 6725b3a..5f5c87b 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -170,3 +170,5 @@ obj-y                                       += $(nand-
> m) $(nand-y)
>
>  smc91x-$(CONFIG_SMC91X)                        := gpmc-smc91x.o
>  obj-y                                  += $(smc91x-m) $(smc91x-y)
> +
> +obj-$(CONFIG_ARCH_OMAP4)               += hwspinlocks.o
> \ No newline at end of file
> diff --git a/arch/arm/mach-omap2/hwspinlocks.c b/arch/arm/mach-
> omap2/hwspinlocks.c
> new file mode 100644
> index 0000000..f0b212b
> --- /dev/null
> +++ b/arch/arm/mach-omap2/hwspinlocks.c
> @@ -0,0 +1,72 @@
> +/*
> + * OMAP hardware spinlock device initialization
> + *
> + * Copyright (C) 2010 Texas Instruments. All rights reserved.
> + *
> + * Contact: Simon Que <sque@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +
> +#include <plat/hwspinlock.h>
> +
No need of new  line here.
> +#include <plat/omap_device.h>
> +#include <plat/omap_hwmod.h>
> +
> +/* Spinlock register offsets */
> +#define REVISION_OFFSET                        0x0000
> +#define SYSCONFIG_OFFSET               0x0010
> +#define SYSSTATUS_OFFSET               0x0014
> +#define LOCK_BASE_OFFSET               0x0800
> +#define LOCK_OFFSET(i)                 (LOCK_BASE_OFFSET + 0x4 * (i))
> +
> +/* Initialization function */
> +int __init hwspinlocks_init(void)
Since it's only init, can this go to "arch/arm/mach-omap2/omap4-commin.c" ?
> +{
> +       int retval = 0;
> +
> +       struct hwspinlock_plat_info *pdata;
> +       struct omap_hwmod *oh;
> +       char *oh_name, *pdev_name;
> +
> +       oh_name = "spinlock";
> +       oh = omap_hwmod_lookup(oh_name);
> +       if (WARN_ON(oh == NULL))
> +               return -EINVAL;
> +
> +       pdev_name = "hwspinlock";
> +
> +       /* Pass data to device initialization */
> +       pdata = kzalloc(sizeof(struct hwspinlock_plat_info), GFP_KERNEL);
> +       if (WARN_ON(pdata == NULL))
> +               return -ENOMEM;
> +       pdata->sysstatus_offset = SYSSTATUS_OFFSET;
> +       pdata->lock_base_offset = LOCK_BASE_OFFSET;
> +
> +       omap_device_build(pdev_name, 0, oh, pdata,
> +                       sizeof(struct hwspinlock_plat_info), NULL, 0,
> false);
> +
> +       return retval;
> +}
> +module_init(hwspinlocks_init);
> +
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_44xx_data.c
> index d8d6d58..ce6c5ff 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -4875,7 +4875,7 @@ static __initdata struct omap_hwmod
> *omap44xx_hwmods[] = {
>  /*     &omap44xx_smartreflex_iva_hwmod, */
>  /*     &omap44xx_smartreflex_mpu_hwmod, */
>         /* spinlock class */
> -/*     &omap44xx_spinlock_hwmod, */
> +       &omap44xx_spinlock_hwmod,
>         /* timer class */
>         &omap44xx_timer1_hwmod,
>         &omap44xx_timer2_hwmod,
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index a37abf5..f725afc 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -32,4 +32,5 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
>  obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
>  obj-$(CONFIG_OMAP_REMOTE_PROC) += remoteproc.o
>
> -obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
> \ No newline at end of file
> +obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
> +obj-$(CONFIG_ARCH_OMAP4) += hwspinlock.o
> \ No newline at end of file
> diff --git a/arch/arm/plat-omap/hwspinlock.c b/arch/arm/plat-
> omap/hwspinlock.c
> new file mode 100644
> index 0000000..7cfd2c0
> --- /dev/null
> +++ b/arch/arm/plat-omap/hwspinlock.c
> @@ -0,0 +1,298 @@
> +/*
> + * OMAP hardware spinlock driver
> + *
> + * Copyright (C) 2010 Texas Instruments. All rights reserved.
> + *
> + * Contact: Simon Que <sque@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include <plat/hwspinlock.h>
> +
> +/* Spinlock count code */
> +#define SPINLOCK_32_REGS               1
> +#define SPINLOCK_64_REGS               2
> +#define SPINLOCK_128_REGS              4
> +#define SPINLOCK_256_REGS              8
> +#define SPINLOCK_NUMLOCKS_OFFSET       24
> +
> +/* for managing a hardware spinlock module */
> +struct hwspinlock_state {
> +       bool is_init;                   /* For first-time initialization
> */
> +       int num_locks;                  /* Total number of locks in system
> */
> +       spinlock_t local_lock;          /* Local protection */
> +       void __iomem *io_base;          /* Mapped base address */
> +};
> +
> +/* Points to the hardware spinlock module */
> +static struct hwspinlock_state hwspinlock_state;
> +static struct hwspinlock_state *hwspinlock_module = &hwspinlock_state;
> +
> +/* Spinlock object */
> +struct hwspinlock {
> +       bool is_init;
> +       int id;
> +       void __iomem *lock_reg;
> +       bool is_allocated;
> +       struct platform_device *pdev;
> +};
> +
> +/* Array of spinlocks */
> +static struct hwspinlock *hwspinlocks;
> +
> +/* API functions */
> +
> +/* Busy loop to acquire a spinlock */
> +int hwspinlock_lock(struct hwspinlock *handle)
> +{
> +       int retval;
> +
> +       if (WARN_ON(handle == NULL))
> +               return -EINVAL;
> +
> +       if (WARN_ON(in_atomic() || in_irq()))
> +               return -EPERM;
> +
> +       if (pm_runtime_get(&handle->pdev->dev) < 0)
> +               return -ENODEV;
> +
> +       /* Attempt to acquire the lock by reading from it */
> +       do {
> +               retval = readl(handle->lock_reg);
> +       } while (retval == HWSPINLOCK_BUSY);
> +
> +       if (retval == HWSPINLOCK_BUSY)
> +               pm_runtime_put(&handle->pdev->dev);
What resource is getting release with above ??
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(hwspinlock_lock);
> +
> +/* Attempt to acquire a spinlock once */
> +int hwspinlock_trylock(struct hwspinlock *handle)
> +{
> +       int retval = 0;
> +
> +       if (WARN_ON(handle == NULL))
> +               return -EINVAL;
> +
> +       if (WARN_ON(in_atomic() || in_irq()))
> +               return -EPERM;
> +
> +       if (pm_runtime_get(&handle->pdev->dev) < 0)
> +               return -ENODEV;
> +
> +       /* Attempt to acquire the lock by reading from it */
> +       retval = readl(handle->lock_reg);
> +
> +       if (retval == HWSPINLOCK_BUSY)
> +               pm_runtime_put(&handle->pdev->dev);
> +
> +       return retval;
> +}
> +EXPORT_SYMBOL(hwspinlock_trylock);
> +
> +/* Release a spinlock */
> +int hwspinlock_unlock(struct hwspinlock *handle)
> +{
> +       if (WARN_ON(handle == NULL))
> +               return -EINVAL;
> +
> +       /* Release it by writing 0 to it */
> +       writel(0, handle->lock_reg);
> +
> +       pm_runtime_put(&handle->pdev->dev);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(hwspinlock_unlock);
> +
> +/* Request an unclaimed spinlock */
> +struct hwspinlock *hwspinlock_request(void)
> +{
> +       int i;
> +       bool found = false;
> +       struct hwspinlock *handle = NULL;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&hwspinlock_module->local_lock, flags);
> +       /* Search for an unclaimed, unreserved lock */
> +       for (i = 0; i < hwspinlock_module->num_locks && !found; i++) {
> +               if (!hwspinlocks[i].is_allocated) {
> +                       found = true;
> +                       handle = &hwspinlocks[i];
> +               }
> +       }
> +       spin_unlock_irqrestore(&hwspinlock_module->local_lock, flags);
> +
> +       /* Return error if no more locks available */
> +       if (!found)
> +               return NULL;
> +
> +       handle->is_allocated = true;
> +
> +       return handle;
> +}
> +EXPORT_SYMBOL(hwspinlock_request);
> +
> +/* Request an unclaimed spinlock by ID */
> +struct hwspinlock *hwspinlock_request_specific(unsigned int id)
> +{
> +       struct hwspinlock *handle = NULL;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&hwspinlock_module->local_lock, flags);
> +
> +       if (WARN_ON(hwspinlocks[id].is_allocated))
> +               goto exit;
> +
> +       handle = &hwspinlocks[id];
> +       handle->is_allocated = true;
> +
> +exit:
> +       spin_unlock_irqrestore(&hwspinlock_module->local_lock, flags);
> +       return handle;
> +}
> +EXPORT_SYMBOL(hwspinlock_request_specific);
> +
> +/* Release a claimed spinlock */
> +int hwspinlock_free(struct hwspinlock *handle)
> +{
> +       if (WARN_ON(handle == NULL))
> +               return -EINVAL;
> +
> +       if (WARN_ON(!handle->is_allocated))
> +               return -ENOMEM;
> +
> +       handle->is_allocated = false;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(hwspinlock_free);
> +
> +/* Probe function */
> +static int __devinit hwspinlock_probe(struct platform_device *pdev)
> +{
> +       struct hwspinlock_plat_info *pdata = pdev->dev.platform_data;
> +       struct resource *res;
> +       void __iomem *io_base;
> +       int id;
> +
> +       void __iomem *sysstatus_reg;
> +
> +       /* Determine number of locks */
> +       sysstatus_reg = ioremap(OMAP44XX_SPINLOCK_BASE +
> +                                       pdata->sysstatus_offset,
> sizeof(u32));
> +       switch (readl(sysstatus_reg) >> SPINLOCK_NUMLOCKS_OFFSET) {
> +       case SPINLOCK_32_REGS:
> +               hwspinlock_module->num_locks = 32;
> +               break;
> +       case SPINLOCK_64_REGS:
> +               hwspinlock_module->num_locks = 64;
> +               break;
> +       case SPINLOCK_128_REGS:
> +               hwspinlock_module->num_locks = 128;
> +               break;
> +       case SPINLOCK_256_REGS:
> +               hwspinlock_module->num_locks = 256;
> +               break;
> +       default:
> +               return -EINVAL; /* Invalid spinlock count code */
> +       }
> +       iounmap(sysstatus_reg);
> +
> +       /* Allocate spinlock device objects */
> +       hwspinlocks = kmalloc(sizeof(struct hwspinlock) *
> +                       hwspinlock_module->num_locks, GFP_KERNEL);
> +       if (WARN_ON(hwspinlocks == NULL))
> +               return -ENOMEM;
> +
> +       /* Initialize local lock */
> +       spin_lock_init(&hwspinlock_module->local_lock);
> +
> +       /* Get address info */
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       /* Map spinlock module address space */
> +       io_base = ioremap(res->start, resource_size(res));
> +       hwspinlock_module->io_base = io_base;
> +
> +       /* Set up each individual lock handle */
> +       for (id = 0; id < hwspinlock_module->num_locks; id++) {
> +               hwspinlocks[id].id              = id;
> +               hwspinlocks[id].pdev            = pdev;
> +
> +               hwspinlocks[id].is_init         = true;
> +               hwspinlocks[id].is_allocated    = false;
> +
> +               hwspinlocks[id].lock_reg        = io_base + pdata->
> +                                       lock_base_offset + sizeof(u32) *
> id;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct platform_driver hwspinlock_driver = {
> +       .probe          = hwspinlock_probe,
> +       .driver         = {
> +               .name   = "hwspinlock",
> +       },
> +};
> +
> +/* Initialization function */
> +static int __init hwspinlock_init(void)
> +{
> +       int retval = 0;
> +
> +       /* Register spinlock driver */
> +       retval = platform_driver_register(&hwspinlock_driver);
> +
> +       return retval;
> +}
> +
> +/* Cleanup function */
> +static void __exit hwspinlock_exit(void)
> +{
> +       int id;
> +
> +       platform_driver_unregister(&hwspinlock_driver);
> +
> +       for (id = 0; id < hwspinlock_module->num_locks; id++)
> +               hwspinlocks[id].is_init = false;
> +       iounmap(hwspinlock_module->io_base);
> +
> +       /* Free spinlock device objects */
> +       if (hwspinlock_module->is_init)
> +               kfree(hwspinlocks);
> +}
> +
> +module_init(hwspinlock_init);
> +module_exit(hwspinlock_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Hardware spinlock driver");
> +MODULE_AUTHOR("Simon Que");
> +MODULE_AUTHOR("Hari Kanigeri");
> diff --git a/arch/arm/plat-omap/include/plat/hwspinlock.h b/arch/arm/plat-
> omap/include/plat/hwspinlock.h
> new file mode 100644
> index 0000000..8c69ca5
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/hwspinlock.h
> @@ -0,0 +1,29 @@
> +/* hwspinlock.h */
> +
> +#ifndef HWSPINLOCK_H
> +#define HWSPINLOCK_H
> +
> +#include <linux/platform_device.h>
> +#include <plat/omap44xx.h>
> +
> +/* Read values from the spinlock register */
> +#define HWSPINLOCK_ACQUIRED 0
> +#define HWSPINLOCK_BUSY 1
> +
> +/* Device data */
> +struct hwspinlock_plat_info {
> +       u32 sysstatus_offset;           /* System status register offset
> */
> +       u32 lock_base_offset;           /* Offset of spinlock registers */
> +};
> +
> +struct hwspinlock;
> +
> +int hwspinlock_lock(struct hwspinlock *handle);
> +int hwspinlock_trylock(struct hwspinlock *handle);
> +int hwspinlock_unlock(struct hwspinlock *handle);
> +
> +struct hwspinlock *hwspinlock_request(void);
> +struct hwspinlock *hwspinlock_request_specific(unsigned int id);
> +int hwspinlock_free(struct hwspinlock *hwspinlock_ptr);
> +
> +#endif /* HWSPINLOCK_H */
> diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-
> omap/include/plat/omap44xx.h
> index 8b3f12f..8016508 100644
> --- a/arch/arm/plat-omap/include/plat/omap44xx.h
> +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
> @@ -52,5 +52,7 @@
>  #define OMAP4_MMU1_BASE                        0x55082000
>  #define OMAP4_MMU2_BASE                        0x4A066000
>
> +#define OMAP44XX_SPINLOCK_BASE         (L4_44XX_BASE + 0xF6000)
> +
>  #endif /* __ASM_ARCH_OMAP44XX_H */
>
> --
> 1.7.0

