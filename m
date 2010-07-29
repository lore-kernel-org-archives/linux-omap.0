From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/5] omap:hwspinlock-added hwspinlock driver
Date: Thu, 29 Jul 2010 09:05:52 -0500
Message-ID: <4C518AC0.6070809@ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com> <1279558221-14954-4-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37233 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717Ab0G2OGw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jul 2010 10:06:52 -0400
In-Reply-To: <1279558221-14954-4-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>

Kanigeri, Hari had written, on 07/19/2010 11:50 AM, the following:
> From: Simon Que <sque@ti.com>
> 
> Created driver for OMAP hardware spinlock.  This driver supports:
> - Reserved spinlocks for internal use
> - Dynamic allocation of unreserved locks
> - Lock, unlock, and trylock functions, with or without disabling irqs/preempt
> - Registered as a platform device driver
> 
> The device initialization uses hwmod to configure the devices.
> One device will be created for each IP.  It will pass spinlock register offset
> info to the driver.  The device initialization file is:
>                 arch/arm/mach-omap2/hwspinlocks.c
> 
> The driver takes in register offset info passed in device initialization.
> It uses hwmod to obtain the base address of the hardware spinlock module.
> Then it reads info from the registers.  The function hwspinlock_probe()
> initializes the array of spinlock structures, each containing a spinlock
> register address calculated from the base address and lock offsets.
> The device driver file is:
>                 arch/arm/plat-omap/hwspinlock.c

just a curious question:

Is there no h/w spinlock implementation for other architectures in 
linux? I mean the concept does not seem unique for a heterogenous 
processor environments now a days.. if it does exist, maybe we have two 
options:
* extend standard spinlock architecture to handle h/w spinlocks as well
* establish a new framework for h/w spinlocks..

[...]

-- 
Regards,
Nishanth Menon
