From: Thomas Renninger <trenn@suse.de>
Subject: Passing device tree via intitrd
Date: Mon, 30 Jul 2012 09:35:51 +0200
Message-ID: <201207300935.51426.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51780 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2G3Hf4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 03:35:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: arnd@arndb.de, "H. Peter Anvin" <hpa@zytor.com>

Hello,

I recently posted a patch to be able to pass data to
the kernel and make use of it really early.
Use-cases are currently:
"Pass modified ACPI tables and make use of these instead of BIOS provided 
ones"
and (nothing has been done there yet):
"Pass CPU microcode updates and flash it really early"

This is done by an uncompressed cpio (initrd can consist of one
or more glued cpio archives, compressed or uncompressed).

I've been told that on ARM this feature might get convenient
to pass a flattened device tree via initrd.

These are my posts on lkml:

https://lkml.org/lkml/2012/7/18/165

Early initrd file overwrite and ACPI table override making use of it
  [PATCH 1/2] init: Introduce early initrd files through uncompressed cpio 
passing
  [PATCH 2/2] ACPI: Override arbitrary ACPI tables via initrd for 
debugging

The interesting part for ARM is the first patch.
Enabling this feature on ARM could then be (with the first patch slightly
modified using HAVE_EARLY_INITRD) as easy as below.

The code setup_arch() in arch/arm/kernel/setup.c would at least need some
shifting. But I guess it should be possible to get an arch independent
unified format (via uncompressed, glued cpio) how to pass early data via 
initrd to the kernel?

Unfortunately X86 might need the cpio scanning even earlier (before 
initrd_start is valid). The same seem to be the case for ARM?
I put the scanning, right after initrd_start got valid, for my purposes
that's early enough. Looks like in the end architectures may need
special handling early, but it's certainly a good idea to provide a kernel
wide mechanism to pass data to the kernel early (via uncompressed cpio).

Thanks for comments,

   Thomas

ARM: Enable early initrd file access feature

This would allow passing an uncompressed cpio initrd glued to
the initrd and accessing it early.
The files can be accessed as soon as arm_memblock_init()
(which sets up initrd_start) got called.

This patch is only to show how arch independent the early
initrd feature is and to ask whether this would be useful
for ARM (or other archs):

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..db48897 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -45,6 +45,7 @@ config ARM
 	select GENERIC_SMP_IDLE_THREAD
 	select KTIME_SCALAR
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select HAVE_EARLY_INITRD
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index f54d592..5abc675 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -363,6 +363,8 @@ void __init arm_memblock_init(struct meminfo *mi, 
struct machine_desc *mdesc)
 		/* Now convert initrd to virtual addresses */
 		initrd_start = __phys_to_virt(phys_initrd_start);
 		initrd_end = initrd_start + phys_initrd_size;
+		early_initrd_find_cpio_data((void *)initrd_start,
+					    initrd_end - initrd_start);
 	}
 #endif
 
