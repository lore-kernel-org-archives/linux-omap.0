From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 0/5] omap:hwspinlock support-omap4
Date: Mon, 19 Jul 2010 11:50:16 -0500
Message-ID: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35776 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936439Ab0GSQjd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 12:39:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Cousson Benoit <b-cousson@ti.com>, Simon Que <sque@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

Resending the hwspinlock patch Simon Que sent few days ago by splitting
the patch into logical pieces. The first 4 patches are based on Simon's
patch.
https://patchwork.kernel.org/patch/110672/

The 5th patch is a new patch to address race condition issue with
I2C driver usage.


Created driver for OMAP hardware spinlock.  This driver supports:
- Reserved spinlocks for internal use
- Dynamic allocation of unreserved locks
- Lock, unlock, and trylock functions, with or without disabling irqs/preempt
- Registered as a platform device driver

The device initialization uses hwmod to configure the devices.
One device will be created for each IP.
It will pass spinlock register offset info to the driver.
The device initialization file is:
                arch/arm/mach-omap2/hwspinlocks.c

The driver takes in register offset info passed in device initialization.
It uses hwmod to obtain the base address of the hardware spinlock module.
Then it reads info from the registers.
The function hwspinlock_probe() initializes the array of spinlock structures,
each containing a spinlock register address calculated from the base address
and lock offsets.  The device driver file is:
                arch/arm/plat-omap/hwspinlock.c

Here's an API summary:
int hwspinlock_lock(struct hwspinlock *);
        Attempt to lock a hardware spinlock.  If it is busy, the function will
        keep trying until it succeeds.  This is a blocking function.
int hwspinlock_trylock(struct hwspinlock *);
        Attempt to lock a hardware spinlock.  If it is busy, the function will
        return BUSY.  If it succeeds in locking, the function will return
        ACQUIRED.  This is a non-blocking function.
int hwspinlock_unlock(struct hwspinlock *);
        Unlock a hardware spinlock.

struct hwspinlock *hwspinlock_request(void);
        Provides for "dynamic allocation" of a hardware spinlock.  It returns
        the handle to the next available (unallocated) spinlock.  If no more
        locks are available, it returns NULL.
struct hwspinlock *hwspinlock_request_specific(unsigned int);
        Provides for "static allocation" of a specific hardware spinlock. This
        allows the system to use a specific spinlock, identified by an ID. If
        the ID is invalid or if the desired lock is already allocated, this
        will return NULL.  Otherwise it returns a spinlock handle.
int hwspinlock_free(struct hwspinlock *);
        Frees an allocated hardware spinlock (either reserved or unreserved).

Hari Kanigeri (1):
  omap:hwspinlocks-ensure the order of registration

Simon Que (4):
  omap:hwmod-hwspinlock-enable
  omap:hwspinlock-define HWSPINLOCK base address
  omap:hwspinlock-added hwspinlock driver
  omap:hwspinlock-add build support

 arch/arm/mach-omap2/Makefile                 |    2 +
 arch/arm/mach-omap2/hwspinlocks.c            |   70 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +-
 arch/arm/plat-omap/Makefile                  |    2 +
 arch/arm/plat-omap/hwspinlock.c              |  334 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/hwspinlock.h |   29 +++
 arch/arm/plat-omap/include/plat/omap44xx.h   |    5 +
 7 files changed, 443 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hwspinlocks.c
 create mode 100644 arch/arm/plat-omap/hwspinlock.c
 create mode 100644 arch/arm/plat-omap/include/plat/hwspinlock.h

