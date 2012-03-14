From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/12] mfd: twl: Fix for irqdomain/next + SPARSE_IRQ + MMC card detect
Date: Wed, 14 Mar 2012 13:50:36 -0700
Message-ID: <87399ahppf.fsf@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:61000 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756314Ab2CNUu1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 16:50:27 -0400
Received: by mail-pz0-f45.google.com with SMTP id p14so3202431dad.4
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 13:50:24 -0700 (PDT)
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 2 Mar 2012 17:50:12 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Benoit,

Benoit Cousson <b-cousson@ti.com> writes:

[...]

> This is not for pull-request, becasue it is based on irqdomain + OMAP
> IRQ DT series + OMAP twl DT series yet to be pushed.

What's the status of this series?

At least 'gpio/twl: Allocate irq_desc dynamically for SPARSE_IRQ
support' is needed in mainline (linux-next) now since without it, non-DT
boots will dump a big fat warning trace[2].  

Also FYI, I needed the patch below[1] in order to build this series.

Kevin

[1]
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index b8c74c7..8db1d64 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -15,6 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
+#include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
 #include <asm/hardware/gic.h>


[2]
[    0.495117] twl4030: PIH (irq 7) chaining IRQs 368..401
[    0.501190] twl4030: power (irq 373) chaining IRQs 402..409
[    0.509429] twl4030: gpio (irq 368) chaining IRQs 410..427
[    0.515319] ------------[ cut here ]------------
[    0.520202] WARNING: at /work/kernel/omap/pm/drivers/gpio/gpio-twl4030.c:410 gpio_twl4030_probe+0x44/0x214()
[    0.530395] Modules linked in:
[    0.533691] [<c0014248>] (unwind_backtrace+0x0/0xf0) from [<c0039054>] (warn_slowpath_common+0x4c/0x64)
[    0.543640] [<c0039054>] (warn_slowpath_common+0x4c/0x64) from [<c0039088>] (warn_slowpath_null+0x1c/0x24)
[    0.553680] [<c0039088>] (warn_slowpath_null+0x1c/0x24) from [<c04196f4>] (gpio_twl4030_probe+0x44/0x214)
[    0.563629] [<c04196f4>] (gpio_twl4030_probe+0x44/0x214) from [<c028832c>] (platform_drv_probe+0x18/0x1c)
[    0.573577] [<c028832c>] (platform_drv_probe+0x18/0x1c) from [<c0286fd4>] (really_probe+0x60/0x15c)
[    0.583007] [<c0286fd4>] (really_probe+0x60/0x15c) from [<c0287214>] (driver_probe_device+0x48/0x60)
[    0.592498] [<c0287214>] (driver_probe_device+0x48/0x60) from [<c0285af8>] (bus_for_each_drv+0x5c/0x88)
[    0.602264] [<c0285af8>] (bus_for_each_drv+0x5c/0x88) from [<c028718c>] (device_attach+0x98/0xbc)
[    0.611480] [<c028718c>] (device_attach+0x98/0xbc) from [<c0286844>] (bus_probe_device+0x88/0xac)
[    0.620727] [<c0286844>] (bus_probe_device+0x88/0xac) from [<c0285160>] (device_add+0x278/0x358)
[    0.629882] [<c0285160>] (device_add+0x278/0x358) from [<c02887a8>] (platform_device_add+0xf8/0x1a4)
[    0.639373] [<c02887a8>] (platform_device_add+0xf8/0x1a4) from [<c042e4a0>] (add_numbered_child.constprop.0+0xb8/0xfc)
[    0.650451] [<c042e4a0>] (add_numbered_child.constprop.0+0xb8/0xfc) from [<c042e5a4>] (add_children+0x44/0x6d0)
[    0.660949] [<c042e5a4>] (add_children+0x44/0x6d0) from [<c041a8b8>] (twl_probe+0x354/0x3bc)
[    0.669738] [<c041a8b8>] (twl_probe+0x354/0x3bc) from [<c0326cb0>] (i2c_device_probe+0xc0/0x100)
[    0.678863] [<c0326cb0>] (i2c_device_probe+0xc0/0x100) from [<c0286fd4>] (really_probe+0x60/0x15c)
[    0.688171] [<c0286fd4>] (really_probe+0x60/0x15c) from [<c0287214>] (driver_probe_device+0x48/0x60)
[    0.697692] [<c0287214>] (driver_probe_device+0x48/0x60) from [<c0285af8>] (bus_for_each_drv+0x5c/0x88)
[    0.707458] [<c0285af8>] (bus_for_each_drv+0x5c/0x88) from [<c028718c>] (device_attach+0x98/0xbc)
[    0.716674] [<c028718c>] (device_attach+0x98/0xbc) from [<c0286844>] (bus_probe_device+0x88/0xac)
[    0.725921] [<c0286844>] (bus_probe_device+0x88/0xac) from [<c0285160>] (device_add+0x278/0x358)
[    0.735076] [<c0285160>] (device_add+0x278/0x358) from [<c0327410>] (i2c_new_device+0xec/0x160)
[    0.744354] [<c0327410>] (i2c_new_device+0xec/0x160) from [<c032781c>] (i2c_register_adapter+0x168/0x220)
[    0.754302] [<c032781c>] (i2c_register_adapter+0x168/0x220) from [<c0327a40>] (i2c_add_numbered_adapter+0xd4/0xf0)
[    0.765045] [<c0327a40>] (i2c_add_numbered_adapter+0xd4/0xf0) from [<c041f4c8>] (omap_i2c_probe+0x334/0x424)
[    0.775268] [<c041f4c8>] (omap_i2c_probe+0x334/0x424) from [<c028832c>] (platform_drv_probe+0x18/0x1c)
[    0.784942] [<c028832c>] (platform_drv_probe+0x18/0x1c) from [<c0286fd4>] (really_probe+0x60/0x15c)
[    0.794342] [<c0286fd4>] (really_probe+0x60/0x15c) from [<c0287214>] (driver_probe_device+0x48/0x60)
[    0.803863] [<c0287214>] (driver_probe_device+0x48/0x60) from [<c02872c0>] (__driver_attach+0x94/0x98)
[    0.813537] [<c02872c0>] (__driver_attach+0x94/0x98) from [<c0285b74>] (bus_for_each_dev+0x50/0x7c)
[    0.822937] [<c0285b74>] (bus_for_each_dev+0x50/0x7c) from [<c0286ad4>] (bus_add_driver+0x184/0x248)
[    0.832427] [<c0286ad4>] (bus_add_driver+0x184/0x248) from [<c0287798>] (driver_register+0x78/0x12c)
[    0.841949] [<c0287798>] (driver_register+0x78/0x12c) from [<c0008800>] (do_one_initcall+0x34/0x178)
[    0.851440] [<c0008800>] (do_one_initcall+0x34/0x178) from [<c06068ac>] (kernel_init+0x8c/0x130)
[    0.860565] [<c06068ac>] (kernel_init+0x8c/0x130) from [<c000e850>] (kernel_thread_exit+0x0/0x8)
[    0.870117] ---[ end trace 1b75b31a2719ed1c ]---
