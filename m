From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC] omap: hwspinlock: Added hwspinlock driver
Date: Sat, 26 Jun 2010 00:03:54 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D167E8@dbde02.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44308 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab0FYSeA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 14:34:00 -0400
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Simon,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Que,
> Simon
> Sent: Friday, June 25, 2010 6:10 AM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Ohad Ben-Cohen
> Subject: [RFC] omap: hwspinlock: Added hwspinlock driver
>
>
> Hi,
>
> We are introducing a kernel driver for hardware spinlock, called hwspinlock.
> It is designed to interface with the OMAP4 hardware spinlock module.  This
> driver supports:
> - Reserved spinlocks for internal use
> - Dynamic allocation of unreserved locks
> - Lock, unlock, and trylock functions, with or without disabling irqs/preempt
> - Registered as a platform device driver
>
> The device initialization will set aside some spinlocks as reserved for
> special-purpose use.  All other locks can be used by anyone.  This is
> configurable using a Kconfig option.  The device initialization file is:
>                 arch/arm/mach-omap2/hwspinlocks.c
>
> The driver takes in data passed in device initialization.  The function
> hwspinlock_probe() initializes the array of spinlock structures, each
> containing a spinlock register address provided by the device initialization.
> The device driver file is:
>                 arch/arm/plat-omap/hwspinlock.c
>
> Here's an API summary:
> int hwspinlock_lock(struct hwspinlock *);
>         Attempt to lock a hardware spinlock.  If it is busy, the function will
>         keep trying until it succeeds.  This is a blocking function.
> int hwspinlock_trylock(struct hwspinlock *);
>         Attempt to lock a hardware spinlock.  If it is busy, the function will
>         return BUSY.  If it succeeds in locking, the function will return
>         ACQUIRED.  This is a non-blocking function
> int hwspinlock_unlock(struct hwspinlock *);
>         Unlock a hardware spinlock.
>
> int hwspinlock_lock_irqsave(struct hwspinlock *, unsigned long *);
>         Same as hwspinlock_lock, but disables interrupts and preemption
> int hwspinlock_trylock_irqsave(struct hwspinlock *, unsigned long *);
>         Same as hwspinlock_trylock, but disables interrupts and preemption
> int hwspinlock_unlock_irqrestore(struct hwspinlock *, unsigned long);
>         Same as hwspinlock_unlock, but restores interrupts and preemption
>
> struct hwspinlock *hwspinlock_request(void);
>         Provides for "dynamic allocation" of an unreserved hardware spinlock.
>         If no more locks are available, returns NULL.
> struct hwspinlock *hwspinlock_request_specific(unsigned int);
>         Provides for "static allocation" of a reserved hardware spinlock. This
>         allows the system to use a specific reserved lock, identified by an ID.
>         If the ID is invalid or if the desired lock is already allocated, this
>         will return NULL.
> int hwspinlock_free(struct hwspinlock *);
>         Frees an allocated hardware spinlock (either reserved or unreserved).
>
> Please see the below patch contents, or the attached patch, and provide feedback.
>
> Signed-off-by: Simon Que <sque@ti.com>
> Cc: Hari Kanigeri <h-kanigeri2@ti.com>
>
> =====================================================================
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 9f73d79..a13c188 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -182,3 +182,13 @@ config OMAP3_SDRC_AC_TIMING
>           wish to say no.  Selecting yes without understanding what is
>           going on could result in system crashes;
>
> +config OMAP_HWSPINLOCK_NUM_RESERVED
> +       int "Number of hardware spinlocks reserved for system use"
> +       depends on ARCH_OMAP
It should have been "ARCH_OMAP4" but I think this KCONFIG should be killed
> +       default 8
> +       range 0 32
> +       help
> +         Choose a number of hardware spinlocks to reserve for internal use.
> +         The rest will be unreserved and availble for general use.  Make
> +         that the number of reserved locks does not exceed the total number
> +         available locks.

This reservation KCONFIG isn't necessary. HWSPINLOCK IP is not really for very generic use
but specific usages where you need to protect the data between independent softwares
running on different masters.
For other Linux only side software even with dual core, kernel spinlock library
is sufficient.

> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 6725b3a..14af19a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -170,3 +170,5 @@ obj-y                                       += $(nand-m) $(nand-y)
>
>  smc91x-$(CONFIG_SMC91X)                        := gpmc-smc91x.o
>  obj-y                                  += $(smc91x-m) $(smc91x-y)
> +
> +obj-y                                  += hwspinlocks.o
Are you building this for all OMAP's ??
> \ No newline at end of file
> diff --git a/arch/arm/mach-omap2/hwspinlocks.c b/arch/arm/mach-omap2/hwspinlocks.c
> new file mode 100644
> index 0000000..de813a0
> --- /dev/null
> +++ b/arch/arm/mach-omap2/hwspinlocks.c
> @@ -0,0 +1,126 @@
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
> +#include <linux/slab.h>
> +
> +#include <plat/hwspinlock.h>
> +
> +/* Base address of HW spinlock module */
> +#define HWSPINLOCK_BASE                (L4_44XX_BASE + 0xF6000)
Move this base address to plat/omap44xx.h and use it from there
> +#define HWSPINLOCK_REGADDR(reg)                                \
> +                       OMAP2_L4_IO_ADDRESS(HWSPINLOCK_BASE + (reg))
" OMAP2_L4_IO_ADDRESS" this should not be used anymore. Rather, use
"ioremap and readl/writel"

> +
> +/* Spinlock register offsets */
> +#define HWSPINLOCK_REVISION                    0x0000
> +#define HWSPINLOCK_SYSCONFIG                   0x0010
> +#define HWSPINLOCK_SYSSTATUS                   0x0014
> +#define HWSPINLOCK_LOCK_BASE                   0x0800
> +
> +/* Spinlock register addresses */
> +#define HWSPINLOCK_REVISION_REG                        \
> +       HWSPINLOCK_REGADDR(HWSPINLOCK_REVISION)
> +#define HWSPINLOCK_SYSCONFIG_REG                       \
> +       HWSPINLOCK_REGADDR(HWSPINLOCK_SYSCONFIG)
> +#define HWSPINLOCK_SYSSTATUS_REG                       \
> +       HWSPINLOCK_REGADDR(HWSPINLOCK_SYSSTATUS)
> +#define HWSPINLOCK_LOCK_REG(i)                 \
> +       HWSPINLOCK_REGADDR(HWSPINLOCK_LOCK_BASE + 0x4 * (i))
> +
> +/* Spinlock count code */
> +#define HWSPINLOCK_32_REGS                             1
> +#define HWSPINLOCK_64_REGS                             2
> +#define HWSPINLOCK_128_REGS                            4
> +#define HWSPINLOCK_256_REGS                            8
> +#define HWSPINLOCK_NUMLOCKS_OFFSET                     24
> +
> +
> +/* Initialization function */
> +int __init hwspinlocks_init(void)
> +{
> +       int i;
> +       int retval = 0;
> +
> +       struct platform_device *pdev;
> +       struct hwspinlock_plat_info *pdata;
> +       void __iomem *base;
> +       int num_locks;
> +       bool is_reserved;
> +
> +       /* Determine number of locks */
> +       switch (__raw_readl(HWSPINLOCK_SYSSTATUS_REG) >>
> +                                       HWSPINLOCK_NUMLOCKS_OFFSET) {
> +       case HWSPINLOCK_32_REGS:
> +               num_locks = 32;
> +               break;
> +       case HWSPINLOCK_64_REGS:
> +               num_locks = 64;
> +               break;
> +       case HWSPINLOCK_128_REGS:
> +               num_locks = 128;
> +               break;
> +       case HWSPINLOCK_256_REGS:
> +               num_locks = 256;
> +               break;
> +       default:
> +               return -EINVAL; /* Invalid spinlock count code */
> +       }
> +
> +       /* Device drivers */
> +       for (i = 0; i < num_locks; i++) {
> +               pdev = platform_device_alloc("hwspinlock", i);
> +
> +               base = HWSPINLOCK_LOCK_REG(i);  /* Get register address */
> +
> +               /* Some locks are reserved for system use */
> +               if (i < CONFIG_OMAP_HWSPINLOCK_NUM_RESERVED)
> +                       is_reserved = true;
> +               else
> +                       is_reserved = false;
> +
> +               /* Pass data to device initialization */
> +               pdata = kzalloc(sizeof(struct hwspinlock_plat_info),
> +                                                               GFP_KERNEL);
> +               pdata->num_locks = num_locks;
> +               pdata->io_base = base;
> +               pdata->is_reserved = is_reserved;
> +               retval = platform_device_add_data(pdev, pdata, sizeof(*pdata));
> +               if (retval)
> +                       goto device_add_fail;
> +
> +               retval = platform_device_add(pdev);
> +               if (retval)
> +                       goto device_add_fail;
> +               continue;
> +device_add_fail:
> +               platform_device_put(pdev);
> +       }
> +
> +       return retval;
> +}
> +module_init(hwspinlocks_init);
> +
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index a37abf5..fb98ff9 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -32,4 +32,5 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
>  obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
>  obj-$(CONFIG_OMAP_REMOTE_PROC) += remoteproc.o
>
> -obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
> \ No newline at end of file
> +obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
> +obj-y += hwspinlock.o
> \ No newline at end of file
> diff --git a/arch/arm/plat-omap/hwspinlock.c b/arch/arm/plat-omap/hwspinlock.c

Why do you have two files ? This IP is not part of OMAP1 and all the code can
go in mach-omap and can be exported from there.

> new file mode 100644
> index 0000000..327a524
> --- /dev/null
> +++ b/arch/arm/plat-omap/hwspinlock.c
> @@ -0,0 +1,331 @@
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
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include <plat/hwspinlock.h>
> +
> +/* for managing a hardware spinlock module */
> +struct hwspinlock_state {
> +       bool is_init;                   /* For first-time initialization */
> +       int num_locks;                  /* Total number of locks in system */
> +       spinlock_t local_lock;          /* Local protection */
> +};
> +
> +/* Points to the hardware spinlock module */
> +static struct hwspinlock_state hwspinlock_state;
> +static struct hwspinlock_state *hwspinlock_module = &hwspinlock_state;
> +
> +/* Spinlock object */
> +struct hwspinlock {
> +       void __iomem *io_base;
> +       bool is_reserved;
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
> +       /* Attempt to acquire the lock by reading from it */
> +       do {
> +               retval = __raw_readl(handle->io_base);
> +       } while (retval == HWSPINLOCK_BUSY);
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
> +       /* Attempt to acquire the lock by reading from it */
> +       retval = __raw_readl(handle->io_base);
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
> +       __raw_writel(0, handle->io_base);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(hwspinlock_unlock);
> +
> +/* Busy loop to acquire a spinlock, disabling interrupts/preemption */
> +int hwspinlock_lock_irqsave(struct hwspinlock *handle, unsigned long *flags)
> +{
> +       int retval;
> +       unsigned long temp_flags;
> +
> +       if (WARN_ON(handle == NULL))
> +               return -EINVAL;
> +
> +       if (WARN_ON(in_atomic() || in_irq()))
> +               return -EPERM;
> +
> +       if (WARN_ON(flags == NULL))
> +               return -EINVAL;
> +
> +       /* Attempt to acquire the lock by reading from it */
> +       do {
> +               preempt_disable();                      /* Disable preemption */
> +               local_irq_save(temp_flags);             /* Disable interrupts */
> +
> +               retval = __raw_readl(handle->io_base);
> +
> +               /* Restore interrupts and preemption if not successful */
> +               if (retval == HWSPINLOCK_BUSY) {
> +                       local_irq_restore(temp_flags);
> +                       preempt_enable();
> +               }
> +       } while (retval == HWSPINLOCK_BUSY);
> +
> +       *flags = temp_flags;            /* Return IRQ state */
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(hwspinlock_lock_irqsave);
> +
> +/* Attempt to acquire a spinlock once, disabling interrupts/preemption */
> +int hwspinlock_trylock_irqsave(struct hwspinlock *handle, unsigned long *flags)
> +{
> +       int retval = 0;
> +       unsigned long temp_flags;
> +
> +       if (WARN_ON(handle == NULL))
> +               return -EINVAL;
> +
> +       if (WARN_ON(in_atomic() || in_irq()))
> +               return -EPERM;
> +
> +       if (WARN_ON(flags == NULL))
> +               return -EINVAL;
> +
> +       preempt_disable();                      /* Disable preemption */
> +       local_irq_save(temp_flags);             /* Disable interrupts */
> +
> +       /* Attempt to acquire the lock by reading from it */
> +       retval = __raw_readl(handle->io_base);
> +
> +       /* Restore interrupts and preemption if not successful */
> +       if (retval == HWSPINLOCK_BUSY) {
> +               local_irq_restore(temp_flags);
> +               preempt_enable();
> +       } else
> +               *flags = temp_flags;    /* Return IRQ state */
> +
> +       return retval;
> +}
> +EXPORT_SYMBOL(hwspinlock_trylock_irqsave);
> +
> +/* Unlock a spinlock that was locked with irq/preempt disabled */
> +int hwspinlock_unlock_irqrestore(struct hwspinlock *handle, unsigned long
> +                                                                       flags)
> +{
> +       if (WARN_ON(handle == NULL))
> +               return -EINVAL;
> +
> +       /* Release it by writing 0 to it */
> +       __raw_writel(0, handle->io_base);
> +
> +       /* Restore interrupts and preemption */
> +       local_irq_restore(flags);
> +       preempt_enable();
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(hwspinlock_unlock_irqrestore);
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
> +               if (!hwspinlocks[i].is_allocated &&
> +                                               !hwspinlocks[i].is_reserved) {
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
> +       if (WARN_ON(!hwspinlocks[id].is_reserved))
> +               goto exit;
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
> +       int id = pdev->id;
> +
> +       /* Set up the spinlock count and array */
> +       if (!hwspinlock_module->is_init) {
> +               hwspinlock_module->num_locks = pdata->num_locks;
> +
> +               /* Allocate spinlock device objects */
> +               hwspinlocks = kmalloc(sizeof(struct hwspinlock) *
> +                               hwspinlock_module->num_locks, GFP_KERNEL);
> +               if (WARN_ON(hwspinlocks == NULL))
> +                       return -ENOMEM;
> +
> +               /* Initialize local lock */
> +               spin_lock_init(&hwspinlock_module->local_lock);
> +
> +               /* Only do initialization once */
> +               hwspinlock_module->is_init = true;
> +       }
> +
> +       hwspinlocks[id].pdev                    = pdev;
> +
> +       hwspinlocks[id].is_reserved             = pdata->is_reserved;
> +       hwspinlocks[id].is_allocated            = false;
> +       hwspinlocks[id].io_base                 = pdata->io_base;
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
> +       /* Make sure the it was properly initialized */
> +       if (WARN_ON(!hwspinlock_module->is_init))
> +               return -EACCES;
> +
> +       return retval;
> +}
> +
> +/* Cleanup function */
> +static void __exit hwspinlock_exit(void)
> +{
> +       platform_driver_unregister(&hwspinlock_driver);
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
> index 0000000..1cdf7a8
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/hwspinlock.h
This too can be moved to
arch/arm/mach-omap2/include/mach/hwspinlock.h

> @@ -0,0 +1,35 @@
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
> +       int num_locks;                  /* Number of locks (initialization) */
> +       void __iomem *io_base;          /* Address of spinlock register */
> +       bool is_reserved;               /* Reserved for system use? */
> +};
> +
> +struct hwspinlock;
> +
> +int hwspinlock_lock(struct hwspinlock *handle);
> +int hwspinlock_trylock(struct hwspinlock *handle);
> +int hwspinlock_unlock(struct hwspinlock *handle);
> +
> +int hwspinlock_lock_irqsave(struct hwspinlock *handle, unsigned long *flags);
> +int hwspinlock_trylock_irqsave(struct hwspinlock *handle, unsigned long *flags);
> +int hwspinlock_unlock_irqrestore(struct hwspinlock *handle, unsigned long
> +                                                                       flags);
> +
> +struct hwspinlock *hwspinlock_request(void);
> +struct hwspinlock *hwspinlock_request_specific(unsigned int id);
> +int hwspinlock_free(struct hwspinlock *hwspinlock_ptr);
> +
> +#endif /* HWSPINLOCK_H */
> --
> 1.7.0

