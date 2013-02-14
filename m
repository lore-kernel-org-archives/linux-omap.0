From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: Build error: OMAP randconfig / mvebu
Date: Thu, 14 Feb 2013 13:35:38 +0100
Message-ID: <511CDA1A.10401@free-electrons.com>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk> <201302141127.07378.arnd@arndb.de> <20130214120650.GA11345@localhost> <201302141221.16267.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54854 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757562Ab3BNMfm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 07:35:42 -0500
In-Reply-To: <201302141221.16267.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/14/2013 01:21 PM, Arnd Bergmann wrote:
> On Thursday 14 February 2013, Ezequiel Garcia wrote:
>> Now, using the random config there's a new error, unrelated to the
>> previous one:
>>
>> ERROR: "twl6030_interrupt_unmask" [drivers/usb/otg/twl6030-usb.ko] undefined!
>> ERROR: "twl_i2c_read_u8" [drivers/usb/otg/twl6030-usb.ko] undefined!
>> ERROR: "twl_i2c_write_u8" [drivers/usb/otg/twl6030-usb.ko] undefined!
>> ERROR: "twl6030_interrupt_mask" [drivers/usb/otg/twl6030-usb.ko] undefined!
> 
> Yes, I guess that is an unrelated error. However, my patch also wasn't
> correct because it is not allowed to have an empty list of objects.
> 
> There is an updated patch below, I could add that straight to the branch
> that caused the problem if it looks ok to you.

OK for me, this patch still fix the build error and I tested that we
still have a valid kernel for Armada 370 for Armada XP

Tested-by: Gregory Clement <gregory.clement@free-electrons.com> on Armada 370 DB
and Armada XP DB

> 
> 	Arnd
> ----
> From 0860b5b4558ad777068826bc9a735b82f3cf0d88 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 14 Feb 2013 13:14:53 +0100
> Subject: [PATCH] ARM: mvebu: allow selecting mvebu without Armada XP
> 
> Selecting only CONFIG_ARCH_MVEBU but not the respective
> options for Armada 370 or Armada XP results in these
> link errors:
> 
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_init_cpus':
> arch/arm/mach-mvebu/platsmp.c:91: undefined reference to `coherency_get_cpu_count'
> arch/arm/mach-mvebu/platsmp.c:104: undefined reference to `armada_mpic_send_doorbell'
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_prepare_cpus':
> arch/arm/mach-mvebu/platsmp.c:111: undefined reference to `set_cpu_coherent'
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_boot_secondary':
> arch/arm/mach-mvebu/platsmp.c:83: undefined reference to `armada_xp_boot_cpu'
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_init':
> arch/arm/mach-mvebu/platsmp.c:75: undefined reference to `armada_xp_mpic_smp_cpu_init'
> arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_startup':
> arch/arm/mach-mvebu/headsmp.S:46: undefined reference to `ll_set_cpu_coherent'
> 
> We can solve this by enabling all common MVEBU files that are
> referenced by the SMP files. This means we enable code that
> is not going to be used without a machine descriptor referencing
> it, but only if the kernel is configured specifically for this
> case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
> index 99df4df..da93bcb 100644
> --- a/arch/arm/mach-mvebu/Makefile
> +++ b/arch/arm/mach-mvebu/Makefile
> @@ -3,7 +3,8 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  
>  AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
>  
> -obj-y += system-controller.o
> -obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o coherency.o coherency_ll.o pmsu.o
> +obj-y				 += system-controller.o
> +obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
> +obj-$(CONFIG_ARCH_MVEBU)	 += addr-map.o coherency.o coherency_ll.o pmsu.o irq-armada-370-xp.o 
>  obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
