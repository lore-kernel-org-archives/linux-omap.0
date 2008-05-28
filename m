From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/14] ARM: OMAP: Remove omap_sram_patch_va
Date: Tue, 27 May 2008 21:20:13 -0700
Message-ID: <1211948418-16455-10-git-send-email-tony@atomide.com>
References: multi-omap-2008-05-27-212014
 <1211948418-16455-1-git-send-email-tony@atomide.com>
 <1211948418-16455-2-git-send-email-tony@atomide.com>
 <1211948418-16455-3-git-send-email-tony@atomide.com>
 <1211948418-16455-4-git-send-email-tony@atomide.com>
 <1211948418-16455-5-git-send-email-tony@atomide.com>
 <1211948418-16455-6-git-send-email-tony@atomide.com>
 <1211948418-16455-7-git-send-email-tony@atomide.com>
 <1211948418-16455-8-git-send-email-tony@atomide.com>
 <1211948418-16455-9-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:49701 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbYE1EUe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:34 -0400
In-Reply-To: <1211948418-16455-9-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

This is no longer needed as the 24xx *.S files have been split
into 242x and 243x specific files.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/Kconfig       |   10 ------
 arch/arm/plat-omap/sram.c        |   60 --------------------------------------
 include/asm-arm/arch-omap/sram.h |    3 --
 include/linux/poison.h           |    6 ----
 4 files changed, 0 insertions(+), 79 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ba858a8..b085b07 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -32,16 +32,6 @@ config OMAP_DEBUG_LEDS
 	depends on OMAP_DEBUG_DEVICES
 	default y if LEDS || LEDS_OMAP_DEBUG
 
-config OMAP_DEBUG_SRAM_PATCH
-	bool "Extra sanity checking for SRAM patch code"
-	depends on ARCH_OMAP
-	default y
-	help
-	  Say Y here if you want the kernel to use extra caution
-	  in patching SRAM virtual addresses.  If you are
-	  confident in your SRAM code, disabling this will save
-	  about 600 bytes.
-
 config OMAP_DEBUG_POWERDOMAIN
 	bool "Emit debug messages from powerdomain layer"
 	depends on ARCH_OMAP2 || ARCH_OMAP3
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 388ecfc..554ee58 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -241,66 +241,6 @@ void * omap_sram_push(void * start, unsigned long size)
 	return (void *)omap_sram_ceil;
 }
 
-/**
- * omap_sram_patch_va - patch a virtual address into SRAM code
- * @srcfn: original start address (in DRAM) of function to patch
- * @srcd: original address (in DRAM) of location to patch
- * @sramfn: start address (in SRAM) of function to patch
- * @d: virtual address to insert
- *
- * Replace a location in SRAM containing a magic number
- * (SRAM_VA_MAGIC) with a caller-specified virtual address.  Used to
- * dynamically patch SRAM code at runtime for multiboot, since some
- * register addresses change depending on the OMAP chip in use.
- * Returns 1 upon success, 0 upon failure.
- */
-int omap_sram_patch_va(void *srcfn, void *srcd, void *sramfn, void __iomem *d)
-{
-	unsigned long sram_addr;
-	long offs;
-
-	offs = (unsigned long)srcd - (unsigned long)srcfn;
-	sram_addr = (unsigned long)sramfn + offs;
-
-#ifdef CONFIG_OMAP_DEBUG_SRAM_PATCH
-	if (offs < 0) {
-		printk(KERN_ERR "sram: patch address 0x%0lx < function start "
-		       "address 0x%0lx\n", (unsigned long)srcd,
-		       (unsigned long)srcfn);
-		WARN_ON(1);
-		return 0;
-	}
-
-	/*
-	 * REVISIT: We should probably pass in the function's size also,
-	 * so we can verify that the address to patch exists within
-	 * the function
-	 */
-	if (sram_addr > omap_sram_base + omap_sram_size ||
-	    sram_addr < omap_sram_base + SRAM_BOOTLOADER_SZ) {
-		printk(KERN_ERR "sram: invalid patch address 0x%0lx\n",
-		       sram_addr);
-		WARN_ON(1);
-		return 0;
-	}
-
-	if (*(typeof(SRAM_VA_MAGIC) *)sram_addr != SRAM_VA_MAGIC) {
-		printk(KERN_ERR "sram: will not patch address 0x%0lx: "
-		       "no magic\n", sram_addr);
-		WARN_ON(1);
-		return 0;
-	}
-#endif /* CONFIG_OMAP_DEBUG_SRAM_PATCH */
-
-	pr_debug("sram: patching 0x%0lx with 0x%0lx\n", sram_addr,
-		 (unsigned long)d);
-
-	*(unsigned long *)sram_addr = (unsigned long)d;
-
-	return 1;
-}
-
-
 static void omap_sram_error(void)
 {
 	panic("Uninitialized SRAM function\n");
diff --git a/include/asm-arm/arch-omap/sram.h b/include/asm-arm/arch-omap/sram.h
index 866b864..6c577f7 100644
--- a/include/asm-arm/arch-omap/sram.h
+++ b/include/asm-arm/arch-omap/sram.h
@@ -11,11 +11,8 @@
 #ifndef __ARCH_ARM_OMAP_SRAM_H
 #define __ARCH_ARM_OMAP_SRAM_H
 
-#include <linux/poison.h>    /* for SRAM_VA_MAGIC */
-
 extern int __init omap_sram_init(void);
 extern void * omap_sram_push(void * start, unsigned long size);
-extern int omap_sram_patch_va(void *srcfn, void *srcd, void *sramfn, void __iomem *d);
 extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);
 
 extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
diff --git a/include/linux/poison.h b/include/linux/poison.h
index 03620da..9f31683 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -68,10 +68,4 @@
 /********** sound/oss/ **********/
 #define OSS_POISON_FREE		0xAB
 
-/*
- * Used in arch/arm/plat-omap/sram.h to mark SRAM addresses that
- * will be patched at runtime
- */
-#define SRAM_VA_MAGIC		0xbadfeed1
-
 #endif
-- 
1.5.3.6

