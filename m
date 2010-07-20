From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/5] omap:hwspinlock support-omap4
Date: Tue, 20 Jul 2010 11:07:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6128817@dbde02.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54534 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224Ab0GTFiG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 01:38:06 -0400
In-Reply-To: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>

Hari,
> -----Original Message-----
> From: Kanigeri, Hari
> Sent: Monday, July 19, 2010 10:20 PM
> To: Linux Omap; Tony Lindgren
> Cc: Shilimkar, Santosh; Cousson, Benoit; Que, Simon; Kanigeri, Hari
> Subject: [PATCH 0/5] omap:hwspinlock support-omap4
> 
> Resending the hwspinlock patch Simon Que sent few days ago by splitting
> the patch into logical pieces. The first 4 patches are based on Simon's
> patch.
> https://patchwork.kernel.org/patch/110672/
> 
> The 5th patch is a new patch to address race condition issue with
> I2C driver usage.
> 
> 
> Created driver for OMAP hardware spinlock.  This driver supports:
> - Reserved spinlocks for internal use
> - Dynamic allocation of unreserved locks
> - Lock, unlock, and trylock functions, with or without disabling
> irqs/preempt
> - Registered as a platform device driver
> 
> The device initialization uses hwmod to configure the devices.
> One device will be created for each IP.
> It will pass spinlock register offset info to the driver.
> The device initialization file is:
>                 arch/arm/mach-omap2/hwspinlocks.c
> 
> The driver takes in register offset info passed in device initialization.
> It uses hwmod to obtain the base address of the hardware spinlock module.
> Then it reads info from the registers.
> The function hwspinlock_probe() initializes the array of spinlock
> structures,
> each containing a spinlock register address calculated from the base
> address
> and lock offsets.  The device driver file is:
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
>         ACQUIRED.  This is a non-blocking function.
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
> Hari Kanigeri (1):
>   omap:hwspinlocks-ensure the order of registration
> 
> Simon Que (4):
>   omap:hwmod-hwspinlock-enable
>   omap:hwspinlock-define HWSPINLOCK base address
I think you should fold patch 1/5 , 2/5 into patch 3/5. 
At least patch 2/5 o.w git-bisect will break 

>   omap:hwspinlock-added hwspinlock driver
>   omap:hwspinlock-add build support
> 
>  arch/arm/mach-omap2/Makefile                 |    2 +
>  arch/arm/mach-omap2/hwspinlocks.c            |   70 ++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
>  arch/arm/plat-omap/Makefile                  |    2 +
>  arch/arm/plat-omap/hwspinlock.c              |  334
> ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/hwspinlock.h |   29 +++
>  arch/arm/plat-omap/include/plat/omap44xx.h   |    5 +
>  7 files changed, 443 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/hwspinlocks.c
>  create mode 100644 arch/arm/plat-omap/hwspinlock.c
>  create mode 100644 arch/arm/plat-omap/include/plat/hwspinlock.h

