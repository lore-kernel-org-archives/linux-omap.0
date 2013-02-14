From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Build error: OMAP randconfig / mvebu
Date: Thu, 14 Feb 2013 12:21:16 +0000
Message-ID: <201302141221.16267.arnd@arndb.de>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk> <201302141127.07378.arnd@arndb.de> <20130214120650.GA11345@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63048 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758549Ab3BNMVW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 07:21:22 -0500
In-Reply-To: <20130214120650.GA11345@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, arm@kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 14 February 2013, Ezequiel Garcia wrote:
> Now, using the random config there's a new error, unrelated to the
> previous one:
> 
> ERROR: "twl6030_interrupt_unmask" [drivers/usb/otg/twl6030-usb.ko] undefined!
> ERROR: "twl_i2c_read_u8" [drivers/usb/otg/twl6030-usb.ko] undefined!
> ERROR: "twl_i2c_write_u8" [drivers/usb/otg/twl6030-usb.ko] undefined!
> ERROR: "twl6030_interrupt_mask" [drivers/usb/otg/twl6030-usb.ko] undefined!

Yes, I guess that is an unrelated error. However, my patch also wasn't
correct because it is not allowed to have an empty list of objects.

There is an updated patch below, I could add that straight to the branch
that caused the problem if it looks ok to you.

	Arnd
----
>From 0860b5b4558ad777068826bc9a735b82f3cf0d88 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Feb 2013 13:14:53 +0100
Subject: [PATCH] ARM: mvebu: allow selecting mvebu without Armada XP

Selecting only CONFIG_ARCH_MVEBU but not the respective
options for Armada 370 or Armada XP results in these
link errors:

arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_init_cpus':
arch/arm/mach-mvebu/platsmp.c:91: undefined reference to `coherency_get_cpu_count'
arch/arm/mach-mvebu/platsmp.c:104: undefined reference to `armada_mpic_send_doorbell'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_prepare_cpus':
arch/arm/mach-mvebu/platsmp.c:111: undefined reference to `set_cpu_coherent'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_boot_secondary':
arch/arm/mach-mvebu/platsmp.c:83: undefined reference to `armada_xp_boot_cpu'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_init':
arch/arm/mach-mvebu/platsmp.c:75: undefined reference to `armada_xp_mpic_smp_cpu_init'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_startup':
arch/arm/mach-mvebu/headsmp.S:46: undefined reference to `ll_set_cpu_coherent'

We can solve this by enabling all common MVEBU files that are
referenced by the SMP files. This means we enable code that
is not going to be used without a machine descriptor referencing
it, but only if the kernel is configured specifically for this
case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 99df4df..da93bcb 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -3,7 +3,8 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
-obj-y += system-controller.o
-obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o addr-map.o coherency.o coherency_ll.o pmsu.o
+obj-y				 += system-controller.o
+obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
+obj-$(CONFIG_ARCH_MVEBU)	 += addr-map.o coherency.o coherency_ll.o pmsu.o irq-armada-370-xp.o 
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
