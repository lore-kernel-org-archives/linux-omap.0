From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC v.4] omap: hwspinlock: Added hwspinlock driver
Date: Wed, 7 Jul 2010 11:04:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECFA5E@dbde02.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab0GGFfE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 01:35:04 -0400
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0F@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Simon,
> -----Original Message-----
> From: Que, Simon
> Sent: Wednesday, July 07, 2010 1:55 AM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Ohad Ben-Cohen; Shilimkar, Santosh
> Subject: [RFC v.4] omap: hwspinlock: Added hwspinlock driver

<snip>
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
> 		arch/arm/mach-omap2/hwspinlocks.c
> 
> The driver takes in data passed in device initialization.  The function
> hwspinlock_probe() initializes the array of spinlock structures, each
> containing a spinlock register address provided by the device
> initialization.
> The device driver file is:
> 		arch/arm/plat-omap/hwspinlock.c
> 
> Here's an API summary:
> int hwspinlock_lock(struct hwspinlock *);
> 	Attempt to lock a hardware spinlock.  If it is busy, the function
> will
> 	keep trying until it succeeds.  This is a blocking function.
> int hwspinlock_trylock(struct hwspinlock *);
> 	Attempt to lock a hardware spinlock.  If it is busy, the function
> will
> 	return BUSY.  If it succeeds in locking, the function will return
> 	ACQUIRED.  This is a non-blocking function
> int hwspinlock_unlock(struct hwspinlock *);
> 	Unlock a hardware spinlock.
> 
> struct hwspinlock *hwspinlock_request(void);
> 	Provides for "dynamic allocation" of a hardware spinlock.  It
> returns
> 	the handle to the next available (unallocated) spinlock.  If no more
> 	locks are available, it returns NULL.
> struct hwspinlock *hwspinlock_request_specific(unsigned int);
> 	Provides for "static allocation" of a specific hardware spinlock.
> This
> 	allows the system to use a specific spinlock, identified by an ID.
> If
> 	the ID is invalid or if the desired lock is already allocated, this
> 	will return NULL.  Otherwise it returns a spinlock handle.
> int hwspinlock_free(struct hwspinlock *);
> 	Frees an allocated hardware spinlock (either reserved or
> unreserved).
The above API description also should be present in the source file. Add
It on top of respective API.
> 
> Signed-off-by: Simon Que <sque@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                 |    2 +
>  arch/arm/mach-omap2/hwspinlocks.c            |   71 ++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
>  arch/arm/plat-omap/Makefile                  |    3 +-
>  arch/arm/plat-omap/hwspinlock.c              |  295
> ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/hwspinlock.h |   29 +++
>  arch/arm/plat-omap/include/plat/omap44xx.h   |    2 +
>  7 files changed, 402 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/hwspinlocks.c
>  create mode 100644 arch/arm/plat-omap/hwspinlock.c
>  create mode 100644 arch/arm/plat-omap/include/plat/hwspinlock.h
> 
Apart from the documentation comments, patch looks good to me.

Regards,
Santosh
