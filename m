From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC] omap: hwspinlock: Added hwspinlock driver
Date: Fri, 25 Jun 2010 10:11:29 +0200
Message-ID: <4C2464B1.6030008@ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43545 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0FYILc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 04:11:32 -0400
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E14728DDBB@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Hi Simon,

On 6/25/2010 2:40 AM, Que, Simon wrote:
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
>                  arch/arm/mach-omap2/hwspinlocks.c

Why using a Kconfig option in that case? You can reserve the locks at 
run time based on other driver request. The goal of the hwspinlock is to 
protect data shared between various processors inside OMAP4 like ipu, 
iva, dsp and mpu. So in anycase the syslink driver can request the 
needed locks at init time on behalf of the dsp or the ipu.

Since you don't even know the number of locks because it is determined 
at init time, you cannot know at build time that information.

You should add an API to reserve some locks at run time instead of doing 
that.

>
> The driver takes in data passed in device initialization.  The function
> hwspinlock_probe() initializes the array of spinlock structures, each
> containing a spinlock register address provided by the device initialization.
> The device driver file is:
>                  arch/arm/plat-omap/hwspinlock.c
>
> Here's an API summary:
> int hwspinlock_lock(struct hwspinlock *);
>          Attempt to lock a hardware spinlock.  If it is busy, the function will
>          keep trying until it succeeds.  This is a blocking function.
> int hwspinlock_trylock(struct hwspinlock *);
>          Attempt to lock a hardware spinlock.  If it is busy, the function will
>          return BUSY.  If it succeeds in locking, the function will return
>          ACQUIRED.  This is a non-blocking function
> int hwspinlock_unlock(struct hwspinlock *);
>          Unlock a hardware spinlock.
>
> int hwspinlock_lock_irqsave(struct hwspinlock *, unsigned long *);
>          Same as hwspinlock_lock, but disables interrupts and preemption
> int hwspinlock_trylock_irqsave(struct hwspinlock *, unsigned long *);
>          Same as hwspinlock_trylock, but disables interrupts and preemption
> int hwspinlock_unlock_irqrestore(struct hwspinlock *, unsigned long);
>          Same as hwspinlock_unlock, but restores interrupts and preemption
>
> struct hwspinlock *hwspinlock_request(void);
>          Provides for "dynamic allocation" of an unreserved hardware spinlock.
>          If no more locks are available, returns NULL.
> struct hwspinlock *hwspinlock_request_specific(unsigned int);
>          Provides for "static allocation" of a reserved hardware spinlock. This
>          allows the system to use a specific reserved lock, identified by an ID.
>          If the ID is invalid or if the desired lock is already allocated, this
>          will return NULL.
> int hwspinlock_free(struct hwspinlock *);
>          Frees an allocated hardware spinlock (either reserved or unreserved).
>
> Please see the below patch contents, or the attached patch, and provide feedback.
>
> Signed-off-by: Simon Que<sque@ti.com>
> Cc: Hari Kanigeri<h-kanigeri2@ti.com>
>
> =====================================================================
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 9f73d79..a13c188 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -182,3 +182,13 @@ config OMAP3_SDRC_AC_TIMING
>            wish to say no.  Selecting yes without understanding what is
>            going on could result in system crashes;
>
> +config OMAP_HWSPINLOCK_NUM_RESERVED
> +       int "Number of hardware spinlocks reserved for system use"
> +       depends on ARCH_OMAP
> +       default 8
> +       range 0 32
> +       help
> +         Choose a number of hardware spinlocks to reserve for internal use.
> +         The rest will be unreserved and availble for general use.  Make
> +         that the number of reserved locks does not exceed the total number
> +         available locks.
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 6725b3a..14af19a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -170,3 +170,5 @@ obj-y                                       += $(nand-m) $(nand-y)
>
>   smc91x-$(CONFIG_SMC91X)                        := gpmc-smc91x.o
>   obj-y                                  += $(smc91x-m) $(smc91x-y)
> +
> +obj-y                                  += hwspinlocks.o
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
> + * Contact: Simon Que<sque@ti.com>
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
> +#include<linux/module.h>
> +#include<linux/interrupt.h>
> +#include<linux/device.h>
> +#include<linux/delay.h>
> +#include<linux/io.h>
> +#include<linux/slab.h>
> +
> +#include<plat/hwspinlock.h>
> +
> +/* Base address of HW spinlock module */
> +#define HWSPINLOCK_BASE                (L4_44XX_BASE + 0xF6000)

It is a details, but why are you renaming the registers with the HW 
prefix? The module name is spinlock not hwspinlock.

The names should be that:
#define SPINLOCK_REVISION                    0x0000
#define SPINLOCK_SYSCONFIG                   0x0010
#define SPINLOCK_SYSSTATUS                   0x0014
#define SPINLOCK_LOCK_BASE                   0x0800

or even that since you are not sharing these defines:
#define REVISION                    0x0000
#define SYSCONFIG                   0x0010
#define SYSSTATUS                   0x0014
#define LOCK_BASE                   0x0800

Every IPs are by definition an HW module, so that information is useless.

> +#define HWSPINLOCK_REGADDR(reg)                                \
> +                       OMAP2_L4_IO_ADDRESS(HWSPINLOCK_BASE + (reg))
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
> +       switch (__raw_readl(HWSPINLOCK_SYSSTATUS_REG)>>
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
> +       for (i = 0; i<  num_locks; i++) {
> +               pdev = platform_device_alloc("hwspinlock", i);

Since it is a new driver for a new IP, why don't you use directly the 
omap_device / omap_hwmod abstraction?

Regards,
Benoit
