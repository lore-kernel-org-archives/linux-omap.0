From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 3/4 v2] omap: hwspinlock: Created driver for OMAP
 hardware spinlock.
Date: Thu, 12 Aug 2010 15:31:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E814709F@dbde02.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54840 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516Ab0HLKBp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 06:01:45 -0400
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

> -----Original Message-----
> From: Que, Simon
> Sent: Thursday, August 12, 2010 6:00 AM
> To: Linux Omap; Tony Lindgren
> Cc: Cousson, Benoit; Shilimkar, Santosh; Premi, Sanjeev;
> Kanigeri, Hari
> Subject: [PATCH 3/4 v2] omap: hwspinlock: Created driver for
> OMAP hardware spinlock.
>
> Created driver for OMAP hardware spinlock.
>
>  - Reserved spinlocks for internal use
>  - Dynamic allocation of unreserved locks
>  - Lock, unlock, and trylock functions, with or without
> disabling irqs/preempt
>  - Registered as a platform device driver
>
> The device initialization uses hwmod to configure the devices.
> One device will be created for each IP.  It will pass
> spinlock register offset info to the driver.  The device
> initialization file is:
>               arch/arm/mach-omap2/hwspinlocks.c
>
> The driver takes in register offset info passed in device
> initialization.
> It uses hwmod to obtain the base address of the hardware
> spinlock module.
> Then it reads info from the registers.  The function
> hwspinlock_probe() initializes the array of spinlock
> structures, each containing a spinlock register address
> calculated from the base address and lock offsets.
> The device driver file is:
>               arch/arm/plat-omap/hwspinlock.c
>
> Here's an API summary:
> int hwspinlock_lock(struct hwspinlock *);
>       Attempt to lock a hardware spinlock.  If it is busy,
> the function will
>       keep trying until it succeeds.  This is a blocking function.
> int hwspinlock_trylock(struct hwspinlock *);
>       Attempt to lock a hardware spinlock.  If it is busy,
> the function will
>       return BUSY.  If it succeeds in locking, the function
> will return
>       ACQUIRED.  This is a non-blocking function.
> int hwspinlock_unlock(struct hwspinlock *);
>       Unlock a hardware spinlock.
>
> struct hwspinlock *hwspinlock_request(void);
>       Provides for "dynamic allocation" of a hardware
> spinlock.  It returns
>       the handle to the next available (unallocated)
> spinlock.  If no more
>       locks are available, it returns NULL.
> struct hwspinlock *hwspinlock_request_specific(unsigned int);
>       Provides for "static allocation" of a specific hardware
> spinlock. This
>       allows the system to use a specific spinlock,
> identified by an ID. If
>       the ID is invalid or if the desired lock is already
> allocated, this
>       will return NULL.  Otherwise it returns a spinlock handle.
> int hwspinlock_free(struct hwspinlock *);
>       Frees an allocated hardware spinlock (either reserved
> or unreserved).
>
> Signed-off-by: Simon Que <sque@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Krishnamoorthy, Balaji T <balajitk@ti.com>
> ---
>  arch/arm/mach-omap2/hwspinlocks.c            |   65 +++++
>  arch/arm/plat-omap/hwspinlock.c              |  353
> ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/hwspinlock.h |   47 ++++
>  3 files changed, 465 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/hwspinlocks.c
>  create mode 100644 arch/arm/plat-omap/hwspinlock.c
>  create mode 100644 arch/arm/plat-omap/include/plat/hwspinlock.h
>
> diff --git a/arch/arm/mach-omap2/hwspinlocks.c
> b/arch/arm/mach-omap2/hwspinlocks.c
> new file mode 100644
> index 0000000..154fc40
> --- /dev/null
> +++ b/arch/arm/mach-omap2/hwspinlocks.c
> @@ -0,0 +1,65 @@
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
> + * This program is distributed in the hope that it will be
> useful, but
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
> +#include <plat/omap_device.h>
> +#include <plat/omap_hwmod.h>
> +
> +
> +struct omap_device_pm_latency omap_spinlock_latency[] = {
> +     {
> +             .deactivate_func = omap_device_idle_hwmods,
> +             .activate_func   = omap_device_enable_hwmods,
> +             .flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +     }
> +};
> +
> +/* Initialization function */
> +int __init hwspinlocks_init(void)
> +{
> +     int retval = 0;
> +
> +     struct omap_hwmod *oh;
> +     const char *oh_name, *pdev_name;
> +
> +     oh_name = "spinlock";
> +     oh = omap_hwmod_lookup(oh_name);
> +     if (WARN_ON(oh == NULL))
> +             return -EINVAL;
> +
> +     pdev_name = "hwspinlock";
> +
> +     /* Pass data to device initialization */
> +     omap_device_build(pdev_name, 0, oh, NULL, 0,
> omap_spinlock_latency,
> +
> ARRAY_SIZE(omap_spinlock_latency), false);
> +
> +     return retval;
> +}
> +postcore_initcall(hwspinlocks_init);
> diff --git a/arch/arm/plat-omap/hwspinlock.c
> b/arch/arm/plat-omap/hwspinlock.c
> new file mode 100644
> index 0000000..6f78658
> --- /dev/null
> +++ b/arch/arm/plat-omap/hwspinlock.c
> @@ -0,0 +1,353 @@
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
> + * This program is distributed in the hope that it will be
> useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + * This driver supports:
> + * - Reserved spinlocks for internal use
> + * - Dynamic allocation of unreserved locks
> + * - Lock, unlock, and trylock functions, with or without
> disabling irqs/preempt
> + * - Registered as a platform device driver
> + *
> + * The device initialization uses hwmod to configure the
> devices.  One device
> + * will be created for each IP.  It will pass spinlock
> register offset info to
> + * the driver.  The device initialization file is:
> + *          arch/arm/mach-omap2/hwspinlock_array.c
> + *
> + * The driver takes in register offset info passed in device
> initialization.
> + * It uses hwmod to obtain the base address of the hardware
> spinlock module.
> + * Then it reads info from the registers.  The function
> hwspinlock_probe()
> + * initializes the array of spinlock structures, each
> containing a spinlock
> + * register address calculated from the base address and
> lock offsets.
> + *
> + * Here's an API summary:
> + *
> + * int hwspinlock_lock(struct hwspinlock *);
> + *      Attempt to lock a hardware spinlock.  If it is busy,
> the function will
> + *      keep trying until it succeeds.  This is a blocking function.
> + * int hwspinlock_trylock(struct hwspinlock *);
> + *      Attempt to lock a hardware spinlock.  If it is busy,
> the function will
> + *      return BUSY.  If it succeeds in locking, the
> function will return
> + *      ACQUIRED.  This is a non-blocking function
> + * int hwspinlock_unlock(struct hwspinlock *);
> + *      Unlock a hardware spinlock.
> + *
> + * struct hwspinlock *hwspinlock_request(void);
> + *      Provides for "dynamic allocation" of a hardware
> spinlock.  It returns
> + *      the handle to the next available (unallocated)
> spinlock.  If no more
> + *      locks are available, it returns NULL.
> + * struct hwspinlock *hwspinlock_request_specific(unsigned int);
> + *      Provides for "static allocation" of a specific
> hardware spinlock. This
> + *      allows the system to use a specific spinlock,
> identified by an ID. If
> + *      the ID is invalid or if the desired lock is already
> allocated, this
> + *      will return NULL.  Otherwise it returns a spinlock handle.
> + * int hwspinlock_free(struct hwspinlock *);
> + *      Frees an allocated hardware spinlock (either
> reserved or unreserved).
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
> +/* Spinlock register offsets */
> +#define SYSSTATUS_OFFSET             0x0014
> +#define LOCK_BASE_OFFSET             0x0800
> +
> +/* Spinlock count code */
> +#define SPINLOCK_32_REGS             1
> +#define SPINLOCK_64_REGS             2
> +#define SPINLOCK_128_REGS            4
> +#define SPINLOCK_256_REGS            8
> +#define SPINLOCK_NUMLOCKS_BIT_OFFSET 24
> +
> +/* Number of attempts to try locking */
> +#define MAX_LOCK_ATTEMPTS            1000
> +
> +/* for managing a hardware spinlock module */
> +struct hwspinlock_module_state {
> +     bool is_init;                   /* For first-time
> initialization */
> +     int num_locks;                  /* Total number of
> locks in system */
> +     spinlock_t local_lock;          /* Local protection */
> +     void __iomem *io_base;          /* Mapped base address */
> +};
> +
> +/* Points to the hardware spinlock module */
> +static struct hwspinlock_module_state hwspinlock_state;
> +
> +/* Spinlock object */
> +struct hwspinlock {
> +     bool is_init;
> +     int id;
> +     void __iomem *lock_reg;
> +     bool is_allocated;
> +     struct platform_device *pdev;
> +};
> +
> +/* Array of spinlocks */
> +static struct hwspinlock *hwspinlock_array;
> +
> +/* API functions */
> +
> +/* Busy loop to acquire a spinlock */
> +int hwspinlock_lock(struct hwspinlock *handle)
> +{
> +     int retval;
> +     int num_attempts = 0;
> +
> +     if (WARN_ON(handle == NULL))
> +             return -EINVAL;
> +
> +     /* This is not permitted in IRQ because we do not want
> a context */
> +     /* switch while the lock is being held */
> +     if (WARN_ON(in_irq()))
> +             return -EPERM;
> +
> +     if (pm_runtime_get_sync(&handle->pdev->dev) < 0)
> +             return -ENODEV;
> +
> +     /* Attempt to acquire the lock by reading from it */
> +     do {
> +             retval = readl(handle->lock_reg);
> +             num_attempts++;         /* Increment the
> timeout counter */
> +     } while (retval == HWSPINLOCK_BUSY &&
> +                                     num_attempts <
> MAX_LOCK_ATTEMPTS);
> +
> +     /* If there was a timeout, put the device back */
> +     if (num_attempts >= MAX_LOCK_ATTEMPTS)
> +             pm_runtime_put_sync(&handle->pdev->dev);
> +
> +     return retval;
> +}
> +EXPORT_SYMBOL(hwspinlock_lock);
> +
> +/* Attempt to acquire a spinlock once */
> +int hwspinlock_trylock(struct hwspinlock *handle)
> +{
> +     int retval = 0;
> +
> +     if (WARN_ON(handle == NULL))
> +             return -EINVAL;
> +
> +     /* This is not permitted in IRQ because we do not want
> a context */
> +     /* switch while the lock is being held */
> +     if (WARN_ON(in_irq()))
> +             return -EPERM;
> +
> +     if ((retval = pm_runtime_get_sync(&handle->pdev->dev)) < 0)
> +             return -ENODEV;
> +
> +     /* Attempt to acquire the lock by reading from it */
> +     retval = readl(handle->lock_reg);
> +
> +     if (retval == HWSPINLOCK_BUSY)
> +             pm_runtime_put_sync(&handle->pdev->dev);
> +
> +     return retval;
> +}
> +EXPORT_SYMBOL(hwspinlock_trylock);

[sp] The code is almost duplicated in the functions hwspinlock_trylock()
     and hwspinlock_lock(). The difference being try-once/ try-multiple.
     I believe one function with additional arg - say limit - should be
     sufficient.

     If there is need to abstract additional arg, you can define macros
     for the same.

> +
> +/* Release a spinlock */
> +int hwspinlock_unlock(struct hwspinlock *handle)
> +{
> +     if (WARN_ON(handle == NULL))
> +             return -EINVAL;
> +
> +     /* Release it by writing 0 to it */
> +     writel(0, handle->lock_reg);
> +
> +     pm_runtime_put_sync(&handle->pdev->dev);
> +
> +     return 0;
> +}
> +EXPORT_SYMBOL(hwspinlock_unlock);
> +
> +/* Request an unclaimed spinlock */
> +struct hwspinlock *hwspinlock_request(void)
> +{
> +     int i;
> +     bool found = false;
> +     struct hwspinlock *handle = NULL;
> +     unsigned long flags;
> +
> +     spin_lock_irqsave(&hwspinlock_state.local_lock, flags);
> +     /* Search for an unclaimed, unreserved lock */
> +     for (i = 0; i < hwspinlock_state.num_locks && !found; i++) {
> +             if (!hwspinlock_array[i].is_allocated) {
> +                     found = true;
> +                     handle = &hwspinlock_array[i];
> +             }

[sp] Starting from index 0 every time can be quite time consuming
     esp. in the situations where we need spinlocks. IRQs being
     disabled for long can impact the performance.

     Wouldn't a used and free list be better alternative?

> +     }
> +     spin_unlock_irqrestore(&hwspinlock_state.local_lock, flags);
> +
> +     /* Return error if no more locks available */
> +     if (!found)
> +             return NULL;
> +
> +     handle->is_allocated = true;
> +
> +     return handle;
> +}
> +EXPORT_SYMBOL(hwspinlock_request);
> +
> +/* Request an unclaimed spinlock by ID */
> +struct hwspinlock *hwspinlock_request_specific(unsigned int id)
> +{
> +     struct hwspinlock *handle = NULL;
> +     unsigned long flags;
> +
> +     spin_lock_irqsave(&hwspinlock_state.local_lock, flags);
> +
> +     if (WARN_ON(hwspinlock_array[id].is_allocated))
> +             goto exit;
> +
[sp] if (id > hwspinlock_state.num_locks) then ??

> +     handle = &hwspinlock_array[id];
> +     handle->is_allocated = true;
> +
> +exit:
> +     spin_unlock_irqrestore(&hwspinlock_state.local_lock, flags);
> +     return handle;
> +}
> +EXPORT_SYMBOL(hwspinlock_request_specific);

[sp] What if either of the "request" funcs are called before
     hwspinlock_probe() gets executed?

> +
> +/* Release a claimed spinlock */
> +int hwspinlock_free(struct hwspinlock *handle)
> +{
> +     if (WARN_ON(handle == NULL))
> +             return -EINVAL;
> +
> +     if (WARN_ON(!handle->is_allocated))
> +             return -ENOMEM;
> +
> +     handle->is_allocated = false;
> +
> +     return 0;
> +}
> +EXPORT_SYMBOL(hwspinlock_free);
> +
> +/* Probe function */
> +static int __devinit hwspinlock_probe(struct platform_device *pdev)
> +{
> +     struct resource *res;
> +     void __iomem *io_base;
> +     int id;
> +
[sp] Extra line?

> +     void __iomem *sysstatus_reg;
[sp] can be combined with op_base declaration.

> +
> +     /* Determine number of locks */
> +     sysstatus_reg = ioremap(OMAP44XX_SPINLOCK_BASE +
> SYSSTATUS_OFFSET,
> +
> sizeof(u32));
> +     if (sysstatus_reg == NULL)
> +             return -EFAULT;
> +
> +     switch (readl(sysstatus_reg) >> SPINLOCK_NUMLOCKS_BIT_OFFSET) {
> +     case SPINLOCK_32_REGS:
> +             hwspinlock_state.num_locks = 32;
> +             break;
> +     case SPINLOCK_64_REGS:
> +             hwspinlock_state.num_locks = 64;
> +             break;
> +     case SPINLOCK_128_REGS:
> +             hwspinlock_state.num_locks = 128;
> +             break;
> +     case SPINLOCK_256_REGS:
> +             hwspinlock_state.num_locks = 256;
> +             break;
> +     default:
> +             return -EINVAL; /* Invalid spinlock count code */
> +     }
> +     iounmap(sysstatus_reg);
> +
> +     /* Allocate spinlock device objects */
> +     hwspinlock_array = kmalloc(sizeof(struct hwspinlock) *
> +                     hwspinlock_state.num_locks, GFP_KERNEL);
> +     if (WARN_ON(hwspinlock_array == NULL))
> +             return -ENOMEM;
> +
> +     /* Initialize local lock */
> +     spin_lock_init(&hwspinlock_state.local_lock);
> +
> +     /* Get address info */
> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +     /* Map spinlock module address space */
> +     io_base = ioremap(res->start, resource_size(res));
> +     hwspinlock_state.io_base = io_base;
> +
> +     /* Set up each individual lock handle */
> +     for (id = 0; id < hwspinlock_state.num_locks; id++) {
> +             hwspinlock_array[id].id         = id;
> +             hwspinlock_array[id].pdev               = pdev;
> +             hwspinlock_array[id].is_init            = true;
> +             hwspinlock_array[id].is_allocated       = false;
> +
> +             hwspinlock_array[id].lock_reg   = io_base +
> LOCK_BASE_OFFSET +
> +
> sizeof(u32) * id;
> +     }
> +     pm_runtime_enable(&pdev->dev);
> +
> +     return 0;
> +}
> +
> +static struct platform_driver hwspinlock_driver = {
> +     .probe          = hwspinlock_probe,
> +     .driver         = {
> +             .name   = "hwspinlock",

[sp] Extra TAB?

> +     },
> +};
> +
> +/* Initialization function */
> +static int __init hwspinlock_init(void)
> +{
> +     int retval = 0;
> +
> +     /* Register spinlock driver */
> +     retval = platform_driver_register(&hwspinlock_driver);
> +
> +     return retval;
> +}
> +postcore_initcall(hwspinlock_init);
> +
> +/* Cleanup function */
> +static void __exit hwspinlock_exit(void)
> +{
> +     int id;
> +
> +     platform_driver_unregister(&hwspinlock_driver);
> +
> +     for (id = 0; id < hwspinlock_state.num_locks; id++)
> +             hwspinlock_array[id].is_init = false;
> +     iounmap(hwspinlock_state.io_base);
> +
> +     /* Free spinlock device objects */
> +     if (hwspinlock_state.is_init)
> +             kfree(hwspinlock_array);
> +}
> +module_exit(hwspinlock_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Hardware spinlock driver");
> +MODULE_AUTHOR("Simon Que");
> +MODULE_AUTHOR("Hari Kanigeri");
> diff --git a/arch/arm/plat-omap/include/plat/hwspinlock.h
> b/arch/arm/plat-omap/include/plat/hwspinlock.h
> new file mode 100644
> index 0000000..ea64c48
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/hwspinlock.h
> @@ -0,0 +1,47 @@
> +/*
> + * OMAP hardware spinlock driver header
> + *
> + * Copyright (C) 2010 Texas Instruments. All rights reserved.
> + *
> + * Contact: Simon Que <sque@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be
> useful, but
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
> +#ifndef HWSPINLOCK_H
> +#define HWSPINLOCK_H
> +
> +#include <linux/platform_device.h>
> +#include <plat/omap44xx.h>
> +
> +/* Values that are read from the spinlock register */
> +/* ACQUIRED means the lock was successfully acquired by the
> read operation */
> +/* BUSY means the lock was already acquired before the read
> operation, and */
> +/*   thus the read operation was not successful */
> +#define HWSPINLOCK_ACQUIRED  0
> +#define HWSPINLOCK_BUSY              1
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
> --
> 1.7.0
>
>
