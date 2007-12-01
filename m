From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] Clean up cpu.h for 24xx, 34xx
Date: Fri, 30 Nov 2007 19:47:32 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711301945080.18772@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


[ This patch replaces the previous patch from me on this topic, 
  "Fix cpu_is_omap343x()" ]

include/asm-arm/arch-omap/cpu.h was always returning 0 for
cpu_is_omap343x().  This caused 3430SDP to fail to boot after the
recent system control module patch.

Also, clean up the existing OMAP2/3 CPU type reporting macros to
evaluate to constants on non-multiboot kernels, and fix some
whitespace and numeric format problems with the recent DEVICE_TYPE
macro changes.

Boot-tested on N800, 2430SDP, and 3430SDP-ES1.

size:

2885444  147008   96280 3128732  2fbd9c vmlinux.3430sdp
2885416  147008   96280 3128704  2fbd80 vmlinux.3430sdp.patched

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 include/asm-arm/arch-omap/cpu.h |   89 ++++++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 29 deletions(-)

Index: linux-omap/include/asm-arm/arch-omap/cpu.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/cpu.h	2007-11-30 16:23:40.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/cpu.h	2007-11-30 17:09:04.000000000 -0700
@@ -35,7 +35,6 @@
  */
 #undef MULTI_OMAP1
 #undef MULTI_OMAP2
-#undef MULTI_OMAP3
 #undef OMAP_NAME
 
 #ifdef CONFIG_ARCH_OMAP730
@@ -62,20 +61,33 @@
 #  define OMAP_NAME omap16xx
 # endif
 #endif
-#ifdef CONFIG_ARCH_OMAP24XX
+#if (defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX))
 # if (defined(OMAP_NAME) || defined(MULTI_OMAP1))
 #  error "OMAP1 and OMAP2 can't be selected at the same time"
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP2420
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
 # else
+#  define OMAP_NAME omap2420
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP2430
+# ifdef OMAP_NAME
 #  undef  MULTI_OMAP2
-#  define OMAP_NAME omap24xx
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap2430
 # endif
 #endif
-#ifdef CONFIG_ARCH_OMAP34XX
-# if (defined(OMAP_NAME) || defined(MULTI_OMAP1) || defined(MULTI_OMAP2))
-#  error "OMAP1 / OMAP2 / OMAP3 can't be selected at the same time"
+#ifdef CONFIG_ARCH_OMAP3430
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
 # else
-#  undef MULTI_OMAP3
-#  define OMAP_NAME omap34xx
+#  define OMAP_NAME omap3430
 # endif
 #endif
 
@@ -122,6 +134,7 @@
 #define cpu_is_omap24xx()		0
 #define cpu_is_omap242x()		0
 #define cpu_is_omap243x()		0
+#define cpu_is_omap34xx()		0
 #define cpu_is_omap343x()		0
 
 #if defined(MULTI_OMAP1)
@@ -150,19 +163,43 @@
 #  undef  cpu_is_omap16xx
 #  define cpu_is_omap16xx()		1
 # endif
+#endif
+
+#if defined(MULTI_OMAP2)
 # if defined(CONFIG_ARCH_OMAP24XX)
 #  undef  cpu_is_omap24xx
 #  undef  cpu_is_omap242x
 #  undef  cpu_is_omap243x
-#  define cpu_is_omap24xx()		1
+#  define cpu_is_omap24xx()		is_omap24xx()
 #  define cpu_is_omap242x()		is_omap242x()
 #  define cpu_is_omap243x()		is_omap243x()
 # endif
 # if defined(CONFIG_ARCH_OMAP34XX)
 #  undef  cpu_is_omap34xx
+#  undef  cpu_is_omap343x
+#  define cpu_is_omap34xx()		is_omap34xx()
+#  define cpu_is_omap343x()		is_omap343x()
+# endif
+#else
+# if defined(CONFIG_ARCH_OMAP24XX)
+#  undef  cpu_is_omap24xx
+#  define cpu_is_omap24xx()		1
+# endif
+# if defined(CONFIG_ARCH_OMAP2420)
+#  undef  cpu_is_omap242x
+#  define cpu_is_omap242x()		1
+# endif
+# if defined(CONFIG_ARCH_OMAP2430)
+#  undef  cpu_is_omap243x
+#  define cpu_is_omap243x()		1
+# endif
+# if defined(CONFIG_ARCH_OMAP34XX)
+#  undef  cpu_is_omap34xx
 #  define cpu_is_omap34xx()		1
-# else
-#  define cpu_is_omap34xx()		0
+# endif
+# if defined(CONFIG_ARCH_OMAP3430)
+#  undef  cpu_is_omap343x
+#  define cpu_is_omap343x()		1
 # endif
 #endif
 
@@ -285,7 +322,7 @@
  * get_sil_rev:			return the silicon rev value.
  */
 #define get_sil_omap_type(rev)	((rev & 0xffff0000) >> 16)
-#define get_sil_revision(rev)	((rev & 0x00000f000) >> 12)
+#define get_sil_revision(rev)	((rev & 0x0000f000) >> 12)
 
 #define is_sil_rev_greater_than(rev) \
 		((get_sil_omap_type(system_rev) == get_sil_omap_type(rev)) && \
@@ -313,23 +350,17 @@
  * Macro to detect device type i.e. EMU/HS/TST/GP/BAD
  */
 #define DEVICE_TYPE_TEST	0
-#define DEVICE_TYPE_EMU 	1
-#define DEVICE_TYPE_SEC 	2
-#define DEVICE_TYPE_GP  	3
-#define DEVICE_TYPE_BAD 	4
-
-#define get_device_type()	\
-		((system_rev & 0x700) >> 8)
-#define is_device_type_test()	\
-		(get_device_type() == DEVICE_TYPE_TEST)
-#define is_device_type_emu()	\
-		(get_device_type() == DEVICE_TYPE_EMU)
-#define is_device_type_sec()	\
-		(get_device_type() == DEVICE_TYPE_SEC)
-#define is_device_type_gp()	\
-		(get_device_type() == DEVICE_TYPE_GP)
-#define is_device_type_bad()	\
-		(get_device_type() == DEVICE_TYPE_BAD)
+#define DEVICE_TYPE_EMU		1
+#define DEVICE_TYPE_SEC		2
+#define DEVICE_TYPE_GP		3
+#define DEVICE_TYPE_BAD		4
+
+#define get_device_type()	((system_rev & 0x700) >> 8)
+#define is_device_type_test()	(get_device_type() == DEVICE_TYPE_TEST)
+#define is_device_type_emu()	(get_device_type() == DEVICE_TYPE_EMU)
+#define is_device_type_sec()	(get_device_type() == DEVICE_TYPE_SEC)
+#define is_device_type_gp()	(get_device_type() == DEVICE_TYPE_GP)
+#define is_device_type_bad()	(get_device_type() == DEVICE_TYPE_BAD)
 
 #endif
 
