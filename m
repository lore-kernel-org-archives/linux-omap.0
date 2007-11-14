From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] SRAM patcher: add SRAM virtual address patcher
Date: Wed, 14 Nov 2007 01:30:11 -0700
Message-ID: <20071114083104.467714435@pwsan.com>
References: <20071114083010.938764990@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=sp-add-sram-patch-code.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add omap_sram_patch_va(), which patches a virtual address into SRAM 
code at runtime.  This will be used in a future patch series to implement
part of multiboot support for OMAP2/3.

If CONFIG_OMAP_DEBUG_SRAM_PATCH is defined (the default), the code
will be very careful to ensure that the target location to patch is
valid.  It will only overwrite a location if the location contains a
32-bit magic number, defined as SRAM_VA_MAGIC.  Also, defining DEBUG
at the top of the file and enabling CONFIG_DEBUG_LL will log patch
locations and data via printk.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/plat-omap/Kconfig       |   10 ++++++
 arch/arm/plat-omap/sram.c        |   61 +++++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/sram.h |    3 +
 include/linux/poison.h           |    6 +++
 4 files changed, 80 insertions(+)

Index: linux-omap/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/sram.c	2007-11-14 01:02:26.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/sram.c	2007-11-14 01:02:28.000000000 -0700
@@ -10,6 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#undef DEBUG
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -195,6 +196,66 @@
 	return (void *)omap_sram_ceil;
 }
 
+/**
+ * omap_sram_patch_va - patch a virtual address into SRAM code
+ * @srcfn: original start address (in DRAM) of function to patch
+ * @srcd: original address (in DRAM) of location to patch
+ * @sramfn: start address (in SRAM) of function to patch
+ * @d: virtual address to insert
+ *
+ * Replace a location in SRAM containing a magic number
+ * (SRAM_VA_MAGIC) with a caller-specified virtual address.  Used to
+ * dynamically patch SRAM code at runtime for multiboot, since some
+ * register addresses change depending on the OMAP chip in use.
+ * Returns 1 upon success, 0 upon failure.
+ */
+int omap_sram_patch_va(void *srcfn, void *srcd, void *sramfn, void __iomem *d)
+{
+	unsigned long sram_addr;
+	long offs;
+
+	offs = (unsigned long)srcd - (unsigned long)srcfn;
+	sram_addr = (unsigned long)sramfn + offs;
+
+#ifdef CONFIG_OMAP_DEBUG_SRAM_PATCH
+	if (offs < 0) {
+		printk(KERN_ERR "sram: patch address 0x%0lx < function start "
+		       "address 0x%0lx\n", (unsigned long)srcd,
+		       (unsigned long)srcfn);
+		WARN_ON(1);
+		return 0;
+	}
+
+	/*
+	 * REVISIT: We should probably pass in the function's size also,
+	 * so we can verify that the address to patch exists within
+	 * the function
+	 */
+	if (sram_addr > omap_sram_base + omap_sram_size ||
+	    sram_addr < omap_sram_base + SRAM_BOOTLOADER_SZ) {
+		printk(KERN_ERR "sram: invalid patch address 0x%0lx\n",
+		       sram_addr);
+		WARN_ON(1);
+		return 0;
+	}
+
+	if (*(typeof(SRAM_VA_MAGIC) *)sram_addr != SRAM_VA_MAGIC) {
+		printk(KERN_ERR "sram: will not patch address 0x%0lx: "
+		       "no magic\n", sram_addr);
+		WARN_ON(1);
+		return 0;
+	}
+#endif /* CONFIG_OMAP_DEBUG_SRAM_PATCH */
+
+	pr_debug("sram: patching 0x%0lx with 0x%0lx\n", sram_addr,
+		 (unsigned long)d);
+
+	*(unsigned long *)sram_addr = (unsigned long)d;
+
+	return 1;
+}
+
+
 static void omap_sram_error(void)
 {
 	panic("Uninitialized SRAM function\n");
Index: linux-omap/include/asm-arm/arch-omap/sram.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/sram.h	2007-11-14 01:02:26.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/sram.h	2007-11-14 01:02:28.000000000 -0700
@@ -11,7 +11,10 @@
 #ifndef __ARCH_ARM_OMAP_SRAM_H
 #define __ARCH_ARM_OMAP_SRAM_H
 
+#include <linux/poison.h>    /* for SRAM_VA_MAGIC */
+
 extern void * omap_sram_push(void * start, unsigned long size);
+extern int omap_sram_patch_va(void *srcfn, void *srcd, void *sramfn, void __iomem *d);
 extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);
 
 extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
Index: linux-omap/include/linux/poison.h
===================================================================
--- linux-omap.orig/include/linux/poison.h	2007-11-14 01:02:26.000000000 -0700
+++ linux-omap/include/linux/poison.h	2007-11-14 01:02:28.000000000 -0700
@@ -61,4 +61,10 @@
 /********** sound/oss/ **********/
 #define OSS_POISON_FREE		0xAB
 
+/*
+ * Used in arch/arm/plat-omap/sram.h to mark SRAM addresses that
+ * will be patched at runtime
+ */
+#define SRAM_VA_MAGIC		0xbadfeed1
+
 #endif
Index: linux-omap/arch/arm/plat-omap/Kconfig
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/Kconfig	2007-11-14 01:02:26.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/Kconfig	2007-11-14 01:03:57.000000000 -0700
@@ -32,6 +32,16 @@
 	depends on OMAP_DEBUG_DEVICES
 	default y if LEDS || LEDS_OMAP_DEBUG
 
+config OMAP_DEBUG_SRAM_PATCH
+	bool "Extra sanity checking for SRAM patch code"
+	depends on ARCH_OMAP
+	default y
+	help
+	  Say Y here if you want the kernel to use extra caution
+	  in patching SRAM virtual addresses.  If you are
+	  confident in your SRAM code, disabling this will save
+	  about 600 bytes.
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP

-- 
